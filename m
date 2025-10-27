Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D085CCF9F5
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 07:22:02 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.26400.1761549712486507065
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Oct 2025 00:21:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=SAjozR5i;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-20251027072150ef995a6384000207d3-jka8hj@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20251027072150ef995a6384000207d3
        for <cip-dev@lists.cip-project.org>;
        Mon, 27 Oct 2025 08:21:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=O32b7XAoN1CljXFLLUISv+6EZebCLWYC476C6kKVKJk=;
 b=SAjozR5i8cj0LXdWJN8plNDw0bkTuIlvESyF0VRTdRzq+39zErTkJfDVfY0HI+ZJnKCq4m
 LpP5rCiBE1OtWoH4sKtP12q3mok4JZR/JsYl+E+XZgggBdMjJLHzM6oBPkXiFoquAnkTaZ6p
 1U2sHa5QGjh/Ia4U+JkEvXBJT4EciLMQcZfwBv7vshXIfONB8JPzt2eqVr8y31JjZVVcZ6WY
 48Jf7PCwd//+vbImQIT1yRrJflFBBwXF1juahL5Rr8iQmVNbSwhJDLIJoPd08V8HQAve7OdD
 DGFPHSevV39e8EHMY2Z+YBp4HgjKzzSSrxHx9NETlauvDH+VVCvSrSmg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 08/19] u-boot-qemu: Add patches and config switch needed for eMMC boot
Date: Mon, 27 Oct 2025 08:21:37 +0100
Message-ID: <95aa9bf9d60d569ed57d4b90c41e088360b0572b.1761549708.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1761549708.git.jan.kiszka@siemens.com>
References: <cover.1761549708.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Oct 2025 07:22:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20235

From: Jan Kiszka <jan.kiszka@siemens.com>

Add 2 patches that are needed to boot from a PCI-attached eMMC. Both
will be available with v2026.01. Furthermore enable the required config
switches for all QEMU builds of U-Boot. Only ARM64 will use that soon,
but there is no reason to not have the others prepared already.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...onvert-SYS_EARLY_PCI_INIT-to-Kconfig.patch | 37 +++++++++++++++++++
 ...arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch | 28 ++++++++++++++
 recipes-bsp/u-boot/files/qemu-extra.cfg       |  7 ++++
 recipes-bsp/u-boot/u-boot-common-2025.07.inc  |  2 +
 4 files changed, 74 insertions(+)
 create mode 100644 recipes-bsp/u-boot/files/0001-Kconfig-Convert-SYS_EARLY_PCI_INIT-to-Kconfig.patch
 create mode 100644 recipes-bsp/u-boot/files/0002-qemu_arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch

