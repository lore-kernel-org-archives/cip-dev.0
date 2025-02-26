Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D4AC021B8
	for <webhook@archiver.kernel.org>; Wed, 26 Feb 2025 23:28:44 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.19793.1740612520662405980
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Feb 2025 15:28:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=MbUOk0BT;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1326448-20250226232837be96d1832208b5c50b-9p6raw@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20250226232837be96d1832208b5c50b
        for <cip-dev@lists.cip-project.org>;
        Thu, 27 Feb 2025 00:28:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=AY/OqTCOoHWVMqzVIbK/OvmZZx6c69NHw+TydkSAHjQ=;
 b=MbUOk0BTJRlHUK/GuAMM/XVOl2FJaulvfC5znsqgt0wSA6KorWTGow/6kOuD0WkXqnyo/8
 MXxPqydxt4U/BoSyyCLpiSwQoP5VEoEabHpLb0I0Xh6se9oeryjcantUhpUq4H/Ct8RNyxjq
 qDrwtnk0CRS3tpo8C1TKdl8oEkAKiFbrauCk+/tkKH0nMj0BXGhzqwNnJkd+5bQGO5cg7zMS
 M5VaGAnCt9K3bEc/alFmHTvCREaWZGB9m5mwZOMlpabqmkHKjNKJVYL9d8CZSa0vXY+AFdE/
 dOWrhkVLMAXACSxPAGdIgOKE60G6z5TNGiPjgAYXw1v7NGRsw3hgGmAw==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	jan.kiszka@siemens.com,
	clara.kowalsky@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v3] initramfs-crypt-hook: Optimize disk encryption in combination with expansion of last partition
Date: Thu, 27 Feb 2025 00:28:12 +0100
Message-ID: <20250226232812.374892-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1326448:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Feb 2025 23:28:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17924

From: Alexander Heinisch <alexander.heinisch@siemens.com>

In the current implementation (since: 284175c3) disk expansion logic
is done before the actual disk encryption.

This results in reencrypting the full expanded size of the disk, instead
of only reencrypting the sections containing the actual data. This results
in a drastic increase of time (approx 20x on our systems ) needed for reencryption!

Since relevant disk contents are only available in the sections of the disk
available before the expansion, it is sufficient to reencrypt them only.

This patch changes order of encryption and disk expansion resulting in
faster encryption (since only the necessary parts are encrypted).
The resize operation does not reencrypt the added disk parts but just
extends the LUKS container (cryptsetup resize) to reflect the maximum
available disk space.

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---

Changes v3:
- Provide key to cryptsetup resize for clevis based setups.
- removed export of EXT2FS_NO_MTAB_OK=1
- Added support to expand partitions with btrfs

Changes v2:
- Reuse get_fstype from mkinitramfs scripts/functions. 
  Therefore, we could also get rid of mounting the partition
- Dropped support for btrfs (compared to v1) since crypt hook
  does not support btrfs anyways

 .../files/local-top-complete                  | 37 +++++++++++++++++--
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 5ef7ca4..fac6db6 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -102,6 +102,8 @@ reencrypt_existing_partition() {
 }
 
 expand_partition() {
+	key_file="$2"
+
 	boot_device="$(echo "${part_device}" | sed 's/p\?[0-9]*$//')"
 	last_part="$(sfdisk -d "${boot_device}" 2>/dev/null | \
 		     tail -1 | cut -d ' ' -f 1)"
@@ -155,6 +157,33 @@ expand_partition() {
 	# Inform the kernel about the partitioning change
 	partx -u "${last_part}"
 
+	last_part_device_name=${last_part#\/dev/}
+
+	mapping_name=$(cat /sys/class/block/"$last_part_device_name"/holders/*/dm/name)
+	# systemd based systems do not need to have the
+	# key_file provided since systemd backend for 
+	# cryptsetup resolves the passphrase directly
+	cat $key_file | cryptsetup resize "$mapping_name"
+
+	last_part_mapped=/dev/mapper/"$mapping_name"
+	fs_type=$(get_fstype ${last_part_mapped})
+
+	case ${fs_type} in
+	ext*)
+		resize2fs "${last_part_mapped}"
+		;;
+	btrfs)
+		mkdir /.mnt-tmp
+		mount -t btrfs "${last_part_mapped}" /.mnt-tmp
+		btrfs filesystem resize max /.mnt-tmp
+		umount /.mnt-tmp
+		rmdir /.mnt-tmp
+		;;
+	*)
+		log_warning_msg "Unrecognized filesystem type ${fs_type} - no resize performed"
+		;;
+	esac
+
 	log_end_msg
 }
 
@@ -217,10 +246,6 @@ for partition_set in $partition_sets; do
 		echo "ROOT=$decrypted_part" >/conf/param.conf
 	fi
 
-	if [ "$partition_expand" = "expand" ]; then
-		expand_partition $part_device
-	fi
-
 	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
 			| grep -q "luks2"; then
 		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
@@ -260,6 +285,10 @@ for partition_set in $partition_sets; do
 		 ;;
 	esac
 
+	if [ "$partition_expand" = "expand" ]; then
+		expand_partition $part_device $tmp_key
+	fi
+
 	finalize_tpm2_encryption "$part_device"
 done
 
-- 
2.43.0


