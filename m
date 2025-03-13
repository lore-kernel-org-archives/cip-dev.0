Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D903C35FF2
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 12:36:51 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.13385.1741869408273519332
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Mar 2025 05:36:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=LGbWnLP3;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 64DC51020E4ED;
	Thu, 13 Mar 2025 13:36:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741869406; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=smtn76XKyk1UwdRUycmZwPLKGszXF9Fe5VFkXFG99Vo=;
	b=LGbWnLP3ZGTaP5ZRsF+GWfDVNBIY53Q65DeNyd7kx+QdHvAY16aMxbwQOe/Kebga5DkxCE
	8P9Pb1jrRJAvU8kO08L5zqGm2x5wJQyrWpqpsXvJnxuh22czS7Y6TcSLkIthnV2xEpifr9
	5yON/8C4dOmvlkbA1yNwqw1NVo0Pn9HLKPqwmlwwyu0IYZUfcdmcvqhEpQg+Jon8sw251h
	ERfO09mwKn+z3scL/29esPGdKia0N3MjpvBJTDbFFiMSt9I94pS9oG0xhjfGTvmXxYCwTe
	092KX5X3JNOmtF0/010Kuqqm/YjUc/qQ6IRPVdlDZsbET/aGRIExIx9e07HDtw==
From: Claudius Heine <ch@denx.de>
Date: Thu, 13 Mar 2025 13:35:42 +0100
Subject: [PATCH v5 2/4] initramfs-crypt-hook: add re-encryption recovery
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-initramfs-crypt-hook-patches-2-v5-2-fc62d4a2ad29@denx.de>
References: <20250313-initramfs-crypt-hook-patches-2-v5-0-fc62d4a2ad29@denx.de>
In-Reply-To: <20250313-initramfs-crypt-hook-patches-2-v5-0-fc62d4a2ad29@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Quirin Gylstorff <quirin.gylstorff@siemens.com>, 
 Alexander <alexander.heinisch@siemens.com>, Claudius Heine <ch@denx.de>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 12:36:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18192

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
index e511e8ef2d0bd4f4c8fd2fca248312dee173d224..6df4cccee9c99653fa9869ca2e46ead549d6fc2d 100644
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
2.47.2


