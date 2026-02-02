Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8B5E7316A
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 12:57:57 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.51547.1770037072085760783
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Feb 2026 04:57:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=aEeqERVe;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-2026020212574907ac4206da000207d2-r7o3vk@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2026020212574907ac4206da000207d2
        for <cip-dev@lists.cip-project.org>;
        Mon, 02 Feb 2026 13:57:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=AavrAJeqMnQUrelLiCoVxosJ5yA0VXBqivJrnPDlYX8=;
 b=aEeqERVeizeWk10v9Ve45HIAMs7ZRgThC6OATANDtaC6ihFS5X4VPon+nFnKySRtovFZ6T
 yw2rVCuCxm+XuIz0Vui2VX847Dp0q8eIxYe8muUDaaf4mcm/AD0bivMxKUCKmsJq6GV6Z+uV
 AwKcRKHQiKVCG+1kyhvorndbd/PlUvJ6t8aF6ruMehkau6NcCBnCsQTl/gaMjKiwsEo8mCrQ
 M7Sklua6j9lpjdXJ1x9TBMcLSP4lvIZmticJJgUi2I0q8E3j4RUJ5ER2TU/pLilOUm1J790C
 zsuG64jq+wU2M/jJWqCumjre9as8Vqd3lptNBwWbo4zHSqDlT+O3MAaA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Subject: [isar-cip-core][PATCH 3/9] u-boot: Update to v2026.01
Date: Mon,  2 Feb 2026 13:57:42 +0100
Message-ID: <4ae68c333a1aee1b2eb350bb74c29bd660ef2176.1770037068.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1770037068.git.jan.kiszka@siemens.com>
References: <cover.1770037068.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Feb 2026 12:57:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21798

From: Jan Kiszka <jan.kiszka@siemens.com>

Allows to drop a number of patches. Refresh the queue for the DE0 Nano
SoC at this chance. Unfortunately, a lot of those fixes didn't make it
into this release.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
CC: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 ...onvert-SYS_EARLY_PCI_INIT-to-Kconfig.patch |  37 ----
 ...-mach-socfpga-Fix-non-Agilex-targets.patch |  97 -----------
 ...KASLR-OPTEE-RNG-support-for-K3-devic.patch |  38 -----
 ...missing-SPL_LOAD_BLOCK-for-SYS_MMCSD.patch |  30 ++++
 ...ot-generate-logo-when-cross-building.patch |  33 ----
 ...arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch |  28 ---
 ...or-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch} |  38 ++---
 ...ector-value-passed-to-mmc_load_imag.patch} |   6 +-
 .../files/0003-test-Fix-optee-unit-test.patch | 134 ---------------
 ...cfpga-Adjust-a-raw-sectors-for-MMC-l.patch |  16 +-
 ...onfigs-socfpga-Fix-de0_nano_soc-boot.patch |   4 +-
 ...6-configs-socfpga-Permit-EFI-booting.patch | 161 ++++++++++--------
 ...t-bbb_2025.07.bb => u-boot-bbb_2026.01.bb} |   0
 ...-2025.07.inc => u-boot-common-2026.01.inc} |  12 +-
 ...5.07.bb => u-boot-de0-nano-soc_2026.01.bb} |   0
 ...025.07.bb => u-boot-qemu-arm64_2026.01.bb} |   0
 ..._2025.07.bb => u-boot-qemu-arm_2026.01.bb} |   0
 ...5.07.bb => u-boot-qemu-riscv64_2026.01.bb} |   0
 ...5.07.bb => u-boot-ti-am62px-sk_2026.01.bb} |   1 -
 19 files changed, 148 insertions(+), 487 deletions(-)
 delete mode 100644 recipes-bsp/u-boot/files/0001-Kconfig-Convert-SYS_EARLY_PCI_INIT-to-Kconfig.patch
 delete mode 100644 recipes-bsp/u-boot/files/0001-arch-arm-mach-socfpga-Fix-non-Agilex-targets.patch
 delete mode 100644 recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
 create mode 100644 recipes-bsp/u-boot/files/0001-spl-Kconfig-Add-missing-SPL_LOAD_BLOCK-for-SYS_MMCSD.patch
 delete mode 100644 recipes-bsp/u-boot/files/0001-tools-Do-not-generate-logo-when-cross-building.patch
 delete mode 100644 recipes-bsp/u-boot/files/0002-qemu_arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch
 rename recipes-bsp/u-boot/files/{0003-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch => 0002-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch} (67%)
 rename recipes-bsp/u-boot/files/{0002-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch => 0003-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch} (87%)
 delete mode 100644 recipes-bsp/u-boot/files/0003-test-Fix-optee-unit-test.patch
 rename recipes-bsp/u-boot/{u-boot-bbb_2025.07.bb => u-boot-bbb_2026.01.bb} (100%)
 rename recipes-bsp/u-boot/{u-boot-common-2025.07.inc => u-boot-common-2026.01.inc} (77%)
 rename recipes-bsp/u-boot/{u-boot-de0-nano-soc_2025.07.bb => u-boot-de0-nano-soc_2026.01.bb} (100%)
 rename recipes-bsp/u-boot/{u-boot-qemu-arm64_2025.07.bb => u-boot-qemu-arm64_2026.01.bb} (100%)
 rename recipes-bsp/u-boot/{u-boot-qemu-arm_2025.07.bb => u-boot-qemu-arm_2026.01.bb} (100%)
 rename recipes-bsp/u-boot/{u-boot-qemu-riscv64_2025.07.bb => u-boot-qemu-riscv64_2026.01.bb} (100%)
 rename recipes-bsp/u-boot/{u-boot-ti-am62px-sk_2025.07.bb => u-boot-ti-am62px-sk_2026.01.bb} (98%)

