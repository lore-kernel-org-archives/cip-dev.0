Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132EFCCF9F3
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 07:22:02 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.26592.1761549712709964129
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Oct 2025 00:21:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=fxkV+Vzq;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-2025102707215069a0f77a1c000207ba-glgsnc@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025102707215069a0f77a1c000207ba
        for <cip-dev@lists.cip-project.org>;
        Mon, 27 Oct 2025 08:21:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=yN46aGPLF8HoK3C9gAeQZotgwDIp3oSG+AgN0tuB4pQ=;
 b=fxkV+VzqMQZonhDUgB5WUpS5CszrDY6xAudQ6ObZiexhqBZsxlA0TWzCTYw1fE3uXnSPl4
 QeFAcL5knt6dJRbSJPi+q9Kk0vFB8APJxIkn3uH5G1qD7YIWaS+540YxZ044JzA3C+G+WQak
 hVijbFpNytE15L8xkcp7zuT9Uia0dGdD0ktp+3+IqCc/Vy5qcrw2En+dUYyJZQZFExkAmdFQ
 zr0MYSVmhhh9y1lhQWD+/PSDyfxwshJJ6fWP7UjumukaKZnjq1bFhyO2O8BdoOnMD9f5sMz4
 ZdmcqxH/OTfuEyX5T01DAR3yoXQa1/nIOBqq7wDfeQB1iu9/nVGMpNkA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 12/19] Add class to generate eMMC image for QEMU
Date: Mon, 27 Oct 2025 08:21:41 +0100
Message-ID: <08f8a09bd85b9b151784e387cc5a4572dfbacbe0.1761549708.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20236

From: Jan Kiszka <jan.kiszka@siemens.com>

To add an RPMB partition to eMMC image for QEMU, we need a simple image
class. It will prepend a zero'ed partition to the user data area or 2 MB
by default.

First user of this image type is the qemu-arm64 target in fTPM/StMM
mode.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/qemu-emmc.bbclass    | 43 ++++++++++++++++++++++++++++++++++++
 conf/layer.conf              |  5 ++---
 conf/machine/qemu-arm64.conf |  4 +++-
 3 files changed, 48 insertions(+), 4 deletions(-)
 create mode 100644 classes/qemu-emmc.bbclass

diff --git a/classes/qemu-emmc.bbclass b/classes/qemu-emmc.bbclass
new file mode 100644
index 00000000..bded834d
--- /dev/null
+++ b/classes/qemu-emmc.bbclass
@@ -0,0 +1,43 @@
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
+IMAGE_TYPEDEP:qemu_emmc = "wic"
+
+SOURCE_IMAGE_FILE ?= "${IMAGE_FULLNAME}.wic"
+SOURCE_IMAGE_PATH = "${DEPLOY_DIR_IMAGE}/${SOURCE_IMAGE_FILE}"
+
+QEMU_EMMC_RPMB_PART_SIZE ?= "2097152"
+
+python set_data_part_size() {
+    import os
+
+    size = os.stat(d.getVar('SOURCE_IMAGE_PATH')).st_size
+    if size > 2 * 1024 * 1024 * 1024:
+        size = (size + 511) & ~511
+    elif size & (size - 1) > 0:
+        n = 0
+        while size > 0:
+            size >>= 1
+            n = n + 1
+        size = 1 << n
+    size += int(d.getVar('QEMU_EMMC_RPMB_PART_SIZE'))
+    d.setVar('QEMU_EMMC_IMAGE_SIZE', str(size))
+}
+
+do_image_qemu_emmc[prefuncs] = "set_data_part_size"
+IMAGE_CMD:qemu_emmc() {
+    dd if=/dev/zero of="${IMAGE_FILE_HOST}" status=none bs=128K \
+        count=${@int(d.getVar('QEMU_EMMC_RPMB_PART_SIZE')) // (128*1024)}
+    cat "${SOURCE_IMAGE_PATH}" >> "${IMAGE_FILE_HOST}"
+
+    image_size=$(stat -L -c %s "${SOURCE_IMAGE_PATH}")
+    truncate "${IMAGE_FILE_HOST}" -s ${QEMU_EMMC_IMAGE_SIZE}
+}
diff --git a/conf/layer.conf b/conf/layer.conf
index 316f4a81..c51c3af1 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -23,5 +23,4 @@ LAYERSERIES_COMPAT_cip-core = "next"
 LAYERDIR_cip-core = "${LAYERDIR}"
 LAYERDIR_cip-core[vardepvalue] = "isar-cip-core"
 
-IMAGE_CLASSES += "squashfs erofs verity swupdate delta-update"
-
+IMAGE_CLASSES += "squashfs erofs verity swupdate delta-update qemu-emmc"
diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
index cdb94d51..0745938b 100644
--- a/conf/machine/qemu-arm64.conf
+++ b/conf/machine/qemu-arm64.conf
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2025
 #
 # SPDX-License-Identifier: MIT
 #
@@ -9,6 +9,8 @@
 DISTRO_ARCH = "arm64"
 
 IMAGE_FSTYPES ?= "ext4"
+IMAGE_FSTYPES:append:ftpm-stmm = " qemu-emmc"
+
 USE_CIP_KERNEL_CONFIG = "1"
 KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/cip_merged_defconfig"
 
-- 
2.51.0


