Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA81C02181
	for <webhook@archiver.kernel.org>; Mon, 20 Jan 2025 12:34:53 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.35549.1737376491818166579
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Jan 2025 04:34:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=X3YkN7uZ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1326448-20250120123448a99583464cbaf606d1-vowj_c@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20250120123448a99583464cbaf606d1
        for <cip-dev@lists.cip-project.org>;
        Mon, 20 Jan 2025 13:34:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=V2OyFU4otP9avXGy0VNyLG+7LSeyjPPohNxPny0HnuU=;
 b=X3YkN7uZamEvGxSnkKKfcKMQ+nNrwLLp2aVi7tRDNp/QkONbcc3qqyQ0oloBa12rwp7ud6
 lBrE30GiWi++dXve3/SYBaKvwLRVrN+P4PROrfHPngDMNsP4icfJe6djMQUk4iLIdM0CstlU
 jsE6h1M64qUsFNy3IJNqhXkOC0HZf9HEOAA3/+rIkWsyOPtkAy5ZbiJddkemWhe/0CBTdqgs
 nm4vvMjblYm3t0r88GEuOcyyr5DzWvuUhBc8o57AdcKZQmf0ok2C+gE89Xh7oZLHF8YOwJKD
 zdvRgS+ZaFz+unOiLolnWCvupg24htpZHdyR560yC2dGS1UCxY9W58aQ==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH] initramfs-crypt-hook: Optimize disk encryption in combination with expansion of last partition
Date: Mon, 20 Jan 2025 13:34:25 +0100
Message-ID: <20250120123425.79292-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1326448:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jan 2025 12:34:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17548

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
 .../files/local-top-complete                  | 37 +++++++++++++++++--
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 8adc4e5..c4135c3 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -153,6 +153,35 @@ expand_partition() {
 	# Inform the kernel about the partitioning change
 	partx -u "${last_part}"
 
+	last_part_device_name=${last_part#\/dev/}
+
+	mount_point=$(mktemp -d -p "" "$(basename "$0").XXXXXXXXXX")
+
+	mapping_name=$(cat /sys/class/block/"$last_part_device_name"/holders/*/dm/name)
+	cryptsetup resize "$mapping_name"
+	mount /dev/mapper/"$mapping_name" "${mount_point}"
+	fs_type=$(findmnt -fno FSTYPE "${mount_point}" )
+	last_part=/dev/mapper/"$mapping_name"
+
+	case ${fs_type} in
+	ext*)
+
+		# Do not fail resize2fs if no mtab entry is found, e.g.,
+		# when using systemd mount units.
+		export EXT2FS_NO_MTAB_OK=1
+		resize2fs "${last_part}"
+		;;
+	btrfs)
+		btrfs filesystem resize max "${mount_point}"
+		;;
+	*)
+		log_warning_msg "Unrecognized filesystem type ${fs_type} - no resize performed"
+		;;
+	esac
+
+	umount "${mount_point}"
+	rmdir "${mount_point}"
+
 	log_end_msg
 }
 
@@ -215,10 +244,6 @@ for partition_set in $partition_sets; do
 		echo "ROOT=$decrypted_part" >/conf/param.conf
 	fi
 
-	if [ "$partition_expand" = "expand" ]; then
-		expand_partition $part_device
-	fi
-
 	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
 			| grep -q "luks2"; then
 		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
@@ -259,6 +284,10 @@ for partition_set in $partition_sets; do
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


