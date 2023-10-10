Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DFECD6901
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 08:11:26 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.85917.1696925476074595806
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Oct 2023 01:11:17 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 39A8BDNv2468029; Tue, 10 Oct 2023 17:11:14 +0900
X-Iguazu-Qid: 2rWhPRBjcSWLt8kjrB
X-Iguazu-QSIG: v=2; s=0; t=1696925473; q=2rWhPRBjcSWLt8kjrB; m=G7iHDieXMRiU2Oi7rNGosWLDBQozVHvsQxC7SrsJVZY=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 39A8BBtl1978960
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 10 Oct 2023 17:11:12 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org, minmin@plathome.co.jp,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [isar-cip-core][PATCH v2] Add support Plat'Home OpenBlocks IoT VX2
Date: Tue, 10 Oct 2023 17:10:34 +0900
X-TSB-HOP2: ON
Message-Id: <20231010081034.3762306-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 08:11:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13344

This adds configuration files to support Plat'Home OpenBlocks IoT VX2.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---

Note: This commit depends 'https://lore.kernel.org/cip-dev/20231010080305.3762206-1-nobuhiro1.iwamatsu@toshiba.co.jp/T/#u'
v2: Drop patch for wic/openblocks-iot-vx2.wks and use x86_64-generic.wks with WKS_FILE.

---

 Kconfig                              |  4 ++++
 conf/machine/openblocks-iot-vx2.conf | 16 ++++++++++++++++
 kas/board/openblocks-iot-vx2.yml     | 15 +++++++++++++++
 3 files changed, 35 insertions(+)
 create mode 100644 conf/machine/openblocks-iot-vx2.conf
 create mode 100644 kas/board/openblocks-iot-vx2.yml

diff --git a/Kconfig b/Kconfig
index f5ea5af..be8bbc2 100644
--- a/Kconfig
+++ b/Kconfig
@@ -67,6 +67,9 @@ config TARGET_QEMU_RISCV64
 	bool "QEMU RISC-V 64-bit (riscv64)"
 	select ARCH_RISCV64
 
+config TARGET_OBS_IOT_VX2
+	bool "Plat'Home OpenBlocks IoT VX2"
+	select ARCH_AMD64
 endchoice
 
 config KAS_INCLUDE_BOARD
@@ -79,6 +82,7 @@ config KAS_INCLUDE_BOARD
 	default "kas/board/bbb.yml" if TARGET_BBB
 	default "kas/board/iwg20m.yml" if TARGET_IWG20D
 	default "kas/board/qemu-riscv64.yml" if TARGET_QEMU_RISCV64
+	default "kas/board/openblocks-iot-vx2.yml" if TARGET_OBS_IOT_VX2
 
 comment "Kernel options"
 
diff --git a/conf/machine/openblocks-iot-vx2.conf b/conf/machine/openblocks-iot-vx2.conf
new file mode 100644
index 0000000..5c144a3
--- /dev/null
+++ b/conf/machine/openblocks-iot-vx2.conf
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2019
+# Copyright (c) TOSHIBA CORPORATION, 2023
+#
+# SPDX-License-Identifier: MIT
+#
+
+DISTRO_ARCH = "amd64"
+
+IMAGE_FSTYPES ?= "wic"
+WKS_FILE ?= "x86_64-generic.wks"
+IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
+USE_CIP_KERNEL_CONFIG = "1"
+KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/plathome_obsvx2_defconfig"
diff --git a/kas/board/openblocks-iot-vx2.yml b/kas/board/openblocks-iot-vx2.yml
new file mode 100644
index 0000000..6951e2e
--- /dev/null
+++ b/kas/board/openblocks-iot-vx2.yml
@@ -0,0 +1,15 @@
+#
+# CIP Core, generic profile
+#
+# TOSHIBA CORPORATION, 2023
+#
+# Authors:
+#  Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 12
+
+machine: openblocks-iot-vx2
-- 
2.42.0