diff --git a/recipes-bsp/u-boot/files/0001-Kconfig-Convert-SYS_EARLY_PCI_INIT-to-Kconfig.patch b/recipes-bsp/u-boot/files/0001-Kconfig-Convert-SYS_EARLY_PCI_INIT-to-Kconfig.patch
deleted file mode 100644
index 36c0ea8b..00000000
--- a/recipes-bsp/u-boot/files/0001-Kconfig-Convert-SYS_EARLY_PCI_INIT-to-Kconfig.patch
+++ /dev/null
@@ -1,37 +0,0 @@
-From d3403a731b5b194a9e4e2ba67911e760dcd89207 Mon Sep 17 00:00:00 2001
-From: Fabio Estevam <festevam@gmail.com>
-Date: Thu, 14 Aug 2025 20:14:35 +0200
-Subject: [PATCH 1/3] Kconfig: Convert SYS_EARLY_PCI_INIT to Kconfig
-
-The CONFIG_SYS_EARLY_PCI_INIT symbol is currently not supported
-by Kconfig.
-
-Make it a Kconfig symbol so that users could select it via defconfig.
-
-Signed-off-by: Fabio Estevam <festevam@gmail.com>
-Reviewed-by: Tom Rini <trini@konsulko.com>
----
- common/Kconfig | 7 +++++++
- 1 file changed, 7 insertions(+)
-
-diff --git a/common/Kconfig b/common/Kconfig
-index a2f653f7e72..cb17f056153 100644
---- a/common/Kconfig
-+++ b/common/Kconfig
-@@ -833,6 +833,13 @@ config PCI_INIT_R
- 	  case of DM PCI-based Ethernet devices, which will not be detected
- 	  without having the enumeration performed earlier.
- 
-+config SYS_EARLY_PCI_INIT
-+	bool "Enumerate PCI buses early during init"
-+	depends on PCI
-+	help
-+	  Do early PCI configuration before the eMMC gets initialised,
-+	  because PCI resources are crucial for eMMC access on some boards.
-+
- config RESET_PHY_R
- 	bool "Reset ethernet PHY during init"
- 	help
--- 
-2.51.0
-
diff --git a/recipes-bsp/u-boot/files/0001-arch-arm-mach-socfpga-Fix-non-Agilex-targets.patch b/recipes-bsp/u-boot/files/0001-arch-arm-mach-socfpga-Fix-non-Agilex-targets.patch
deleted file mode 100644
index 2c05d5cd..00000000
--- a/recipes-bsp/u-boot/files/0001-arch-arm-mach-socfpga-Fix-non-Agilex-targets.patch
+++ /dev/null
@@ -1,97 +0,0 @@
-From c02c7bbadf6d97f3d178289909495483b66a921f Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Fri, 14 Nov 2025 12:42:46 +0100
-Subject: [PATCH 1/6] arch: arm: mach-socfpga: Fix non-Agilex targets
-
-The Altera system manager device is only provided for the Agilex
-targets. All others were left with an uninitialized socfpga_sysmgr_base
-after that refactoring, breaking any boot attempts already in SPL.
-
-Tested only on Cyclone5 / DE0-Nano-SoC.
-
-Fixes: 35638172f99a ("arm: socfpga: agilex5: Add new driver model for system manager in Agilex5")
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
----
- arch/arm/mach-socfpga/misc.c     | 7 +++++++
- arch/arm/mach-socfpga/spl_a10.c  | 1 +
- arch/arm/mach-socfpga/spl_gen5.c | 1 +
- arch/arm/mach-socfpga/spl_n5x.c  | 1 +
- arch/arm/mach-socfpga/spl_s10.c  | 1 +
- 5 files changed, 11 insertions(+)
-
-diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
-index 97e01140513..dee822fa870 100644
---- a/arch/arm/mach-socfpga/misc.c
-+++ b/arch/arm/mach-socfpga/misc.c
-@@ -277,6 +277,8 @@ void socfpga_get_managers_addr(void)
- void socfpga_get_sys_mgr_addr(const char *compat)
- {
- 	int ret;
-+#if defined(CONFIG_TARGET_SOCFPGA_AGILEX) || \
-+    defined(TARGET_SOCFPGA_AGILEX7M) || defined(TARGET_SOCFPGA_AGILEX5)
- 	struct udevice *sysmgr_dev;
- 
- 	ret = uclass_get_device_by_name(UCLASS_NOP, compat, &sysmgr_dev);
-@@ -286,6 +288,11 @@ void socfpga_get_sys_mgr_addr(const char *compat)
- 	} else {
- 		socfpga_sysmgr_base = (phys_addr_t)dev_read_addr(sysmgr_dev);
- 	}
-+#else
-+	ret = socfpga_get_base_addr("altr,sys-mgr", &socfpga_sysmgr_base);
-+	if (ret)
-+		hang();
-+#endif
- }
- 
- phys_addr_t socfpga_get_rstmgr_addr(void)
-diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/spl_a10.c
-index c20376f7f8e..6722c9cef3f 100644
---- a/arch/arm/mach-socfpga/spl_a10.c
-+++ b/arch/arm/mach-socfpga/spl_a10.c
-@@ -250,6 +250,7 @@ void board_init_f(ulong dummy)
- 	if (spl_early_init())
- 		hang();
- 
-+	socfpga_get_sys_mgr_addr(NULL);
- 	socfpga_get_managers_addr();
- 
- 	dcache_disable();
-diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/spl_gen5.c
-index df79cfe0f7f..cd8b09d7a8d 100644
---- a/arch/arm/mach-socfpga/spl_gen5.c
-+++ b/arch/arm/mach-socfpga/spl_gen5.c
-@@ -72,6 +72,7 @@ void board_init_f(ulong dummy)
- 	if (ret)
- 		hang();
- 
-+	socfpga_get_sys_mgr_addr(NULL);
- 	socfpga_get_managers_addr();
- 
- 	/*
-diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
-index 81283ef7162..2b6a443e989 100644
---- a/arch/arm/mach-socfpga/spl_n5x.c
-+++ b/arch/arm/mach-socfpga/spl_n5x.c
-@@ -31,6 +31,7 @@ void board_init_f(ulong dummy)
- 	if (ret)
- 		hang();
- 
-+	socfpga_get_sys_mgr_addr(NULL);
- 	socfpga_get_managers_addr();
- 
- 	/* Ensure watchdog is paused when debugging is happening */
-diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
-index fa83ff96adc..379e5642b2a 100644
---- a/arch/arm/mach-socfpga/spl_s10.c
-+++ b/arch/arm/mach-socfpga/spl_s10.c
-@@ -33,6 +33,7 @@ void board_init_f(ulong dummy)
- 	if (ret)
- 		hang();
- 
-+	socfpga_get_sys_mgr_addr(NULL);
- 	socfpga_get_managers_addr();
- 
- 	/* Ensure watchdog is paused when debugging is happening */
--- 
-2.51.0
-
diff --git a/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch b/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
deleted file mode 100644
index d831b211..00000000
--- a/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
+++ /dev/null
@@ -1,38 +0,0 @@
-From 7d4136397715d2c08161a32a873c052dd1bb8b6c Mon Sep 17 00:00:00 2001
-From: Gokul Praveen <g-praveen@ti.com>
-Date: Thu, 10 Jul 2025 15:29:22 +0530
-Subject: [PATCH] configs: KASLR OPTEE RNG support for K3 devices
-
-KASLR, or Kernel Address Space Layout Randomization, is a security
-feature in the Linux kernel that randomizes the memory location
-where the kernel is loaded during boot.
-
-OP-TEE RNG is a Random Number Generator (RNG) component within the
-Open Portable Trusted Execution Environment (OP-TEE) which provides
-a random number to U-BOOT and U-BOOT provides this random number
-as seed value to the LINUX kernel for KASLR.
-
-Add KASLR OPTEE RNG support across K3 devices by enabling the required
-configs.
-
-Signed-off-by: Gokul Praveen <g-praveen@ti.com>
-Reviewed-by: Bryan Brattlof <bb@ti.com>
-Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>
----
- arch/arm/Kconfig | 3 +++
- 1 file changed, 3 insertions(+)
-
-diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
-index 5872455a0fe5..4e7593616d8a 100644
---- a/arch/arm/Kconfig
-+++ b/arch/arm/Kconfig
-@@ -835,6 +835,9 @@ config ARCH_K3
- 	select FIT_SIGNATURE if ARM64
- 	select LTO
- 	imply TI_SECURE_DEVICE
-+	imply DM_RNG if ARM64
-+	imply TEE if ARM64
-+	imply OPTEE if ARM64
- 
- config ARCH_OMAP2PLUS
- 	bool "TI OMAP2+"
diff --git a/recipes-bsp/u-boot/files/0001-spl-Kconfig-Add-missing-SPL_LOAD_BLOCK-for-SYS_MMCSD.patch b/recipes-bsp/u-boot/files/0001-spl-Kconfig-Add-missing-SPL_LOAD_BLOCK-for-SYS_MMCSD.patch
new file mode 100644
index 00000000..82153d70
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0001-spl-Kconfig-Add-missing-SPL_LOAD_BLOCK-for-SYS_MMCSD.patch
@@ -0,0 +1,30 @@
+From 542e5b9c621a8f0eade97c745bbf6150cb79f254 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Fri, 28 Nov 2025 12:08:19 +0100
+Subject: [PATCH 1/6] spl: Kconfig: Add missing SPL_LOAD_BLOCK for
+ SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
+
+We need to explicitly select SPL_LOAD_BLOCK when USE_PARTITION_TYPE is
+enabled, just like the other choices do.
+
+Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ common/spl/Kconfig | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/common/spl/Kconfig b/common/spl/Kconfig
+index 3b7b6cafef8..142cdb34cd5 100644
+--- a/common/spl/Kconfig
++++ b/common/spl/Kconfig
+@@ -573,6 +573,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
+ 
+ config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
+ 	bool "MMC raw mode: by partition type"
++	select SPL_LOAD_BLOCK
+ 	depends on DOS_PARTITION
+ 	help
+ 	  Use partition type for specifying U-Boot partition on MMC/SD in
+-- 
+2.51.0
+
diff --git a/recipes-bsp/u-boot/files/0001-tools-Do-not-generate-logo-when-cross-building.patch b/recipes-bsp/u-boot/files/0001-tools-Do-not-generate-logo-when-cross-building.patch
deleted file mode 100644
index 16b219f5..00000000
--- a/recipes-bsp/u-boot/files/0001-tools-Do-not-generate-logo-when-cross-building.patch
+++ /dev/null
@@ -1,33 +0,0 @@
-From 371a76e845504c9ba7ca216b6edfb4ae4ec14e56 Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Sat, 23 Aug 2025 17:21:09 +0200
-Subject: [PATCH] tools: Do not generate logo when cross-building
-
-This cannot work (unless qemu-user is registered in binfmt_misc) as the
-tools will be for a different architecture.
-
-Fixes "make cross_tools" in case CONFIG_VIDEO_LOGO is enabled.
-
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
-Reviewed-by: Tom Rini <trini@konsulko.com>
----
- tools/Makefile | 2 ++
- 1 file changed, 2 insertions(+)
-
-diff --git a/tools/Makefile b/tools/Makefile
-index 7eb17f92116..ae6a3052646 100644
---- a/tools/Makefile
-+++ b/tools/Makefile
-@@ -333,7 +333,9 @@ HOST_EXTRACFLAGS += -include $(srctree)/include/compiler.h \
- 		-D__KERNEL_STRICT_NAMES \
- 		-D_GNU_SOURCE
- 
-+ifeq ($(CROSS_BUILD_TOOLS),)
- __build:	$(LOGO-y)
-+endif
- 
- $(LOGO_H):	$(obj)/bmp_logo $(LOGO_BMP)
- 	$(obj)/bmp_logo --gen-info $(LOGO_BMP) > $@
--- 
-2.51.0
-
diff --git a/recipes-bsp/u-boot/files/0002-qemu_arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch b/recipes-bsp/u-boot/files/0002-qemu_arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch
deleted file mode 100644
index ec82a32b..00000000
--- a/recipes-bsp/u-boot/files/0002-qemu_arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch
+++ /dev/null
@@ -1,28 +0,0 @@
-From b93d9e7cc2b39a6d16356d391d2d7832ed4b9202 Mon Sep 17 00:00:00 2001
-From: Fabio Estevam <festevam@gmail.com>
-Date: Thu, 14 Aug 2025 20:14:36 +0200
-Subject: [PATCH 2/3] qemu_arm: Select CONFIG_SYS_EARLY_PCI_INIT
-
-Select CONFIG_SYS_EARLY_PCI_INIT so that eMMC emulation can
-work.
-
-Signed-off-by: Fabio Estevam <festevam@gmail.com>
----
- board/emulation/qemu-arm/Kconfig | 1 +
- 1 file changed, 1 insertion(+)
-
-diff --git a/board/emulation/qemu-arm/Kconfig b/board/emulation/qemu-arm/Kconfig
-index 80ab9d8e1c3..447061b25cd 100644
---- a/board/emulation/qemu-arm/Kconfig
-+++ b/board/emulation/qemu-arm/Kconfig
-@@ -8,6 +8,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
- 	select HAS_CUSTOM_SYS_INIT_SP_ADDR
- 	select QFW if ACPI
- 	select QFW_MMIO if CMD_QFW
-+	imply SYS_EARLY_PCI_INIT
- 	imply VIRTIO_MMIO
- 	imply VIRTIO_PCI
- 	imply VIRTIO_NET
--- 
-2.51.0
-
diff --git a/recipes-bsp/u-boot/files/0003-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch b/recipes-bsp/u-boot/files/0002-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch
similarity index 67%
rename from recipes-bsp/u-boot/files/0003-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch
rename to recipes-bsp/u-boot/files/0002-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch
index 4e735718..4f10b912 100644
--- a/recipes-bsp/u-boot/files/0003-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch
+++ b/recipes-bsp/u-boot/files/0002-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch
@@ -1,41 +1,28 @@
-From 2695758ae0f8184f6093086c0f2d4a152273d674 Mon Sep 17 00:00:00 2001
+From 3bee0382a4c2025f2696cd06df34c091ebc637d4 Mon Sep 17 00:00:00 2001
 From: Jan Kiszka <jan.kiszka@siemens.com>
 Date: Fri, 14 Nov 2025 13:40:20 +0100
