Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF40C02182
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 14:28:21 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.44618.1737556098249213532
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 06:28:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=H9T+BS3S;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1326448-202501221428155b666ee1f6ccdcbd00-se72zy@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202501221428155b666ee1f6ccdcbd00
        for <cip-dev@lists.cip-project.org>;
        Wed, 22 Jan 2025 15:28:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=qK+/7FTiyzntfPzRCOEDTyd/+foJ8ZG1DXpajQtoy+s=;
 b=H9T+BS3SrteOQDbGYNFWEkn9CRVUlm3E5B+uoiy6SpiNE+owNjVV1F3vAs0G14rPaKRkfK
 K2TnnPVqo6nnON5Uwe413vdAyzG7xjGtXKVcfytrRU+t2p+tkjUUNOOwXZv3WY/WsQNRBMrG
 aiUQ6CugIxpMkkYzO/zatEYVjWnlxqEDpDXk14pSkzPihf19QVNLy5+SjNdCyNRGEDHOIlI/
 gwavFSINI797AcewTYXUgLrNPn/zj/hAz23lFgO7IAgItcUWwmeAHpQL9gLytK3LxP6mCv6k
 8p2pbXUwuuTu6leqIh1c/hzucYCPUzdFRTJCuTSliFoZQ5IuOFSKYDiA==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v2] initramfs-crypt-hook: Optimize disk encryption in combination with expansion of last partition
Date: Wed, 22 Jan 2025 15:28:11 +0100
Message-ID: <20250122142811.106525-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1326448:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 14:28:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17595

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

Changes v2:
- Reuse get_fstype from mkinitramfs scripts/functions. 
  Therefore, we could also get rid of mounting the partition
- Dropped support for btrfs (compared to v1) since crypt hook
  does not support btrfs anyways

 .../files/local-top-complete                  | 28 ++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 8adc4e5..0146f58 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -153,6 +153,26 @@ expand_partition() {
 	# Inform the kernel about the partitioning change
 	partx -u "${last_part}"
 
+	last_part_device_name=${last_part#\/dev/}
+
+	mapping_name=$(cat /sys/class/block/"$last_part_device_name"/holders/*/dm/name)
+	cryptsetup resize "$mapping_name"
+	last_part_mapped=/dev/mapper/"$mapping_name"
+	fs_type=$(get_fstype ${last_part_mapped})
+
+	case ${fs_type} in
+	ext*)
+
+		# Do not fail resize2fs if no mtab entry is found, e.g.,
+		# when using systemd mount units.
+		export EXT2FS_NO_MTAB_OK=1
+		resize2fs "${last_part_mapped}"
+		;;
+	*)
+		log_warning_msg "Unrecognized filesystem type ${fs_type} - no resize performed"
+		;;
+	esac
+
 	log_end_msg
 }
 
@@ -215,10 +235,6 @@ for partition_set in $partition_sets; do
 		echo "ROOT=$decrypted_part" >/conf/param.conf
 	fi
 
-	if [ "$partition_expand" = "expand" ]; then
-		expand_partition $part_device
-	fi
-
 	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
 			| grep -q "luks2"; then
 		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
@@ -259,6 +275,10 @@ for partition_set in $partition_sets; do
 	esac
 
 	finalize_tpm2_encryption "$part_device"
+
+	if [ "$partition_expand" = "expand" ]; then
+		expand_partition $part_device
+	fi
 done
 
 if [ -n "$watchdog_pid" ]; then
-- 
2.39.5


