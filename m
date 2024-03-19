Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903D4CD11DE
	for <webhook@archiver.kernel.org>; Tue, 19 Mar 2024 18:20:41 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.23526.1710872431419546138
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Mar 2024 11:20:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=IVndewqu;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-202403191820297a4c54bd1a8e9f5af7-icqmyc@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202403191820297a4c54bd1a8e9f5af7
        for <cip-dev@lists.cip-project.org>;
        Tue, 19 Mar 2024 19:20:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ZTixechiK4iqAZkd7QmSm13S3iNgXrasVmkta0xNHxI=;
 b=IVndewquSBEro5PWxtAdiAiBcpETU8+lWCT5LzvQcGTAVyk+29DLH9+fv147RSscMqOMPu
 e7tjMyDEVw/Yyzk1wGTZ78yfUq0SL1+DQfuMlxB1Gog4hvDAjfpFichQyePIHipfD2K9M8DT
 GkUDwipHeQEqpgi67f3xoB2qyL9l0=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	johnxw@amazon.com
Subject: [cip-dev][isar-cip-core][PATCH 7/8] initramfs-crypt-hook: split encryption and mounting
Date: Tue, 19 Mar 2024 19:18:31 +0100
Message-ID: <20240319182026.1571362-8-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240319182026.1571362-1-Quirin.Gylstorff@siemens.com>
References: <20240319182026.1571362-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Mar 2024 18:20:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15371

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The encryption now occurs before the rootfs is mounted.
The file system is mounted after the rootfs.

This removes the required order between overlay and disk encryption.
Also it allows the encryption of the rootfs.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/encrypt_partition.clevis.script     | 27 --------
 .../files/encrypt_partition.systemd.script    | 27 --------
 .../files/mount_crypt_partitions.script       | 61 +++++++++++++++++++
 .../initramfs-crypt-hook_0.1.bb               |  6 +-
 .../files/overlay.script.tmpl                 |  2 +-
 5 files changed, 67 insertions(+), 56 deletions(-)
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/mount_crypt_partitions.script

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
index 0bb6720..eec3cf1 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
@@ -92,16 +92,6 @@ reencrypt_existing_partition() {
 	fi
 }
 
-mount_partition() {
-	partition_dev_path=$1
-	partition_mountpoint=$2
-	echo "mount device: '$partition' to '$partition_mountpoint'"
-	if ! mount -t "$(get_fstype "${partition_dev_path}")" "${partition_dev_path}" \
-		 "${partition_mountpoint}"; then
-		panic "Can't mount encrypted partition '${partition_dev_path}'!"
-	fi
-}
-
 for candidate in /dev/tpm*; do
 	if ! tpm2_pcrread -T device:"$candidate" "$pcr_bank_hash_type":7 --quiet 2>/dev/null; then
 		continue
@@ -115,19 +105,6 @@ done
 if [ ! -e "$tpm_device" ]; then
 	if [ "$tpm_encryption_optional" = "true" ]; then
 		echo "No tpm_device exists abort optional encryption"
-		for partition_set in $partition_sets; do
-			partition_label="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
-			partition_mountpoint="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')"
-			partition_format="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[3]}')"
-			partition=/dev/disk/by-partlabel/"$partition_label"
-			case "${partition_format}" in
-			"reencrypt")
-				mount_partition "$partition" "$rootmnt""$partition_mountpoint"
-				;;
-			*)
-				echo "cannot mount partition '$partition' as it is marked for formatting."
-			esac
-		done
 		exit 0
 	fi
 	panic "No tpm device exists or supports pcr_hash '$pcr_bank_hash_type' or '$tpm_key_algorithm' - cannot create a encrypted device!"
@@ -140,7 +117,6 @@ fi
 
 for partition_set in $partition_sets; do
 	partition_label="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
-	partition_mountpoint="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')"
 	partition_format="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[3]}')"
 	partition=/dev/disk/by-partlabel/"$partition_label"
 	crypt_mount_name="encrypted_$partition_label"
@@ -151,7 +127,6 @@ for partition_set in $partition_sets; do
 	if /usr/sbin/cryptsetup luksDump --batch-mode "$partition" \
 			| grep -q "clevis"; then
 		open_tpm2_partition "$part_device"
-		mount_partition "$decrypted_part" "${rootmnt}""$partition_mountpoint"
 		continue
 	fi
 
@@ -184,8 +159,6 @@ for partition_set in $partition_sets; do
 		 ;;
 	esac
 
-	mount_partition "$decrypted_part" "${rootmnt}""$partition_mountpoint"
-
 	# delete initial key
 	# afterwards no new keys can be enrolled
 	cryptsetup -v luksKillSlot -q  "$part_device" 0
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
index 9809c87..c7822f2 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
@@ -105,16 +105,6 @@ reencrypt_existing_partition() {
 	fi
 }
 
-mount_partition() {
-	partition_dev_path=$1
-	partition_mountpoint=$2
-	echo "mount device: '$partition' to '$partition_mountpoint'"
-	if ! mount -t "$(get_fstype "${partition_dev_path}")" "${partition_dev_path}" \
-		 "${partition_mountpoint}"; then
-		panic "Can't mount encrypted partition '${partition_dev_path}'!"
-	fi
-}
-
 for candidate in /dev/tpm*; do
 	if ! tpm2_pcrread -T device:"$candidate" "$pcr_bank_hash_type":7 --quiet 2>/dev/null; then
 		continue
@@ -128,19 +118,6 @@ done
 if [ ! -e "$tpm_device" ]; then
 	if [ "$tpm_encryption_optional" = "true" ]; then
 		echo "No tpm_device exists abort optional encryption"
