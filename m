Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D45C7EE2F
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 13:12:46 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.21958.1677847741683661534
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Mar 2023 04:49:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=R9AQdyqI;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-72506-2023030312485927e96525a4b1a0ed9b-_ro0g6@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2023030312485927e96525a4b1a0ed9b
        for <cip-dev@lists.cip-project.org>;
        Fri, 03 Mar 2023 13:48:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=VVksCwvfPLheyA0PIpxsfpZnAUflFC6T/SjV3H+ijw0=;
 b=R9AQdyqI74M6AoorMKctnZ/MMecVUXjd/rkDjM6zyj1FeMzQfACSmdVl/foM2zdryA6xgM
 bexxSOyjTVeKcvW1iB1m0poGfAJ3pNRP20zfvwpMe9kcl+VUuhW8L7kRVXaLb7h7hkNiqAQN
 IsOd0R93/yqCy/0j78njP9fgrMZ4c=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v4 4/8] add opensbi with u-boot payload for riscv64
Date: Fri,  3 Mar 2023 12:48:16 +0000
Message-Id: <20230303124820.2209954-5-felix.moessbauer@siemens.com>
In-Reply-To: <20230303124820.2209954-1-felix.moessbauer@siemens.com>
References: <20230303124820.2209954-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 13:12:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10909

This patch adds the opensbi firmware with u-boot payload (smode) for the
qemu-riscv64 machine. Using that, the generated riscv64 images can be
booted on qemu.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 recipes-bsp/opensbi/files/qemu-riscv64-rules  | 12 ++++
 .../opensbi/opensbi-qemu-riscv64_1.2.bb       |  8 +++
 recipes-bsp/opensbi/opensbi.inc               | 45 +++++++++++++++
 ...iscv-Fix-build-against-binutils-2.38.patch | 55 +++++++++++++++++++
 .../u-boot/u-boot-qemu-riscv64_2022.07.bb     | 22 ++++++++
 5 files changed, 142 insertions(+)
 create mode 100644 recipes-bsp/opensbi/files/qemu-riscv64-rules
 create mode 100644 recipes-bsp/opensbi/opensbi-qemu-riscv64_1.2.bb
 create mode 100644 recipes-bsp/opensbi/opensbi.inc
 create mode 100644 recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch
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
diff --git a/recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb b/recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb
new file mode 100644
index 0000000..8dfac45
--- /dev/null
+++ b/recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb
@@ -0,0 +1,22 @@
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
+    file://riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch"
+
+U_BOOT_BIN = "u-boot.bin"
-- 
2.34.1


