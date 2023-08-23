Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A850EEE49A5
	for <webhook@archiver.kernel.org>; Wed, 23 Aug 2023 02:17:43 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.3065.1692757055811412006
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Aug 2023 19:17:36 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 37N2HY4i4060212; Wed, 23 Aug 2023 11:17:34 +0900
X-Iguazu-Qid: 2rWhi9UHdKc48BaVGM
X-Iguazu-QSIG: v=2; s=0; t=1692757053; q=2rWhi9UHdKc48BaVGM; m=DiTKyIqYkuibfBRMjPyhZ9G2wnEqTkQ7LWlbJZB2uQc=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 37N2HWib1972501
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 23 Aug 2023 11:17:33 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Masato Minda <minmin@plathome.co.jp>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [isar-cip-core][PATCH] Add support Plat'Home OpenBlocks IoT VX2
Date: Wed, 23 Aug 2023 11:17:13 +0900
X-TSB-HOP2: ON
Message-Id: <20230823021713.87089-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Aug 2023 02:17:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12832

From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

This adds configuration files to support Plat'Home OpenBlocks IoT VX2.

CC: Masato Minda <minmin@plathome.co.jp>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 Kconfig                              |  4 ++++
 conf/machine/openblocks-iot-vx2.conf | 15 +++++++++++++++
 kas/board/openblocks-iot-vx2.yml     | 15 +++++++++++++++
 wic/openblocks-iot-vx2.wks           | 15 +++++++++++++++
 4 files changed, 49 insertions(+)
 create mode 100644 conf/machine/openblocks-iot-vx2.conf
 create mode 100644 kas/board/openblocks-iot-vx2.yml
 create mode 100644 wic/openblocks-iot-vx2.wks

diff --git a/Kconfig b/Kconfig
index ec49631..778acf6 100644
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
index 0000000..a9bf65d
--- /dev/null
+++ b/conf/machine/openblocks-iot-vx2.conf
@@ -0,0 +1,15 @@
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
diff --git a/wic/openblocks-iot-vx2.wks b/wic/openblocks-iot-vx2.wks
new file mode 100644
index 0000000..3050684
--- /dev/null
+++ b/wic/openblocks-iot-vx2.wks
@@ -0,0 +1,15 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2019
+#
+# SPDX-License-Identifier: MIT
+#
+# Based wic/simatic-ipc227e.wks
+#
+
+part /boot --source bootimg-efi-isar --sourceparams "loader=grub-efi" --label efi --part-type EF00 --align 1024
+
+part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --use-uuid
+
+bootloader --ptable gpt --timeout 2 --append "console=ttyS0,115200"
-- 
2.40.1



