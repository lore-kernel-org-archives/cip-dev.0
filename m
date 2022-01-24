Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE33C433EF
	for <webhook@archiver.kernel.org>; Mon, 24 Jan 2022 15:37:58 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web08.5219.1643038676775635626
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Jan 2022 07:37:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1
 header.b=ECPs+0i4;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-51332-20220124153750c26d14f404b619ace0-ldalnm@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20220124153750c26d14f404b619ace0
        for <cip-dev@lists.cip-project.org>;
        Mon, 24 Jan 2022 16:37:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=cucWoscdXKH7/E4cWN/sPaDoYaTr1gtduTICQiynOIM=;
 b=ECPs+0i4LeW/4/F4TOr62GvECOqRxBPTixvyhtWWgFrQv7HB2r/4ceKgCPu6Q44gAQi8rB
 r73U47gvRhKXZUJg0RlMxolOIiPh/NHLLWWW3pq/JI/hckQbzMr53mlvB7OCYXVPbSZCgh1a
 8SY7JlckaTYc2meJN2nU2cB9rTfzA=;
From: Quirin.Gylstorff@siemens.com
To: cip-dev@lists.cip-project.org,
	Jan.Kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] Update ISAR
Date: Mon, 24 Jan 2022 16:37:48 +0100
Message-Id: <20220124153748.646550-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Jan 2022 15:37:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7479

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Update ISAR to commit 33b5aa65fa3f28987525799d0731fb4e7050207d and fix warnings.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/machine/bbb.conf                | 2 +-
 conf/machine/hihope-rzg2m.conf       | 2 +-
 conf/machine/iwg20m.conf             | 2 +-
 conf/machine/qemu-amd64.conf         | 2 +-
 conf/machine/qemu-arm.conf           | 2 +-
 conf/machine/qemu-arm64.conf         | 2 +-
 conf/machine/simatic-ipc227e.conf    | 2 +-
 kas-cip.yml                          | 2 +-
 kas/opt/ebg-secure-boot-snakeoil.yml | 2 +-
 kas/opt/efibootguard.yml             | 2 +-
 kas/opt/swupdate.yml                 | 2 +-
 kas/opt/targz-img.yml                | 2 +-
 kas/opt/wic-targz-img.yml            | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/conf/machine/bbb.conf b/conf/machine/bbb.conf
index 6d8facb..81e624e 100644
--- a/conf/machine/bbb.conf
+++ b/conf/machine/bbb.conf
@@ -8,7 +8,7 @@
 
 DISTRO_ARCH = "armhf"
 
-IMAGE_TYPE ?= "wic-img"
+IMAGE_FSTYPES ?= "wic-img"
 IMAGER_INSTALL += "u-boot-omap"
 
 IMAGE_INSTALL += "u-boot-script"
diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-rzg2m.conf
index 18a86d4..bc80ddd 100644
--- a/conf/machine/hihope-rzg2m.conf
+++ b/conf/machine/hihope-rzg2m.conf
@@ -11,7 +11,7 @@
 
 DISTRO_ARCH = "arm64"
 
-IMAGE_TYPE ?= "wic-img"
+IMAGE_FSTYPES ?= "wic-img"
 
 KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/renesas_defconfig"
 USE_CIP_KERNEL_CONFIG = "1"
diff --git a/conf/machine/iwg20m.conf b/conf/machine/iwg20m.conf
index 91bfd94..a26f7fe 100644
--- a/conf/machine/iwg20m.conf
+++ b/conf/machine/iwg20m.conf
@@ -8,7 +8,7 @@
 DISTRO_ARCH = "armhf"
 
 # see wic/iwg20m.wks
-IMAGE_TYPE ?= "wic-img"
+IMAGE_FSTYPES ?= "wic-img"
 
 # sets serial login getty
 MACHINE_SERIAL = "ttySC0"
diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
index d9605ca..a60f818 100644
--- a/conf/machine/qemu-amd64.conf
+++ b/conf/machine/qemu-amd64.conf
@@ -8,6 +8,6 @@
 
 DISTRO_ARCH = "amd64"
 
