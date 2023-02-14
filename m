Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D49DC61DA4
	for <webhook@archiver.kernel.org>; Tue, 14 Feb 2023 12:14:14 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.979.1676356206996562939
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Feb 2023 22:30:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=Q2y7Xqwq;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-72506-20230214063004cf9fb1b7e39ce2f1b1-wrvlrd@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230214063004cf9fb1b7e39ce2f1b1
        for <cip-dev@lists.cip-project.org>;
        Tue, 14 Feb 2023 07:30:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=H735EieT/N8+d2nFEzFpw9XCCAm3GKE7KLBwzZ3SUhc=;
 b=Q2y7Xqwq8RXpsw8BG3z+B+RsLeC1L4ttrL3xIj1UoUisAB7s1TYoMMw+RiCx/kRfPBTusg
 BX+O+b+XEG2a8549LsaLPEXiUZHWaRAGGHivyN/ozObqLzRB3Kj+tDdjdmiRVIM0OTGHbl+m
 Ld/CBXsvkfW86N55sTfP089qQZ9qw=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v2 3/3] add swupdate support for qemu-riscv64
Date: Tue, 14 Feb 2023 06:27:30 +0000
Message-Id: <20230214062730.1636598-4-felix.moessbauer@siemens.com>
In-Reply-To: <20230214062730.1636598-1-felix.moessbauer@siemens.com>
References: <20230214062730.1636598-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Feb 2023 12:14:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10695

This patch enables the swupdate KConfig entry for the qemu-riscv64
board. For that, we also duplicate the qemu-arm64-efibootguard.wks
template for qemu-riscv64. As this is the first riscv64 board, we do not
symlink but create a copy.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 Kconfig                              |  2 +-
 wic/qemu-riscv64-efibootguard.wks.in | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 wic/qemu-riscv64-efibootguard.wks.in

diff --git a/Kconfig b/Kconfig
index cd24ce2..b021f29 100644
--- a/Kconfig
+++ b/Kconfig
@@ -177,7 +177,7 @@ if IMAGE_FLASH && !KERNEL_4_4 && !KERNEL_4_19
 
 config IMAGE_SWUPDATE
 	bool "SWUpdate support for root partition"
-	depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB
+	depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB || TARGET_QEMU_RISCV64
 
 config IMAGE_SECURE_BOOT
 	bool "Secure boot support"
diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efibootguard.wks.in
new file mode 100644
index 0000000..d63fc3a
--- /dev/null
+++ b/wic/qemu-riscv64-efibootguard.wks.in
@@ -0,0 +1,13 @@
+# short-description: riscv64 with EFI Boot Guard and SWUpdate
+# long-description: Disk image for riscv64 machines with EFI Boot Guard and SWUpdate
+
+include ebg-sysparts.inc
+
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
+part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
+
+# home and var are extra partitions
+part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
+part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G
+
+bootloader --ptable gpt
-- 
2.34.1


