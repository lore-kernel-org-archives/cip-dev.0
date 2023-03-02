Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7E3C7EE2F
	for <webhook@archiver.kernel.org>; Thu,  2 Mar 2023 15:31:10 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.18904.1677770861139122093
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Mar 2023 07:27:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=k6LXxsoO;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-72506-20230302152744790d7dbd0ce9793029-1wywn2@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230302152744790d7dbd0ce9793029
        for <cip-dev@lists.cip-project.org>;
        Thu, 02 Mar 2023 16:27:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=gYPWaRxASQmcxny66E9thj+4ib+loS6je9VTXZzzopg=;
 b=k6LXxsoO8iE6nv/3PBFwuiaxe6QR6m7gyASNOwCCndHL5hjVpPuYn7uKHIAj0+3YlNnPfH
 QQanj1ChSmjQ+yGWlCiZ1Nu391q27x2PzsE5zVrRhaiOZLI5GPIWt7qAvYA0M5CN7vEcJ9oB
 uovadMaKtRI8dWDm00Zi3p/87/ZbA=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v3 5/9] add opensbi with u-boot payload for riscv64
Date: Thu,  2 Mar 2023 15:26:55 +0000
Message-Id: <20230302152659.2096307-6-felix.moessbauer@siemens.com>
In-Reply-To: <20230302152659.2096307-1-felix.moessbauer@siemens.com>
References: <20230302152659.2096307-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Mar 2023 15:31:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10880

This patch adds the opensbi firmware with u-boot payload (smode) for the
qemu-riscv64 machine. Using that, the generated riscv64 images can be
booted on qemu.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 recipes-bsp/opensbi/files/qemu-riscv64-rules  | 12 +++
 .../opensbi/opensbi-qemu-riscv64_1.2.bb       |  8 ++
 recipes-bsp/opensbi/opensbi.inc               | 45 ++++++++++
 ...iscv-Fix-build-against-binutils-2.38.patch | 55 ++++++++++++
 ...upport-building-double-float-modules.patch | 89 +++++++++++++++++++
 .../u-boot/u-boot-qemu-riscv64_2022.07.bb     | 23 +++++
 6 files changed, 232 insertions(+)
 create mode 100644 recipes-bsp/opensbi/files/qemu-riscv64-rules
 create mode 100644 recipes-bsp/opensbi/opensbi-qemu-riscv64_1.2.bb
 create mode 100644 recipes-bsp/opensbi/opensbi.inc
 create mode 100644 recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch
 create mode 100644 recipes-bsp/u-boot/files/riscv64/0002-riscv-support-building-double-float-modules.patch
 create mode 100644 recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb

