Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4051C25B4F
	for <webhook@archiver.kernel.org>; Mon,  6 May 2024 14:18:44 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.21767.1715005119064229741
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 May 2024 07:18:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=MUHHjhXo;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20240506141837bfb813215830beb692-i5rah3@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240506141837bfb813215830beb692
        for <cip-dev@lists.cip-project.org>;
        Mon, 06 May 2024 16:18:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=pdU+I4P0CBYAPeYH3Hwr7y0zwB3m1lNg7jkmtNe6rmw=;
 b=MUHHjhXorMJjofDueZlWuKYNJq4pWLsjzOmccR9yv89AV46Nq2JJPTPgObO7jQZWMGPw22
 mWZ/jqB3gTCWlhgVIiZfR6O9C7b6RsbykAoxUKxzzQ1z+u1TSEF5NyoOyfH3YXHb2RhmUUoZ
 5VdEtMolXzZzlFwXB/c+GDyBjTfsA=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	johnxw@amazon.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 11/11] initramfs-crypt-hook: cleanup logging
Date: Mon,  6 May 2024 16:17:32 +0200
Message-ID: <20240506141833.3622989-12-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240506141833.3622989-1-Quirin.Gylstorff@siemens.com>
References: <20240506141833.3622989-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 May 2024 14:18:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15839

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Reduce the clutter during boot. Print messages only if debug is
set in the commandline.
Use the provided logging functionality.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.script   | 8 ++++++--
 .../files/mount_crypt_partitions.script                   | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
index d9a85e5..d48db94 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
@@ -78,7 +78,7 @@ reencrypt_existing_partition() {
 		fi
 		;;
 	squashfs|"")
-		echo "skip disk resize as it is not supported or unnecessary for fstype: '$partition_fstype'"
+		[ "$debug" = "y" ] && echo "skip disk resize as it is not supported or unnecessary for fstype: '$partition_fstype'"
 		;;
 	*)
 		panic "cannot resize parition. unsupport fstype: $partition_fstype"
@@ -112,7 +112,7 @@ done
 
 if [ ! -e "$tpm_device" ]; then
 	if [ "$tpm_encryption_optional" = "true" ]; then
-		echo "No tpm_device exists abort optional encryption"
+		log_warning_msg "No tpm_device exists abort optional encryption"
 		exit 0
 	fi
 	panic "No tpm device exists or supports pcr_hash '$pcr_bank_hash_type' or '$tpm_key_algorithm' - cannot create a encrypted device!"
@@ -167,16 +167,20 @@ for partition_set in $partition_sets; do
 
 	case "${partition_format}" in
 		"reencrypt")
+			log_begin_msg "Encryption of ${part_device}"
 			reencrypt_existing_partition "$part_device" "$tmp_key"
 			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_algorithm" "$pcr_bank_hash_type"
 			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
+			log_end_msg
 		;;
 		"format")
+			log_begin_msg "Encryption of ${part_device}"
 			/usr/sbin/cryptsetup luksFormat --batch-mode \
 				 --type luks2 "$partition" < "$tmp_key"
 			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_algorithm" "$pcr_bank_hash_type"
 			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
 			eval "${create_file_system_cmd} ${decrypted_part}"
+			log_end_msg
 		;;
 		*)
 			panic "Unknown value ${partition_format}. Cannot create a encrypted partition !"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/mount_crypt_partitions.script b/recipes-initramfs/initramfs-crypt-hook/files/mount_crypt_partitions.script
index f35685e..f47219b 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/mount_crypt_partitions.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/mount_crypt_partitions.script
@@ -35,7 +35,7 @@ esac
 mount_partition() {
 	partition_dev_path=$1
 	partition_mountpoint=$2
-	echo "mount device: '$partition_dev_path' to '$partition_mountpoint'"
+	[ "$debug" = "y" ] && echo "mount device: '$partition_dev_path' to '$partition_mountpoint'"
 	if ! mountpoint -q "${partition_mountpoint}"; then
 		if ! mount -t "$(get_fstype "${partition_dev_path}")" "${partition_dev_path}" \
 			 "${partition_mountpoint}"; then
-- 
2.43.0


