Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A96C02198
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 09:39:29 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.12049.1738229961102574227
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 01:39:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=ONJrfv7m;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-202501300939182e9dfeb6c8bae4e5d2-higbx2@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202501300939182e9dfeb6c8bae4e5d2
        for <cip-dev@lists.cip-project.org>;
        Thu, 30 Jan 2025 10:39:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=5qve6P4Fj9MG+wmzEVqJLK23zqS/L7xkLm8L6m8ImiA=;
 b=ONJrfv7moyc8PHiQaGs1CwJ31YQuJC2hZGpxVFWqdaHw0StOHofucN4RZTXbnKu45kdB/B
 y81nUpzJbKXI0/vomWbtr47lkqQrcw6kQx/G3ue/lzNRWL6JBZvLclQ1uiLILzjaDc0Uw2Y0
 kfTa0c4E/qGSUZFv71IaCTHtSUzM1GaTXOZY/FeKgYo+7mAJM+Rn50dYww0uNgxRgMbP1390
 xJNyoTX8o9XFPrEOZt0JZeiZ+HtO63zhPgNLlmKMe4i3zapJqZxAgD71C62gBY+T2HU27AHn
 I54g7G1R9/NnGW45W1FUqB5FlS361Glz5i2zyy219rUUe62MlR88kB5Q==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][RFC][PATCH 01/10] initramfs-crypt-hook: Add support for btrfs
Date: Thu, 30 Jan 2025 10:39:08 +0100
Message-ID: <e06e86fb58915dd43f79a73da790324aa9be13a2.1738229957.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1738229957.git.jan.kiszka@siemens.com>
References: <cover.1738229957.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 09:39:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17707

From: Jan Kiszka <jan.kiszka@siemens.com>

Add the required bits to support reencryption of btrfs, thus resizing.
To avoid bloating the initramfs if this filesystem is not used, make it
opt-in.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-crypt-hook/files/local-top-complete          | 7 +++++++
 .../initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb       | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 8adc4e58..54b8a6e0 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -85,6 +85,13 @@ EOF
 			panic "reencryption of partition $1 cannot continue - resizing of the partition failed!"
 		fi
 		;;
+	btrfs)
+		mkdir /.mnt-tmp
+		mount -t btrfs "$1" /.mnt-tmp
+		btrfs filesystem resize "${reduced_size_in_kb}" /.mnt-tmp
+		umount /.mnt-tmp
+		rmdir /.mnt-tmp
+		;;
 	squashfs|swap|erofs|"")
 		[ "$debug" = "y" ] && echo "skip disk resize as it is not supported or unnecessary for fstype: '$partition_fstype'"
 		;;
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb
index 71ee44db..df335c9f 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb
@@ -82,6 +82,8 @@ INITRAMFS_WATCHDOG_DEVICE ??= "/dev/watchdog"
 CRYPT_HASH_TYPE ??= "sha256"
 CRYPT_KEY_ALGORITHM ??= "ecc"
 CRYPT_ENCRYPTION_OPTIONAL ??= "false"
+# add support for btrfs encryption
+CRYPT_BTRFS_SUPPORT ??= "0"
 
 TEMPLATE_VARS += "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
     CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
@@ -92,6 +94,10 @@ OVERRIDES .= "${@':expand-on-crypt' if ':expand' in d.getVar('CRYPT_PARTITIONS')
 DEBIAN_DEPENDS:append:expand-on-crypt = ", fdisk, util-linux"
 HOOK_COPY_EXECS:append:expand-on-crypt = " sed sfdisk tail cut dd partx rm"
 
+OVERRIDES .= "${@':btrfs-support' if bb.utils.to_boolean(d.getVar('CRYPT_BTRFS_SUPPORT')) else ''}"
+DEBIAN_DEPENDS:append:btrfs-support = ", btrfs-progs"
+HOOK_COPY_EXECS:append:btrfs-support = " mkdir rmdir btrfs"
+
 do_install[cleandirs] += "${D}/usr/share/encrypt_partition"
 do_install:prepend() {
     install -m 0600 "${WORKDIR}/encrypt_partition.env" "${D}/usr/share/encrypt_partition/encrypt_partition.env"
-- 
2.43.0