-Subject: [PATCH 3/6] spl: mmc: Account for
+Subject: [PATCH 2/6] spl: mmc: Account for
  SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE being a choice
 
 Add SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE as condition where so
 far SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION was enough - though often
 by chance as both options were enabled.
 
-We also need to explicitly select SPL_LOAD_BLOCK when UES_PARTITION_TYPE
-is enabled, just like the other choices do.
+Reorder the #ifdef blocks at this chance to follow the order in the
+Kconfig menu.
 
 Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
 Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
 ---
- common/spl/Kconfig   |  1 +
- common/spl/spl_mmc.c | 16 ++++++++--------
+ common/spl/spl_mmc.c | 17 +++++++++--------
  include/part.h       |  3 ++-
- 3 files changed, 11 insertions(+), 9 deletions(-)
+ 2 files changed, 11 insertions(+), 9 deletions(-)
 
-diff --git a/common/spl/Kconfig b/common/spl/Kconfig
-index 77cf04d38ed..b757d14fbf1 100644
---- a/common/spl/Kconfig
-+++ b/common/spl/Kconfig
-@@ -563,6 +563,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
- 
- config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
- 	bool "MMC raw mode: by partition type"
-+	select SPL_LOAD_BLOCK
- 	depends on DOS_PARTITION
- 	help
- 	  Use partition type for specifying U-Boot partition on MMC/SD in
 diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
-index 81415ae7594..34fe362d97e 100644
+index d8ce3a84614..1942e417075 100644
 --- a/common/spl/spl_mmc.c
 +++ b/common/spl/spl_mmc.c