diff --git a/recipes-bsp/u-boot/files/0001-Kconfig-Convert-SYS_EARLY_PCI_INIT-to-Kconfig.patch b/recipes-bsp/u-boot/files/0001-Kconfig-Convert-SYS_EARLY_PCI_INIT-to-Kconfig.patch
new file mode 100644
index 00000000..36c0ea8b
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0001-Kconfig-Convert-SYS_EARLY_PCI_INIT-to-Kconfig.patch
@@ -0,0 +1,37 @@
+From d3403a731b5b194a9e4e2ba67911e760dcd89207 Mon Sep 17 00:00:00 2001
+From: Fabio Estevam <festevam@gmail.com>
+Date: Thu, 14 Aug 2025 20:14:35 +0200
+Subject: [PATCH 1/3] Kconfig: Convert SYS_EARLY_PCI_INIT to Kconfig
+
+The CONFIG_SYS_EARLY_PCI_INIT symbol is currently not supported
+by Kconfig.
+
+Make it a Kconfig symbol so that users could select it via defconfig.
+
+Signed-off-by: Fabio Estevam <festevam@gmail.com>
+Reviewed-by: Tom Rini <trini@konsulko.com>
+---
+ common/Kconfig | 7 +++++++
+ 1 file changed, 7 insertions(+)
+
+diff --git a/common/Kconfig b/common/Kconfig
+index a2f653f7e72..cb17f056153 100644
+--- a/common/Kconfig
++++ b/common/Kconfig
+@@ -833,6 +833,13 @@ config PCI_INIT_R
+ 	  case of DM PCI-based Ethernet devices, which will not be detected
+ 	  without having the enumeration performed earlier.
+ 
++config SYS_EARLY_PCI_INIT
++	bool "Enumerate PCI buses early during init"
++	depends on PCI
++	help
++	  Do early PCI configuration before the eMMC gets initialised,
++	  because PCI resources are crucial for eMMC access on some boards.
++
+ config RESET_PHY_R
+ 	bool "Reset ethernet PHY during init"
+ 	help
+-- 
+2.51.0
+
diff --git a/recipes-bsp/u-boot/files/0002-qemu_arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch b/recipes-bsp/u-boot/files/0002-qemu_arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch
new file mode 100644
index 00000000..ec82a32b
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0002-qemu_arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch
@@ -0,0 +1,28 @@
+From b93d9e7cc2b39a6d16356d391d2d7832ed4b9202 Mon Sep 17 00:00:00 2001
+From: Fabio Estevam <festevam@gmail.com>
+Date: Thu, 14 Aug 2025 20:14:36 +0200
+Subject: [PATCH 2/3] qemu_arm: Select CONFIG_SYS_EARLY_PCI_INIT
+
+Select CONFIG_SYS_EARLY_PCI_INIT so that eMMC emulation can
+work.
+
+Signed-off-by: Fabio Estevam <festevam@gmail.com>
+---
+ board/emulation/qemu-arm/Kconfig | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/board/emulation/qemu-arm/Kconfig b/board/emulation/qemu-arm/Kconfig
+index 80ab9d8e1c3..447061b25cd 100644
+--- a/board/emulation/qemu-arm/Kconfig
++++ b/board/emulation/qemu-arm/Kconfig
+@@ -8,6 +8,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
+ 	select HAS_CUSTOM_SYS_INIT_SP_ADDR
+ 	select QFW if ACPI
+ 	select QFW_MMIO if CMD_QFW
++	imply SYS_EARLY_PCI_INIT
+ 	imply VIRTIO_MMIO
+ 	imply VIRTIO_PCI
+ 	imply VIRTIO_NET
+-- 
+2.51.0
+
diff --git a/recipes-bsp/u-boot/files/qemu-extra.cfg b/recipes-bsp/u-boot/files/qemu-extra.cfg
index 775e999c..e643db7d 100644
--- a/recipes-bsp/u-boot/files/qemu-extra.cfg
+++ b/recipes-bsp/u-boot/files/qemu-extra.cfg
@@ -1,2 +1,9 @@
 ### QEMU extra config
+CONFIG_MMC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_PCI=y
+CONFIG_MMC_SDHCI=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MMC_REG=y
 CONFIG_EFI_SCROLL_ON_CLEAR_SCREEN=y
diff --git a/recipes-bsp/u-boot/u-boot-common-2025.07.inc b/recipes-bsp/u-boot/u-boot-common-2025.07.inc
index b5ecb31a..5f8f9de9 100644
--- a/recipes-bsp/u-boot/u-boot-common-2025.07.inc
+++ b/recipes-bsp/u-boot/u-boot-common-2025.07.inc
@@ -16,6 +16,8 @@ FILESPATH:append := ":${FILE_DIRNAME}/files"
 SRC_URI += " \
     https://ftp.denx.de/pub/u-boot/u-boot-${PV}.tar.bz2 \
     file://0001-tools-Do-not-generate-logo-when-cross-building.patch \
+    file://0001-Kconfig-Convert-SYS_EARLY_PCI_INIT-to-Kconfig.patch \
+    file://0002-qemu_arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch \
     file://rules.tmpl;subdir=debian"
 SRC_URI[sha256sum] = "0f933f6c5a426895bf306e93e6ac53c60870e4b54cda56d95211bec99e63bec7"
 
-- 
2.51.0


