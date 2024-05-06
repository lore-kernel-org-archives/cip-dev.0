Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5455AC25B77
	for <webhook@archiver.kernel.org>; Mon,  6 May 2024 14:18:45 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.21764.1715005118034398596
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 May 2024 07:18:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=HFgf7q15;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20240506141836ea1e8e62879232d0e1-rvycei@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240506141836ea1e8e62879232d0e1
        for <cip-dev@lists.cip-project.org>;
        Mon, 06 May 2024 16:18:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=34cQ3Qte/w3ZWWldCQsv1m0pk0ovHGlHKSzO/ewilSo=;
 b=HFgf7q15CpLBGHjNfNxbWc1UfAM01WcMSzIn/edDoM51IbSI5TczA9o/AREWynvRFkYW/V
 xloh4FgWT7zjzvN15IBN2utwm4XF/BWXBNAmGLlquGynplg/juOzNNhGfqi6HdT6w6K1x5eF
 /4ry++k4PIgJbNIN+DCeiu4aiXAcg=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	johnxw@amazon.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 07/11] crypt-hook: Extend partition selection
Date: Mon,  6 May 2024 16:17:28 +0200
Message-ID: <20240506141833.3622989-8-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240506141833.3622989-1-Quirin.Gylstorff@siemens.com>
References: <20240506141833.3622989-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 May 2024 14:18:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15832

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This adds the possiblity to select the partition to be encrypted
by UUID or absolute path.

If used with an UUID the uuid is used as the name of the device
mapper. With this change the swupdate-handler-roundrobin selects
the /dev/mapper/<PARTUUID> device for the update instead of the
underling partition.

This allows to update an encrypted partition without triggering a
reencryption.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/encrypt_partition.clevis.hook       |  2 ++
 .../files/encrypt_partition.script            | 27 ++++++++++++++-----
 .../files/encrypt_partition.systemd.hook      |  2 ++
 .../files/mount_crypt_partitions.script       | 20 +++++++++++---
 .../initramfs-crypt-hook_0.2.bb               |  3 ++-
 5 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
index 0bb8ce6..0644eab 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
@@ -72,6 +72,8 @@ copy_exec /usr/bin/seq || hook_error "Unable to copy /usr/bin/seq"
 copy_exec /usr/bin/pwmake || hook_error "Unable to copy /usr/bin/pwmake"
 copy_exec /usr/bin/file || hook_error "Unable to copy /usr/bin/file "
 copy_exec /usr/lib/*/libgcc_s.so.1 || hook_error "Unable to copy /usr/lib/*/libgcc_s.so.1 "
+copy_exec /usr/bin/uuidparse || hook_error "Unable to copy /usr/bin/uuidparse"
+
 if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
     copy_exec /usr/sbin/cryptsetup-reencrypt
 fi
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
index 7cb7f34..857b73f 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
@@ -121,19 +121,34 @@ fi
 prepare_for_encryption
 
 for partition_set in $partition_sets; do
-	partition_label="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
+	partition="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
 	partition_mountpoint="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')"
 	partition_format="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[3]}')"
-	partition=/dev/disk/by-partlabel/"$partition_label"
-	crypt_mount_name="encrypted_$partition_label"
+	case "$partition" in
+		/*)
+			part_device=$(readlink -f "$partition")
+			crypt_mount_name="$( basename "$partition")"
+			;;
+		*)
+			if uuidparse "$partition" -n -o TYPE | grep -q invalid; then
+				part_device=$(readlink -f /dev/disk/by-partlabel/"$partition")
+				crypt_mount_name="encrypted_${partition}"
+			else
+				part_device=$(readlink -f /dev/disk/by-partuuid/"$partition")
+				crypt_mount_name="${partition}"
+			fi
+			;;
+	esac
+	if [ ! -e  "$part_device" ]; then
+		panic "Could not find device  mapped to '$partition' cannot be encrypted!"
+	fi
 	decrypted_part=/dev/mapper/"$crypt_mount_name"
-	part_device=$(readlink -f "$partition")
 	# check if we are trying to mount root
 	if [ "$partition_mountpoint" = "/" ]; then
 		echo "ROOT=$decrypted_part" >/conf/param.conf
 	fi
 
-	if /usr/sbin/cryptsetup luksDump --batch-mode "$partition" \
+	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
 			| grep -q "luks2"; then
 		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
 		continue
@@ -147,7 +162,7 @@ for partition_set in $partition_sets; do
 
 	# create random password for initial encryption
 	# this will be dropped after reboot
-	tmp_key=/tmp/"$partition_label-lukskey"
+	tmp_key=/tmp/"$(basename "$part_device")-lukskey"
 	openssl rand -base64 32 > "$tmp_key"
 
 	case "${partition_format}" in
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
index 941f0b1..19e0fe4 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
@@ -51,6 +51,8 @@ copy_exec /usr/bin/systemd-cryptenroll || hook_error "/usr/bin/systemd-cryptenro
 copy_exec /usr/lib/systemd/systemd-cryptsetup || hook_error "/usr/lib/systemd/systemd-cryptsetup not found"
 copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy /usr/bin/tpm2_pcrread"
 copy_exec /usr/bin/tpm2_testparms || hook_error "Unable to copy /usr/bin/tpm2_testparms"
+copy_exec /usr/bin/basename || hook_error "Unable to copy /usr/bin/basename"
+copy_exec /usr/bin/uuidparse || hook_error "Unable to copy /usr/bin/uuidparse"
 
 copy_exec /usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so || hook_error "/usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so not found"
 if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/mount_crypt_partitions.script b/recipes-initramfs/initramfs-crypt-hook/files/mount_crypt_partitions.script
index b72323f..f35685e 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/mount_crypt_partitions.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/mount_crypt_partitions.script
@@ -45,11 +45,23 @@ mount_partition() {
 }
 partition_sets="$PARTITIONS"
 for partition_set in $partition_sets; do
-	partition_label="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
+	partition="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
 	partition_mountpoint="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')"
-	partition=/dev/disk/by-partlabel/"$partition_label"
-	part_device=$(readlink -f "$partition")
-	crypt_mount_name="encrypted_$partition_label"
+	case "$partition" in
+		/*)
+			part_device=$(readlink -f "$partition")
+			crypt_mount_name="$( basename "$partition")"
+			;;
+		*)
+			if uuidparse "$partition" -n -o TYPE | grep -q invalid; then
+				part_device=$(readlink -f /dev/disk/by-partlabel/"$partition")
+				crypt_mount_name="encrypted_${partition}"
+			else
+				part_device=$(readlink -f /dev/disk/by-partuuid/"$partition")
+				crypt_mount_name="${partition}"
+			fi
+			;;
+	esac
 	decrypted_part=/dev/mapper/"$crypt_mount_name"
 	if [ -z "$partition_mountpoint" ]; then
 		continue
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
index 1d5a4a7..72de5b6 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
@@ -11,7 +11,8 @@
 inherit dpkg-raw
 DEBIAN_DEPENDS = "initramfs-tools, cryptsetup, \
     awk, openssl, libtss2-esys-3.0.2-0 | libtss2-esys0, \
-    libtss2-rc0 | libtss2-esys0, libtss2-mu0 | libtss2-esys0, e2fsprogs, tpm2-tools"
+    libtss2-rc0 | libtss2-esys0, libtss2-mu0 | libtss2-esys0, \
+    e2fsprogs, tpm2-tools, coreutils, uuid-runtime"
 
 CLEVIS_DEPEND = ", clevis-luks, jose, bash, luksmeta, file, libpwquality-tools"
 
-- 
2.43.0