-@@ -107,7 +107,8 @@ static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
+@@ -106,7 +106,8 @@ static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
  	return 0;
  }
  
@@ -45,7 +32,7 @@ index 81415ae7594..34fe362d97e 100644
  static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
  					struct spl_boot_device *bootdev,
  					struct mmc *mmc, int partition,
-@@ -392,19 +393,18 @@ int spl_mmc_load(struct spl_image_info *spl_image,
+@@ -419,19 +420,19 @@ int spl_mmc_load(struct spl_image_info *spl_image,
  
  		raw_sect = spl_mmc_get_uboot_raw_sector(mmc, raw_sect);
  
@@ -62,7 +49,8 @@ index 81415ae7594..34fe362d97e 100644
  						spl_mmc_raw_uboot_offset(part));
  		if (!ret)
  			return 0;
-+#else
++#elif defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
++      defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
 +		ret = mmc_load_image_raw_partition(spl_image, bootdev,
 +						   mmc, raw_part,
 +						   raw_sect);
@@ -72,10 +60,10 @@ index 81415ae7594..34fe362d97e 100644
  		/* If RAW mode fails, try FS mode. */
  		fallthrough;
 diff --git a/include/part.h b/include/part.h
-index fcb3c13dea4..6d16bf7ff85 100644
+index 6caaa6526aa..ba4a63ddc75 100644
 --- a/include/part.h
 +++ b/include/part.h
-@@ -443,7 +443,8 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
+@@ -461,7 +461,8 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
  #ifdef CONFIG_XPL_BUILD
  # define part_print_ptr(x)	NULL
  # if defined(CONFIG_SPL_FS_EXT4) || defined(CONFIG_SPL_FS_FAT) || \
diff --git a/recipes-bsp/u-boot/files/0002-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch b/recipes-bsp/u-boot/files/0003-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch
similarity index 87%
rename from recipes-bsp/u-boot/files/0002-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch
rename to recipes-bsp/u-boot/files/0003-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch
index 1b9cb526..3ed63586 100644
--- a/recipes-bsp/u-boot/files/0002-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch
+++ b/recipes-bsp/u-boot/files/0003-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch
@@ -1,7 +1,7 @@
-From 27441e4cad3bcb2fd0c83c85f29a71e68f5a8c2d Mon Sep 17 00:00:00 2001
+From 4d9cfe96b1a770f0f6ab8ba56c9e21ff85e53c49 Mon Sep 17 00:00:00 2001
 From: Jan Kiszka <jan.kiszka@siemens.com>
 Date: Fri, 14 Nov 2025 13:34:48 +0100
-Subject: [PATCH 2/6] spl: mmc: Respect sector value passed to
+Subject: [PATCH 3/6] spl: mmc: Respect sector value passed to
  mmc_load_image_raw_partition
 
 This function and the sector parameter evolved over the time. By now,
@@ -19,7 +19,7 @@ Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
  1 file changed, 4 deletions(-)
 
 diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
-index d06f9f0dee6..81415ae7594 100644
+index 1942e417075..47cfe4aef58 100644
 --- a/common/spl/spl_mmc.c
 +++ b/common/spl/spl_mmc.c
 @@ -137,11 +137,7 @@ static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
diff --git a/recipes-bsp/u-boot/files/0003-test-Fix-optee-unit-test.patch b/recipes-bsp/u-boot/files/0003-test-Fix-optee-unit-test.patch
deleted file mode 100644
index ed928f64..00000000
--- a/recipes-bsp/u-boot/files/0003-test-Fix-optee-unit-test.patch
+++ /dev/null
@@ -1,134 +0,0 @@
-From a7ff306c8ea79743552992638b8d228818cd9975 Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Mon, 15 Sep 2025 07:50:26 +0200
-Subject: [PATCH 3/3] test: Fix optee unit test
-
-This was apparently not built for several years: Since a2535243e011,
-optee_copy_fdt_nodes implicitly works against the U-Boot dt. We
-therefore have to tweak its reference before using the function and
-restore things afterwards.
-
-If it had been built, actually trying it out would have failed next: We
-need CONFIG_OPTEE_LIB to actually build the function that is primarily
-being tested here. And we need to re-initialize target fdt, now that the
-tests may run in random order.
-
-Fixes: a2535243e011 ("lib: optee: migration optee_copy_fdt_nodes for OF_LIVE support")
-Fixes: ba2feaf41435 ("test: Split optee tests into three functions")
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
----
- test/optee/Kconfig |  1 +
- test/optee/optee.c | 42 +++++++++++++++++++++++++++++++-----------
- 2 files changed, 32 insertions(+), 11 deletions(-)
-
-diff --git a/test/optee/Kconfig b/test/optee/Kconfig
-index 63e2cbf79c7..ebf8d07c41c 100644
---- a/test/optee/Kconfig
-+++ b/test/optee/Kconfig
-@@ -1,6 +1,7 @@
- config UT_OPTEE
- 	bool "Enable OP-TEE Unit Tests"
- 	depends on OF_CONTROL && OPTEE
-+	select OPTEE_LIB
- 	default y
- 	help
- 	  This enables the 'ut optee' command which runs a series of unit
-diff --git a/test/optee/optee.c b/test/optee/optee.c
-index 658621fa2fa..7e1c8d04a11 100644
---- a/test/optee/optee.c
-+++ b/test/optee/optee.c
-@@ -5,16 +5,20 @@
- 
- #include <command.h>
- #include <errno.h>
-+#include <fdtdec.h>
- #include <fdt_support.h>
- #include <log.h>
- #include <malloc.h>
- #include <tee/optee.h>
-+#include <asm/global_data.h>
- 
- #include <linux/sizes.h>
- 
- #include <test/ut.h>
- #include <test/optee.h>
- 
-+DECLARE_GLOBAL_DATA_PTR;
-+
- /* 4k ought to be enough for anybody */
- #define FDT_COPY_SIZE	(4 * SZ_1K)
- 
-@@ -40,14 +44,6 @@ static int optee_test_init(struct unit_test_state *uts)
- 	if (!fdt)
- 		return ret;
- 
--	/*
--	 * Resize the FDT to 4k so that we have room to operate on
--	 *
--	 * (and relocate it since the memory might be mapped
--	 * read-only)
--	 */
--	ut_assertok(fdt_open_into(fdt_base, fdt, FDT_COPY_SIZE));
--
- 	return 0;
- }
- OPTEE_TEST_INIT(optee_test_init, 0);
-@@ -127,9 +123,21 @@ static int optee_fdt_protected_memory(struct unit_test_state *uts)
- static int optee_fdt_copy_empty(struct unit_test_state *uts)
- {
- 	void *fdt_no_optee = &__dtb_test_optee_no_optee_begin;
-+	const void *fdt_blob = gd->fdt_blob;
-+
-+	/*
-+	 * Resize the FDT to 4k so that we have room to operate on
-+	 *
-+	 * (and relocate it since the memory might be mapped
-+	 * read-only)
-+	 */
-+	ut_assertok(fdt_open_into(&__dtb_test_optee_base_begin, fdt,
-+				  FDT_COPY_SIZE));
- 
- 	/* This should still run successfully */
--	ut_assertok(optee_copy_fdt_nodes(fdt_no_optee, fdt));
-+	gd->fdt_blob = fdt_no_optee;
-+	ut_assertok(optee_copy_fdt_nodes(fdt));
-+	gd->fdt_blob = fdt_blob;
- 
- 	expect_success = false;
- 	ut_assertok(optee_fdt_firmware(uts));
-@@ -143,8 +151,14 @@ OPTEE_TEST(optee_fdt_copy_empty, 0);
- static int optee_fdt_copy_prefilled(struct unit_test_state *uts)
- {
- 	void *fdt_optee = &__dtb_test_optee_optee_begin;
-+	const void *fdt_blob = gd->fdt_blob;
- 
--	ut_assertok(optee_copy_fdt_nodes(fdt_optee, fdt));
-+	ut_assertok(fdt_open_into(&__dtb_test_optee_base_begin, fdt,
-+				  FDT_COPY_SIZE));
-+
-+	gd->fdt_blob = fdt_optee;
-+	ut_assertok(optee_copy_fdt_nodes(fdt));
-+	gd->fdt_blob = fdt_blob;
- 
- 	expect_success = true;
- 	ut_assertok(optee_fdt_firmware(uts));
-@@ -158,9 +172,15 @@ OPTEE_TEST(optee_fdt_copy_prefilled, 0);
- static int optee_fdt_copy_already_filled(struct unit_test_state *uts)
- {
- 	void *fdt_optee = &__dtb_test_optee_optee_begin;
-+	const void *fdt_blob = gd->fdt_blob;
-+
-+	ut_assertok(fdt_open_into(&__dtb_test_optee_base_begin, fdt,
-+				  FDT_COPY_SIZE));
- 
- 	ut_assertok(fdt_open_into(fdt_optee, fdt, FDT_COPY_SIZE));
--	ut_assertok(optee_copy_fdt_nodes(fdt_optee, fdt));
-+	gd->fdt_blob = fdt_optee;
-+	ut_assertok(optee_copy_fdt_nodes(fdt));
-+	gd->fdt_blob = fdt_blob;
- 
- 	expect_success = true;
- 	ut_assertok(optee_fdt_firmware(uts));
--- 
-2.51.0
-
diff --git a/recipes-bsp/u-boot/files/0004-arch-arm-mach-socfpga-Adjust-a-raw-sectors-for-MMC-l.patch b/recipes-bsp/u-boot/files/0004-arch-arm-mach-socfpga-Adjust-a-raw-sectors-for-MMC-l.patch
index bdbb4d1d..7a52853d 100644
--- a/recipes-bsp/u-boot/files/0004-arch-arm-mach-socfpga-Adjust-a-raw-sectors-for-MMC-l.patch
+++ b/recipes-bsp/u-boot/files/0004-arch-arm-mach-socfpga-Adjust-a-raw-sectors-for-MMC-l.patch
@@ -1,4 +1,4 @@
-From 93a35b8a962d4f8d9e211c55e2d85b12d2ccce4b Mon Sep 17 00:00:00 2001
+From 6201f8e8df19b890baacb15690be067430e3e4e9 Mon Sep 17 00:00:00 2001
 From: Jan Kiszka <jan.kiszka@siemens.com>
 Date: Fri, 14 Nov 2025 13:53:25 +0100
 Subject: [PATCH 4/6] arch: arm: mach-socfpga: Adjust a raw sectors for MMC
@@ -12,14 +12,14 @@ offset via SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
 
 Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
 ---
- arch/arm/mach-socfpga/board.c | 9 +++++++++
- 1 file changed, 9 insertions(+)
+ arch/arm/mach-socfpga/board.c | 11 +++++++++++
+ 1 file changed, 11 insertions(+)
 
 diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.c
-index 8506d510413..a7598e79362 100644
+index 28554b7a109..7f65aed4540 100644
 --- a/arch/arm/mach-socfpga/board.c
 +++ b/arch/arm/mach-socfpga/board.c
-@@ -13,6 +13,7 @@
+@@ -14,6 +14,7 @@
  #include <hang.h>
  #include <handoff.h>
  #include <image.h>
@@ -27,15 +27,17 @@ index 8506d510413..a7598e79362 100644
  #include <usb.h>
  #include <usb/dwc2_udc.h>
  #include <asm/global_data.h>
-@@ -208,3 +209,11 @@ void lmb_arch_add_memory(void)
+@@ -209,3 +210,13 @@ void lmb_arch_add_memory(void)
  	}
  }
  #endif
 +
-+#ifdef CONFIG_SPL
++#if (defined(CONFIG_TARGET_SOCFPGA_ARRIA10) || \
++     defined(CONFIG_TARGET_SOCFPGA_GEN5)) && defined(CONFIG_XPL_BUILD)
 +unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 +						 unsigned long raw_sect)
 +{
++	/* offset of u-boot proper inside u-boot-with-spl.sfp image */
 +	return (CONFIG_SPL_PAD_TO * 4) / 512 + raw_sect;
 +}
 +#endif
