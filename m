Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FB4CCFA1E
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 07:12:53 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7683.1762931570892960934
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Nov 2025 23:12:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=VIFv1ssQ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-20251112071247b9e14df9e000020753-2wlazm@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20251112071247b9e14df9e000020753
        for <cip-dev@lists.cip-project.org>;
        Wed, 12 Nov 2025 08:12:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=r2ymVCmOPKCcwOKk1edp1Fk8X6WMs8IGvJRQSOoHBaw=;
 b=VIFv1ssQSVTirc+BYFS8rcOTNZpjwGIIvsAb8tc8XzNjgf4n/6lcc/HfUkVncaxVIaHsQm
 nCgUaX7V0nedsYejLi49Q/5ZSSsLi5zypIe+cxJYjoy7Q8mKl1aPMPDLbX9ocAnGOFw8hSSp
 buf/rLMPPCZgVofBmw0b9LOT1EAmLeOm5j4xyhpSMyTc1A35FaelRJGkkwizJLbMnfdhVYOE
 FM8FHVjieehS6Yrks4FX22A2PJwV3J0hE3OOVgu6FjFn+GThUy3nTWjo1IyZvwX4z6MTxTlq
 8iL756oE5yegmEEk3iVIZ+OKCGy+teECGLcpnMQp4SoFL3zY/IOva81w==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 5/5] opensbi-qemu-riscv64: Use the new class
Date: Wed, 12 Nov 2025 08:12:46 +0100
Message-ID: <e5efd01fc6c8ba03ff780b93c1db291dac72d7ea.1762931566.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1762931566.git.jan.kiszka@siemens.com>
References: <cover.1762931566.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Nov 2025 07:12:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20506

From: Jan Kiszka <jan.kiszka@siemens.com>

This simplifies our own recipe for qemu.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/opensbi/files/qemu-riscv64-rules  | 12 ------------
 .../opensbi/opensbi-qemu-riscv64_1.7.bb       |  7 ++-----
 recipes-bsp/opensbi/opensbi.inc               | 19 -------------------
 recipes-bsp/opensbi/opensbi_1.7.inc           | 11 +++++++++++
 4 files changed, 13 insertions(+), 36 deletions(-)
 delete mode 100644 recipes-bsp/opensbi/files/qemu-riscv64-rules
 delete mode 100644 recipes-bsp/opensbi/opensbi.inc
 create mode 100644 recipes-bsp/opensbi/opensbi_1.7.inc

diff --git a/recipes-bsp/opensbi/files/qemu-riscv64-rules b/recipes-bsp/opensbi/files/qemu-riscv64-rules
deleted file mode 100644
index 960e10cb..00000000
--- a/recipes-bsp/opensbi/files/qemu-riscv64-rules
+++ /dev/null
@@ -1,12 +0,0 @@
-#!/usr/bin/make -f
-
-ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
-export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
-endif
-
-override_dh_auto_build:
-	CFLAGS= LDFLAGS= $(MAKE) $(PARALLEL_MAKE) PLATFORM=generic \
-		FW_PAYLOAD_PATH=/usr/lib/u-boot/qemu-riscv64/u-boot.bin
-
-%:
-	dh $@
diff --git a/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb b/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb
index 7623f132..6e3f2497 100644
--- a/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb
+++ b/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb
@@ -3,18 +3,15 @@
 #
 # SPDX-License-Identifier: MIT
 
-include opensbi.inc
+include opensbi_${PV}.inc
 
 inherit deploy-firmware
 
-SRC_URI += "file://qemu-riscv64-rules"
-
-SRC_URI[opensbi.sha256sum] = "2cf856a4e5e2e052948ddb54ba48232b1f698b7f52e0374fc7d17d51e8c8f7ce"
-
 DEPENDS += "u-boot-qemu-riscv64"
 DEBIAN_BUILD_DEPENDS .= ", u-boot-qemu-riscv64"
 
 OPENSBI_BIN = "fw_payload.bin"
+OPENSBI_EXTRA_BUILDARGS = "FW_PAYLOAD_PATH=/usr/lib/u-boot/qemu-riscv64/u-boot.bin"
 
 do_deploy_firmware() {
     dpkg --fsys-tarfile "${WORKDIR}/${PN}_${PV}_${DISTRO_ARCH}.deb" | \
diff --git a/recipes-bsp/opensbi/opensbi.inc b/recipes-bsp/opensbi/opensbi.inc
deleted file mode 100644
index 1f15312b..00000000
--- a/recipes-bsp/opensbi/opensbi.inc
+++ /dev/null
@@ -1,19 +0,0 @@
-#
-# Copyright (c) Siemens AG, 2023-2025
-#
-# SPDX-License-Identifier: MIT
-
-inherit dpkg
-
-SRC_URI = " \
-    https://github.com/riscv/opensbi/archive/v${PV}.tar.gz;downloadfilename=opensbi-${PV}.tar.gz;name=opensbi"
-
-S = "${WORKDIR}/opensbi-${PV}"
-
-do_prepare_build[cleandirs] += "${S}/debian"
-do_prepare_build() {
-    cp ${WORKDIR}/${MACHINE}-rules ${WORKDIR}/rules
-    deb_debianize
-
-    echo "build/platform/generic/firmware/${OPENSBI_BIN} /usr/lib/opensbi/${MACHINE}/" > ${S}/debian/install
-}
diff --git a/recipes-bsp/opensbi/opensbi_1.7.inc b/recipes-bsp/opensbi/opensbi_1.7.inc
new file mode 100644
index 00000000..c83935be
--- /dev/null
+++ b/recipes-bsp/opensbi/opensbi_1.7.inc
@@ -0,0 +1,11 @@
+#
+# Copyright (c) Siemens AG, 2023-2025
+#
+# SPDX-License-Identifier: MIT
+
+inherit opensbi
+
+SRC_URI += "https://github.com/riscv/opensbi/archive/v${PV}.tar.gz;downloadfilename=opensbi-${PV}.tar.gz;name=opensbi"
+SRC_URI[opensbi.sha256sum] = "2cf856a4e5e2e052948ddb54ba48232b1f698b7f52e0374fc7d17d51e8c8f7ce"
+
+S = "${WORKDIR}/opensbi-${PV}"
-- 
2.51.0


