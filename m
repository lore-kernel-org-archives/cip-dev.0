Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C022AC64991
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 07:31:29 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web12.22583.1661931086804511377
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 00:31:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=LoF694yh;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225,
 mailfrom: fm-294854-202208310731240c03233d5300afb99b-phjr_m@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 202208310731240c03233d5300afb99b
        for <cip-dev@lists.cip-project.org>;
        Wed, 31 Aug 2022 09:31:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=13+PIAm3CPw/Cq9H2UhWE1U3soBq3wnkXk5PuU0PODU=;
 b=LoF694yhj7SKJlHslTjTpuqgs4uHmOfpovca7ePqiwEaSI+3v+2Iu6hBMSVBx+WBfpZMaK
 QpEkNkmGbgffwQvCdGAM/IgNI56PV3zw81mVwh4c7i1I62UOSjWsejtj3z79kfJMnYwsYKr7
 aail7BeBzctP87utW6GEHc87KPY/4=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 6/6] Enable BeagleBone Black images with A/B
 SWUpdate support
Date: Wed, 31 Aug 2022 09:31:21 +0200
Message-Id: 
 <c8d5fc471ca1d3d1877d32c894a664086f8c858b.1661931081.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1661931081.git.jan.kiszka@siemens.com>
References: <cover.1661931081.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 07:31:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9330

From: Jan Kiszka <jan.kiszka@siemens.com>

We only needs to add the related wks file and configure the EBG watchdog
timeout to 0, and then also this target can gain support for A/B rootfs
SWUpdate with EFI Boot Guard as switcher.

Note that some extra kernel parameters are needed so that the omap_wdt
is properly taken over by the kernel from U-Boot but without petting it
too early during boot. This must only be done once userspace open the
device and signals real system readiness.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                     |  2 +-
 conf/machine/bbb.conf       |  3 +++
 wic/bbb-efibootguard.wks.in | 21 +++++++++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 wic/bbb-efibootguard.wks.in

diff --git a/Kconfig b/Kconfig
index c63000b..d87e0a6 100644
--- a/Kconfig
+++ b/Kconfig
@@ -132,7 +132,7 @@ if IMAGE_FLASH && !KERNEL_4_4 && !KERNEL_4_19
 
 config IMAGE_SWUPDATE
 	bool "SWUpdate support for root partition"
-	depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
+	depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB
 
 config IMAGE_SECURE_BOOT
 	bool "Secure boot support"
diff --git a/conf/machine/bbb.conf b/conf/machine/bbb.conf
index eaec5a3..c8b4aaa 100644
--- a/conf/machine/bbb.conf
+++ b/conf/machine/bbb.conf
@@ -18,4 +18,7 @@ IMAGE_INSTALL += "u-boot-script"
 USE_CIP_KERNEL_CONFIG = "1"
 KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/cip_bbb_defconfig"
 
+# for SWUpdate setups: watchdog is configured in U-Boot
+WDOG_TIMEOUT = "0"
+
 PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-bbb"
diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-efibootguard.wks.in
new file mode 100644
index 0000000..e48cc7f
--- /dev/null
+++ b/wic/bbb-efibootguard.wks.in
@@ -0,0 +1,21 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2019-2022
+#
+# SPDX-License-Identifier: MIT
+#
+
+part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/MLO" --no-table --align 128
+part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/u-boot.img" --no-table --align 384
+
+include ebg-sysparts.inc
+
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
+
+# home and var are extra partitions
+part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
+part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G
+
+bootloader --ptable gpt --append="rootwait console=ttyO0,115200 omap_wdt.early_enable=1 omap_wdt.nowayout=1 watchdog.handle_boot_enabled=0"
-- 
2.35.3