diff --git a/recipes-bsp/u-boot/files/0005-configs-socfpga-Fix-de0_nano_soc-boot.patch b/recipes-bsp/u-boot/files/0005-configs-socfpga-Fix-de0_nano_soc-boot.patch
index 295a0e2f..388377b2 100644
--- a/recipes-bsp/u-boot/files/0005-configs-socfpga-Fix-de0_nano_soc-boot.patch
+++ b/recipes-bsp/u-boot/files/0005-configs-socfpga-Fix-de0_nano_soc-boot.patch
@@ -1,4 +1,4 @@
-From fdd7059526064d130b6797c7e62ed26b25bd2f77 Mon Sep 17 00:00:00 2001
+From 7af75a1322ef6e5ffbc809d30e4e017cd7f46cc2 Mon Sep 17 00:00:00 2001
 From: Jan Kiszka <jan.kiszka@siemens.com>
 Date: Thu, 13 Nov 2025 18:38:28 +0100
 Subject: [PATCH 5/6] configs: socfpga: Fix de0_nano_soc boot
@@ -15,7 +15,7 @@ Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/configs/socfpga_de0_nano_soc_defconfig b/configs/socfpga_de0_nano_soc_defconfig
-index 7188c46d98e..0bcc970728f 100644
+index 32cdf6d3a6c..6564cbd03c6 100644
 --- a/configs/socfpga_de0_nano_soc_defconfig
 +++ b/configs/socfpga_de0_nano_soc_defconfig
 @@ -28,6 +28,7 @@ CONFIG_SPL_NO_BSS_LIMIT=y
diff --git a/recipes-bsp/u-boot/files/0006-configs-socfpga-Permit-EFI-booting.patch b/recipes-bsp/u-boot/files/0006-configs-socfpga-Permit-EFI-booting.patch
index 31d51f2e..d799ec97 100644
--- a/recipes-bsp/u-boot/files/0006-configs-socfpga-Permit-EFI-booting.patch
+++ b/recipes-bsp/u-boot/files/0006-configs-socfpga-Permit-EFI-booting.patch
@@ -1,4 +1,4 @@
-From bd234afd41c8c21ac9caa7992c3e0b8292cca8b0 Mon Sep 17 00:00:00 2001
+From e2c93d129c0ec627ac2542ec93f2a27996429476 Mon Sep 17 00:00:00 2001
 From: Jan Kiszka <jan.kiszka@siemens.com>
 Date: Fri, 14 Nov 2025 16:18:14 +0100
 Subject: [PATCH 6/6] configs: socfpga: Permit EFI booting
