Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F05FCD12A4
	for <webhook@archiver.kernel.org>; Tue,  9 Apr 2024 13:06:51 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.135724.1712668002601964028
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Apr 2024 06:06:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=D77eIRET;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20240409130639412e549b238820a40c-77fsbl@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240409130639412e549b238820a40c
        for <cip-dev@lists.cip-project.org>;
        Tue, 09 Apr 2024 15:06:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=NaFR/n2lebjMguG9ktD6vHxvUptZL4wpnpzgeNTZUXs=;
 b=D77eIRETEa+tJFhPLkTLY/pY5j0iM59i40fA7Y1AGoSt6llVYo/vj5O3/QPA0FbFUVGtEM
 4Ng7aiSMLyFvwFt+u+NneqHY78+xvHaNOc9ArGJ/Uz7/e7kMA+W4+M9S3x0d1kk6VZl8IE9g
 f5wp89pZPOR/E6Xx99CJtuCgHzbp0=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	johnxw@amazon.com
Subject: [cip-dev][isar-cip-core][PATCH v3 03/15] initramfs-crypt-hook: move the mounting of encrypted disks in a seperate function
Date: Tue,  9 Apr 2024 15:05:20 +0200
Message-ID: <20240409130638.559398-4-Quirin.Gylstorff@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15519

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This increase the maintainability and avoids missing checks.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/encrypt_partition.clevis.script     | 20 +++++++++++--------
 .../files/encrypt_partition.systemd.script    | 20 +++++++++++--------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
index 4e76c44..0f82c1a 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
@@ -92,6 +92,16 @@ reencrypt_existing_partition() {
 	fi
 }
 
+mount_partition() {
+	partition_dev_path=$1
+	partition_mountpoint=$2
+	echo "mount device: '$partition' to '$partition_mountpoint'"
+	if ! mount -t "$(get_fstype "${partition_dev_path}")" "${partition_dev_path}" \
+		 "${partition_mountpoint}"; then
+		panic "Can't mount encrypted partition '${partition_dev_path}'!"
+	fi
+}
+
 if [ ! -e "$tpm_device" ]; then
 	panic "tpm device '$tpm_device' does not exists - cannot create a encrypted device!"
 fi
@@ -114,10 +124,7 @@ for partition_set in $partition_sets; do
 	if /usr/sbin/cryptsetup luksDump --batch-mode "$partition" \
 			| grep -q "clevis"; then
 		open_tpm2_partition "$part_device"
-		if ! mount -t "$(get_fstype "${decrypted_part}")" "${decrypted_part}" \
-			 "${rootmnt}${partition_mountpoint}"; then
-			panic "Can't mount encrypted partition '${decrypted_part}'!"
-		fi
+		mount_partition "$decrypted_part" "${rootmnt}""$partition_mountpoint"
 		continue
 	fi
 
@@ -150,10 +157,7 @@ for partition_set in $partition_sets; do
 		 ;;
 	esac
 
-	if ! mount -t "$(get_fstype "${decrypted_part}")" "${decrypted_part}" \
-		 "${rootmnt}${partition_mountpoint}"; then
-		panic "Can't mount encrypted partition '${decrypted_part}'!"
-	fi
+	mount_partition "$decrypted_part" "${rootmnt}""$partition_mountpoint"
 
 	# delete initial key
 	# afterwards no new keys can be enrolled
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
index f97a461..6c6d22e 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
@@ -102,6 +102,16 @@ reencrypt_existing_partition() {
 	fi
 }
 
+mount_partition() {
+	partition_dev_path=$1
+	partition_mountpoint=$2
+	echo "mount device: '$partition' to '$partition_mountpoint'"
+	if ! mount -t "$(get_fstype "${partition_dev_path}")" "${partition_dev_path}" \
+		 "${partition_mountpoint}"; then
+		panic "Can't mount encrypted partition '${partition_dev_path}'!"
+	fi
+}
+
 if [ ! -e "$tpm_device" ]; then
 	panic "tpm device '$tpm_device' does not exists - cannot create a encrypted device!"
 fi
@@ -118,11 +128,8 @@ for partition_set in $partition_sets; do
 	# check if partition is already encrypted with systemd-tpm2
 	if /usr/sbin/cryptsetup luksDump --batch-mode "$partition" \
 			| grep -q "systemd-tpm2"; then
-		if ! mount -t "$(get_fstype "${decrypted_part}")" "${decrypted_part}" \
-			 "${rootmnt}${partition_mountpoint}"; then
-			panic "Can't mount encrypted partition '${decrypted_part}'!"
-		fi
 		open_tpm2_partition "$part_device"
+		mount_partition "$decrypted_part" "${rootmnt}""$partition_mountpoint"
 		continue
 	fi
 
@@ -155,10 +162,7 @@ for partition_set in $partition_sets; do
 		 ;;
 	esac
 
-	if ! mount -t "$(get_fstype "${decrypted_part}")" "${decrypted_part}" \
-		 "${rootmnt}${partition_mountpoint}"; then
-		panic "Can't mount encrypted partition '${decrypted_part}'!"
-	fi
+	mount_partition "$decrypted_part" "${rootmnt}""$partition_mountpoint"
 
 	# delete initial key
 	# afterwards no new keys can be enrolled
-- 
2.43.0


