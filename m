Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266E5CD13D8
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 07:12:54 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7681.1762931570427118661
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Nov 2025 23:12:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=IuiM6AOQ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-2025111207124788c1216da40002072e-4abszh@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2025111207124788c1216da40002072e
        for <cip-dev@lists.cip-project.org>;
        Wed, 12 Nov 2025 08:12:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=IpqCu2zqiUaLHbsyshnJvYIFM2U6pmHOs67Rn/ISuMo=;
 b=IuiM6AOQoRJUw7UWdRLkAnbj/2Iiq48p7s43NGrVyEvBTbjG4/qGwS+su7nEW4WU2PZj36
 /Aqsoj0Tq59X5u2RHRNsozR+tG1Aqc0FpV0CPn1HHaZLXAt4k5Af22mKBBrqHXNoqCPnvVS4
 Pt9fvzxnxBi2wt7xxp/9VJZYKIoHxumcLWH7P5GPNfMK/WlTwQO10k0j0hdLwcYu14uHa9YQ
 bbSgsSeCAjC0jo3GEbCW3E84OPKHQYePqf2L/Rlt9RMGL4quRUqILNAVUd+dCNSUuUDjfnBJ
 CAdisTnktYxIj9khripPIjR+/Aflq23zEivw3xXM7rZH9o1TtKJg2rHw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 3/5] opensbi: Refactor opensbi.inc
Date: Wed, 12 Nov 2025 08:12:44 +0100
Message-ID: <515110cb96d6f7327332c5793af45de9350bdc5c.1762931566.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1762931566.git.jan.kiszka@siemens.com>
References: <cover.1762931566.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Nov 2025 07:12:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20509

From: Jan Kiszka <jan.kiszka@siemens.com>

The abstraction of opensbi.inc made some incorrect or suboptimal
choices.

First of all, only QEMU will deploy a firmware.bin, other targets will
more likely embed the output into another artifact (u-boot, disk image
etc.).

Then, U-Boot may also be the integrator of the opensbi output.
Therefore, pull all dependencies into the qemu recipe.

Factor out OPENSBI_DEPLOY_BIN to allow packaging different bits of the
build process for other boards.

And finally, PLATFORM will most likely only be set to "generic", so
hard-code this.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb | 13 +++++++++++++
 recipes-bsp/opensbi/opensbi.inc                 | 17 ++---------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb b/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb
index 260d1390..7623f132 100644
--- a/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb
+++ b/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb
@@ -5,6 +5,19 @@
 
 include opensbi.inc
 
+inherit deploy-firmware
+
 SRC_URI += "file://qemu-riscv64-rules"
 
 SRC_URI[opensbi.sha256sum] = "2cf856a4e5e2e052948ddb54ba48232b1f698b7f52e0374fc7d17d51e8c8f7ce"
+
+DEPENDS += "u-boot-qemu-riscv64"
+DEBIAN_BUILD_DEPENDS .= ", u-boot-qemu-riscv64"
+
+OPENSBI_BIN = "fw_payload.bin"
+
+do_deploy_firmware() {
+    dpkg --fsys-tarfile "${WORKDIR}/${PN}_${PV}_${DISTRO_ARCH}.deb" | \
+        tar xOf - "./usr/lib/opensbi/${MACHINE}/${OPENSBI_BIN}" \
+        > "${DEPLOYDIR_FIRMWARE}/${OPENSBI_BIN}"
+}
diff --git a/recipes-bsp/opensbi/opensbi.inc b/recipes-bsp/opensbi/opensbi.inc
index 6d840264..1f15312b 100644
--- a/recipes-bsp/opensbi/opensbi.inc
+++ b/recipes-bsp/opensbi/opensbi.inc
@@ -1,32 +1,19 @@
 #
-# Copyright (c) Siemens AG, 2023
+# Copyright (c) Siemens AG, 2023-2025
 #
 # SPDX-License-Identifier: MIT
 
 inherit dpkg
-inherit deploy-firmware
-
-U_BOOT_PACKAGE ?= "u-boot-${MACHINE}"
-PLATFORM ?= "generic"
 
 SRC_URI = " \
     https://github.com/riscv/opensbi/archive/v${PV}.tar.gz;downloadfilename=opensbi-${PV}.tar.gz;name=opensbi"
 
 S = "${WORKDIR}/opensbi-${PV}"
 
-DEPENDS += "${U_BOOT_PACKAGE}"
-DEBIAN_BUILD_DEPENDS .= ",${U_BOOT_PACKAGE}"
-
 do_prepare_build[cleandirs] += "${S}/debian"
 do_prepare_build() {
     cp ${WORKDIR}/${MACHINE}-rules ${WORKDIR}/rules
     deb_debianize
 
-    echo "build/platform/${PLATFORM}/firmware/fw_payload.bin /usr/lib/opensbi/${MACHINE}/" > ${S}/debian/install
-}
-
-do_deploy_firmware() {
-    dpkg --fsys-tarfile "${WORKDIR}/${PN}_${PV}_${DISTRO_ARCH}.deb" | \
-        tar xOf - "./usr/lib/opensbi/${MACHINE}/fw_payload.bin" \
-        > "${DEPLOYDIR_FIRMWARE}/fw_payload.bin"
+    echo "build/platform/generic/firmware/${OPENSBI_BIN} /usr/lib/opensbi/${MACHINE}/" > ${S}/debian/install
 }
-- 
2.51.0


