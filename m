Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DED8C7EE25
	for <webhook@archiver.kernel.org>; Tue,  2 May 2023 15:38:08 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.1534.1683041884354577091
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 May 2023 08:38:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Z5J9XvwH;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-2023050215380277c1d4ad8b8e5a845d-t0v_ph@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2023050215380277c1d4ad8b8e5a845d
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 May 2023 17:38:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=BCVYt7Q1qEXCsHADukbJVNNx9CdHu/kVpyjkaAqI9W4=;
 b=Z5J9XvwHYroSHiPjQD60agxY8yny4PWrSMI4Xo5Dh82awYIICnLy7bA3xuY46RA6lly3HY
 LP5la4s8AjQo1BHCNagZKqIQxD3FAoSHFrVObmBn0vUQ9Ik5LjhlOiUZgN8/W2sN01PoaHHI
 a148h2hLM2TS105hHOm6UVfeMkDKc=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 5/7] initramfs-crypt-hook/systemd: Address shellcheck findings
Date: Tue,  2 May 2023 17:37:57 +0200
Message-Id: <20230502153759.1284906-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230502153759.1284906-1-Quirin.Gylstorff@siemens.com>
References: <20230502153759.1284906-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 May 2023 15:38:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11385

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Mostly quoting errors but also a non working assignment and
missing paths to executables.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/encrypt_partition.systemd.hook      |  2 +-
 .../files/encrypt_partition.systemd.script    | 28 +++++++++----------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
index 4f7263b..077f43a 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
@@ -43,7 +43,7 @@ copy_exec /usr/bin/systemd-cryptenroll || hook_error "/usr/bin/systemd-cryptenro
 copy_exec /usr/lib/systemd/systemd-cryptsetup || hook_error "/usr/lib/systemd/systemd-cryptsetup not found"
 
 copy_exec /usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so || hook_error "/usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so not found"
-if [ -x cryptsetup-reencrypt ]; then
+if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
     copy_exec /usr/sbin/cryptsetup-reencrypt
 fi
 
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
index 468b308..927184c 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
@@ -41,7 +41,7 @@ partition_sets="$PARTITIONS"
 create_file_system_cmd="$CREATE_FILE_SYSTEM_CMD"
 
 if [ -z "${create_file_system_cmd}" ]; then
-	create_file_system_cmd = "mke2fs -t ext4"
+	create_file_system_cmd="mke2fs -t ext4"
 fi
 
 open_tpm2_partition() {
@@ -73,17 +73,17 @@ enroll_tpm2_token() {
 
 reencrypt_existing_partition() {
 	part_device=$(readlink -f "$partition")
-	part_size_blocks=$(cat /sys/class/block/"$(awk -v dev=$part_device 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)
+	part_size_blocks=$(cat /sys/class/block/"$(awk -v dev="$part_device" 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)
 	# reduce the filesystem and partition by 32M to fit the LUKS header
 	reduce_device_size=32768
-	reduced_size=$(expr $part_size_blocks - 65536 )
-	reduced_size_in_byte=$(expr $reduced_size \* 512)
-	reduced_size_in_kb=$(expr $reduced_size_in_byte / 1024)K
+	reduced_size=$(expr "$part_size_blocks" - 65536 )
+	reduced_size_in_byte=$(expr "$reduced_size" \* 512)
+	reduced_size_in_kb=$(expr "$reduced_size_in_byte" / 1024)K
 	resize2fs "$1" "${reduced_size_in_kb}"
-	if [ -x cryptsetup-reencrypt ]; then
-		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k $1 < $2
+	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
+		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k "$1" < "$2"
 	else
-		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k $1 < $2
+		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$1" < "$2"
 	fi
 
 }
@@ -93,10 +93,10 @@ if [ ! -e "$tpm_device" ]; then
 fi
 
 for partition_set in $partition_sets; do
-	partition_label=$(awk -v var=$partition_set 'BEGIN{split(var,a,":"); print a[1]}')
-	partition_mountpoint=$(awk -v var=$partition_set 'BEGIN{split(var,a,":"); print a[2]}')
-	partition_format=$(awk -v var=$partition_set 'BEGIN{split(var,a,":"); print a[3]}')
-	partition=/dev/disk/by-partlabel/$partition_label
+	partition_label=$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')
+	partition_mountpoint=$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')
+	partition_format=$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[3]}')
+	partition=/dev/disk/by-partlabel/"$partition_label"
 	crypt_mount_name="encrypted_$partition_label"
 	decrypted_part=/dev/mapper/"$crypt_mount_name"
 
@@ -104,7 +104,7 @@ for partition_set in $partition_sets; do
 	if /usr/sbin/cryptsetup luksDump --batch-mode "$partition" \
 			| grep -q "systemd-tpm2"; then
 		open_tpm2_partition "$partition"
-		if ! mount -t $(get_fstype "${decrypted_part}") "${decrypted_part}" \
+		if ! mount -t "$(get_fstype "${decrypted_part}")" "${decrypted_part}" \
 			 "${rootmnt}${partition_mountpoint}"; then
 			panic "Can't mount encrypted partition '${decrypted_part}'!"
 		fi
@@ -134,7 +134,7 @@ for partition_set in $partition_sets; do
 		 ;;
 	esac
 
-	if ! mount -t $(get_fstype "${decrypted_part}") "${decrypted_part}" \
+	if ! mount -t "$(get_fstype "${decrypted_part}")" "${decrypted_part}" \
 		 "${rootmnt}${partition_mountpoint}"; then
 		panic "Can't mount encrypted partition '${decrypted_part}'!"
 	fi
-- 
2.39.2