-		for partition_set in $partition_sets; do
-			partition_label="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
-			partition_mountpoint="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')"
-			partition_format="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[3]}')"
-			partition=/dev/disk/by-partlabel/"$partition_label"
-			case "${partition_format}" in
-			"reencrypt")
-				mount_partition "$partition" "$rootmnt""$partition_mountpoint"
-				;;
-			*)
-				echo "cannot mount partition '$partition' as it is marked for formatting."
-			esac
-		done
 		exit 0
 	fi
 	panic "No tpm device exists or supports pcr_hash '$pcr_bank_hash_type' or '$tpm_key_algorithm' - cannot create a encrypted device!"
@@ -149,7 +126,6 @@ fi
 
 for partition_set in $partition_sets; do
 	partition_label="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
-	partition_mountpoint="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')"
 	partition_format="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[3]}')"
 	partition=/dev/disk/by-partlabel/"$partition_label"
 	crypt_mount_name="encrypted_$partition_label"
@@ -160,7 +136,6 @@ for partition_set in $partition_sets; do
 	if /usr/sbin/cryptsetup luksDump --batch-mode "$partition" \
 			| grep -q "systemd-tpm2"; then
 		open_tpm2_partition "$part_device"
-		mount_partition "$decrypted_part" "${rootmnt}""$partition_mountpoint"
 		continue
 	fi
 
@@ -193,8 +168,6 @@ for partition_set in $partition_sets; do
 		 ;;
 	esac
 
-	mount_partition "$decrypted_part" "${rootmnt}""$partition_mountpoint"
-
 	# delete initial key
 	# afterwards no new keys can be enrolled
 	/usr/bin/systemd-cryptenroll "$partition" --wipe-slot=0
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/mount_crypt_partitions.script b/recipes-initramfs/initramfs-crypt-hook/files/mount_crypt_partitions.script
new file mode 100644
index 0000000..1d3eb6c
--- /dev/null
+++ b/recipes-initramfs/initramfs-crypt-hook/files/mount_crypt_partitions.script
@@ -0,0 +1,61 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+prereqs()
+{
+	# Make sure that this script is run last in local-top
+	local req
+	for req in "${0%/*}"/*; do
+		script="${req##*/}"
+		if [ "$script" != "${0##*/}" ]; then
+			printf '%s\n' "$script"
+		fi
+	done
+}
+case $1 in
+prereqs)
+	prereqs
+	exit 0
+	;;
+esac
+
+. /scripts/functions
+
+# get configuration variables
+. /usr/share/encrypt_partition/encrypt_partition.env
+
+mount_partition() {
+	partition_dev_path=$1
+	partition_mountpoint=$2
+	echo "mount device: '$partition' to '$partition_mountpoint'"
+	if ! mountpoint -q "${partition_mountpoint}"; then
+		if ! mount -t "$(get_fstype "${partition_dev_path}")" "${partition_dev_path}" \
+			 "${partition_mountpoint}"; then
+			panic "Can't mount encrypted partition '${partition_dev_path}'!"
+		fi
+	fi
+}
+partition_sets="$PARTITIONS"
+for partition_set in $partition_sets; do
+	partition_label="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
+	partition_mountpoint="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')"
+	partition=/dev/disk/by-partlabel/"$partition_label"
+	part_device=$(readlink -f "$partition")
+	crypt_mount_name="encrypted_$partition_label"
+	decrypted_part=/dev/mapper/"$crypt_mount_name"
+
+	if /usr/sbin/cryptsetup luksDump --batch-mode "$partition" \
+			| grep -q "systemd-tpm2"; then
+		mount_partition "$decrypted_part" "${rootmnt}""$partition_mountpoint"
+	else
+		mount_partition "$part_device" "$rootmnt""$partition_mountpoint"
+	fi
+done
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
index 54c91fd..4e60c10 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
@@ -35,6 +35,7 @@ CRYPT_BACKEND = "systemd"
 
 SRC_URI += "file://encrypt_partition.env.tmpl \
             file://encrypt_partition.${CRYPT_BACKEND}.script \
+            file://mount_crypt_partitions.script \
             file://encrypt_partition.${CRYPT_BACKEND}.hook \
             file://pwquality.conf"
 
@@ -60,12 +61,15 @@ TEMPLATE_FILES = "encrypt_partition.env.tmpl"
 do_install[cleandirs] += " \
     ${D}/usr/share/initramfs-tools/hooks \
     ${D}/usr/share/encrypt_partition \
+    ${D}/usr/share/initramfs-tools/scripts/local-top \
     ${D}/usr/share/initramfs-tools/scripts/local-bottom"
 
 do_install() {
     install -m 0600 "${WORKDIR}/encrypt_partition.env" "${D}/usr/share/encrypt_partition/encrypt_partition.env"
     install -m 0755 "${WORKDIR}/encrypt_partition.${CRYPT_BACKEND}.script" \
-        "${D}/usr/share/initramfs-tools/scripts/local-bottom/encrypt_partition"
+        "${D}/usr/share/initramfs-tools/scripts/local-top/encrypt_partition"
+    install -m 0755 "${WORKDIR}/mount_crypt_partitions.script" \
+        "${D}/usr/share/initramfs-tools/scripts/local-bottom/mount_decrypted_partition"
     install -m 0755 "${WORKDIR}/encrypt_partition.${CRYPT_BACKEND}.hook" \
         "${D}/usr/share/initramfs-tools/hooks/encrypt_partition"
     install -m 0644 "${WORKDIR}/pwquality.conf" "${D}/usr/share/encrypt_partition/pwquality.conf"
diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
index a321490..2563dfd 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
+++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
@@ -9,7 +9,7 @@
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
 #
 
-PREREQ="encrypt_partition"
+PREREQ=""
 
 prereqs()
 {
-- 
2.43.0


