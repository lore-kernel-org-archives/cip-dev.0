Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9993EE7315F
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 12:57:57 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.51546.1770037072085566521
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Feb 2026 04:57:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=V8we3TTb;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-2026020212574928b82f50a100020721-2_jjpz@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2026020212574928b82f50a100020721
        for <cip-dev@lists.cip-project.org>;
        Mon, 02 Feb 2026 13:57:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=rOtL+aQMfM1ceSlYXzWFtAN6rPRGTAjjX4VohqVI6Rc=;
 b=V8we3TTb+GBHFAg3e67Vj1DEbzH05l9FrFYGfpnt8YPndj5xWHBuVS5EXNM25FB3WWPioT
 J6Dofs2PuTaJWzH3f6SjiKiM2wDWf7HMDip9J4gwZx6i+MIMXf6sDvgH1DkeaRfLUeHiZa85
 l4Q0H3JNYhF57WlrWmxTnTmOqyGRvQH3qWgcIQl66Nsb5QRsB7KdOEpD7OHA6Rj+N4f1YqcZ
 Pa/RkL6kzLu545x0+Gm6K86kvs4OokmHcrgxDDwicm6rewP6NK/qqU5jtPnkBUZP9h0aCHAX
 LKULRuxA9c4IwnXnU95XgD6fYzlKcdic2X/TZISvRPhb0ubeaVNLlwsw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 5/9] u-boot: Add recipe for BeagleV-Fire
Date: Mon,  2 Feb 2026 13:57:44 +0100
Message-ID: <4282c28406ecd0bdcf5d8599010b6d1dcdb8be0b.1770037068.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21797

From: Jan Kiszka <jan.kiszka@siemens.com>

Requires 3 patches, 2 are merged for past 2026.01, one is pending and
had some fix-up needs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...ustom-CPU-implementation-for-PolarFi.patch | 153 ++++++++
 ...SoC-level-options-to-the-CPU-Kconfig.patch |  83 +++++
 ...3-riscv-Add-support-for-BeagleV-Fire.patch | 346 ++++++++++++++++++
 .../u-boot/files/beaglev-fire-config.yaml     |  17 +
 .../u-boot/u-boot-beaglev-fire_2026.01.bb     |  23 ++
 recipes-bsp/u-boot/u-boot-common-2026.01.inc  |   3 +
 6 files changed, 625 insertions(+)
 create mode 100644 recipes-bsp/u-boot/files/0001-riscv-create-a-custom-CPU-implementation-for-PolarFi.patch
 create mode 100644 recipes-bsp/u-boot/files/0002-riscv-mpfs-move-SoC-level-options-to-the-CPU-Kconfig.patch
 create mode 100644 recipes-bsp/u-boot/files/0003-riscv-Add-support-for-BeagleV-Fire.patch
 create mode 100644 recipes-bsp/u-boot/files/beaglev-fire-config.yaml
 create mode 100644 recipes-bsp/u-boot/u-boot-beaglev-fire_2026.01.bb