@@ -12,218 +12,231 @@ partition table to make both the bootrom and UEFI happy.
 
 Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
 ---
- configs/socfpga_agilex5_defconfig       | 3 +--
- configs/socfpga_arria5_defconfig        | 3 +--
- configs/socfpga_cyclone5_defconfig      | 3 +--
- configs/socfpga_de0_nano_soc_defconfig  | 3 +--
- configs/socfpga_de10_nano_defconfig     | 3 +--
- configs/socfpga_de10_standard_defconfig | 3 +--
- configs/socfpga_de1_soc_defconfig       | 3 +--
- configs/socfpga_is1_defconfig           | 3 +--
- configs/socfpga_mcvevk_defconfig        | 3 +--
- configs/socfpga_secu1_defconfig         | 3 +--
- configs/socfpga_sockit_defconfig        | 3 +--
- configs/socfpga_socrates_defconfig      | 3 +--
- configs/socfpga_sr1500_defconfig        | 3 +--
- configs/socfpga_vining_fpga_defconfig   | 3 +--
- 14 files changed, 14 insertions(+), 28 deletions(-)
+ configs/socfpga_agilex5_defconfig       | 2 --
+ configs/socfpga_agilex_defconfig        | 2 --
+ configs/socfpga_arria5_defconfig        | 2 --
+ configs/socfpga_cyclone5_defconfig      | 2 --
+ configs/socfpga_de0_nano_soc_defconfig  | 2 --
+ configs/socfpga_de10_nano_defconfig     | 2 --
+ configs/socfpga_de10_standard_defconfig | 2 --
+ configs/socfpga_de1_soc_defconfig       | 2 --
+ configs/socfpga_is1_defconfig           | 2 --
+ configs/socfpga_mcvevk_defconfig        | 2 --
+ configs/socfpga_secu1_defconfig         | 2 --
+ configs/socfpga_sockit_defconfig        | 2 --
+ configs/socfpga_socrates_defconfig      | 2 --
+ configs/socfpga_sr1500_defconfig        | 2 --
+ configs/socfpga_vining_fpga_defconfig   | 2 --
+ disk/Kconfig                            | 1 +
+ 16 files changed, 1 insertion(+), 30 deletions(-)
 
 diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
-index 4ac0a5d9b99..4cb9d1fa4c2 100644
+index 64f2f1bf115..20fd1e237c9 100644
 --- a/configs/socfpga_agilex5_defconfig
 +++ b/configs/socfpga_agilex5_defconfig
-@@ -64,8 +64,7 @@ CONFIG_CMD_WDT=y
+@@ -67,8 +67,6 @@ CONFIG_CMD_WDT=y
  CONFIG_CMD_CACHE=y
  CONFIG_CMD_TIMER=y
  CONFIG_CMD_UBI=y
 -# CONFIG_ISO_PARTITION is not set
 -# CONFIG_EFI_PARTITION is not set
-+# CONFIG_SPL_EFI_PARTITION is not set
  CONFIG_OF_LIST=""
+ CONFIG_ENV_IS_IN_FAT=y
  CONFIG_ENV_IS_IN_UBI=y
- CONFIG_ENV_UBI_PART="root"
+diff --git a/configs/socfpga_agilex_defconfig b/configs/socfpga_agilex_defconfig
+index 1c3664bc0d7..eb99392f0ea 100644
+--- a/configs/socfpga_agilex_defconfig
++++ b/configs/socfpga_agilex_defconfig
+@@ -57,8 +57,6 @@ CONFIG_CMD_USB=y
+ CONFIG_CMD_CACHE=y
+ CONFIG_CMD_SMC=y
+ CONFIG_CMD_UBI=y
+-# CONFIG_ISO_PARTITION is not set
+-# CONFIG_EFI_PARTITION is not set
+ CONFIG_OF_UPSTREAM=y
+ CONFIG_OF_LIST=""
+ CONFIG_ENV_IS_IN_FAT=y
 diff --git a/configs/socfpga_arria5_defconfig b/configs/socfpga_arria5_defconfig
-index f3c142300f2..4685314fbb1 100644
+index 3c860f97ae9..88ef2eb0c76 100644
 --- a/configs/socfpga_arria5_defconfig
 +++ b/configs/socfpga_arria5_defconfig
-@@ -44,8 +44,7 @@ CONFIG_CMD_EXT4_WRITE=y
+@@ -44,8 +44,6 @@ CONFIG_CMD_EXT4_WRITE=y
  CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
  CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
  CONFIG_CMD_UBI=y
 -# CONFIG_ISO_PARTITION is not set
 -# CONFIG_EFI_PARTITION is not set
-+# CONFIG_SPL_EFI_PARTITION is not set
  CONFIG_ENV_IS_IN_MMC=y
- CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
  CONFIG_VERSION_VARIABLE=y
 diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone5_defconfig
-index 97e5fae0f53..ae92bd2feb3 100644
+index 992abdbfdc4..0485d20260c 100644
 --- a/configs/socfpga_cyclone5_defconfig
 +++ b/configs/socfpga_cyclone5_defconfig
-@@ -44,8 +44,7 @@ CONFIG_CMD_EXT4_WRITE=y
+@@ -45,8 +45,6 @@ CONFIG_CMD_EXT4_WRITE=y
  CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
  CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
  CONFIG_CMD_UBI=y
 -# CONFIG_ISO_PARTITION is not set
 -# CONFIG_EFI_PARTITION is not set
-+# CONFIG_SPL_EFI_PARTITION is not set
  CONFIG_ENV_IS_IN_MMC=y
- CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
  CONFIG_VERSION_VARIABLE=y
 diff --git a/configs/socfpga_de0_nano_soc_defconfig b/configs/socfpga_de0_nano_soc_defconfig
-index 0bcc970728f..a5f8258eaaf 100644
+index 6564cbd03c6..3b021634bb9 100644
 --- a/configs/socfpga_de0_nano_soc_defconfig
 +++ b/configs/socfpga_de0_nano_soc_defconfig
-@@ -46,8 +46,7 @@ CONFIG_CMD_EXT4_WRITE=y
+@@ -46,8 +46,6 @@ CONFIG_CMD_EXT4_WRITE=y
  CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
  CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
  CONFIG_CMD_UBI=y
 -# CONFIG_ISO_PARTITION is not set
 -# CONFIG_EFI_PARTITION is not set
-+# CONFIG_SPL_EFI_PARTITION is not set
  CONFIG_ENV_IS_IN_MMC=y
- CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
  CONFIG_VERSION_VARIABLE=y
 diff --git a/configs/socfpga_de10_nano_defconfig b/configs/socfpga_de10_nano_defconfig
-index 102e781f5c1..2ea0852824b 100644
+index 4fabd63f2b4..941f9e9f3bc 100644
 --- a/configs/socfpga_de10_nano_defconfig
 +++ b/configs/socfpga_de10_nano_defconfig
