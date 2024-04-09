Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C48CD12A8
	for <webhook@archiver.kernel.org>; Tue,  9 Apr 2024 13:06:51 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.136240.1712668002829672516
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Apr 2024 06:06:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=loT178MT;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-202404091306398372c8c81d589ad06d-qfsexu@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202404091306398372c8c81d589ad06d
        for <cip-dev@lists.cip-project.org>;
        Tue, 09 Apr 2024 15:06:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=yqlNpChmOvPHuitayu5PdAQTVGO9xrsKLIRb+IZoWSo=;
 b=loT178MT/yBcMBCOKB01nKlcHIKELdHpCePyiGMEqgHSwfNOCdjVBBk5zs1Mf+8KrCAGQl
 s2knkptpUsBPLW0OP7jc9IolyTemklF0rrIiVEiuEMGuFk3pbRw/olr3tj8+tr2cLm4dOxUx
 ni4rkCFX4TzxCfUqCHZuQPIqHUq20=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	johnxw@amazon.com
Subject: [cip-dev][isar-cip-core][PATCH v3 02/15] initramfs-crypt-hook: Align systemd encryption and clevis encryption
Date: Tue,  9 Apr 2024 15:05:19 +0200
Message-ID: <20240409130638.559398-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240409130638.559398-1-Quirin.Gylstorff@siemens.com>
References: <20240409130638.559398-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Apr 2024 13:06:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15514

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The following changes were copied from systemd to clevis:
 - check return of resize command
The following changes were copied form clevis to systemd:
 - check if create_filesystem command is empty
 - use part_device(/dev/*) instead of disk
   label(/dev/disk/by-partlabel/*)

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/encrypt_partition.clevis.script     |  6 ++++--
 .../files/encrypt_partition.systemd.script    | 21 +++++++++++--------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
index 0318966..4e76c44 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
@@ -2,7 +2,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2023
+# Copyright (c) Siemens AG, 2023-2024
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -82,7 +82,9 @@ reencrypt_existing_partition() {
 	reduced_size="$(expr "$part_size_blocks" - 65536 )"
 	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
 	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
-	resize2fs "$1" "${reduced_size_in_kb}"
+	if ! resize2fs "$1" "${reduced_size_in_kb}"; then
+		panic "reencryption of filesystem $1 cannot continue!"
+	fi
 	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
 		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k "$1" < "$2"
 	else
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
index eeeb55a..f97a461 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
@@ -2,7 +2,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2023
+# Copyright (c) Siemens AG, 2023-2024
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -47,6 +47,9 @@ modprobe loop
 tpm_device=/dev/tpmrm0
 partition_sets="$PARTITIONS"
 create_file_system_cmd="$CREATE_FILE_SYSTEM_CMD"
+if [ -z "${create_file_system_cmd}" ]; then
+	create_file_system_cmd="mke2fs -t ext4"
+fi
 
 service_watchdog() {
 	for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
@@ -83,8 +86,7 @@ enroll_tpm2_token() {
 }
 
 reencrypt_existing_partition() {
-	part_device="$(readlink -f "$partition")"
-	part_size_blocks="$(cat /sys/class/block/"$(awk -v dev="$part_device" 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)"
+	part_size_blocks="$(cat /sys/class/block/"$(awk -v dev="$1" 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)"
 	# reduce the filesystem and partition by 32M to fit the LUKS header
 	reduce_device_size=32768
 	reduced_size="$(expr "$part_size_blocks" - 65536 )"
@@ -111,15 +113,16 @@ for partition_set in $partition_sets; do
 	partition=/dev/disk/by-partlabel/"$partition_label"
 	crypt_mount_name="encrypted_$partition_label"
 	decrypted_part=/dev/mapper/"$crypt_mount_name"
+	part_device=$(readlink -f "$partition")
 
 	# check if partition is already encrypted with systemd-tpm2
 	if /usr/sbin/cryptsetup luksDump --batch-mode "$partition" \
 			| grep -q "systemd-tpm2"; then
-		open_tpm2_partition "$partition"
 		if ! mount -t "$(get_fstype "${decrypted_part}")" "${decrypted_part}" \
 			 "${rootmnt}${partition_mountpoint}"; then
 			panic "Can't mount encrypted partition '${decrypted_part}'!"
 		fi
+		open_tpm2_partition "$part_device"
 		continue
 	fi
 
@@ -136,15 +139,15 @@ for partition_set in $partition_sets; do
 
 	case "${partition_format}" in
 		"reencrypt")
-			reencrypt_existing_partition "$partition" "$tmp_key"
-			enroll_tpm2_token "$partition" "$tmp_key"
-			open_tpm2_partition "$partition"
+			reencrypt_existing_partition "$part_device" "$tmp_key"
+			enroll_tpm2_token "$part_device" "$tmp_key"
+			open_tpm2_partition "$part_device"
 		;;
 		"format")
 			/usr/sbin/cryptsetup luksFormat --batch-mode \
 				 --type luks2 "$partition" < "$tmp_key"
-			enroll_tpm2_token "$partition" "$tmp_key"
-			open_tpm2_partition "$partition"
+			enroll_tpm2_token "$part_device" "$tmp_key"
+			open_tpm2_partition "$part_device"
 			eval "${create_file_system_cmd} ${decrypted_part}"
 		;;
 		*)
-- 
2.43.0


