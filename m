Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BD7C433EF
	for <webhook@archiver.kernel.org>; Mon, 13 Dec 2021 08:13:59 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web12.8779.1639383237252853116
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Dec 2021 00:13:57 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 1BD8Dt3h009834
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 13 Dec 2021 09:13:55 +0100
Received: from md2dvrtc.fritz.box ([167.87.0.205])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 1BD8DssG032583;
	Mon, 13 Dec 2021 09:13:54 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2] conf/machine/*: Add variable to
 set version of kernel defconfig
Date: Mon, 13 Dec 2021 09:13:54 +0100
Message-Id: <20211213081354.2500909-1-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Dec 2021 08:13:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7095

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes an issue, that the defconfig from kernel 4.19.X does not
work with kernel 5.10.X. The kernel boots but cannot find any qemu hard
disk.

The fix adds the new Variable
KERNEL_DEFCONFIG_VERSION to select to correct path in [1].

This fixes issue [17].
[1]: https://gitlab.com/cip-project/cip-kernel/cip-kernel-config
[17]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/17

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---

Changes V2:
 - Set KERNEL_DEFCONFIG_VERSION in linux kernel recipes instead of
   machine config
 - change Commit message

 conf/machine/hihope-rzg2m.conf                           | 2 +-
 conf/machine/qemu-amd64.conf                             | 2 +-
 conf/machine/qemu-arm.conf                               | 2 +-
 conf/machine/qemu-arm64.conf                             | 2 +-
 conf/machine/simatic-ipc227e.conf                        | 2 +-
 recipes-kernel/linux/linux-cip-rt_4.19.217-cip62-rt23.bb | 2 ++
 recipes-kernel/linux/linux-cip-rt_4.4.285-cip63-rt36.bb  | 2 ++
 recipes-kernel/linux/linux-cip-rt_5.10.83-cip1-rt1.bb    | 2 ++
 recipes-kernel/linux/linux-cip_4.19.217-cip62.bb         | 2 ++
 recipes-kernel/linux/linux-cip_4.4.291-cip65.bb          | 2 ++
 recipes-kernel/linux/linux-cip_5.10.83-cip1.bb           | 2 ++
 11 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-rzg2m.conf
index 4f4ee81..18a86d4 100644
--- a/conf/machine/hihope-rzg2m.conf
+++ b/conf/machine/hihope-rzg2m.conf
@@ -13,7 +13,7 @@ DISTRO_ARCH = "arm64"
 
 IMAGE_TYPE ?= "wic-img"
 
-KERNEL_DEFCONFIG = "cip-kernel-config/4.19.y-cip/arm64/renesas_defconfig"
+KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/renesas_defconfig"
 USE_CIP_KERNEL_CONFIG = "1"
 DTB_FILES = "r8a774a1-hihope-rzg2m-ex.dtb"
 IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"
diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
index c90d957..d9605ca 100644
--- a/conf/machine/qemu-amd64.conf
+++ b/conf/machine/qemu-amd64.conf
@@ -10,4 +10,4 @@ DISTRO_ARCH = "amd64"
 
 IMAGE_TYPE ?= "ext4-img"
 USE_CIP_KERNEL_CONFIG = "1"
-KERNEL_DEFCONFIG = "cip-kernel-config/4.19.y-cip/x86/cip_qemu_defconfig"
+KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_qemu_defconfig"
diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
index 81a22c1..e439d49 100644
--- a/conf/machine/qemu-arm.conf
+++ b/conf/machine/qemu-arm.conf
@@ -11,4 +11,4 @@ DISTRO_ARCH = "armhf"
 
 IMAGE_TYPE ?= "ext4-img"
 USE_CIP_KERNEL_CONFIG = "1"
-KERNEL_DEFCONFIG ?= "cip-kernel-config/4.19.y-cip/arm/qemu_arm_defconfig"
+KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/qemu_arm_defconfig"
diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
index eb34703..f2a301b 100644
--- a/conf/machine/qemu-arm64.conf
+++ b/conf/machine/qemu-arm64.conf
@@ -10,4 +10,4 @@ DISTRO_ARCH = "arm64"
 
 IMAGE_TYPE ?= "ext4-img"
 USE_CIP_KERNEL_CONFIG = "1"
-KERNEL_DEFCONFIG ?= "cip-kernel-config/4.19.y-cip/arm64/qemu_arm64_defconfig"
+KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/qemu_arm64_defconfig"
diff --git a/conf/machine/simatic-ipc227e.conf b/conf/machine/simatic-ipc227e.conf
index 3c9638f..552a0b0 100644
--- a/conf/machine/simatic-ipc227e.conf
+++ b/conf/machine/simatic-ipc227e.conf
@@ -11,4 +11,4 @@ DISTRO_ARCH = "amd64"
 IMAGE_TYPE ?= "wic-img"
 IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
 USE_CIP_KERNEL_CONFIG = "1"
-KERNEL_DEFCONFIG = "cip-kernel-config/4.19.y-cip/x86/siemens_ipc227e_defconfig"
+KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/siemens_ipc227e_defconfig"
diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.217-cip62-rt23.bb b/recipes-kernel/linux/linux-cip-rt_4.19.217-cip62-rt23.bb
index a3a9c43..2eefbdc 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.217-cip62-rt23.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.217-cip62-rt23.bb
@@ -11,4 +11,6 @@
 
 require linux-cip-rt-common.inc
 
+KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
+
 SRC_URI[sha256sum] = "f7584d79132ad99ed5b7ce7430c79a08cb9b81ad40b5982464f95859a00ceb6f"
diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.285-cip63-rt36.bb b/recipes-kernel/linux/linux-cip-rt_4.4.285-cip63-rt36.bb
index c051583..41342b3 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.285-cip63-rt36.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.285-cip63-rt36.bb
@@ -11,4 +11,6 @@
 
 require linux-cip-rt-common.inc
 
+KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
+
 SRC_URI[sha256sum] = "c2fe6bcf44fc7a8ee9785adc4dc41d07c50d803883add859648cbbb0461854fa"
diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.83-cip1-rt1.bb b/recipes-kernel/linux/linux-cip-rt_5.10.83-cip1-rt1.bb
index 7b38c1e..b20ac56 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.83-cip1-rt1.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.83-cip1-rt1.bb
@@ -11,4 +11,6 @@
 
 require linux-cip-rt-common.inc
 
+KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
+
 SRC_URI[sha256sum] = "e10b3ab1ad09ed7650883c5357b68660ac1c56f6d71b3b82feb0d69ed182ea54"
diff --git a/recipes-kernel/linux/linux-cip_4.19.217-cip62.bb b/recipes-kernel/linux/linux-cip_4.19.217-cip62.bb
index 1a60571..0147313 100644
--- a/recipes-kernel/linux/linux-cip_4.19.217-cip62.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.217-cip62.bb
@@ -11,4 +11,6 @@
 
 require linux-cip-common.inc
 
+KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
+
 SRC_URI[sha256sum] = "00b22f2e7b3d4f5787ca92f2e182211ac2c1391c09435174c2b4670b2837b23c"
diff --git a/recipes-kernel/linux/linux-cip_4.4.291-cip65.bb b/recipes-kernel/linux/linux-cip_4.4.291-cip65.bb
index e45c57c..4e32031 100644
--- a/recipes-kernel/linux/linux-cip_4.4.291-cip65.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.291-cip65.bb
@@ -11,4 +11,6 @@
 
 require linux-cip-common.inc
 
+KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
+
 SRC_URI[sha256sum] = "9ed7782c067793e684691e99388608ff746f04121cc35dbbbfc2fa5ed6f9e88e"
diff --git a/recipes-kernel/linux/linux-cip_5.10.83-cip1.bb b/recipes-kernel/linux/linux-cip_5.10.83-cip1.bb
index a89f568..236358a 100644
--- a/recipes-kernel/linux/linux-cip_5.10.83-cip1.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.83-cip1.bb
@@ -11,4 +11,6 @@
 
 require linux-cip-common.inc
 
+KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
+
 SRC_URI[sha256sum] = "85af8f809b2505c6434266d6658d977d62d383889b3a4f9968b2764794108d4f"
-- 
2.33.0


