Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2F0C83F10
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 09:16:28 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.55700.1751879784441193449
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Jul 2025 02:16:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=Aao30M/B;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-20250707091621bf1daffc89babce280-mvr11o@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250707091621bf1daffc89babce280
        for <cip-dev@lists.cip-project.org>;
        Mon, 07 Jul 2025 11:16:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=GZKqngNRPq65dACgfONJ3TZGW2c58jLyZiEXfeCyWho=;
 b=Aao30M/Be86lHCVW26waTXwNsSu+kHdqhWAaU/HIUj+pYRntfamrsFFG/BazSbEi2XImBx
 +GyvcS9Ld4QkkPq46jJE1RVR/zWFb+PBbaEI1EqN9W1drjCuxdfSA41/3GB8te9KFecrJwBP
 Xa2G3VpY7Ea2yTX+395YrM6GPA7wluaryYZcvBGs8fDDuzDYYS0+sQis70JJZvUVjJd2rzd0
 wiArKMIiNfO9IM2kQR34+RGaM3R3T1HAFI4nAYEYqNTiXQL8DQDY2Ap8shxPUShuHE2fpx3U
 p1D+sIg02Cj8TtoIzUfAzew5BI8IEVndcpIcstf/RkCrixgwWcbxI8xA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Heinisch Alexander <alexander.heinisch@siemens.com>,
	Cetin Gokhan <gokhan.cetin@siemens.com>
Subject: [isar-cip-core][PATCH v9 6/8] initramfs-crypt-hook: add re-encryption recovery
Date: Mon,  7 Jul 2025 11:16:18 +0200
Message-ID: <1c6d1caa1a062487ccc56ea1405757e15767cc93.1751879779.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1751879779.git.jan.kiszka@siemens.com>
References: <cover.1751879779.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Jul 2025 09:16:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19376

From: Claudius Heine <ch@denx.de>

Integrate detection and recovery of power failures while a partition is
being encrypted.

There are possible scenarios:
1. Power-fail happens while the partition is reencrypted:
  - The LUKS header contains `online-reencrypt-v2` and needs to be
    repaired with `cryptsetup repair` before it can continue.
  - Also no resizing of the file system is necessary
2. Power-fail happens before the systemd-tpm2/clevis token can be installed
  - The LUKS header does not contain 'systemd-tpm2'/'clevis', thus it
    needs to be registered and the temporary encryption key needs to be
    removed

The list of these scenarios is not complete, there might be other
instances where a sudden power-fail could be fatal to the system, but
these where the most obvious and risky ones.

Signed-off-by: Claudius Heine <ch@denx.de>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../files/local-top-complete                  | 26 ++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 6d5feda8..f93f2a92 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -75,6 +75,9 @@ reencrypt_existing_partition() {
 	reduced_size="$(expr "$part_size_blocks" - 65536 )"
 	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
 	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
+
+	CRYPTSETUP_PARAMS="--reduce-device-size ${reduce_device_size}k"
+
 	case $partition_fstype in
 	ext*)
 		# reduce the filesystem and partition by 32M to fit the LUKS header
@@ -93,14 +96,25 @@ reencrypt_existing_partition() {
 	squashfs|swap|erofs|"")
 		[ "$debug" = "y" ] && echo "skip disk resize as it is not supported or unnecessary for fstype: '$partition_fstype'"
 		;;
+	luks)
+		# Check if reencrypt was aborted
+		if /usr/sbin/cryptsetup luksDump --batch-mode "$1" \
+				| grep -q "online-reencrypt-v2"; then
+			/usr/sbin/cryptsetup repair --batch-mode "$1" < "$2" || \
+				panic "cryptsetup repair was not successful"
+		fi
+
+		# already luks partition, don't resize
+		CRYPTSETUP_PARAMS=""
+		;;
 	*)
 		panic "cannot resize partition, unsupported fstype: '$partition_fstype'"
 		;;
 	esac
 	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
-		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k "$1" < "$2"
+		/usr/sbin/cryptsetup-reencrypt --new ${CRYPTSETUP_PARAMS} "$1" < "$2"
 	else
-		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$1" < "$2"
+		/usr/sbin/cryptsetup reencrypt --encrypt ${CRYPTSETUP_PARAMS} "$1" < "$2"
 	fi
 }
 
@@ -236,11 +250,17 @@ for partition_set in $partition_sets; do
 	fi
 
 	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
-			| grep -q "luks2"; then
+			| grep -q "systemd-tpm2\|clevis"; then
 		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
 		continue
 	fi
 
+	# If partition contains an aborted reencrypt luks header, switch to reencrypt mode:
+	if /usr/sbin/cryptsetup luksDump --batch-mode "${part_device}" \
+			| grep -q "online-reencrypt-v2"; then
+		partition_format="reencrypt"
+	fi
+
 	# service watchdog in the background during lengthy re-encryption
 	if [ -z "$watchdog_pid" ]; then
 		service_watchdog &
-- 
2.43.0


