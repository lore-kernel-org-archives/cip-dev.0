Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A023C64EC4
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 13:12:56 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.21964.1677847759828263477
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Mar 2023 04:49:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=pQJuVpHb;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-72506-20230303124917bf515024b7d5737943-uuwruy@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230303124917bf515024b7d5737943
        for <cip-dev@lists.cip-project.org>;
        Fri, 03 Mar 2023 13:49:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=TELIHZsy6JEg2raK+LfsmtaurnSPk0fNmDPxGUX2DEE=;
 b=pQJuVpHbodEXCbSqt1oDYuqRx6fQp7p60IcoA2nMnkjFHIjeOs9KRGmr01dWRWbluM8IsN
 RbqXpse9yEH1Sb1iPQ2ki+6bpGoPqqwfvlAT6Pl9wkQ9wYysyKVxDRIR+Y8gknNCObGN/LuG
 DmR+oSVW8JfTaIgFrgMaPVMW2/Qkw=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v4 7/8] add swupdate support for qemu-riscv64
Date: Fri,  3 Mar 2023 12:48:19 +0000
Message-Id: <20230303124820.2209954-8-felix.moessbauer@siemens.com>
In-Reply-To: <20230303124820.2209954-1-felix.moessbauer@siemens.com>
References: <20230303124820.2209954-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 13:12:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10912

This patch enables the swupdate KConfig entry for the qemu-riscv64
board. For that, we also duplicate the qemu-arm64-efibootguard.wks
template for qemu-riscv64. As this is the first riscv64 board, we do not
symlink but create a copy.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 Kconfig                              |  2 +-
 kas/opt/ebg-swu.yml                  |  1 +
 wic/qemu-riscv64-efibootguard.wks.in | 13 +++++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)
 create mode 100644 wic/qemu-riscv64-efibootguard.wks.in

diff --git a/Kconfig b/Kconfig
index a932bbe..7d72094 100644
--- a/Kconfig
+++ b/Kconfig
@@ -181,7 +181,7 @@ if IMAGE_FLASH && !KERNEL_4_4 && !KERNEL_4_19
 
 config IMAGE_SWUPDATE
 	bool "SWUpdate support for root partition"
-	depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB
+	depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB || ( TARGET_QEMU_RISCV64 && KERNEL_6_1_MAINLINE )
 
 config IMAGE_SECURE_BOOT
 	bool "Secure boot support"
diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index 6bc893b..203a6b9 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -32,3 +32,4 @@ local_conf_header:
     # Add U-Boot for qemu
     IMAGER_BUILD_DEPS:append:qemu-arm64 = " u-boot-qemu-arm64"
     IMAGER_BUILD_DEPS:append:qemu-arm = " u-boot-qemu-arm"
+    IMAGER_BUILD_DEPS:append:qemu-riscv64 = " opensbi-qemu-riscv64"
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