diff --git a/recipes-bsp/u-boot/files/0001-riscv-create-a-custom-CPU-implementation-for-PolarFi.patch b/recipes-bsp/u-boot/files/0001-riscv-create-a-custom-CPU-implementation-for-PolarFi.patch
new file mode 100644
index 00000000..aafb7f6c
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0001-riscv-create-a-custom-CPU-implementation-for-PolarFi.patch
@@ -0,0 +1,153 @@
+From 851a7cf7775590e0d0b9d3cec38c1c3ae9cec528 Mon Sep 17 00:00:00 2001
+From: Conor Dooley <conor.dooley@microchip.com>
+Date: Wed, 19 Nov 2025 12:38:42 +0000
+Subject: [PATCH 1/3] riscv: create a custom CPU implementation for PolarFire
+ SoC
+
+PolarFire SoC needs a custom implementation of top_of_ram(), so stop
+using the generic CPU & create a custom CPU instead.
+
+Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
+Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
+---
+ arch/riscv/Kconfig                     |  1 +
+ arch/riscv/cpu/mpfs/Kconfig            | 16 +++++++++++
+ arch/riscv/cpu/mpfs/Makefile           |  5 ++++
+ arch/riscv/cpu/mpfs/dram.c             | 38 ++++++++++++++++++++++++++
+ arch/riscv/include/asm/arch-mpfs/clk.h |  8 ++++++
+ board/microchip/mpfs_generic/Kconfig   |  4 +--
+ 6 files changed, 70 insertions(+), 2 deletions(-)
+ create mode 100644 arch/riscv/cpu/mpfs/Kconfig
+ create mode 100644 arch/riscv/cpu/mpfs/Makefile
+ create mode 100644 arch/riscv/cpu/mpfs/dram.c
+ create mode 100644 arch/riscv/include/asm/arch-mpfs/clk.h
+
+diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
+index 265b5320777..79867656b15 100644
+--- a/arch/riscv/Kconfig
++++ b/arch/riscv/Kconfig
+@@ -126,6 +126,7 @@ source "arch/riscv/cpu/cv1800b/Kconfig"
+ source "arch/riscv/cpu/fu540/Kconfig"
+ source "arch/riscv/cpu/fu740/Kconfig"
+ source "arch/riscv/cpu/ast2700/Kconfig"
++source "arch/riscv/cpu/mpfs/Kconfig"
+ source "arch/riscv/cpu/generic/Kconfig"
+ source "arch/riscv/cpu/jh7110/Kconfig"
+ source "arch/riscv/cpu/k1/Kconfig"
+diff --git a/arch/riscv/cpu/mpfs/Kconfig b/arch/riscv/cpu/mpfs/Kconfig
+new file mode 100644
+index 00000000000..3e99c1aae38
+--- /dev/null
++++ b/arch/riscv/cpu/mpfs/Kconfig
+@@ -0,0 +1,16 @@
++# SPDX-License-Identifier: GPL-2.0+
++
++config MICROCHIP_MPFS
++	bool
++	select ARCH_EARLY_INIT_R
++	imply CPU
++	imply CPU_RISCV
++	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
++	imply SIFIVE_CLINT if RISCV_MMODE
++	imply SPL_SIFIVE_CLINT if SPL_RISCV_MMODE
++	imply CMD_CPU
++	imply SPL_CPU
++	imply SPL_OPENSBI
++	imply SPL_LOAD_FIT
++	imply REGMAP
++	imply SYSCON
+diff --git a/arch/riscv/cpu/mpfs/Makefile b/arch/riscv/cpu/mpfs/Makefile
+new file mode 100644
+index 00000000000..e2f62ff7711
+--- /dev/null
++++ b/arch/riscv/cpu/mpfs/Makefile
+@@ -0,0 +1,5 @@
++# SPDX-License-Identifier: GPL-2.0+
++
++ifneq ($(CONFIG_SPL_BUILD),y)
++obj-y += dram.o
++endif
+diff --git a/arch/riscv/cpu/mpfs/dram.c b/arch/riscv/cpu/mpfs/dram.c
+new file mode 100644
+index 00000000000..4398d3e36c8
+--- /dev/null
++++ b/arch/riscv/cpu/mpfs/dram.c
+@@ -0,0 +1,38 @@
++// SPDX-License-Identifier: GPL-2.0+
++/*
++ * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
++ */
++
++#include <asm/global_data.h>
++#include <fdtdec.h>
++#include <init.h>
++#include <linux/sizes.h>
++
++DECLARE_GLOBAL_DATA_PTR;
++
++#define MPFS_TOP_OF_CACHED (SZ_2G + SZ_1G)
++#define MPFS_HSS_RESERVATION (SZ_4M)
++
++int dram_init(void) {
++    return fdtdec_setup_mem_size_base();
++}
++
++int dram_init_banksize(void) {
++    return fdtdec_setup_memory_banksize();
++}
++
++phys_size_t board_get_usable_ram_top(phys_size_t total_size) {
++    /*
++     * Ensure that if we run from 32-bit memory that all memory used by
++     * U-Boot is cached addresses, but also account for the reservation at
++     * the top of 32 bit cached DDR used by the HSS.
++     */
++    if (gd->ram_top >= MPFS_TOP_OF_CACHED - MPFS_HSS_RESERVATION)
++        return MPFS_TOP_OF_CACHED - MPFS_HSS_RESERVATION - 1;
++    /*
++     * If we don't find a 32 bit region just return the top of memory.
++     * If the address is a 32-bit region, but fits beneath the HSS'
++     * reservation, ram_top is adequate also.
++     */
++    return gd->ram_top;
++}
+\ No newline at end of file
+diff --git a/arch/riscv/include/asm/arch-mpfs/clk.h b/arch/riscv/include/asm/arch-mpfs/clk.h
+new file mode 100644
+index 00000000000..fbb1399f3c8
+--- /dev/null
++++ b/arch/riscv/include/asm/arch-mpfs/clk.h
+@@ -0,0 +1,8 @@
++/* SPDX-License-Identifier: GPL-2.0+ */
++
++#ifndef __ASM_RISCV_ARCH_MPFS_CLK_H
++#define __ASM_RISCV_ARCH_MPFS_CLK_H
++
++/* Note: This is a placeholder header for driver compilation. */
++
++#endif
+diff --git a/board/microchip/mpfs_generic/Kconfig b/board/microchip/mpfs_generic/Kconfig
+index 8dcf55a0311..49663a4c562 100644
+--- a/board/microchip/mpfs_generic/Kconfig
++++ b/board/microchip/mpfs_generic/Kconfig
+@@ -7,7 +7,7 @@ config SYS_VENDOR
+ 	default "microchip"
+ 
+ config SYS_CPU
+-	default "generic"
++	default "mpfs"
+ 
+ config SYS_CONFIG_NAME
+ 	default "microchip_mpfs_generic"
+@@ -18,7 +18,7 @@ config TEXT_BASE
+ 
+ config BOARD_SPECIFIC_OPTIONS # dummy
+ 	def_bool y
+-	select GENERIC_RISCV
++	select MICROCHIP_MPFS
+ 	select BOARD_EARLY_INIT_F
+ 	select BOARD_LATE_INIT
+ 	imply SMP
+-- 
+2.51.0
+
diff --git a/recipes-bsp/u-boot/files/0002-riscv-mpfs-move-SoC-level-options-to-the-CPU-Kconfig.patch b/recipes-bsp/u-boot/files/0002-riscv-mpfs-move-SoC-level-options-to-the-CPU-Kconfig.patch
new file mode 100644
index 00000000..6001146c
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0002-riscv-mpfs-move-SoC-level-options-to-the-CPU-Kconfig.patch
@@ -0,0 +1,83 @@
+From 61f4e301ad700bcc2d87521258dbd31e073a6088 Mon Sep 17 00:00:00 2001
+From: Conor Dooley <conor.dooley@microchip.com>
+Date: Wed, 19 Nov 2025 12:38:43 +0000
+Subject: [PATCH 2/3] riscv: mpfs: move SoC level options to the CPU Kconfig
+
+There are multiple boards that use the PolarFire SoC, so extract
+the Kconfig sections that are determined at a CPU level from the board
+Kconfigs now that we have a CPU Kconfig.
+
+Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
+---
+ arch/riscv/cpu/mpfs/Kconfig          | 17 +++++++++++++++++
+ board/microchip/mpfs_generic/Kconfig | 20 --------------------
+ 2 files changed, 17 insertions(+), 20 deletions(-)
+
+diff --git a/arch/riscv/cpu/mpfs/Kconfig b/arch/riscv/cpu/mpfs/Kconfig
+index 3e99c1aae38..bcf1ede818b 100644
+--- a/arch/riscv/cpu/mpfs/Kconfig
++++ b/arch/riscv/cpu/mpfs/Kconfig
+@@ -14,3 +14,20 @@ config MICROCHIP_MPFS
+ 	imply SPL_LOAD_FIT
+ 	imply REGMAP
+ 	imply SYSCON
++	imply CLK_CCF
++	imply CLK_MPFS
++	imply SYS_NS16550
++	imply MACB
++	imply MII
++	imply CMD_I2C
++	imply DM_I2C
++	imply SYS_I2C_MICROCHIP
++	imply MMC
++	imply MMC_WRITE
++	imply MMC_SDHCI
++	imply MMC_SDHCI_CADENCE
++	imply MMC_SDHCI_ADMA
++	imply MMC_HS200_SUPPORT
++	imply SPI
++	imply DM_SPI
++	imply MICROCHIP_QSPI
+diff --git a/board/microchip/mpfs_generic/Kconfig b/board/microchip/mpfs_generic/Kconfig
+index 49663a4c562..d38e56c742d 100644
+--- a/board/microchip/mpfs_generic/Kconfig
++++ b/board/microchip/mpfs_generic/Kconfig
+@@ -22,11 +22,6 @@ config BOARD_SPECIFIC_OPTIONS # dummy
+ 	select BOARD_EARLY_INIT_F
+ 	select BOARD_LATE_INIT
+ 	imply SMP
+-	imply CLK_CCF
+-	imply CLK_MPFS
+-	imply REGMAP
+-	imply SYSCON
+-	imply SYS_NS16550
+ 	imply CMD_DHCP
+ 	imply CMD_EXT2
+ 	imply CMD_EXT4
+@@ -39,23 +34,8 @@ config BOARD_SPECIFIC_OPTIONS # dummy
+ 	imply EFI_PARTITION
+ 	imply IP_DYN
+ 	imply ISO_PARTITION
+-	imply MACB
+-	imply MII
+ 	imply PHY_LIB
+ 	imply PHY_VITESSE
+-	imply MMC
+-	imply MMC_WRITE
+-	imply MMC_SDHCI
+-	imply MMC_SDHCI_CADENCE
+-	imply MMC_SDHCI_ADMA
+-	imply MMC_HS200_SUPPORT
+-	imply CMD_I2C
+-	imply DM_I2C
+-	imply SYS_I2C_MICROCHIP
+-	imply MTD
+-	imply SPI
+-	imply DM_SPI
+-	imply MICROCHIP_COREQSPI
+ 	imply MTD_SPI_NAND
+ 	imply CMD_MTD
+ 	imply CMD_MTDPARTS
+-- 
+2.51.0
+
diff --git a/recipes-bsp/u-boot/files/0003-riscv-Add-support-for-BeagleV-Fire.patch b/recipes-bsp/u-boot/files/0003-riscv-Add-support-for-BeagleV-Fire.patch
new file mode 100644
index 00000000..7f84d057
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0003-riscv-Add-support-for-BeagleV-Fire.patch
@@ -0,0 +1,346 @@
+From 9a3808ac310c2eab02fb66d79c4296c7c7267a9f Mon Sep 17 00:00:00 2001
+From: Jamie Gibbons <jamie.gibbons@microchip.com>
+Date: Tue, 9 Dec 2025 12:45:21 +0100
+Subject: [PATCH 3/3] riscv: Add support for BeagleV-Fire
+
+Bring U-Boot support for the BeagleV-Fire by adding a defconfig and
+supporting board files etc.
+
+Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
+[Jan: enable OF_UPSTREAM, set DEFAULT_FDT_FILE, regenerate defconfig]
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ arch/riscv/Kconfig                       |   4 +
+ board/beagle/beaglev_fire/Kconfig        |  39 ++++++++
+ board/beagle/beaglev_fire/MAINTAINERS    |   7 ++
+ board/beagle/beaglev_fire/Makefile       |   6 ++
+ board/beagle/beaglev_fire/beaglev_fire.c | 117 +++++++++++++++++++++++
+ configs/beaglev_fire_defconfig           |  29 ++++++
+ include/configs/beaglev_fire.h           |  57 +++++++++++
+ 7 files changed, 259 insertions(+)
+ create mode 100644 board/beagle/beaglev_fire/Kconfig
+ create mode 100644 board/beagle/beaglev_fire/MAINTAINERS
+ create mode 100644 board/beagle/beaglev_fire/Makefile
+ create mode 100644 board/beagle/beaglev_fire/beaglev_fire.c
+ create mode 100644 configs/beaglev_fire_defconfig
+ create mode 100644 include/configs/beaglev_fire.h
+
+diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
+index 79867656b15..ad7589123c6 100644
+--- a/arch/riscv/Kconfig
++++ b/arch/riscv/Kconfig
+@@ -17,6 +17,9 @@ config TARGET_ANDES_VOYAGER
+ config TARGET_BANANAPI_F3
+ 	bool "Support BananaPi F3 Board"
+ 
++config TARGET_BEAGLEBOARD_BEAGLEVFIRE
++	bool "Support BeagleBoard BeagleV-Fire Board (based on Microchip MPFS)"
++
+ config TARGET_K230_CANMV
+ 	bool "Support K230 CanMV Board"
+ 
+@@ -106,6 +109,7 @@ config SPL_ZERO_MEM_BEFORE_USE
+ source "board/andestech/ae350/Kconfig"
+ source "board/andestech/voyager/Kconfig"
+ source "board/aspeed/ibex_ast2700/Kconfig"
++source "board/beagle/beaglev_fire/Kconfig"
+ source "board/canaan/k230_canmv/Kconfig"
+ source "board/emulation/qemu-riscv/Kconfig"
+ source "board/microchip/mpfs_generic/Kconfig"
+diff --git a/board/beagle/beaglev_fire/Kconfig b/board/beagle/beaglev_fire/Kconfig
+new file mode 100644
+index 00000000000..279d38b3aa9
+--- /dev/null
++++ b/board/beagle/beaglev_fire/Kconfig
+@@ -0,0 +1,39 @@
++if TARGET_BEAGLEBOARD_BEAGLEVFIRE
++
++config SYS_BOARD
++	default "beaglev_fire"
++
++config SYS_VENDOR
++	default "beagle"
++
++config SYS_CPU
++	default "mpfs"
++
++config SYS_CONFIG_NAME
++	default "beaglev_fire"
++
++config TEXT_BASE
++	default 0x80000000 if !RISCV_SMODE
++	default 0x80200000 if RISCV_SMODE
++
++config BOARD_SPECIFIC_OPTIONS # dummy
++	def_bool y
++	select MICROCHIP_MPFS
++	select BOARD_EARLY_INIT_F
++	select BOARD_LATE_INIT
++	imply SMP
++	imply CMD_DHCP
++	imply CMD_EXT2
++	imply CMD_EXT4
++	imply CMD_FAT
++	imply CMD_FS_GENERIC
++	imply CMD_NET
++	imply CMD_PING
++	imply CMD_MMC
++	imply DOS_PARTITION
++	imply EFI_PARTITION
++	imply IP_DYN
++	imply ISO_PARTITION
++	imply PHY_LIB
++	imply PHY_VITESSE
++endif
+diff --git a/board/beagle/beaglev_fire/MAINTAINERS b/board/beagle/beaglev_fire/MAINTAINERS
+new file mode 100644
+index 00000000000..a5dad93ee99
+--- /dev/null
++++ b/board/beagle/beaglev_fire/MAINTAINERS
+@@ -0,0 +1,7 @@
++BeagleBoard MPFS BeagleV-Fire
++M:	Cyril Jean <cyril.jean@microchip.com>
++M:	Jamie Gibbons <jamie.gibbons@microchip.com>
++S:	Maintained
++F:	board/beagle/beaglev_fire/
++F:	include/configs/beaglev_fire.h
++F:	configs/beaglev_fire_defconfig
+\ No newline at end of file
+diff --git a/board/beagle/beaglev_fire/Makefile b/board/beagle/beaglev_fire/Makefile
+new file mode 100644
+index 00000000000..a4109a8aad4
+--- /dev/null
++++ b/board/beagle/beaglev_fire/Makefile
+@@ -0,0 +1,6 @@
++# SPDX-License-Identifier: GPL-2.0+
++#
++# Copyright (C) 2023 Microchip Technology Inc.
++#
++
++obj-y	+= beaglev_fire.o
+\ No newline at end of file
+diff --git a/board/beagle/beaglev_fire/beaglev_fire.c b/board/beagle/beaglev_fire/beaglev_fire.c
+new file mode 100644
+index 00000000000..b2f18c455b7
+--- /dev/null
++++ b/board/beagle/beaglev_fire/beaglev_fire.c
+@@ -0,0 +1,117 @@
++// SPDX-License-Identifier: GPL-2.0+
++/*
++ * Copyright (C) 2019-2023 Microchip Technology Inc.
++ */
++
++#include <dm.h>
++#include <dm/devres.h>
++#include <env.h>
++#include <asm/global_data.h>
++#include <asm/io.h>
++#include <linux/compat.h>
++#include <mpfs-mailbox.h>
++
++DECLARE_GLOBAL_DATA_PTR;
++
++#define MPFS_SYSREG_SOFT_RESET	((unsigned int *)0x20002088)
++#define PERIPH_RESET_VALUE		0x800001e8u
++
++#if IS_ENABLED(CONFIG_MPFS_SYSCONTROLLER)
++static unsigned char mac_addr[6];
++#endif
++
++int board_init(void)
++{
++	/* For now nothing to do here. */
++
++	return 0;
++}
++
++int board_early_init_f(void)
++{
++	unsigned int val;
++
++	/* Reset uart, mmc peripheral */
++	val = readl(MPFS_SYSREG_SOFT_RESET);
++	val = (val & ~(PERIPH_RESET_VALUE));
++	writel(val, MPFS_SYSREG_SOFT_RESET);
++
++	return 0;
++}
++
++int board_late_init(void)
++{
++#if IS_ENABLED(CONFIG_MPFS_SYSCONTROLLER)
++	u32 ret;
++	int node;
++	u8 device_serial_number[16] = {0};
++	void *blob = (void *)gd->fdt_blob;
++	struct udevice *dev;
++	struct mpfs_sys_serv *sys_serv_priv;
++
++	ret = uclass_get_device_by_name(UCLASS_MISC, "syscontroller", &dev);
++	if (ret) {
++		debug("%s: system controller setup failed\n", __func__);
++		return ret;
++	}
++
++	sys_serv_priv = devm_kzalloc(dev, sizeof(*sys_serv_priv), GFP_KERNEL);
++	if (!sys_serv_priv)
++		return -ENOMEM;
++
++	sys_serv_priv->dev = dev;
++
++	sys_serv_priv->sys_controller = mpfs_syscontroller_get(dev);
++	ret = IS_ERR(sys_serv_priv->sys_controller);
++	if (ret) {
++		debug("%s:  Failed to register system controller sub device ret=%d\n", __func__, ret);
++		return -ENODEV;
++	}
++
++	ret = mpfs_syscontroller_read_sernum(sys_serv_priv, device_serial_number);
++	if (ret) {
++		printf("Cannot read device serial number\n");
++		return -EINVAL;
++	}
++
++	/* Update MAC address with device serial number */
++	mac_addr[0] = 0x00;
++	mac_addr[1] = 0x04;
++	mac_addr[2] = 0xA3;
++	mac_addr[3] = device_serial_number[2];
++	mac_addr[4] = device_serial_number[1];
++	mac_addr[5] = device_serial_number[0];
++
++	node = fdt_path_offset(blob, "/soc/ethernet@20110000");
++	if (node >= 0) {
++		ret = fdt_setprop(blob, node, "local-mac-address", mac_addr, 6);
++		if (ret) {
++			printf("Error setting local-mac-address property for ethernet@20110000\n");
++			return -ENODEV;
++		}
++	}
++
++	mpfs_syscontroller_process_dtbo(sys_serv_priv);
++#endif
++
++	return 0;
++}
++
++int ft_board_setup(void *blob, struct bd_info *bd)
++{
++#if IS_ENABLED(CONFIG_MPFS_SYSCONTROLLER)
++	u32 ret;
++	int node;
++
++	node = fdt_path_offset(blob, "/soc/ethernet@20110000");
++	if (node >= 0) {
++		ret = fdt_setprop(blob, node, "local-mac-address", mac_addr, 6);
++		if (ret) {
++			printf("Error setting local-mac-address property for ethernet@20110000\n");
++			return -ENODEV;
++		}
++	}
++#endif
++
++	return 0;
++}
+\ No newline at end of file
+diff --git a/configs/beaglev_fire_defconfig b/configs/beaglev_fire_defconfig
+new file mode 100644
+index 00000000000..8cb86168f2d
+--- /dev/null
++++ b/configs/beaglev_fire_defconfig
+@@ -0,0 +1,29 @@
++CONFIG_RISCV=y
++CONFIG_SYS_MALLOC_LEN=0x800000
++CONFIG_SYS_MALLOC_F_LEN=0x2000
++CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
++CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
++CONFIG_ENV_SIZE=0x2000
++CONFIG_DM_GPIO=y
++CONFIG_DEFAULT_DEVICE_TREE="microchip/mpfs-beaglev-fire"
++CONFIG_OF_LIBFDT_OVERLAY=y
++CONFIG_SYS_BOOTM_LEN=0x4000000
++CONFIG_SYS_LOAD_ADDR=0x80200000
++CONFIG_TARGET_BEAGLEBOARD_BEAGLEVFIRE=y
++CONFIG_ARCH_RV64I=y
++CONFIG_RISCV_SMODE=y
++CONFIG_FIT=y
++CONFIG_DISTRO_DEFAULTS=y
++CONFIG_OF_BOARD_SETUP=y
++CONFIG_DEFAULT_FDT_FILE="microchip/mchp-beaglev-fire.dtb"
++CONFIG_SYS_CBSIZE=256
++CONFIG_SYS_PBSIZE=282
++CONFIG_DISPLAY_CPUINFO=y
++CONFIG_DISPLAY_BOARDINFO=y
++CONFIG_SYS_PROMPT="RISC-V # "
++CONFIG_CMD_GPIO=y
++CONFIG_OF_UPSTREAM=y
++CONFIG_BOOTP_SEND_HOSTNAME=y
++CONFIG_MPFS_GPIO=y
++CONFIG_MMC_SPI=y
++CONFIG_SYSRESET=y
+diff --git a/include/configs/beaglev_fire.h b/include/configs/beaglev_fire.h
+new file mode 100644
+index 00000000000..e3ee0f02f2d
+--- /dev/null
++++ b/include/configs/beaglev_fire.h
+@@ -0,0 +1,57 @@
++/* SPDX-License-Identifier: GPL-2.0+ */
++/*
++ * Copyright (C) 2023 Microchip Technology Inc.
++ */
++
++#ifndef __CONFIG_H
++#define __CONFIG_H
++
++#include <linux/sizes.h>
++
++#define CFG_SYS_SDRAM_BASE       0x80000000
++
++/* Environment options */
++
++#if defined(CONFIG_CMD_DHCP)
++#define BOOT_TARGET_DEVICES_DHCP(func)	func(DHCP, dhcp, na)
++#else
++#define BOOT_TARGET_DEVICES_DHCP(func)
++#endif
++
++#if defined(CONFIG_CMD_MMC)
++#define BOOT_TARGET_DEVICES_MMC(func)	func(MMC, mmc, 0)
++#else
++#define BOOT_TARGET_DEVICES_MMC(func)
++#endif
++
++#define BOOT_TARGET_DEVICES(func) \
++	BOOT_TARGET_DEVICES_MMC(func)\
++	BOOT_TARGET_DEVICES_DHCP(func)
++
++#define BOOTENV_DESIGN_OVERLAYS \
++	"design_overlays=" \
++	"if test -n ${no_of_overlays}; then " \
++		"setenv inc 1; " \
++		"setenv idx 0; " \
++		"fdt resize ${dtbo_size}; " \
++		"while test $idx -ne ${no_of_overlays}; do " \
++			"setenv dtbo_name dtbo_image${idx}; " \
++			"setenv fdt_cmd \"fdt apply $\"$dtbo_name; " \
++			"run fdt_cmd; " \
++			"setexpr idx $inc + $idx; " \
++		"done; " \
++	"fi;\0 " \
++
++#include <config_distro_bootcmd.h>
++
++#define CFG_EXTRA_ENV_SETTINGS \
++	"bootm_size=0x10000000\0" \
++	"kernel_addr_r=0x80200000\0" \
++	"fdt_addr_r=0x8a000000\0" \
++	"fdtoverlay_addr_r=0x8a080000\0" \
++	"ramdisk_addr_r=0x8aa00000\0" \
++	"scriptaddr=0x8e000000\0" \
++	BOOTENV_DESIGN_OVERLAYS \
++	BOOTENV \
++
++#endif /* __CONFIG_H */
+-- 
+2.51.0
+
diff --git a/recipes-bsp/u-boot/files/beaglev-fire-config.yaml b/recipes-bsp/u-boot/files/beaglev-fire-config.yaml
new file mode 100644
index 00000000..c0806c1f
--- /dev/null
+++ b/recipes-bsp/u-boot/files/beaglev-fire-config.yaml
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+set-name: 'PolarFire-SoC-HSS::U-Boot'
+
+hart-entry-points: {u54_1: '0x80200000', u54_2: '0x80200000', u54_3: '0x80200000', u54_4: '0x80200000'}
+
+payloads:
+  u-boot.bin: {exec-addr: '0x80200000', owner-hart: u54_1, secondary-hart: u54_2, secondary-hart: u54_3, secondary-hart: u54_4, priv-mode: prv_s}
diff --git a/recipes-bsp/u-boot/u-boot-beaglev-fire_2026.01.bb b/recipes-bsp/u-boot/u-boot-beaglev-fire_2026.01.bb
new file mode 100644
index 00000000..6249fa1a
--- /dev/null
+++ b/recipes-bsp/u-boot/u-boot-beaglev-fire_2026.01.bb
@@ -0,0 +1,23 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens, 2026
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require u-boot-common-${PV}.inc
+
+COMPATIBLE_MACHINE = "^(beaglev-fire)$"
+
+SRC_URI += "file://beaglev-fire-config.yaml;subdir=debian"
+
+DEPENDS += "hss-payload-generator-native"
+DEBIAN_BUILD_DEPENDS += ", hss-payload-generator:native"
+
+U_BOOT_CONFIG = "beaglev_fire_defconfig"
+U_BOOT_BIN = "u-boot.bin"
+U_BOOT_EXTRA_BUILDCMD = "hss-payload-generator -c debian/beaglev-fire-config.yaml payload.bin"
diff --git a/recipes-bsp/u-boot/u-boot-common-2026.01.inc b/recipes-bsp/u-boot/u-boot-common-2026.01.inc
index 7b911660..9d12dd92 100644
--- a/recipes-bsp/u-boot/u-boot-common-2026.01.inc
+++ b/recipes-bsp/u-boot/u-boot-common-2026.01.inc
@@ -21,6 +21,9 @@ SRC_URI += " \
     file://0004-arch-arm-mach-socfpga-Adjust-a-raw-sectors-for-MMC-l.patch \
     file://0005-configs-socfpga-Fix-de0_nano_soc-boot.patch \
     file://0006-configs-socfpga-Permit-EFI-booting.patch \
+    file://0001-riscv-create-a-custom-CPU-implementation-for-PolarFi.patch \
+    file://0002-riscv-mpfs-move-SoC-level-options-to-the-CPU-Kconfig.patch \
+    file://0003-riscv-Add-support-for-BeagleV-Fire.patch \
     file://rules.tmpl;subdir=debian"
 SRC_URI[sha256sum] = "b60d5865cefdbc75da8da4156c56c458e00de75a49b80c1a2e58a96e30ad0d54"
 
-- 
2.51.0


