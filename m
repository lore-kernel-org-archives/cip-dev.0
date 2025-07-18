Return-Path: <hirotaka.motai@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBE1C83F3B
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 10:10:42 +0000 (UTC)
Received: from smtp.priv.miraclelinux.com (smtp.priv.miraclelinux.com [202.210.215.66])
 by mx.groups.io with SMTP id smtpd.web10.17492.1752833431774601995
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Jul 2025 03:10:32 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: miraclelinux.com, ip: 202.210.215.66, mailfrom: hirotaka.motai@miraclelinux.com)
Received: from 120i.miraclelinux.com (21A0120i.priv.miraclelinux.com [10.2.0.233])
	by smtp.priv.miraclelinux.com (Postfix) with ESMTP id 5F23F1400F8;
	Fri, 18 Jul 2025 19:10:30 +0900 (JST)
From: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
Subject: [cip-dev][isar-cip-core][PATCH 3/5] zynqmp-zcu102: add wic
Date: Fri, 18 Jul 2025 19:09:06 +0900
Message-ID: <20250718100926.3151777-4-hirotaka.motai@miraclelinux.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718100926.3151777-1-hirotaka.motai@miraclelinux.com>
References: <20250718100926.3151777-1-hirotaka.motai@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Jul 2025 10:10:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19559

Signed-off-by: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
---
 conf/machine/zynqmp-zcu102.conf |  4 ++++
 wic/zynqmp-zcu102.wks.in        | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 wic/zynqmp-zcu102.wks.in

diff --git a/conf/machine/zynqmp-zcu102.conf b/conf/machine/zynqmp-zcu102=
.conf
index b1df5f20bb92..374e436ed43d 100644
--- a/conf/machine/zynqmp-zcu102.conf
+++ b/conf/machine/zynqmp-zcu102.conf
@@ -6,8 +6,11 @@
 # SPDX-License-Identifier: MIT
 #
 DISTRO_ARCH =3D "arm64"
=20
+IMAGE_FSTYPES ?=3D "wic"
+WKS_FILE ?=3D "zynqmp-zcu102.wks.in"
+
 # Setting for kernel and boot
 USE_CIP_KERNEL_CONFIG =3D "1"
 KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm6=
4/ctj_zynqmp_defconfig"
 KERNEL_IMAGE=3D"Image"
@@ -17,4 +20,5 @@ DTB_FILES =3D " \
   zynqmp-zcu102-revA.dtb \
   zynqmp-zcu102-revB.dtb \
 "
=20
+IMAGE_BOOT_FILES =3D "${KERNEL_IMAGE} ${DTB_FILES}"
diff --git a/wic/zynqmp-zcu102.wks.in b/wic/zynqmp-zcu102.wks.in
new file mode 100644
index 000000000000..a40d4bc9329c
--- /dev/null
+++ b/wic/zynqmp-zcu102.wks.in
@@ -0,0 +1,22 @@
+#
+# CIP Core
+#
+# Copyright Cybertrust Japan Co., Ltd., 2025
+#
+# Authors:
+#   Hirotaka Motai <hirotaka.motai@miraclelinux.com>
+#
+# SPDX-License-Identifier: MIT
+#
+# short-description: Create SD card image for ZynqMP ZCU102
+# long-description: Creates a partitioned SD card image for Zynq UltraSc=
ale+ MPSoC ZCU102.
+#
+
+# SD card is partitioned as follows,
+#  1st partition: fat32, 448MB, for kernel image and dtb
+#  2nd partition: ext4, for rootfs
+
+part /boot --source bootimg-partition --ondisk mmcblk0 --fstype=3Dvfat -=
-label boot --active --align 1024 --fixed-size 448
+part / --source rootfs --ondisk mmcblk0 --fstype=3Dext4 --label root --a=
lign 1024 --exclude-path=3Dboot --size=3D${ROOTFS_EXTRA}
+
+bootloader --ptable msdos
--=20
2.47.2


