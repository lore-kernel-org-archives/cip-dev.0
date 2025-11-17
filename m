Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19FECEACEF
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 17:15:24 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14789.1763399721869612222
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Nov 2025 09:15:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=AWHUfopx;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-20251117171518a4a2af52900002076e-bwk4xx@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20251117171518a4a2af52900002076e
        for <cip-dev@lists.cip-project.org>;
        Mon, 17 Nov 2025 18:15:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=lSNOOYpWqn4KHE+doCo2LxZstv4OCAnVw2lvqufe3zI=;
 b=AWHUfopx/LvUlIGtO5Qx6A9Dw+ua2dFYVRArL3LgCfXpyI0EfSEKfbYqS6cRHeuMdj8Uki
 kHQGagWJhPeg0QTkJeNNZVvk5bChxWQKWglW2zNdwXCBqgrARGjaEMC4Tb8eG8GDvcd2jbrl
 orJgObz6lDaiZoCgZHGplrPfh4OPOz/jbIhf66pDmYHHq3iTwhNDwLKQxLQC7GL9+TbtZvI2
 n/n7QpKZjT+e27r2JdmHZCKn1eRSOASdMnYQKeQza/GmFlZDndzBH1GKLI/9idQ31KLPgOu2
 OoZQzBoKI6G2GbW0CIroztH4trg80ok70rJuvP41KM7MbEnmF6bNzGQA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: [isar-cip-core][PATCH 4/6] linux-cip: Refactor KERNEL_DEFCONFIG initialization
Date: Mon, 17 Nov 2025 18:15:15 +0100
Message-ID: <f5bc4f95bb015c8b06b99b92ef490a296733c0ff.1763399717.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1763399717.git.jan.kiszka@siemens.com>
References: <cover.1763399717.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Nov 2025 17:15:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20601

From: Jan Kiszka <jan.kiszka@siemens.com>

Now that all targets are on cip_merged_defconfig, we can make this the
standard value of KERNEL_DEFCONFIG if USE_CIP_KERNEL_CONFIG is set.
This is logically best done in cip-kernel-config.inc.

While at it, switch to bb.utils.to_boolean for the evaluation of
USE_CIP_KERNEL_CONFIG.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/machine/bbb.conf                      |  1 -
 conf/machine/hihope-rzg2m.conf             |  1 -
 conf/machine/iwg20m.conf                   |  1 -
 conf/machine/qemu-amd64.conf               |  1 -
 conf/machine/qemu-arm.conf                 |  1 -
 conf/machine/qemu-arm64.conf               |  1 -
 conf/machine/qemu-riscv64.conf             |  2 --
 conf/machine/ti-am62px-sk.conf             |  1 -
 conf/machine/x86-uefi.conf                 |  1 -
 recipes-kernel/linux/cip-kernel-config.inc | 12 ++++++++++--
 recipes-kernel/linux/linux-cip-common.inc  |  3 ---
 11 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/conf/machine/bbb.conf b/conf/machine/bbb.conf
index cd1e09be..40af2dc0 100644
--- a/conf/machine/bbb.conf
+++ b/conf/machine/bbb.conf
@@ -14,7 +14,6 @@ IMAGER_INSTALL:wic += "u-boot-bbb ${SYSTEMD_BOOTLOADER_INSTALL}"
 IMAGER_BUILD_DEPS += "u-boot-bbb"
 
 USE_CIP_KERNEL_CONFIG = "1"
-KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/cip_merged_defconfig"
 
 # for SWUpdate setups: watchdog is configured in U-Boot
 WDOG_TIMEOUT = "0"
diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-rzg2m.conf
index 485683b2..a09e4a71 100644
--- a/conf/machine/hihope-rzg2m.conf
+++ b/conf/machine/hihope-rzg2m.conf
@@ -13,7 +13,6 @@ DISTRO_ARCH = "arm64"
 
 IMAGE_FSTYPES ?= "wic"
 
-KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/cip_merged_defconfig"
 USE_CIP_KERNEL_CONFIG = "1"
 DTB_FILES = "r8a774a1-hihope-rzg2m-ex.dtb"
 IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"
diff --git a/conf/machine/iwg20m.conf b/conf/machine/iwg20m.conf
index a5b2ecd3..ace7b9ac 100644
--- a/conf/machine/iwg20m.conf
+++ b/conf/machine/iwg20m.conf
@@ -16,7 +16,6 @@ BAUDRATE_TTY = "115200"
 
 # Setting for kernel and boot
 USE_CIP_KERNEL_CONFIG = "1"
-KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/cip_merged_defconfig"
 DTB_FILES = "r8a7743-iwg20d-q7-dbcm-ca.dtb"
 KERNEL_IMAGE="zImage"
 IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"
diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
index 7db2a9db..d8f5453c 100644
--- a/conf/machine/qemu-amd64.conf
+++ b/conf/machine/qemu-amd64.conf
@@ -10,6 +10,5 @@ DISTRO_ARCH = "amd64"
 
 IMAGE_FSTYPES ?= "ext4"
 USE_CIP_KERNEL_CONFIG = "1"
-KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_merged_defconfig"
 
 PREFERRED_PROVIDER_factory-reset-helper:swupdate = "factory-reset-helper-efi"
diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
index 551494b8..17c01fa6 100644
--- a/conf/machine/qemu-arm.conf
+++ b/conf/machine/qemu-arm.conf
@@ -11,7 +11,6 @@ DISTRO_ARCH = "armhf"
 
 IMAGE_FSTYPES ?= "ext4"
 USE_CIP_KERNEL_CONFIG = "1"
-KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/cip_merged_defconfig"
 
 # watchdog is not yet supported in our QEMU executor for this platform, disable it
 WDOG_TIMEOUT = "0"
diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
index cd8187b6..3d590e1c 100644
--- a/conf/machine/qemu-arm64.conf
+++ b/conf/machine/qemu-arm64.conf
@@ -12,7 +12,6 @@ IMAGE_FSTYPES ?= "ext4"
 IMAGE_FSTYPES:append:ftpm-stmm = " qemu-emmc"
 
 USE_CIP_KERNEL_CONFIG = "1"
-KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/cip_merged_defconfig"
 
 # watchdog is not yet supported in our QEMU executor for this platform, disable it
 WDOG_TIMEOUT = "0"
diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-riscv64.conf
index 5d45c0ec..281c4249 100644
--- a/conf/machine/qemu-riscv64.conf
+++ b/conf/machine/qemu-riscv64.conf
@@ -14,7 +14,5 @@ DISTRO_ARCH = "riscv64"
 IMAGE_FSTYPES ?= "ext4"
 USE_CIP_KERNEL_CONFIG = "1"
 
-KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/riscv/cip_merged_defconfig"
-
 # watchdog is not yet supported in our QEMU executor for this platform, disable it
 WDOG_TIMEOUT = "0"
diff --git a/conf/machine/ti-am62px-sk.conf b/conf/machine/ti-am62px-sk.conf
index bf3cf9ab..beabac9e 100644
--- a/conf/machine/ti-am62px-sk.conf
+++ b/conf/machine/ti-am62px-sk.conf
@@ -23,6 +23,5 @@ IMAGE_BOOT_FILES = " \
     /usr/lib/u-boot/${MACHINE}/tiboot3-am62px-hs-fs-evm.bin;tiboot3.bin"
 
 USE_CIP_KERNEL_CONFIG = "1"
-KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/cip_merged_defconfig"
 
 WDOG_TIMEOUT = "0"
diff --git a/conf/machine/x86-uefi.conf b/conf/machine/x86-uefi.conf
index 28ef245f..6bb607a9 100644
--- a/conf/machine/x86-uefi.conf
+++ b/conf/machine/x86-uefi.conf
@@ -12,6 +12,5 @@ IMAGE_FSTYPES ?= "wic"
 WKS_FILE ?= "x86_64-generic.wks"
 IMAGER_INSTALL:wic += "${GRUB_BOOTLOADER_INSTALL}"
 USE_CIP_KERNEL_CONFIG = "1"
-KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_merged_defconfig"
 
 PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-efi"
diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index e944a128..407404ed 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -12,11 +12,19 @@
 SRC_URI:append = " ${@ \
     'git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;protocol=https;branch=master;destsuffix=cip-kernel-config;name=cip-kernel-config \
     file://no-tpm-hwrng.cfg' \
-    if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
+    if bb.utils.to_boolean(d.getVar('USE_CIP_KERNEL_CONFIG')) else '' \
     }"
 
 SRCREV_cip-kernel-config ?= "ba0204aa6c1c5a41dcb4fa1087b5ef5dd3ebf81f"
 
 do_fetch[vardeps] += "SRCREV_cip-kernel-config"
 
-KBUILD_DEPENDS:append = "${@', lzop, lz4' if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else ''}"
+KERNEL_DEFCONFIG_VERSION ?= "${KERNEL_MAJOR_MINOR}.y-cip"
+KERNEL_DEFCONFIG ?= "${@ \
+    'cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/${KERNEL_ARCH}/cip_merged_defconfig' \
+    if bb.utils.to_boolean(d.getVar('USE_CIP_KERNEL_CONFIG')) else \
+    '${MACHINE}_defconfig'}"
+
+KBUILD_DEPENDS:append = "${@ \
+    ', lzop, lz4' \
+    if bb.utils.to_boolean(d.getVar('USE_CIP_KERNEL_CONFIG')) else ''}"
diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index aa625674..8200c617 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -11,9 +11,6 @@
 
 FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
 
-KERNEL_DEFCONFIG_VERSION ?= "${KERNEL_MAJOR_MINOR}.y-cip"
-KERNEL_DEFCONFIG ?= "${MACHINE}_defconfig"
-
 require recipes-kernel/linux/linux-custom.inc
 require recipes-kernel/linux/cip-kernel-config.inc
 
-- 
2.51.0