-@@ -42,8 +42,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
+@@ -42,8 +42,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
  CONFIG_CMD_CACHE=y
  CONFIG_CMD_EXT4_WRITE=y
  CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
 -# CONFIG_ISO_PARTITION is not set
 -# CONFIG_EFI_PARTITION is not set
-+# CONFIG_SPL_EFI_PARTITION is not set
  CONFIG_ENV_IS_IN_MMC=y
- CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
  CONFIG_VERSION_VARIABLE=y
 diff --git a/configs/socfpga_de10_standard_defconfig b/configs/socfpga_de10_standard_defconfig
-index fe3eaad12a3..c903d3669e4 100644
+index 1c9ecbf2bc8..d2b0274249b 100644
 --- a/configs/socfpga_de10_standard_defconfig
 +++ b/configs/socfpga_de10_standard_defconfig
-@@ -42,8 +42,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
+@@ -42,8 +42,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
  CONFIG_CMD_CACHE=y
  CONFIG_CMD_EXT4_WRITE=y
  CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
 -# CONFIG_ISO_PARTITION is not set
 -# CONFIG_EFI_PARTITION is not set
-+# CONFIG_SPL_EFI_PARTITION is not set
  CONFIG_ENV_IS_IN_MMC=y
- CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
  CONFIG_VERSION_VARIABLE=y
 diff --git a/configs/socfpga_de1_soc_defconfig b/configs/socfpga_de1_soc_defconfig
-index 19e4ab98d59..c1c4b4466d8 100644
+index 52ed0ff7ffa..f97b3a4055b 100644
 --- a/configs/socfpga_de1_soc_defconfig
 +++ b/configs/socfpga_de1_soc_defconfig
-@@ -42,8 +42,7 @@ CONFIG_CMD_CACHE=y
+@@ -42,8 +42,6 @@ CONFIG_CMD_CACHE=y
  CONFIG_CMD_TIME=y
  CONFIG_CMD_EXT4_WRITE=y
  CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
 -# CONFIG_ISO_PARTITION is not set
 -# CONFIG_EFI_PARTITION is not set
-+# CONFIG_SPL_EFI_PARTITION is not set
  CONFIG_ENV_IS_IN_MMC=y
- CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
  CONFIG_VERSION_VARIABLE=y
 diff --git a/configs/socfpga_is1_defconfig b/configs/socfpga_is1_defconfig
-index 38286f71f84..523b0f8e09a 100644
+index 45d3b2f0807..4136d22e90e 100644
 --- a/configs/socfpga_is1_defconfig
 +++ b/configs/socfpga_is1_defconfig
-@@ -44,8 +44,7 @@ CONFIG_CMD_EXT4_WRITE=y
+@@ -44,8 +44,6 @@ CONFIG_CMD_EXT4_WRITE=y
  CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
  CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
  CONFIG_CMD_UBI=y
 -# CONFIG_ISO_PARTITION is not set
 -# CONFIG_EFI_PARTITION is not set
-+# CONFIG_SPL_EFI_PARTITION is not set
  CONFIG_ENV_IS_IN_SPI_FLASH=y
- CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
  CONFIG_USE_BOOTFILE=y
 diff --git a/configs/socfpga_mcvevk_defconfig b/configs/socfpga_mcvevk_defconfig
-index f61a63d835a..2e43ef68eba 100644
+index bff0c41336f..db288a2cf05 100644
 --- a/configs/socfpga_mcvevk_defconfig
 +++ b/configs/socfpga_mcvevk_defconfig
-@@ -42,8 +42,7 @@ CONFIG_CMD_USB=y
+@@ -42,8 +42,6 @@ CONFIG_CMD_USB=y
  CONFIG_CMD_USB_MASS_STORAGE=y
  CONFIG_CMD_CACHE=y
  CONFIG_CMD_EXT4_WRITE=y
 -# CONFIG_ISO_PARTITION is not set
 -# CONFIG_EFI_PARTITION is not set
-+# CONFIG_SPL_EFI_PARTITION is not set
  CONFIG_ENV_OVERWRITE=y
  CONFIG_ENV_IS_IN_MMC=y
- CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 diff --git a/configs/socfpga_secu1_defconfig b/configs/socfpga_secu1_defconfig
-index f7ae13c891b..e1338cddd0c 100644
+index 5fe35fe6eb8..552ded52873 100644
 --- a/configs/socfpga_secu1_defconfig
 +++ b/configs/socfpga_secu1_defconfig
-@@ -63,8 +63,7 @@ CONFIG_MTDIDS_DEFAULT="nand0=denali-nand"
+@@ -63,8 +63,6 @@ CONFIG_MTDIDS_DEFAULT="nand0=denali-nand"
  CONFIG_MTDPARTS_DEFAULT="mtdparts=denali-nand:512k(nand.4spl),512k(nand.uboot),128k(nand.env1),128k(nand.env2),0x1000000(nand.rec),0x3ee40000(nand.ubi),0x80000@0x3ff80000(nand.bbt)"
  CONFIG_CMD_UBI=y
  # CONFIG_CMD_UBIFS is not set
 -# CONFIG_ISO_PARTITION is not set
 -# CONFIG_EFI_PARTITION is not set
-+# CONFIG_SPL_EFI_PARTITION is not set
  CONFIG_ENV_OVERWRITE=y
  CONFIG_ENV_IS_IN_NAND=y
- CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+ CONFIG_ENV_REDUNDANT=y
 diff --git a/configs/socfpga_sockit_defconfig b/configs/socfpga_sockit_defconfig
-index 96ce2485a02..66d29245c18 100644
+index fed1dd83dc2..6dec5758fba 100644
 --- a/configs/socfpga_sockit_defconfig
 +++ b/configs/socfpga_sockit_defconfig
-@@ -44,8 +44,7 @@ CONFIG_CMD_EXT4_WRITE=y
+@@ -44,8 +44,6 @@ CONFIG_CMD_EXT4_WRITE=y
  CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
  CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
  CONFIG_CMD_UBI=y
 -# CONFIG_ISO_PARTITION is not set
 -# CONFIG_EFI_PARTITION is not set
-+# CONFIG_SPL_EFI_PARTITION is not set
  CONFIG_ENV_IS_IN_MMC=y
- CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
  CONFIG_VERSION_VARIABLE=y
 diff --git a/configs/socfpga_socrates_defconfig b/configs/socfpga_socrates_defconfig
-index d14dc86a742..73a11ef5019 100644
+index a08c7c0d9e0..3bfb05fa419 100644
 --- a/configs/socfpga_socrates_defconfig
 +++ b/configs/socfpga_socrates_defconfig
-@@ -44,8 +44,7 @@ CONFIG_CMD_EXT4_WRITE=y
+@@ -44,8 +44,6 @@ CONFIG_CMD_EXT4_WRITE=y
  CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
  CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
  CONFIG_CMD_UBI=y
 -# CONFIG_ISO_PARTITION is not set
 -# CONFIG_EFI_PARTITION is not set
-+# CONFIG_SPL_EFI_PARTITION is not set
  CONFIG_ENV_IS_IN_MMC=y
- CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
  CONFIG_VERSION_VARIABLE=y
 diff --git a/configs/socfpga_sr1500_defconfig b/configs/socfpga_sr1500_defconfig
-index 820b935b70a..3a5d3478357 100644
+index 7744ff9a888..814b4e8ce1d 100644
 --- a/configs/socfpga_sr1500_defconfig
 +++ b/configs/socfpga_sr1500_defconfig
