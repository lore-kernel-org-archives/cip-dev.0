Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41991CCF9FA
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 07:22:02 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.26398.1761549712394587388
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Oct 2025 00:21:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=FL3Sn41W;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-294854-20251027072149438772e9c7000207cc-d62w5j@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20251027072149438772e9c7000207cc
        for <cip-dev@lists.cip-project.org>;
        Mon, 27 Oct 2025 08:21:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=z+hssRcz7ptvtbC4Soa4c9QQHcojMFkfQrCEwUTYHgI=;
 b=FL3Sn41WTq7eyxFJBJUjZvLLoGaYxk5zuO3SfI8raXRBQ/hr880hwRhaSLUQxgRDYHvHRq
 06UKKMxpL7Afcoh0wtY2F4Z6VbIOK3oyILnoTi7NUKEu8gSblixyUETMugCXk8J+BhgCo6is
 hhwlt2x7DteIuy3SSPycDOhq0O9kecDA5puHzSF2DOINdADPVKj5yOCB3WlxUjsB90HNDwZ+
 6O91z6HyWMNo/Vt2bMfrIexTsEPyz5T90/FK1lEperEZHXZlQ7HMURhLZJjOefNudWgPjrft
 /9BkdrbdX7JvuDvpjOJBNhlxfmQMNUqzx3gltvh6tiSHGUr4gvvp8Abw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 05/19] qemu-arm64: Add recipe for TF-A
Date: Mon, 27 Oct 2025 08:21:34 +0100
Message-ID: <f7a7041696be5b50eac4cb7f809647317c1894c3.1761549708.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20228

From: Jan Kiszka <jan.kiszka@siemens.com>

Build TF-A with OP-TEE support, starting U-Boot as BL33. This package
will provide the firmware.bin alternative to u-boot.bin when emulating
a full ARM firmware stack.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../trusted-firmware-a-qemu-arm64_2.13.0.bb   | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb

diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb
new file mode 100644
index 00000000..f2ee44ba
--- /dev/null
+++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.13.0.bb
@@ -0,0 +1,40 @@
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
+inherit deploy-firmware
+
+require recipes-bsp/trusted-firmware-a/trusted-firmware-a-custom.inc
+
+SRC_URI += "https://github.com/TrustedFirmware-A/trusted-firmware-a/archive/refs/tags/v${PV}.tar.gz;downloadfilename=trusted-firmware-a-v${PV}.tar.gz"
+SRC_URI[sha256sum] = "28bc15daeeed000ecd30819ecc4851bf9ffc2d33e1d4553a71985c17f47a999e"
+
+S = "${WORKDIR}/trusted-firmware-a-${PV}"
+
+DEPENDS += "u-boot-qemu-arm64 optee-os-qemu-arm64"
+DEBIAN_BUILD_DEPENDS += ", libssl-dev:native, u-boot-qemu-arm64, optee-os-qemu-arm64"
+
+TF_A_NAME = "qemu-arm64"
+TF_A_PLATFORM = "qemu"
+TF_A_EXTRA_BUILDARGS = " \
+    SPD=opteed BL32_RAM_LOCATION=tdram \
+    BL32=/usr/lib/optee-os/qemu-arm64/tee-raw.bin \
+    BL33=/usr/lib/u-boot/qemu-arm64/u-boot.bin \
+    all fip"
+TF_A_BINARIES = "release/bl1.bin release/fip.bin"
+
+do_deploy_firmware() {
+    dpkg --fsys-tarfile "${WORKDIR}/trusted-firmware-a-${TF_A_NAME}_${PV}_${DISTRO_ARCH}.deb" | \
+        tar xOf - "./usr/lib/trusted-firmware-a/${TF_A_NAME}/bl1.bin" \
+        > "${DEPLOYDIR_FIRMWARE}/firmware.bin"
+    dpkg --fsys-tarfile "${WORKDIR}/trusted-firmware-a-${TF_A_NAME}_${PV}_${DISTRO_ARCH}.deb" | \
+        tar xOf - "./usr/lib/trusted-firmware-a/${TF_A_NAME}/fip.bin" | \
+        dd of="${DEPLOYDIR_FIRMWARE}/firmware.bin" seek=64 bs=4096 conv=notrunc
+}
-- 
2.51.0


