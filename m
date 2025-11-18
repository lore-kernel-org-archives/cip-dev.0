Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56C4CED249
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 06:09:17 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6477.1763446148713026466
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Nov 2025 22:09:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=XVGwMceb;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-294854-20251118060905ea0966b5a0000207d2-4xnzkg@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20251118060905ea0966b5a0000207d2
        for <cip-dev@lists.cip-project.org>;
        Tue, 18 Nov 2025 07:09:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=13atkhqdwqP6ee+45O9taBjY348fgDe5JM/UIPbRXM4=;
 b=XVGwMcebZlOqjYepjX5qeN1PPR3fUBXmP3qUv1SNSrZETwbtacc7yAPWSBn8O2CVxdDoge
 WrNaO10c7/aQfdSD6aR4gfSTfrQ8OZnzGGLJ2FjtURB4Ecmh5L3wim6Vdrq76MDuuW9vpkC6
 F3m/ifHYgqE57DuSYbvy1JGdTfRpr0z2ob28Dw03U0UheBoBzM+XuW9v77DCBEYN7MVVHqr2
 qj75bZOy/mVqghgpOXfAAqQhKIdyEu5lhs9Uno3/kvav3i9sXcKHw3Qra82hk/9lcAvLojdP
 Z1pi97oaXbXUCvpvT3zQtWgZDnx03ChurOULlBVYKAdIzsfKNrgonbyw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 1/4] u-boot: Add recipe for DE0-Nano-SoC
Date: Tue, 18 Nov 2025 07:09:01 +0100
Message-ID: <cf43e9da3cfc59771e801d3215d3b3794f3602a8.1763446144.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1763446144.git.jan.kiszka@siemens.com>
References: <cover.1763446144.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Nov 2025 06:09:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20609

From: Jan Kiszka <jan.kiszka@siemens.com>

Unfortunately, upstream regressed for the Cyclone5 (and others), so we
need to add a bunch of further upstream-pending patches for 2025.07.
With those in place, we can configure u-boot to perform EFI booting on
the DE0-Nano-SoC.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...-mach-socfpga-Fix-non-Agilex-targets.patch |  97 ++++++++
 ...sector-value-passed-to-mmc_load_imag.patch |  39 +++
 ...for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch |  90 +++++++
 ...cfpga-Adjust-a-raw-sectors-for-MMC-l.patch |  44 ++++
 ...onfigs-socfpga-Fix-de0_nano_soc-boot.patch |  31 +++
 ...6-configs-socfpga-Permit-EFI-booting.patch | 229 ++++++++++++++++++
 recipes-bsp/u-boot/u-boot-common-2025.07.inc  |   6 +
 .../u-boot/u-boot-de0-nano-soc_2025.07.bb     |  26 ++
 8 files changed, 562 insertions(+)
 create mode 100644 recipes-bsp/u-boot/files/0001-arch-arm-mach-socfpga-Fix-non-Agilex-targets.patch
 create mode 100644 recipes-bsp/u-boot/files/0002-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch
 create mode 100644 recipes-bsp/u-boot/files/0003-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch
 create mode 100644 recipes-bsp/u-boot/files/0004-arch-arm-mach-socfpga-Adjust-a-raw-sectors-for-MMC-l.patch
 create mode 100644 recipes-bsp/u-boot/files/0005-configs-socfpga-Fix-de0_nano_soc-boot.patch
 create mode 100644 recipes-bsp/u-boot/files/0006-configs-socfpga-Permit-EFI-booting.patch
 create mode 100644 recipes-bsp/u-boot/u-boot-de0-nano-soc_2025.07.bb

