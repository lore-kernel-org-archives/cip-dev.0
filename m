Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082B2EB64D9
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 08:04:39 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.16607.1688630672358813969
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jul 2023 01:04:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=bqhG/Q75;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-20230706080429097dfe430862c58012-ehutco@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230706080429097dfe430862c58012
        for <cip-dev@lists.cip-project.org>;
        Thu, 06 Jul 2023 10:04:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=m0Li02p90h+ohYbi7BjOuykt1nPiC8kH4XDxNerK7Ec=;
 b=bqhG/Q75mt+vcStjQH1eVp5vQbD88Hs4zdQYngZfQWqw9kUtX/6O45jwio43ITN6GrJkwc
 VNsthdNRJmcM75h2wg1I3XxecqmuH/Iaiu0aj9LTiXUkvdD+cUCVh7QLDIjo7Sdar/CGmKj5
 WMK2tNLGnq45h+osNcL5MdDJjaxN4=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 2/3] initramfs-crypt-hook: Service watchdog while setting up the crypto partitions
Date: Thu,  6 Jul 2023 10:04:27 +0200
Message-Id: <3e0c558a5b9b0643012484839a1dbf671c4708fb.1688630668.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1688630668.git.jan.kiszka@siemens.com>
References: <cover.1688630668.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jul 2023 08:04:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12256

From: Jan Kiszka <jan.kiszka@siemens.com>

These operations can take longer than the watchdog timeout normally
needed for booting Linux up to systemd. Add a background loop to both
scripts then triggers the watchdog every 10 s, but only up to a
configurable limit. Also the watchdog device can be configured, though
the default /dev/watchdog should be fine in almost all cases.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../files/encrypt_partition.clevis.script       | 17 +++++++++++++++++
 .../files/encrypt_partition.env.tmpl            |  2 ++
 .../files/encrypt_partition.systemd.hook        |  2 ++
 .../files/encrypt_partition.systemd.script      | 17 +++++++++++++++++
 .../initramfs-crypt-hook_0.1.bb                 |  7 ++++++-
 5 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
index 9a1c37ba..c38c0e94 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
@@ -45,6 +45,13 @@ if [ -z "${create_file_system_cmd}" ]; then
 	create_file_system_cmd="mke2fs -t ext4"
 fi
 
+service_watchdog() {
+	for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
+		printf '\0'
+		sleep 10
+	done > "$WATCHDOG_DEV"
+}
+
 open_tpm2_partition() {
 	if ! /usr/bin/clevis luks unlock -n "$crypt_mount_name" \
 		 -d "$1"; then
@@ -104,6 +111,12 @@ for partition_set in $partition_sets; do
 		continue
 	fi
 
+	# service watchdog in the background during lengthy re-encryption
+	if [ -z "$watchdog_pid" ]; then
+		service_watchdog &
+		watchdog_pid=$!
+	fi
+
 	# create random password for initial encryption
 	# this will be dropped after reboot
 	tmp_key=/tmp/"$partition_label-lukskey"
@@ -136,3 +149,7 @@ for partition_set in $partition_sets; do
 	# afterwards no new keys can be enrolled
 	cryptsetup -v luksKillSlot -q  "$part_device" 0
 done
+
+if [ -n "$watchdog_pid" ]; then
+	kill "$watchdog_pid"
+fi
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
index d04be56c..382fe45f 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
@@ -1,2 +1,4 @@
 PARTITIONS="${CRYPT_PARTITIONS}"
 CREATE_FILE_SYSTEM_CMD="${CRYPT_CREATE_FILE_SYSTEM_CMD}"
+SETUP_TIMEOUT="${CRYPT_SETUP_TIMEOUT}"
+WATCHDOG_DEV="${WATCHDOG_DEVICE}"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
index fa37b57a..08ea631a 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
@@ -36,6 +36,8 @@ copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
 copy_exec /usr/bin/grep || hook_error "/usr/bin/grep not found"
 copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
 copy_exec /usr/bin/expr || hook_error "/usr/bin/expr not found"
+copy_exec /usr/bin/seq || hook_error "/usr/bin/seq not found"
+copy_exec /usr/bin/sleep || hook_error "/usr/bin/sleep not found"
 copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
 copy_exec /usr/sbin/resize2fs || hook_error "/usr/sbin/resize2fs not found"
 copy_exec /usr/sbin/cryptsetup || hook_error "/usr/sbin/cryptsetup not found"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
index eefac4bd..cf513dfe 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
@@ -45,6 +45,13 @@ if [ -z "${create_file_system_cmd}" ]; then
 	create_file_system_cmd="mke2fs -t ext4"
 fi
 
+service_watchdog() {
+	for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
+		printf '\0'
+		sleep 10
+	done > "$WATCHDOG_DEV"
+}
+
 open_tpm2_partition() {
 	if ! /usr/lib/systemd/systemd-cryptsetup attach "$crypt_mount_name" \
 		 "$1" - tpm2-device="$tpm_device"; then
@@ -111,6 +118,12 @@ for partition_set in $partition_sets; do
 		continue
 	fi
 
+	# pet watchdog in the background during lengthy re-encryption
+	if [ -z "$watchdog_pid" ]; then
+		service_watchdog &
+		watchdog_pid=$!
+	fi
+
 	# create random password for initial encryption
 	# this will be dropped after reboot
 	tmp_key=/tmp/"$partition_label-lukskey"
@@ -143,3 +156,7 @@ for partition_set in $partition_sets; do
 	# afterwards no new keys can be enrolled
 	/usr/bin/systemd-cryptenroll "$partition" --wipe-slot=0
 done
+
+if [ -n "$watchdog_pid" ]; then
+	kill "$watchdog_pid"
+fi
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
index 997f469d..db65ea40 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
@@ -33,8 +33,13 @@ CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
 # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to create the filesystem
 # in a newly formatted LUKS Partition
 CRYPT_CREATE_FILE_SYSTEM_CMD ??= "mke2fs -t ext4"
+# Timeout for creating / re-encrypting partitions on first boot
+CRYPT_SETUP_TIMEOUT ??= "600"
+# Watchdog to service during the initial setup of the crypto partitions
+WATCHDOG_DEVICE ??= "/dev/watchdog"
 
-TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD"
+TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
+    CRYPT_SETUP_TIMEOUT WATCHDOG_DEVICE"
 TEMPLATE_FILES = "encrypt_partition.env.tmpl"
 
 do_install[cleandirs] += " \
-- 
2.35.3