-IMAGE_TYPE ?= "ext4-img"
+IMAGE_FSTYPES ?= "ext4-img"
 USE_CIP_KERNEL_CONFIG = "1"
 KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_qemu_defconfig"
diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
index e439d49..aca6d7d 100644
--- a/conf/machine/qemu-arm.conf
+++ b/conf/machine/qemu-arm.conf
@@ -9,6 +9,6 @@
 
 DISTRO_ARCH = "armhf"
 
-IMAGE_TYPE ?= "ext4-img"
+IMAGE_FSTYPES ?= "ext4-img"
 USE_CIP_KERNEL_CONFIG = "1"
 KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/qemu_arm_defconfig"
diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
index f2a301b..0d21262 100644
--- a/conf/machine/qemu-arm64.conf
+++ b/conf/machine/qemu-arm64.conf
@@ -8,6 +8,6 @@
 
 DISTRO_ARCH = "arm64"
 
-IMAGE_TYPE ?= "ext4-img"
+IMAGE_FSTYPES ?= "ext4-img"
 USE_CIP_KERNEL_CONFIG = "1"
 KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/qemu_arm64_defconfig"
diff --git a/conf/machine/simatic-ipc227e.conf b/conf/machine/simatic-ipc227e.conf
index 552a0b0..50d1f8a 100644
--- a/conf/machine/simatic-ipc227e.conf
+++ b/conf/machine/simatic-ipc227e.conf
@@ -8,7 +8,7 @@
 
 DISTRO_ARCH = "amd64"
 
-IMAGE_TYPE ?= "wic-img"
+IMAGE_FSTYPES ?= "wic-img"
 IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
 USE_CIP_KERNEL_CONFIG = "1"
 KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/siemens_ipc227e_defconfig"
diff --git a/kas-cip.yml b/kas-cip.yml
index 8226954..9c8ac9f 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: ceb7e21154fc4862f704bb5c7739e87a26db6eb3
+    refspec: 33b5aa65fa3f28987525799d0731fb4e7050207d
     layers:
       meta:
     patches:
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index 5aa5eff..1f4d668 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -24,7 +24,7 @@ local_conf_header:
 
   verity-img: |
     SECURE_IMAGE_FSTYPE = "squashfs"
-    IMAGE_TYPE = "secure-swupdate-img"
+    IMAGE_FSTYPES = "secure-swupdate-img"
     WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
 
   secure-boot: |
diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
index 580c315..75d4ab1 100644
--- a/kas/opt/efibootguard.yml
+++ b/kas/opt/efibootguard.yml
@@ -23,6 +23,6 @@ local_conf_header:
   efibootguard-wic: |
     WDOG_TIMEOUT ?= "60"
     WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE"
-    IMAGE_TYPE ?= "wic-img"
+    IMAGE_FSTYPES ?= "wic-img"
     WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
 
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index 974eacb..a8b903f 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -20,5 +20,5 @@ local_conf_header:
     IMAGE_INSTALL_append = " swupdate-handler-roundrobin"
 
   wic-swu: |
-    IMAGE_TYPE = "wic-swu-img"
+    IMAGE_FSTYPES = "wic-swu-img"
     WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
diff --git a/kas/opt/targz-img.yml b/kas/opt/targz-img.yml
index bdb5231..d555a8a 100644
--- a/kas/opt/targz-img.yml
+++ b/kas/opt/targz-img.yml
@@ -14,4 +14,4 @@ header:
 
 local_conf_header:
   image-type: |
-    IMAGE_TYPE = "targz-img"
+    IMAGE_FSTYPES = "targz-img"
diff --git a/kas/opt/wic-targz-img.yml b/kas/opt/wic-targz-img.yml
index 7e9081f..2e83760 100644
--- a/kas/opt/wic-targz-img.yml
+++ b/kas/opt/wic-targz-img.yml
@@ -17,4 +17,4 @@ header:
 
 local_conf_header:
   image-type: |
-    IMAGE_TYPE = "wic-targz-img"
+    IMAGE_FSTYPES = "wic-targz-img"
-- 
2.34.1