diff --git a/recipes-bsp/u-boot/files/0001-arch-arm-mach-socfpga-Fix-non-Agilex-targets.patch b/recipes-bsp/u-boot/files/0001-arch-arm-mach-socfpga-Fix-non-Agilex-targets.patch
new file mode 100644
index 00000000..2c05d5cd
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0001-arch-arm-mach-socfpga-Fix-non-Agilex-targets.patch
@@ -0,0 +1,97 @@
+From c02c7bbadf6d97f3d178289909495483b66a921f Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Fri, 14 Nov 2025 12:42:46 +0100
+Subject: [PATCH 1/6] arch: arm: mach-socfpga: Fix non-Agilex targets
+
+The Altera system manager device is only provided for the Agilex
+targets. All others were left with an uninitialized socfpga_sysmgr_base
+after that refactoring, breaking any boot attempts already in SPL.
+
+Tested only on Cyclone5 / DE0-Nano-SoC.
+
+Fixes: 35638172f99a ("arm: socfpga: agilex5: Add new driver model for system manager in Agilex5")
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ arch/arm/mach-socfpga/misc.c     | 7 +++++++
+ arch/arm/mach-socfpga/spl_a10.c  | 1 +
+ arch/arm/mach-socfpga/spl_gen5.c | 1 +
+ arch/arm/mach-socfpga/spl_n5x.c  | 1 +
+ arch/arm/mach-socfpga/spl_s10.c  | 1 +
+ 5 files changed, 11 insertions(+)
+
+diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
+index 97e01140513..dee822fa870 100644
+--- a/arch/arm/mach-socfpga/misc.c
++++ b/arch/arm/mach-socfpga/misc.c
+@@ -277,6 +277,8 @@ void socfpga_get_managers_addr(void)
+ void socfpga_get_sys_mgr_addr(const char *compat)
+ {
+ 	int ret;
++#if defined(CONFIG_TARGET_SOCFPGA_AGILEX) || \
++    defined(TARGET_SOCFPGA_AGILEX7M) || defined(TARGET_SOCFPGA_AGILEX5)
+ 	struct udevice *sysmgr_dev;
+ 
+ 	ret = uclass_get_device_by_name(UCLASS_NOP, compat, &sysmgr_dev);
+@@ -286,6 +288,11 @@ void socfpga_get_sys_mgr_addr(const char *compat)
+ 	} else {
+ 		socfpga_sysmgr_base = (phys_addr_t)dev_read_addr(sysmgr_dev);
+ 	}
++#else
++	ret = socfpga_get_base_addr("altr,sys-mgr", &socfpga_sysmgr_base);
++	if (ret)
++		hang();
++#endif
+ }
+ 
+ phys_addr_t socfpga_get_rstmgr_addr(void)
+diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/spl_a10.c
+index c20376f7f8e..6722c9cef3f 100644
+--- a/arch/arm/mach-socfpga/spl_a10.c
++++ b/arch/arm/mach-socfpga/spl_a10.c
+@@ -250,6 +250,7 @@ void board_init_f(ulong dummy)
+ 	if (spl_early_init())
+ 		hang();
+ 
++	socfpga_get_sys_mgr_addr(NULL);
+ 	socfpga_get_managers_addr();
+ 
+ 	dcache_disable();
+diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/spl_gen5.c
+index df79cfe0f7f..cd8b09d7a8d 100644
+--- a/arch/arm/mach-socfpga/spl_gen5.c
++++ b/arch/arm/mach-socfpga/spl_gen5.c
+@@ -72,6 +72,7 @@ void board_init_f(ulong dummy)
+ 	if (ret)
+ 		hang();
+ 
++	socfpga_get_sys_mgr_addr(NULL);
+ 	socfpga_get_managers_addr();
+ 
+ 	/*
+diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
+index 81283ef7162..2b6a443e989 100644
+--- a/arch/arm/mach-socfpga/spl_n5x.c
++++ b/arch/arm/mach-socfpga/spl_n5x.c
+@@ -31,6 +31,7 @@ void board_init_f(ulong dummy)
+ 	if (ret)
+ 		hang();
+ 
++	socfpga_get_sys_mgr_addr(NULL);
+ 	socfpga_get_managers_addr();
+ 
+ 	/* Ensure watchdog is paused when debugging is happening */
+diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
+index fa83ff96adc..379e5642b2a 100644
+--- a/arch/arm/mach-socfpga/spl_s10.c
++++ b/arch/arm/mach-socfpga/spl_s10.c
+@@ -33,6 +33,7 @@ void board_init_f(ulong dummy)
+ 	if (ret)
+ 		hang();
+ 
++	socfpga_get_sys_mgr_addr(NULL);
+ 	socfpga_get_managers_addr();
+ 
+ 	/* Ensure watchdog is paused when debugging is happening */
+-- 
+2.51.0
+
diff --git a/recipes-bsp/u-boot/files/0002-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch b/recipes-bsp/u-boot/files/0002-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch
new file mode 100644
index 00000000..1b9cb526
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0002-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch
@@ -0,0 +1,39 @@
+From 27441e4cad3bcb2fd0c83c85f29a71e68f5a8c2d Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Fri, 14 Nov 2025 13:34:48 +0100
+Subject: [PATCH 2/6] spl: mmc: Respect sector value passed to
+ mmc_load_image_raw_partition
+
+This function and the sector parameter evolved over the time. By now,
+sector is influenced by spl_mmc_get_uboot_raw_sector which allows to
+adjust the read sector with an offset that U-Boot proper may have inside
+the partition. That used to work by chance if both
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR and
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION were enabled. Since
+2a00d73d081a they are a choice, and we need to drop the condition to
+maintain this feature.
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ common/spl/spl_mmc.c | 4 ----
+ 1 file changed, 4 deletions(-)
+
+diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
+index d06f9f0dee6..81415ae7594 100644
+--- a/common/spl/spl_mmc.c
++++ b/common/spl/spl_mmc.c
+@@ -137,11 +137,7 @@ static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
+ 		return ret;
+ 	}
+ 
+-#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
+ 	return mmc_load_image_raw_sector(spl_image, bootdev, mmc, info.start + sector);
+-#else
+-	return mmc_load_image_raw_sector(spl_image, bootdev, mmc, info.start);
+-#endif
+ }
+ #endif
+ 
+-- 
+2.51.0
+
diff --git a/recipes-bsp/u-boot/files/0003-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch b/recipes-bsp/u-boot/files/0003-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch
new file mode 100644
index 00000000..4e735718
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0003-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch
@@ -0,0 +1,90 @@
+From 2695758ae0f8184f6093086c0f2d4a152273d674 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Fri, 14 Nov 2025 13:40:20 +0100
+Subject: [PATCH 3/6] spl: mmc: Account for
+ SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE being a choice
+
+Add SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE as condition where so
+far SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION was enough - though often
+by chance as both options were enabled.
+
+We also need to explicitly select SPL_LOAD_BLOCK when UES_PARTITION_TYPE
+is enabled, just like the other choices do.
+
+Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ common/spl/Kconfig   |  1 +
+ common/spl/spl_mmc.c | 16 ++++++++--------
+ include/part.h       |  3 ++-
+ 3 files changed, 11 insertions(+), 9 deletions(-)
+
+diff --git a/common/spl/Kconfig b/common/spl/Kconfig
+index 77cf04d38ed..b757d14fbf1 100644
+--- a/common/spl/Kconfig
++++ b/common/spl/Kconfig
+@@ -563,6 +563,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
+ 
+ config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
+ 	bool "MMC raw mode: by partition type"
++	select SPL_LOAD_BLOCK
+ 	depends on DOS_PARTITION
+ 	help
+ 	  Use partition type for specifying U-Boot partition on MMC/SD in
+diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
+index 81415ae7594..34fe362d97e 100644
+--- a/common/spl/spl_mmc.c
++++ b/common/spl/spl_mmc.c
+@@ -107,7 +107,8 @@ static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
+ 	return 0;
+ }
+ 
+-#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
++#if defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
++    defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
+ static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
+ 					struct spl_boot_device *bootdev,
+ 					struct mmc *mmc, int partition,
+@@ -392,19 +393,18 @@ int spl_mmc_load(struct spl_image_info *spl_image,
+ 
+ 		raw_sect = spl_mmc_get_uboot_raw_sector(mmc, raw_sect);
+ 
+-#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
+-		ret = mmc_load_image_raw_partition(spl_image, bootdev,
+-						   mmc, raw_part,
+-						   raw_sect);
+-		if (!ret)
+-			return 0;
+-#endif
+ #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
+ 		ret = mmc_load_image_raw_sector(spl_image, bootdev, mmc,
+ 						raw_sect +
+ 						spl_mmc_raw_uboot_offset(part));
+ 		if (!ret)
+ 			return 0;
++#else
++		ret = mmc_load_image_raw_partition(spl_image, bootdev,
++						   mmc, raw_part,
++						   raw_sect);
++		if (!ret)
++			return 0;
+ #endif
+ 		/* If RAW mode fails, try FS mode. */
+ 		fallthrough;
+diff --git a/include/part.h b/include/part.h
+index fcb3c13dea4..6d16bf7ff85 100644
+--- a/include/part.h
++++ b/include/part.h
+@@ -443,7 +443,8 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
+ #ifdef CONFIG_XPL_BUILD
+ # define part_print_ptr(x)	NULL
+ # if defined(CONFIG_SPL_FS_EXT4) || defined(CONFIG_SPL_FS_FAT) || \
+-	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION)
++	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
++	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
+ #  define part_get_info_ptr(x)	x
+ # else
+ #  define part_get_info_ptr(x)	NULL
+-- 
+2.51.0
+
diff --git a/recipes-bsp/u-boot/files/0004-arch-arm-mach-socfpga-Adjust-a-raw-sectors-for-MMC-l.patch b/recipes-bsp/u-boot/files/0004-arch-arm-mach-socfpga-Adjust-a-raw-sectors-for-MMC-l.patch
new file mode 100644
index 00000000..bdbb4d1d
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0004-arch-arm-mach-socfpga-Adjust-a-raw-sectors-for-MMC-l.patch
@@ -0,0 +1,44 @@
+From 93a35b8a962d4f8d9e211c55e2d85b12d2ccce4b Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Fri, 14 Nov 2025 13:53:25 +0100
+Subject: [PATCH 4/6] arch: arm: mach-socfpga: Adjust a raw sectors for MMC
+ loading of U-Boot from SPL
+
+If U-Boot is located on MMC, SPL and U-Boot proper are glued together.
+More precisely, SPL is stored 4 times. Take this and its padding into
+account and adjust sector number via board_spl_mmc_get_uboot_raw_sector.
+This allows loading from a partition, without the need to hard-code the
+offset via SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ arch/arm/mach-socfpga/board.c | 9 +++++++++
+ 1 file changed, 9 insertions(+)
+
+diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.c
+index 8506d510413..a7598e79362 100644
+--- a/arch/arm/mach-socfpga/board.c
++++ b/arch/arm/mach-socfpga/board.c
+@@ -13,6 +13,7 @@
+ #include <hang.h>
+ #include <handoff.h>
+ #include <image.h>
++#include <spl.h>
+ #include <usb.h>
+ #include <usb/dwc2_udc.h>
+ #include <asm/global_data.h>
+@@ -208,3 +209,11 @@ void lmb_arch_add_memory(void)
+ 	}
+ }
+ #endif
++
++#ifdef CONFIG_SPL
++unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
++						 unsigned long raw_sect)
++{
++	return (CONFIG_SPL_PAD_TO * 4) / 512 + raw_sect;
++}
++#endif
+-- 
+2.51.0
+
diff --git a/recipes-bsp/u-boot/files/0005-configs-socfpga-Fix-de0_nano_soc-boot.patch b/recipes-bsp/u-boot/files/0005-configs-socfpga-Fix-de0_nano_soc-boot.patch
new file mode 100644
index 00000000..295a0e2f
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0005-configs-socfpga-Fix-de0_nano_soc-boot.patch
@@ -0,0 +1,31 @@
+From fdd7059526064d130b6797c7e62ed26b25bd2f77 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Thu, 13 Nov 2025 18:38:28 +0100
+Subject: [PATCH 5/6] configs: socfpga: Fix de0_nano_soc boot
+
+By default, the de0_nano_soc used raw sectors, but the address became
+invalid due the raw-mode refactorings. With loading via partition type
+fixed, we can switch to that mode which is in line with what the ROM
+loader does.
+
+Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ configs/socfpga_de0_nano_soc_defconfig | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/configs/socfpga_de0_nano_soc_defconfig b/configs/socfpga_de0_nano_soc_defconfig
+index 7188c46d98e..0bcc970728f 100644
+--- a/configs/socfpga_de0_nano_soc_defconfig
++++ b/configs/socfpga_de0_nano_soc_defconfig
+@@ -28,6 +28,7 @@ CONFIG_SPL_NO_BSS_LIMIT=y
+ # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+ # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+ CONFIG_SPL_HAVE_INIT_STACK=y
++CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE=y
+ CONFIG_SPL_SPI_LOAD=y
+ CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
+ CONFIG_SYS_MAXARGS=32
+-- 
+2.51.0
+
diff --git a/recipes-bsp/u-boot/files/0006-configs-socfpga-Permit-EFI-booting.patch b/recipes-bsp/u-boot/files/0006-configs-socfpga-Permit-EFI-booting.patch
new file mode 100644
index 00000000..31d51f2e
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0006-configs-socfpga-Permit-EFI-booting.patch
@@ -0,0 +1,229 @@
+From bd234afd41c8c21ac9caa7992c3e0b8292cca8b0 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Fri, 14 Nov 2025 16:18:14 +0100
+Subject: [PATCH 6/6] configs: socfpga: Permit EFI booting
+
+Commit f369e1564cf4 turned those off because the SPL size grew too
+large. It also argued that those boards would never support EFI booting.
+The former is correct, therefore keep CONFIG_SPL_EFI_PARTITION off.
+CONFIG_SPL_ISO_PARTITION is default off. What is not correct is that
+those boards are limited to legacy boot - you just need a hybrid
+partition table to make both the bootrom and UEFI happy.
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ configs/socfpga_agilex5_defconfig       | 3 +--
+ configs/socfpga_arria5_defconfig        | 3 +--
+ configs/socfpga_cyclone5_defconfig      | 3 +--
+ configs/socfpga_de0_nano_soc_defconfig  | 3 +--
+ configs/socfpga_de10_nano_defconfig     | 3 +--
+ configs/socfpga_de10_standard_defconfig | 3 +--
+ configs/socfpga_de1_soc_defconfig       | 3 +--
+ configs/socfpga_is1_defconfig           | 3 +--
+ configs/socfpga_mcvevk_defconfig        | 3 +--
+ configs/socfpga_secu1_defconfig         | 3 +--
+ configs/socfpga_sockit_defconfig        | 3 +--
+ configs/socfpga_socrates_defconfig      | 3 +--
+ configs/socfpga_sr1500_defconfig        | 3 +--
+ configs/socfpga_vining_fpga_defconfig   | 3 +--
+ 14 files changed, 14 insertions(+), 28 deletions(-)
+
+diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
+index 4ac0a5d9b99..4cb9d1fa4c2 100644
+--- a/configs/socfpga_agilex5_defconfig
++++ b/configs/socfpga_agilex5_defconfig
+@@ -64,8 +64,7 @@ CONFIG_CMD_WDT=y
+ CONFIG_CMD_CACHE=y
+ CONFIG_CMD_TIMER=y
+ CONFIG_CMD_UBI=y
+-# CONFIG_ISO_PARTITION is not set
+-# CONFIG_EFI_PARTITION is not set
++# CONFIG_SPL_EFI_PARTITION is not set
+ CONFIG_OF_LIST=""
+ CONFIG_ENV_IS_IN_UBI=y
+ CONFIG_ENV_UBI_PART="root"
+diff --git a/configs/socfpga_arria5_defconfig b/configs/socfpga_arria5_defconfig
+index f3c142300f2..4685314fbb1 100644
+--- a/configs/socfpga_arria5_defconfig
++++ b/configs/socfpga_arria5_defconfig
+@@ -44,8 +44,7 @@ CONFIG_CMD_EXT4_WRITE=y
+ CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
+ CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
+ CONFIG_CMD_UBI=y
+-# CONFIG_ISO_PARTITION is not set
+-# CONFIG_EFI_PARTITION is not set
++# CONFIG_SPL_EFI_PARTITION is not set
+ CONFIG_ENV_IS_IN_MMC=y
+ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+ CONFIG_VERSION_VARIABLE=y
+diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone5_defconfig
+index 97e5fae0f53..ae92bd2feb3 100644
+--- a/configs/socfpga_cyclone5_defconfig
++++ b/configs/socfpga_cyclone5_defconfig
+@@ -44,8 +44,7 @@ CONFIG_CMD_EXT4_WRITE=y
+ CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
+ CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
+ CONFIG_CMD_UBI=y
+-# CONFIG_ISO_PARTITION is not set
+-# CONFIG_EFI_PARTITION is not set
++# CONFIG_SPL_EFI_PARTITION is not set
+ CONFIG_ENV_IS_IN_MMC=y
+ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+ CONFIG_VERSION_VARIABLE=y
+diff --git a/configs/socfpga_de0_nano_soc_defconfig b/configs/socfpga_de0_nano_soc_defconfig
+index 0bcc970728f..a5f8258eaaf 100644
+--- a/configs/socfpga_de0_nano_soc_defconfig
++++ b/configs/socfpga_de0_nano_soc_defconfig
+@@ -46,8 +46,7 @@ CONFIG_CMD_EXT4_WRITE=y
+ CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
+ CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
+ CONFIG_CMD_UBI=y
+-# CONFIG_ISO_PARTITION is not set
+-# CONFIG_EFI_PARTITION is not set
++# CONFIG_SPL_EFI_PARTITION is not set
+ CONFIG_ENV_IS_IN_MMC=y
+ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+ CONFIG_VERSION_VARIABLE=y
+diff --git a/configs/socfpga_de10_nano_defconfig b/configs/socfpga_de10_nano_defconfig
+index 102e781f5c1..2ea0852824b 100644
+--- a/configs/socfpga_de10_nano_defconfig
++++ b/configs/socfpga_de10_nano_defconfig
+@@ -42,8 +42,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
+ CONFIG_CMD_CACHE=y
+ CONFIG_CMD_EXT4_WRITE=y
+ CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
+-# CONFIG_ISO_PARTITION is not set
+-# CONFIG_EFI_PARTITION is not set
++# CONFIG_SPL_EFI_PARTITION is not set
+ CONFIG_ENV_IS_IN_MMC=y
+ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+ CONFIG_VERSION_VARIABLE=y
+diff --git a/configs/socfpga_de10_standard_defconfig b/configs/socfpga_de10_standard_defconfig
+index fe3eaad12a3..c903d3669e4 100644
+--- a/configs/socfpga_de10_standard_defconfig
++++ b/configs/socfpga_de10_standard_defconfig
+@@ -42,8 +42,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
+ CONFIG_CMD_CACHE=y
+ CONFIG_CMD_EXT4_WRITE=y
+ CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
+-# CONFIG_ISO_PARTITION is not set
+-# CONFIG_EFI_PARTITION is not set
++# CONFIG_SPL_EFI_PARTITION is not set
+ CONFIG_ENV_IS_IN_MMC=y
+ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+ CONFIG_VERSION_VARIABLE=y
+diff --git a/configs/socfpga_de1_soc_defconfig b/configs/socfpga_de1_soc_defconfig
+index 19e4ab98d59..c1c4b4466d8 100644
+--- a/configs/socfpga_de1_soc_defconfig
++++ b/configs/socfpga_de1_soc_defconfig
+@@ -42,8 +42,7 @@ CONFIG_CMD_CACHE=y
+ CONFIG_CMD_TIME=y
+ CONFIG_CMD_EXT4_WRITE=y
+ CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
+-# CONFIG_ISO_PARTITION is not set
+-# CONFIG_EFI_PARTITION is not set
++# CONFIG_SPL_EFI_PARTITION is not set
+ CONFIG_ENV_IS_IN_MMC=y
+ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+ CONFIG_VERSION_VARIABLE=y
+diff --git a/configs/socfpga_is1_defconfig b/configs/socfpga_is1_defconfig
+index 38286f71f84..523b0f8e09a 100644
+--- a/configs/socfpga_is1_defconfig
++++ b/configs/socfpga_is1_defconfig
+@@ -44,8 +44,7 @@ CONFIG_CMD_EXT4_WRITE=y
+ CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
+ CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
+ CONFIG_CMD_UBI=y
+-# CONFIG_ISO_PARTITION is not set
+-# CONFIG_EFI_PARTITION is not set
++# CONFIG_SPL_EFI_PARTITION is not set
+ CONFIG_ENV_IS_IN_SPI_FLASH=y
+ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+ CONFIG_USE_BOOTFILE=y
+diff --git a/configs/socfpga_mcvevk_defconfig b/configs/socfpga_mcvevk_defconfig
+index f61a63d835a..2e43ef68eba 100644
+--- a/configs/socfpga_mcvevk_defconfig
++++ b/configs/socfpga_mcvevk_defconfig
+@@ -42,8 +42,7 @@ CONFIG_CMD_USB=y
+ CONFIG_CMD_USB_MASS_STORAGE=y
+ CONFIG_CMD_CACHE=y
+ CONFIG_CMD_EXT4_WRITE=y
+-# CONFIG_ISO_PARTITION is not set
+-# CONFIG_EFI_PARTITION is not set
++# CONFIG_SPL_EFI_PARTITION is not set
+ CONFIG_ENV_OVERWRITE=y
+ CONFIG_ENV_IS_IN_MMC=y
+ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+diff --git a/configs/socfpga_secu1_defconfig b/configs/socfpga_secu1_defconfig
+index f7ae13c891b..e1338cddd0c 100644
+--- a/configs/socfpga_secu1_defconfig
++++ b/configs/socfpga_secu1_defconfig
+@@ -63,8 +63,7 @@ CONFIG_MTDIDS_DEFAULT="nand0=denali-nand"
+ CONFIG_MTDPARTS_DEFAULT="mtdparts=denali-nand:512k(nand.4spl),512k(nand.uboot),128k(nand.env1),128k(nand.env2),0x1000000(nand.rec),0x3ee40000(nand.ubi),0x80000@0x3ff80000(nand.bbt)"
+ CONFIG_CMD_UBI=y
+ # CONFIG_CMD_UBIFS is not set
+-# CONFIG_ISO_PARTITION is not set
+-# CONFIG_EFI_PARTITION is not set
++# CONFIG_SPL_EFI_PARTITION is not set
+ CONFIG_ENV_OVERWRITE=y
+ CONFIG_ENV_IS_IN_NAND=y
+ CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+diff --git a/configs/socfpga_sockit_defconfig b/configs/socfpga_sockit_defconfig
+index 96ce2485a02..66d29245c18 100644
+--- a/configs/socfpga_sockit_defconfig
++++ b/configs/socfpga_sockit_defconfig
+@@ -44,8 +44,7 @@ CONFIG_CMD_EXT4_WRITE=y
+ CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
+ CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
+ CONFIG_CMD_UBI=y
+-# CONFIG_ISO_PARTITION is not set
+-# CONFIG_EFI_PARTITION is not set
++# CONFIG_SPL_EFI_PARTITION is not set
+ CONFIG_ENV_IS_IN_MMC=y
+ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+ CONFIG_VERSION_VARIABLE=y
+diff --git a/configs/socfpga_socrates_defconfig b/configs/socfpga_socrates_defconfig
+index d14dc86a742..73a11ef5019 100644
+--- a/configs/socfpga_socrates_defconfig
++++ b/configs/socfpga_socrates_defconfig
+@@ -44,8 +44,7 @@ CONFIG_CMD_EXT4_WRITE=y
+ CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
+ CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
+ CONFIG_CMD_UBI=y
+-# CONFIG_ISO_PARTITION is not set
+-# CONFIG_EFI_PARTITION is not set
++# CONFIG_SPL_EFI_PARTITION is not set
+ CONFIG_ENV_IS_IN_MMC=y
+ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+ CONFIG_VERSION_VARIABLE=y
+diff --git a/configs/socfpga_sr1500_defconfig b/configs/socfpga_sr1500_defconfig
+index 820b935b70a..3a5d3478357 100644
+--- a/configs/socfpga_sr1500_defconfig
++++ b/configs/socfpga_sr1500_defconfig
+@@ -51,8 +51,7 @@ CONFIG_CMD_EXT4_WRITE=y
+ CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
+ CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
+ CONFIG_CMD_UBI=y
+-# CONFIG_ISO_PARTITION is not set
+-# CONFIG_EFI_PARTITION is not set
++# CONFIG_SPL_EFI_PARTITION is not set
+ CONFIG_ENV_IS_IN_SPI_FLASH=y
+ CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+diff --git a/configs/socfpga_vining_fpga_defconfig b/configs/socfpga_vining_fpga_defconfig
+index b4e303ed6dd..37f2b070c7f 100644
+--- a/configs/socfpga_vining_fpga_defconfig
++++ b/configs/socfpga_vining_fpga_defconfig
+@@ -58,8 +58,7 @@ CONFIG_CMD_EXT4_WRITE=y
+ CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
+ CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),64k(env1),64k(env2),256k(softing1),256k(softing2),-(rcvrfs);"
+ CONFIG_CMD_UBI=y
+-# CONFIG_ISO_PARTITION is not set
+-# CONFIG_EFI_PARTITION is not set
++# CONFIG_SPL_EFI_PARTITION is not set
+ CONFIG_ENV_IS_IN_SPI_FLASH=y
+ CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+-- 
+2.51.0
+
diff --git a/recipes-bsp/u-boot/u-boot-common-2025.07.inc b/recipes-bsp/u-boot/u-boot-common-2025.07.inc
index 92b5e9ce..4f0b7d24 100644
--- a/recipes-bsp/u-boot/u-boot-common-2025.07.inc
+++ b/recipes-bsp/u-boot/u-boot-common-2025.07.inc
@@ -19,6 +19,12 @@ SRC_URI += " \
     file://0001-Kconfig-Convert-SYS_EARLY_PCI_INIT-to-Kconfig.patch \
     file://0002-qemu_arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch \
     file://0003-test-Fix-optee-unit-test.patch \
+    file://0001-arch-arm-mach-socfpga-Fix-non-Agilex-targets.patch \
+    file://0002-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch \
+    file://0003-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch \
+    file://0004-arch-arm-mach-socfpga-Adjust-a-raw-sectors-for-MMC-l.patch \
+    file://0005-configs-socfpga-Fix-de0_nano_soc-boot.patch \
+    file://0006-configs-socfpga-Permit-EFI-booting.patch \
     file://rules.tmpl;subdir=debian"
 SRC_URI[sha256sum] = "0f933f6c5a426895bf306e93e6ac53c60870e4b54cda56d95211bec99e63bec7"
 
diff --git a/recipes-bsp/u-boot/u-boot-de0-nano-soc_2025.07.bb b/recipes-bsp/u-boot/u-boot-de0-nano-soc_2025.07.bb
new file mode 100644
index 00000000..0dd67db1
--- /dev/null
+++ b/recipes-bsp/u-boot/u-boot-de0-nano-soc_2025.07.bb
@@ -0,0 +1,26 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require u-boot-common-${PV}.inc
+
+COMPATIBLE_MACHINE = "de0-nano-soc"
+
+U_BOOT_CONFIG = "socfpga_de0_nano_soc_defconfig"
+U_BOOT_BIN = "u-boot-with-spl.sfp"
+
+do_prepare_build:append() {
+    sed -ni '/### DE0 Nano SoC extra config/q;p' ${S}/configs/${U_BOOT_CONFIG}
+    cat <<EOF >> ${S}/configs/${U_BOOT_CONFIG}
+### DE0 Nano SoC extra config
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="bootefi bootmgr"
+EOF
+}
-- 
2.51.0


