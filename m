Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B22CEACEF
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 17:26:35 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15086.1763400383450445911
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Nov 2025 09:26:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=D//hDF8/;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-20251117171518a25e2a601700020731-kjw9mk@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20251117171518a25e2a601700020731
        for <cip-dev@lists.cip-project.org>;
        Mon, 17 Nov 2025 18:15:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=VZg0Yps/TvsKz2207MBN9k1hwpzTqQFDzjYvrXTdf3I=;
 b=D//hDF8/yPjvOHknis2a6Bf4rWGw5pd35PWaaxDutSc6yzQs/xBTG0h1CetX7CCIUAIHVh
 SNvjVpBzdSFBBBT+I0FDJeWvHhfyOMaXaiHhIqujzsu6O46uDfqwlo46rGWvXV0ryaLEFsU7
 8DMtZxQTP0ay3Twf3kBBPBSqohU62BspgCL9gjA09AvVKpGuNuNy8Z4k4/ER5xtMu8pmk+7y
 AmJnPMB/VxFx+hdJFt1vjpfAH9OoDHBxteZulEb6Lcq3XMqucjK+mEFNWZVwLwHspGGWuZqY
 whDELo7i81oKSyVW3h5MSyBhEDIVef9Vqf67EwZY73swq1t9DM0lpUHA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: [isar-cip-core][PATCH 2/6] arm: Switch to cip_merged_defconfig
Date: Mon, 17 Nov 2025 18:15:13 +0100
Message-ID: <56eada8c1b57b74d7f6e3a2ff9def2e1f23c89d7.1763399717.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1763399717.git.jan.kiszka@siemens.com>
References: <cover.1763399717.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Nov 2025 17:26:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20603

From: Jan Kiszka <jan.kiszka@siemens.com>

Allows to use the same kernel for all arm64 targets. Tested on qemu and
bbb.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/machine/bbb.conf      | 4 ++--
 conf/machine/iwg20m.conf   | 2 +-
 conf/machine/qemu-arm.conf | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/conf/machine/bbb.conf b/conf/machine/bbb.conf
index af6b3299..cd1e09be 100644
--- a/conf/machine/bbb.conf
+++ b/conf/machine/bbb.conf
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2025
 #
 # SPDX-License-Identifier: MIT
 #
@@ -14,7 +14,7 @@ IMAGER_INSTALL:wic += "u-boot-bbb ${SYSTEMD_BOOTLOADER_INSTALL}"
 IMAGER_BUILD_DEPS += "u-boot-bbb"
 
 USE_CIP_KERNEL_CONFIG = "1"
-KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/cip_bbb_defconfig"
+KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/cip_merged_defconfig"
 
 # for SWUpdate setups: watchdog is configured in U-Boot
 WDOG_TIMEOUT = "0"
diff --git a/conf/machine/iwg20m.conf b/conf/machine/iwg20m.conf
index f5d5dda6..a5b2ecd3 100644
--- a/conf/machine/iwg20m.conf
+++ b/conf/machine/iwg20m.conf
@@ -16,7 +16,7 @@ BAUDRATE_TTY = "115200"
 
 # Setting for kernel and boot
 USE_CIP_KERNEL_CONFIG = "1"
-KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/renesas_shmobile_defconfig"
+KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/cip_merged_defconfig"
 DTB_FILES = "r8a7743-iwg20d-q7-dbcm-ca.dtb"
 KERNEL_IMAGE="zImage"
 IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"
diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
index 6e1192a1..551494b8 100644
--- a/conf/machine/qemu-arm.conf
+++ b/conf/machine/qemu-arm.conf
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2025
 # Copyright (c) TOSHIBA CORPORATION, 2021
 #
 # SPDX-License-Identifier: MIT
@@ -11,7 +11,7 @@ DISTRO_ARCH = "armhf"
 
 IMAGE_FSTYPES ?= "ext4"
 USE_CIP_KERNEL_CONFIG = "1"
-KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/qemu_arm_defconfig"
+KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/cip_merged_defconfig"
 
 # watchdog is not yet supported in our QEMU executor for this platform, disable it
 WDOG_TIMEOUT = "0"
-- 
2.51.0