-@@ -51,8 +51,7 @@ CONFIG_CMD_EXT4_WRITE=y
+@@ -51,8 +51,6 @@ CONFIG_CMD_EXT4_WRITE=y
  CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
  CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
  CONFIG_CMD_UBI=y
 -# CONFIG_ISO_PARTITION is not set
 -# CONFIG_EFI_PARTITION is not set
-+# CONFIG_SPL_EFI_PARTITION is not set
  CONFIG_ENV_IS_IN_SPI_FLASH=y
- CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
- CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+ CONFIG_ENV_REDUNDANT=y
+ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 diff --git a/configs/socfpga_vining_fpga_defconfig b/configs/socfpga_vining_fpga_defconfig
-index b4e303ed6dd..37f2b070c7f 100644
+index 396b7a9715d..f698b86e59f 100644
 --- a/configs/socfpga_vining_fpga_defconfig
 +++ b/configs/socfpga_vining_fpga_defconfig
-@@ -58,8 +58,7 @@ CONFIG_CMD_EXT4_WRITE=y
+@@ -58,8 +58,6 @@ CONFIG_CMD_EXT4_WRITE=y
  CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
  CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),64k(env1),64k(env2),256k(softing1),256k(softing2),-(rcvrfs);"
  CONFIG_CMD_UBI=y
 -# CONFIG_ISO_PARTITION is not set
 -# CONFIG_EFI_PARTITION is not set
-+# CONFIG_SPL_EFI_PARTITION is not set
  CONFIG_ENV_IS_IN_SPI_FLASH=y
- CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
- CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+ CONFIG_ENV_REDUNDANT=y
+ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+diff --git a/disk/Kconfig b/disk/Kconfig
+index b0bd02539ee..a58717bda30 100644
+--- a/disk/Kconfig
++++ b/disk/Kconfig
+@@ -142,6 +142,7 @@ config SPL_EFI_PARTITION
+ 	bool "Enable EFI GPT partition table for SPL"
+ 	depends on  SPL
+ 	default n if ARCH_MVEBU
++	default n if ARCH_SOCFPGA
+ 	default n if ARCH_SUNXI
+ 	default y if EFI_PARTITION
+ 	select SPL_PARTITIONS
 -- 
 2.51.0
 
diff --git a/recipes-bsp/u-boot/u-boot-bbb_2025.07.bb b/recipes-bsp/u-boot/u-boot-bbb_2026.01.bb
similarity index 100%
rename from recipes-bsp/u-boot/u-boot-bbb_2025.07.bb
rename to recipes-bsp/u-boot/u-boot-bbb_2026.01.bb
diff --git a/recipes-bsp/u-boot/u-boot-common-2025.07.inc b/recipes-bsp/u-boot/u-boot-common-2026.01.inc
similarity index 77%
rename from recipes-bsp/u-boot/u-boot-common-2025.07.inc
rename to recipes-bsp/u-boot/u-boot-common-2026.01.inc
index 7d91a8d1..7b911660 100644
--- a/recipes-bsp/u-boot/u-boot-common-2025.07.inc
+++ b/recipes-bsp/u-boot/u-boot-common-2026.01.inc
@@ -15,18 +15,14 @@ FILESPATH:append := ":${FILE_DIRNAME}/files"
 
 SRC_URI += " \
     https://ftp.denx.de/pub/u-boot/u-boot-${PV}.tar.bz2 \
-    file://0001-tools-Do-not-generate-logo-when-cross-building.patch \
-    file://0001-Kconfig-Convert-SYS_EARLY_PCI_INIT-to-Kconfig.patch \
-    file://0002-qemu_arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch \
-    file://0003-test-Fix-optee-unit-test.patch \
-    file://0001-arch-arm-mach-socfpga-Fix-non-Agilex-targets.patch \
-    file://0002-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch \
-    file://0003-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch \
+    file://0001-spl-Kconfig-Add-missing-SPL_LOAD_BLOCK-for-SYS_MMCSD.patch \
+    file://0002-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch \
+    file://0003-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch \
     file://0004-arch-arm-mach-socfpga-Adjust-a-raw-sectors-for-MMC-l.patch \
     file://0005-configs-socfpga-Fix-de0_nano_soc-boot.patch \
     file://0006-configs-socfpga-Permit-EFI-booting.patch \
     file://rules.tmpl;subdir=debian"
-SRC_URI[sha256sum] = "0f933f6c5a426895bf306e93e6ac53c60870e4b54cda56d95211bec99e63bec7"
+SRC_URI[sha256sum] = "b60d5865cefdbc75da8da4156c56c458e00de75a49b80c1a2e58a96e30ad0d54"
 
 SRC_URI:append:ftpm-stmm = " \
     file://ftpm-stmm.cfg"
diff --git a/recipes-bsp/u-boot/u-boot-de0-nano-soc_2025.07.bb b/recipes-bsp/u-boot/u-boot-de0-nano-soc_2026.01.bb
similarity index 100%
rename from recipes-bsp/u-boot/u-boot-de0-nano-soc_2025.07.bb
rename to recipes-bsp/u-boot/u-boot-de0-nano-soc_2026.01.bb
diff --git a/recipes-bsp/u-boot/u-boot-qemu-arm64_2025.07.bb b/recipes-bsp/u-boot/u-boot-qemu-arm64_2026.01.bb
similarity index 100%
rename from recipes-bsp/u-boot/u-boot-qemu-arm64_2025.07.bb
rename to recipes-bsp/u-boot/u-boot-qemu-arm64_2026.01.bb
diff --git a/recipes-bsp/u-boot/u-boot-qemu-arm_2025.07.bb b/recipes-bsp/u-boot/u-boot-qemu-arm_2026.01.bb
similarity index 100%
rename from recipes-bsp/u-boot/u-boot-qemu-arm_2025.07.bb
rename to recipes-bsp/u-boot/u-boot-qemu-arm_2026.01.bb
diff --git a/recipes-bsp/u-boot/u-boot-qemu-riscv64_2025.07.bb b/recipes-bsp/u-boot/u-boot-qemu-riscv64_2026.01.bb
similarity index 100%
rename from recipes-bsp/u-boot/u-boot-qemu-riscv64_2025.07.bb
rename to recipes-bsp/u-boot/u-boot-qemu-riscv64_2026.01.bb
diff --git a/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2026.01.bb
similarity index 98%
rename from recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
rename to recipes-bsp/u-boot/u-boot-ti-am62px-sk_2026.01.bb
index 622f429a..c4b2d74d 100644
--- a/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
+++ b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2026.01.bb
@@ -21,7 +21,6 @@ SRC_URI += " \
 	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-dm/am62pxx/ipc_echo_testb_mcu1_0_release_strip.xer5f;downloadfilename=ipc_echo_testb_mcu1_0_release_strip.xer5f;name=am62p-dm \
 	file://rules-${MACHINE} \
 	file://ti-extra.cfg \
-	file://0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch \
 	"
 
 SRC_URI[am62p-dm.sha256sum] = "85ba372a3c9cd0d09c84f9bbe46a72c7e4d6fdaff67df3ee7fbec3996965f044"
-- 
2.51.0


