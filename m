Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D57CD1281
	for <webhook@archiver.kernel.org>; Tue, 19 Mar 2024 18:20:41 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.23428.1710872431643697743
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Mar 2024 11:20:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=RWacj8F7;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20240319182028b14c679819200105b4-so9yvp@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240319182028b14c679819200105b4
        for <cip-dev@lists.cip-project.org>;
        Tue, 19 Mar 2024 19:20:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=NaFR/n2lebjMguG9ktD6vHxvUptZL4wpnpzgeNTZUXs=;
 b=RWacj8F7FcL1epiHD2oiZaM4Wti5M3SHcZwRG9OAMRVRkKzsgu+WY31HwJMwQtKxmZucgT
 j2jM0145njQ9vv0z8zT5SOXowulysVradulkZrXtlxzRZZ2vpzgWYLrQF5dcMqQ7P7366GI9
 6EkGlGy4SX+MbdcKfuAEIH0CQoijs=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	johnxw@amazon.com
Subject: [cip-dev][isar-cip-core][RFC 3/8] initramfs-crypt-hook: move the mounting of encrypted disks in a seperate function
Date: Tue, 19 Mar 2024 19:18:27 +0100
Message-ID: <20240319182026.1571362-4-Quirin.Gylstorff@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15372

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


