Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9CDC7EE33
	for <webhook@archiver.kernel.org>; Thu, 26 Jun 2025 09:09:51 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.3994.1750928981424036961
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Jun 2025 02:09:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=UumIGalL;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8BE6E1039BD41;
	Thu, 26 Jun 2025 11:09:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750928979; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UCh/yLRQeBHPNcWfGmwfwKt2tF90ph+qC6w4+v50qiI=;
	b=UumIGalLLmpO2tPLucQZ0E0+NIe9d28KGDm5aeIXbdjAt3oMTpTlUNzrXx4ESnLPjnn6qf
	JQqyyTjhSqblVHTv0F4+UAqYaqwCWZN5pHkG/k+wDvK4jVNMo6wfN3IC2tWd0DkjclLn2B
	nh6PemDrJoPOgZH/NdeRC4XZoPkKnMT+wmlePPgPtWrWgX6PMGv40qjGjb+JYh76DccR/j
	cGFA5hv7qLnL1E+OmK6qC3uhEnsN5o9LVXOEQzioZO2lgh3yJdRoAnq+9FhZ14mWJFvVy5
	xPcAsTqv2e0zoQ6tDvGuyVQnVo5ISJmu07DxdJWjYz4RBBI4dTSIo3xpqC3dNg==
From: Claudius Heine <ch@denx.de>
Date: Thu, 26 Jun 2025 11:09:25 +0200
Subject: [PATCH v8 2/4] initramfs-crypt-hook: add re-encryption recovery
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-initramfs-crypt-hook-patches-2-v8-2-46f000788686@denx.de>
References: <20250626-initramfs-crypt-hook-patches-2-v8-0-46f000788686@denx.de>
In-Reply-To: <20250626-initramfs-crypt-hook-patches-2-v8-0-46f000788686@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Quirin Gylstorff <quirin.gylstorff@siemens.com>, 
 Heinisch Alexander <alexander.heinisch@siemens.com>, 
 Cetin Gokhan <gokhan.cetin@siemens.com>, Claudius Heine <ch@denx.de>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Jun 2025 09:09:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19241

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
---
 .../initramfs-crypt-hook/files/local-top-complete  | 26 +++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 9e7525117a03debdf2c526ab742e9428372cd0cf..e773ec3e165f72de624a17872ed3fa74746f20d8 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -73,6 +73,9 @@ reencrypt_existing_partition() {
 	reduced_size="$(expr "$part_size_blocks" - 65536 )"
 	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
 	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
+
+	CRYPTSETUP_PARAMS="--reduce-device-size ${reduce_device_size}k"
+
 	case $partition_fstype in
 	ext*)
 		# reduce the filesystem and partition by 32M to fit the LUKS header
@@ -91,14 +94,25 @@ reencrypt_existing_partition() {
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
 
@@ -296,11 +310,17 @@ for partition_set in $partition_sets; do
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
2.50.0