diff --git a/recipes-bsp/opensbi/files/qemu-riscv64-rules b/recipes-bsp/opensbi/files/qemu-riscv64-rules
new file mode 100644
index 0000000..960e10c
--- /dev/null
+++ b/recipes-bsp/opensbi/files/qemu-riscv64-rules
@@ -0,0 +1,12 @@
+#!/usr/bin/make -f
+
+ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
+export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
+endif
+
+override_dh_auto_build:
+	CFLAGS= LDFLAGS= $(MAKE) $(PARALLEL_MAKE) PLATFORM=generic \
+		FW_PAYLOAD_PATH=/usr/lib/u-boot/qemu-riscv64/u-boot.bin
+
+%:
+	dh $@
diff --git a/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.2.bb b/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.2.bb
new file mode 100644
index 0000000..b503afc
--- /dev/null
+++ b/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.2.bb
@@ -0,0 +1,8 @@
+#
+# Copyright (c) Siemens AG, 2023
+#
+# SPDX-License-Identifier: MIT
+
+include opensbi.inc
+
+SRC_URI[opensbi.sha256sum] = "8fcbce598a73acc2c7f7d5607d46b9d5107d3ecbede8f68f42631dcfc25ef2b2"
diff --git a/recipes-bsp/opensbi/opensbi.inc b/recipes-bsp/opensbi/opensbi.inc
new file mode 100644
index 0000000..b41a8bb
--- /dev/null
+++ b/recipes-bsp/opensbi/opensbi.inc
@@ -0,0 +1,45 @@
+#
+# Copyright (c) Siemens AG, 2023
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg
+
+U_BOOT_PACKAGE ?= "u-boot-${MACHINE}"
+PLATFORM ?= "generic"
+
+DEPLOYDIR_FIRMWARE = "${WORKDIR}/deploy-fw"
+SSTATETASKS += "do_deploy"
+
+SRC_URI = " \
+    https://github.com/riscv/opensbi/archive/v${PV}.tar.gz;downloadfilename=opensbi-${PV}.tar.gz;name=opensbi \
+    file://${MACHINE}-rules"
+
+S = "${WORKDIR}/opensbi-${PV}"
+
+DEPENDS += "${U_BOOT_PACKAGE}"
+DEBIAN_BUILD_DEPENDS .= ",${U_BOOT_PACKAGE}"
+
+do_prepare_build[cleandirs] += "${S}/debian"
+do_prepare_build() {
+    cp ${WORKDIR}/${MACHINE}-rules ${WORKDIR}/rules
+    deb_debianize
+
+    echo "build/platform/${PLATFORM}/firmware/fw_payload.bin /usr/lib/opensbi/${MACHINE}/" > ${S}/debian/install
+}
+
+do_deploy[cleandirs] += "${DEPLOYDIR_FIRMWARE}"
+do_deploy[sstate-inputdirs] = "${DEPLOYDIR_FIRMWARE}"
+do_deploy[sstate-outputdirs] = "${DEPLOY_DIR_IMAGE}"
+do_deploy() {
+    dpkg --fsys-tarfile "${WORKDIR}/${PN}_${PV}_${DISTRO_ARCH}.deb" | \
+        tar xOf - "./usr/lib/opensbi/${MACHINE}/fw_payload.bin" \
+        > "${DEPLOYDIR_FIRMWARE}/fw_payload.bin"
+}
+
+python do_deploy_setscene () {
+    sstate_setscene(d)
+}
+addtask do_deploy_setscene
+
+addtask deploy after do_dpkg_build before do_deploy_deb
diff --git a/recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch b/recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch
new file mode 100644
index 0000000..6f8a2ae
--- /dev/null
+++ b/recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch
@@ -0,0 +1,55 @@
+From 5df4b2299f86933fa79aa3bc6a3986fc7e55b7e0 Mon Sep 17 00:00:00 2001
+From: Alexandre Ghiti <alexandre.ghiti@canonical.com>
+Date: Mon, 3 Oct 2022 18:07:54 +0200
+Subject: [PATCH 1/2] riscv: Fix build against binutils 2.38
+
+The following description is copied from the equivalent patch for the
+Linux Kernel proposed by Aurelien Jarno:
+
+>From version 2.38, binutils default to ISA spec version 20191213. This
+means that the csr read/write (csrr*/csrw*) instructions and fence.i
+instruction has separated from the `I` extension, become two standalone
+extensions: Zicsr and Zifencei. As the kernel uses those instruction,
+this causes the following build failure:
+
+arch/riscv/cpu/mtrap.S: Assembler messages:
+arch/riscv/cpu/mtrap.S:65: Error: unrecognized opcode `csrr a0,scause'
+arch/riscv/cpu/mtrap.S:66: Error: unrecognized opcode `csrr a1,sepc'
+arch/riscv/cpu/mtrap.S:67: Error: unrecognized opcode `csrr a2,stval'
+arch/riscv/cpu/mtrap.S:70: Error: unrecognized opcode `csrw sepc,a0'
+
+Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
+Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
+Tested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
+Tested-by: Heiko Stuebner <heiko@sntech.de>
+Tested-by: Christian Stewart <christian@paral.in>
+Reviewed-by: Rick Chen <rick@andestech.com>
+---
+ arch/riscv/Makefile | 11 ++++++++++-
+ 1 file changed, 10 insertions(+), 1 deletion(-)
+
+diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
+index 0b80eb8d86..53d1194ffb 100644
+--- a/arch/riscv/Makefile
++++ b/arch/riscv/Makefile
+@@ -24,7 +24,16 @@ ifeq ($(CONFIG_CMODEL_MEDANY),y)
+ 	CMODEL = medany
+ endif
+ 
+-ARCH_FLAGS = -march=$(ARCH_BASE)$(ARCH_A)$(ARCH_C) -mabi=$(ABI) \
++RISCV_MARCH = $(ARCH_BASE)$(ARCH_A)$(ARCH_C)
++
++# Newer binutils versions default to ISA spec version 20191213 which moves some
++# instructions from the I extension to the Zicsr and Zifencei extensions.
++toolchain-need-zicsr-zifencei := $(call cc-option-yn, -mabi=$(ABI) -march=$(RISCV_MARCH)_zicsr_zifencei)
++ifeq ($(toolchain-need-zicsr-zifencei),y)
++	RISCV_MARCH := $(RISCV_MARCH)_zicsr_zifencei
++endif
++
++ARCH_FLAGS = -march=$(RISCV_MARCH) -mabi=$(ABI) \
+ 	     -mcmodel=$(CMODEL)
+ 
+ PLATFORM_CPPFLAGS	+= $(ARCH_FLAGS)
+-- 
+2.30.2
+
diff --git a/recipes-bsp/u-boot/files/riscv64/0002-riscv-support-building-double-float-modules.patch b/recipes-bsp/u-boot/files/riscv64/0002-riscv-support-building-double-float-modules.patch
new file mode 100644
index 0000000..ec7d7d3
--- /dev/null
+++ b/recipes-bsp/u-boot/files/riscv64/0002-riscv-support-building-double-float-modules.patch
@@ -0,0 +1,89 @@
+From 5aefdcad0950c244d826988a8bd2f90584399849 Mon Sep 17 00:00:00 2001
+From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
+Date: Wed, 12 Oct 2022 14:59:51 +0200
+Subject: [PATCH 2/2] riscv: support building double-float modules
+
+The riscv32 toolchain for GCC-12 provided by kernel.org contains libgcc.a
+compiled for double-float. To link to it we have to adjust how we build
+U-Boot.
+
+As U-Boot actually does not use floating point at all this should not
+make a significant difference for the produced binaries.
+
+Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
+Reviewed-by: Rick Chen <rick@andestech.com>
+Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
+---
+ arch/riscv/Kconfig  | 15 +++++++++++++++
+ arch/riscv/Makefile | 15 ++++++++++++---
+ 2 files changed, 27 insertions(+), 3 deletions(-)
+
+diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
+index 0cf51799fe..25ed0ba1cf 100644
+--- a/arch/riscv/Kconfig
++++ b/arch/riscv/Kconfig
+@@ -161,6 +161,21 @@ config RISCV_ISA_C
+ 	  when building U-Boot, which results in compressed instructions in the
+ 	  U-Boot binary.
+ 
++config RISCV_ISA_F
++	bool "Standard extension for Single-Precision Floating Point"
++	default y
++	help
++	  Adds "F" to the ISA string passed to the compiler.
++
++config RISCV_ISA_D
++	bool "Standard extension for Double-Precision Floating Point"
++	depends on RISCV_ISA_F
++	default y
++	help
++	  Adds "D" to the ISA string passed to the compiler and changes the
++	  riscv32 ABI from ilp32 to ilp32d and the riscv64 ABI from lp64 to
++	  lp64d.
++
+ config RISCV_ISA_A
+ 	def_bool y
+ 
+diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
+index 53d1194ffb..4963b5109b 100644
+--- a/arch/riscv/Makefile
++++ b/arch/riscv/Makefile
+@@ -5,15 +5,22 @@
+ 
+ ifeq ($(CONFIG_ARCH_RV64I),y)
+ 	ARCH_BASE = rv64im
+-	ABI = lp64
++	ABI_BASE = lp64
+ endif
+ ifeq ($(CONFIG_ARCH_RV32I),y)
+ 	ARCH_BASE = rv32im
+-	ABI = ilp32
++	ABI_BASE = ilp32
+ endif
+ ifeq ($(CONFIG_RISCV_ISA_A),y)
+ 	ARCH_A = a
+ endif
++ifeq ($(CONFIG_RISCV_ISA_F),y)
++	ARCH_F = f
++endif
++ifeq ($(CONFIG_RISCV_ISA_D),y)
++	ARCH_D = d
++	ABI_D = d
++endif
+ ifeq ($(CONFIG_RISCV_ISA_C),y)
+ 	ARCH_C = c
+ endif
+@@ -24,7 +31,9 @@ ifeq ($(CONFIG_CMODEL_MEDANY),y)
+ 	CMODEL = medany
+ endif
+ 
+-RISCV_MARCH = $(ARCH_BASE)$(ARCH_A)$(ARCH_C)
++
++RISCV_MARCH = $(ARCH_BASE)$(ARCH_A)$(ARCH_F)$(ARCH_D)$(ARCH_C)
++ABI = $(ABI_BASE)$(ABI_D)
+ 
+ # Newer binutils versions default to ISA spec version 20191213 which moves some
+ # instructions from the I extension to the Zicsr and Zifencei extensions.
+-- 
+2.30.2
+
diff --git a/recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb b/recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb
new file mode 100644
index 0000000..6f101c5
--- /dev/null
+++ b/recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb
@@ -0,0 +1,23 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require u-boot-qemu-common.inc
+
+# we run as OpenSBI payload, hence use smode
+U_BOOT_CONFIG = "${MACHINE}_smode_defconfig"
+
+EFI_ARCH = "riscv64"
+
+SRC_URI += " \
+    file://riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch \
+    file://riscv64/0002-riscv-support-building-double-float-modules.patch"
+
+U_BOOT_BIN = "u-boot.bin"
-- 
2.34.1


