Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB9CCCA47C
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 10:08:20 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.10456.1654596491768609642
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jun 2022 03:08:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1
 header.b=Tf4wjB14;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227,
 mailfrom: fm-51332-20220607100808a9efb4f5f67d2e3251-nmd008@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 20220607100808a9efb4f5f67d2e3251
        for <cip-dev@lists.cip-project.org>;
        Tue, 07 Jun 2022 12:08:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=bRsyjPYz9aaQ+HLah83HgvgGJiabkryDAC9CP/aSLMg=;
 b=Tf4wjB14W/xyjrOViUW/dLAfZ8tA24ATsddyzG0HfV8IvqsGJOw8bBh7WJ5KI/ZwYasQZF
 7Js/dOXgzoaKeCrArpP+vizQQxWZpSnBDLl+ICnIaJmeXbGQ4KWwUsvtcz5yBrVqld+9ljVe
 qC8phMTyfqr65h5oHARIhoz0/yrVo=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	adriaan.schmidt@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v2 1/4] ISAR update
Date: Tue,  7 Jun 2022 12:08:03 +0200
Message-Id: <20220607100806.133889-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20220607100806.133889-1-Quirin.Gylstorff@siemens.com>
References: <20220603115618.985568-1-Quirin.Gylstorff@siemens.com>
 <20220607100806.133889-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jun 2022 10:08:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8507

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This update introduces the new IMAGE_CMD_*.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/wic-targz-img.bbclass                 | 15 --------
 conf/machine/bbb.conf                         |  2 +-
 conf/machine/hihope-rzg2m.conf                |  2 +-
 conf/machine/iwg20m.conf                      |  2 +-
 conf/machine/qemu-amd64.conf                  |  2 +-
 conf/machine/qemu-arm.conf                    |  2 +-
 conf/machine/qemu-arm64.conf                  |  2 +-
 conf/machine/simatic-ipc227e.conf             |  2 +-
 kas-cip.yml                                   |  6 +---
 kas/opt/efibootguard.yml                      |  2 +-
 kas/opt/swupdate.yml                          |  2 +-
 kas/opt/targz-img.yml                         |  2 +-
 kas/opt/wic-targz-img.yml                     |  2 +-
 ...when-splitting-rootfs-folders-across.patch | 35 -------------------
 14 files changed, 12 insertions(+), 66 deletions(-)
 delete mode 100644 classes/wic-targz-img.bbclass
 delete mode 100644 patches/isar/0001-Fix-permissions-when-splitting-rootfs-folders-across.patch

diff --git a/classes/wic-targz-img.bbclass b/classes/wic-targz-img.bbclass
deleted file mode 100644
index 1327840..0000000
--- a/classes/wic-targz-img.bbclass
+++ /dev/null
@@ -1,15 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2019
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-inherit wic-img
-inherit targz-img
-
-addtask do_targz_image after do_wic_image
diff --git a/conf/machine/bbb.conf b/conf/machine/bbb.conf
index 81e624e..b592f4d 100644
--- a/conf/machine/bbb.conf
+++ b/conf/machine/bbb.conf
@@ -8,7 +8,7 @@
 
 DISTRO_ARCH = "armhf"
 
-IMAGE_FSTYPES ?= "wic-img"
+IMAGE_FSTYPES ?= "wic"
 IMAGER_INSTALL += "u-boot-omap"
 
 IMAGE_INSTALL += "u-boot-script"
diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-rzg2m.conf
index bc80ddd..0b3acf4 100644
--- a/conf/machine/hihope-rzg2m.conf
+++ b/conf/machine/hihope-rzg2m.conf
@@ -11,7 +11,7 @@
 
 DISTRO_ARCH = "arm64"
 
-IMAGE_FSTYPES ?= "wic-img"
+IMAGE_FSTYPES ?= "wic"
 
 KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/renesas_defconfig"
 USE_CIP_KERNEL_CONFIG = "1"
diff --git a/conf/machine/iwg20m.conf b/conf/machine/iwg20m.conf
index a26f7fe..d997a02 100644
--- a/conf/machine/iwg20m.conf
+++ b/conf/machine/iwg20m.conf
@@ -8,7 +8,7 @@
 DISTRO_ARCH = "armhf"
 
 # see wic/iwg20m.wks
-IMAGE_FSTYPES ?= "wic-img"
+IMAGE_FSTYPES ?= "wic"
 
 # sets serial login getty
 MACHINE_SERIAL = "ttySC0"
diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
index a60f818..da7e59c 100644
--- a/conf/machine/qemu-amd64.conf
+++ b/conf/machine/qemu-amd64.conf
@@ -8,6 +8,6 @@
 
 DISTRO_ARCH = "amd64"
 
-IMAGE_FSTYPES ?= "ext4-img"
+IMAGE_FSTYPES ?= "ext4"
 USE_CIP_KERNEL_CONFIG = "1"
 KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_qemu_defconfig"
diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
index aca6d7d..1937c4c 100644
--- a/conf/machine/qemu-arm.conf
+++ b/conf/machine/qemu-arm.conf
@@ -9,6 +9,6 @@
 
 DISTRO_ARCH = "armhf"
 
-IMAGE_FSTYPES ?= "ext4-img"
+IMAGE_FSTYPES ?= "ext4"
 USE_CIP_KERNEL_CONFIG = "1"
 KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/qemu_arm_defconfig"
diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
index 4e12cdb..b5c1e1c 100644
--- a/conf/machine/qemu-arm64.conf
+++ b/conf/machine/qemu-arm64.conf
@@ -8,7 +8,7 @@
 
 DISTRO_ARCH = "arm64"
 
-IMAGE_FSTYPES ?= "ext4-img"
+IMAGE_FSTYPES ?= "ext4"
 USE_CIP_KERNEL_CONFIG = "1"
 KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/qemu_arm64_defconfig"
 
diff --git a/conf/machine/simatic-ipc227e.conf b/conf/machine/simatic-ipc227e.conf
index 50d1f8a..a624fcd 100644
--- a/conf/machine/simatic-ipc227e.conf
+++ b/conf/machine/simatic-ipc227e.conf
@@ -8,7 +8,7 @@
 
 DISTRO_ARCH = "amd64"
 
-IMAGE_FSTYPES ?= "wic-img"
+IMAGE_FSTYPES ?= "wic"
 IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
 USE_CIP_KERNEL_CONFIG = "1"
 KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/siemens_ipc227e_defconfig"
diff --git a/kas-cip.yml b/kas-cip.yml
index fce176b..e24aea8 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,13 +22,9 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: cf3f18a649ff42726677a58b224b9bb58ea4ba46
+    refspec: 1000df8e98b9a5849a7897698039687fd0cdd7d3
     layers:
       meta:
-    patches:
-      fix-pseudo:
-        repo: cip-core
-        path: patches/isar/0001-Fix-permissions-when-splitting-rootfs-folders-across.patch
 
 bblayers_conf_header:
   standard: |
diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
index d85aed7..4282932 100644
--- a/kas/opt/efibootguard.yml
+++ b/kas/opt/efibootguard.yml
@@ -24,7 +24,7 @@ local_conf_header:
     WIC_IMAGER_INSTALL_append = " efibootguard"
     WDOG_TIMEOUT ?= "60"
     WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE DTB_FILES"
-    IMAGE_FSTYPES ?= "wic-img"
+    IMAGE_FSTYPES ?= "wic"
     WKS_FILE ?= "${MACHINE}-efibootguard.wks.in"
 
   firmware-binaries: |
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index 31cd0d1..72429c6 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -23,5 +23,5 @@ local_conf_header:
     CIP_IMAGE_OPTIONS_append = " swupdate.inc"
 
   wic-swu: |
-    IMAGE_FSTYPES = "wic-swu-img"
+    IMAGE_FSTYPES = "wic"
     WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
diff --git a/kas/opt/targz-img.yml b/kas/opt/targz-img.yml
index d555a8a..afe2e07 100644
--- a/kas/opt/targz-img.yml
+++ b/kas/opt/targz-img.yml
@@ -14,4 +14,4 @@ header:
 
 local_conf_header:
   image-type: |
-    IMAGE_FSTYPES = "targz-img"
+    IMAGE_FSTYPES = "tar.gz"
diff --git a/kas/opt/wic-targz-img.yml b/kas/opt/wic-targz-img.yml
index 2e83760..aaee76d 100644
--- a/kas/opt/wic-targz-img.yml
+++ b/kas/opt/wic-targz-img.yml
@@ -17,4 +17,4 @@ header:
 
 local_conf_header:
   image-type: |
-    IMAGE_FSTYPES = "wic-targz-img"
+    IMAGE_FSTYPES = "wic tar.gz"
diff --git a/patches/isar/0001-Fix-permissions-when-splitting-rootfs-folders-across.patch b/patches/isar/0001-Fix-permissions-when-splitting-rootfs-folders-across.patch
deleted file mode 100644
index 34704f0..0000000
--- a/patches/isar/0001-Fix-permissions-when-splitting-rootfs-folders-across.patch
+++ /dev/null
@@ -1,35 +0,0 @@
-From 34b37fccd5e454d29d6d4d002d48a9619782b1bb Mon Sep 17 00:00:00 2001
-From: Felix Moessbauer <felix.moessbauer@siemens.com>
-Date: Wed, 3 Nov 2021 13:53:00 +0100
-Subject: [PATCH] Fix permissions when splitting rootfs folders across
- partitions.
-
-This patches ensures that the file database containing the file and
-folder usernames and permissions is always located relative to the
-source and not to the appended rootfs-dir.
-
-Prior to this patch, the database was not found when using
--rootfs-dir in the WIC script, leading to erronous file
-permissions and ownership.
-
-Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
----
- scripts/lib/wic/plugins/source/rootfs.py | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/scripts/lib/wic/plugins/source/rootfs.py b/scripts/lib/wic/plugins/source/rootfs.py
-index 96d940a9..5ab771e5 100644
---- a/scripts/lib/wic/plugins/source/rootfs.py
-+++ b/scripts/lib/wic/plugins/source/rootfs.py
-@@ -95,7 +95,7 @@ class RootfsPlugin(SourcePlugin):
- 
-         part.rootfs_dir = cls.__get_rootfs_dir(rootfs_dir)
-         part.has_fstab = os.path.exists(os.path.join(part.rootfs_dir, "etc/fstab"))
--        pseudo_dir = os.path.join(part.rootfs_dir, "../pseudo")
-+        pseudo_dir = os.path.join(krootfs_dir['ROOTFS_DIR'], "../pseudo")
-         if not os.path.lexists(pseudo_dir):
-             logger.warn("%s folder does not exist. "
-                         "Usernames and permissions will be invalid " % pseudo_dir)
--- 
-2.30.2
-
-- 
2.35.1


