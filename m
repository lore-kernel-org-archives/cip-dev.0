Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065F5EB64DC
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 08:04:39 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.16609.1688630673055613251
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jul 2023 01:04:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=Cg6SStj2;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-20230706080429eb9cd6c46ba30f2db8-y8b3_r@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230706080429eb9cd6c46ba30f2db8
        for <cip-dev@lists.cip-project.org>;
        Thu, 06 Jul 2023 10:04:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=rhozErsQWXw3+H65Y09Qxhdsa6ZZVaTe2LBLbgiyftU=;
 b=Cg6SStj2hr0x7ooCkiF+6GmKCp7m0Y3enwsLpKwIwcCRrw1TwXwzQJxTBGP7MIrShLD8Sq
 A/3354lfBUbUgv9b/ahfXBWBN8TSyZLqt/yAoji970xSWkXzmJA/HxqibLw24qb68JQaAx6q
 eIIoIbMvUk91lD21RhJ5DX0LXr7Cs=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 1/3] initramfs-crypt-hook: Remove needless differences between clevis and systemd scripts
Date: Thu,  6 Jul 2023 10:04:26 +0200
Message-Id: <1365151926687b7dfadcf7bb13b2600772cb6a55.1688630668.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12254

From: Jan Kiszka <jan.kiszka@siemens.com>

Just quoting and comment styles.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../files/encrypt_partition.clevis.script     |  5 ++---
 .../files/encrypt_partition.systemd.script    | 22 +++++++++----------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
index bcb5a048..9a1c37ba 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
@@ -41,7 +41,7 @@ tpm_device=/dev/tpmrm0
 partition_sets="$PARTITIONS"
 create_file_system_cmd="$CREATE_FILE_SYSTEM_CMD"
 
-if [ -z "${create_file_system_cmd}" ];then
+if [ -z "${create_file_system_cmd}" ]; then
 	create_file_system_cmd="mke2fs -t ext4"
 fi
 
@@ -73,7 +73,6 @@ reencrypt_existing_partition() {
 	else
 		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$1" < "$2"
 	fi
-
 }
 
 if [ ! -e "$tpm_device" ]; then
@@ -89,7 +88,7 @@ for partition_set in $partition_sets; do
 	partition_label="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
 	partition_mountpoint="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')"
 	partition_format="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[3]}')"
-	partition=/dev/disk/by-partlabel/$partition_label
+	partition=/dev/disk/by-partlabel/"$partition_label"
 	crypt_mount_name="encrypted_$partition_label"
 	decrypted_part=/dev/mapper/"$crypt_mount_name"
 	# clevis does not work with links in /dev/disk*
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
index 927184c0..eefac4bd 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
@@ -8,6 +8,7 @@
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
 #
 # SPDX-License-Identifier: MIT
+
 prereqs()
 {
 	# Make sure that this script is run last in local-top
@@ -52,11 +53,11 @@ open_tpm2_partition() {
 }
 
 enroll_tpm2_token() {
-	#check systemd version and export password if necessary
+	# check systemd version and export password if necessary
 	if [ -x /usr/bin/systemd-cryptenroll ]; then
 		systemd_version=$(systemd-cryptenroll --version | \
 			  awk -F " " 'NR==1{print $2 }')
-		#check systemd version and export password if necessary
+		# check systemd version and export password if necessary
 		if [ "$systemd_version" -ge "251" ]; then
 			PASSWORD=$(cat "$2" )
 			export PASSWORD
@@ -72,20 +73,19 @@ enroll_tpm2_token() {
 }
 
 reencrypt_existing_partition() {
-	part_device=$(readlink -f "$partition")
-	part_size_blocks=$(cat /sys/class/block/"$(awk -v dev="$part_device" 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)
+	part_device="$(readlink -f "$partition")"
+	part_size_blocks="$(cat /sys/class/block/"$(awk -v dev="$part_device" 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)"
 	# reduce the filesystem and partition by 32M to fit the LUKS header
 	reduce_device_size=32768
-	reduced_size=$(expr "$part_size_blocks" - 65536 )
-	reduced_size_in_byte=$(expr "$reduced_size" \* 512)
-	reduced_size_in_kb=$(expr "$reduced_size_in_byte" / 1024)K
+	reduced_size="$(expr "$part_size_blocks" - 65536 )"
+	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
+	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
 	resize2fs "$1" "${reduced_size_in_kb}"
 	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
 		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k "$1" < "$2"
 	else
 		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$1" < "$2"
 	fi
-
 }
 
 if [ ! -e "$tpm_device" ]; then
@@ -93,9 +93,9 @@ if [ ! -e "$tpm_device" ]; then
 fi
 
 for partition_set in $partition_sets; do
-	partition_label=$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')
-	partition_mountpoint=$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')
-	partition_format=$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[3]}')
+	partition_label="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
+	partition_mountpoint="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')"
+	partition_format="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[3]}')"
 	partition=/dev/disk/by-partlabel/"$partition_label"
 	crypt_mount_name="encrypted_$partition_label"
 	decrypted_part=/dev/mapper/"$crypt_mount_name"
-- 
2.35.3


