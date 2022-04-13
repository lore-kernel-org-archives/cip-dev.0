Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD360C47084
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:06 +0000 (UTC)
Received: from mta-64-227.flowmailer.net (mta-64-227.flowmailer.net
 [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web08.3507.1649834201494836727
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 00:16:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=J3YVC6kx;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-294854-202204130716392a49924007b31d7597-kccjrj@rts-flowmailer.siemens.com)
Received: by mta-64-227.flowmailer.net with ESMTPSA id
 202204130716392a49924007b31d7597
        for <cip-dev@lists.cip-project.org>;
        Wed, 13 Apr 2022 09:16:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=6bk8k2EPRnZrtjBduGkr2w61hzhb0QrWQmMgc9u4BXE=;
 b=J3YVC6kxeHC99JZSwUilLwHdv0bK2rtuZKIv2QKNwJQlTz2soeRhWrfwfR5fhqgzTIJd/A
 g2TS9ZV9NF99JRyt/zAjELtHsezF2oyUv4m6gjrxQFtVDOC7X8Kwb8ZiLGe/bbrqOD/Gg+hb
 Bo0hETn7/xAhlqutoy7/bHVJ8MI0A=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 07/19] swupdate: Switch to unified kernel image
 by default
Date: Wed, 13 Apr 2022 09:16:24 +0200
Message-Id: 
 <ec84e655e1d0a6f0909969f351de6e4ed0abc0d1.1649834193.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1649834193.git.jan.kiszka@siemens.com>
References: <cover.1649834193.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Apr 2022 15:48:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8055

From: Jan Kiszka <jan.kiszka@siemens.com>

This will help to move non-secure and secure boot closer. It will also
be required when booting non-x86 kernels with device trees that shall be
replaceable via updates, thus shall be embedded into the unified kernel
image.

The change obsoletes the need to specify "unified-kernel=y" as
efibootguard-boot plugin parameter. Users can still select the classic
boot method by providing "unified-kernel=n".

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas/opt/ebg-swu.yml                           |  4 ++++
 recipes-core/images/files/sw-description.tmpl | 20 +++++--------------
 recipes-core/images/swupdate.inc              |  4 ++--
 .../files/swupdate.handler.efibootguard.ini   | 16 +++------------
 .../wic/plugins/source/efibootguard-boot.py   | 10 ++++------
 wic/ebg-sysparts.inc                          |  4 ++--
 wic/qemu-amd64-efibootguard-secureboot.wks.in |  4 ++--
 7 files changed, 22 insertions(+), 40 deletions(-)

diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index e708d0a..a58f0ed 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -14,3 +14,7 @@ header:
   includes:
    - kas/opt/efibootguard.yml
    - kas/opt/swupdate.yml
+
+local_conf_header:
+  initramfs: |
+    IMAGE_INSTALL += "initramfs-abrootfs-hook"
diff --git a/recipes-core/images/files/sw-description.tmpl b/recipes-core/images/files/sw-description.tmpl
index c44c2a8..7dd67f9 100644
--- a/recipes-core/images/files/sw-description.tmpl
+++ b/recipes-core/images/files/sw-description.tmpl
@@ -11,10 +11,10 @@
 software =
 {
     version = "0.2";
-    name = "cip software update"
+    name = "cip software update";
     images: ({
             filename = "${ROOTFS_PARTITION_NAME}";
-            device = "fedcba98-7654-3210-cafe-5e0710000001,fedcba98-7654-3210-cafe-5e0710000002";
+            device = "sda4,sda5";
             type = "roundrobin";
             compressed = "zlib";
             filesystem = "ext4";
@@ -23,23 +23,13 @@ software =
             };
     });
     files: ({
-            filename = "${KERNEL_IMAGE}";
-            path = "vmlinuz";
+            filename = "linux.efi";
+            path = "linux.efi";
             type = "roundrobin";
-            device = "fedcba98-7654-3210-cafe-5e0710000001->BOOT0,fedcba98-7654-3210-cafe-5e0710000002->BOOT1";
+            device = "sda4->BOOT0,sda5->BOOT1";
             filesystem = "vfat";
             properties: {
                         subtype = "kernel";
             };
-    },
-    {
-            filename = "${INITRD_IMAGE}";
-            path = "${INITRD_IMAGE}";
-            type = "roundrobin";
-            device = "fedcba98-7654-3210-cafe-5e0710000001->BOOT0,fedcba98-7654-3210-cafe-5e0710000002->BOOT1";
-            filesystem = "vfat";
-            properties: {
-                        subtype = "initrd";
-            };
     });
 }
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index c23c103..2c3ad65 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -16,6 +16,6 @@ ROOTFS_PARTITION_NAME = "${IMAGE_FULLNAME}.wic.img.p4.gz"
 SRC_URI += "file://sw-description.tmpl"
 TEMPLATE_FILES += "sw-description.tmpl"
 
-TEMPLATE_VARS += "PN ROOTFS_PARTITION_NAME KERNEL_IMAGE INITRD_IMAGE"
+TEMPLATE_VARS += "PN ROOTFS_PARTITION_NAME"
 
-SWU_ADDITIONAL_FILES += "${INITRD_IMAGE} ${KERNEL_IMAGE} ${ROOTFS_PARTITION_NAME}"
+SWU_ADDITIONAL_FILES += "linux.efi ${ROOTFS_PARTITION_NAME}"
diff --git a/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini
index 3aee76c..b5e8070 100644
--- a/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini
+++ b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini
@@ -2,25 +2,15 @@
 chainhandler=raw
 
 [image.selector]
-method=cmdline_rr
+method=getroot_rr
 key=root
 
-[image.bootenv]
-kernelparams=root=PARTUUID=${rrtarget} ${cmdline_root}
-
 [kernel]
 chainhandler=rawfile
 
 [kernel.selector]
-method=cmdline_rrmap
+method=getroot_rrmap
 key=root
 
 [kernel.bootenv]
-kernelfile=C:BOOT${rrindex}:vmlinuz
-
-[initrd]
-chainhandler=rawfile
-
-[initrd.selector]
-method=cmdline_rrmap
-key=root
+kernelfile=C:BOOT${rrindex}:linux.efi
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 98a327c..4291dc2 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -78,15 +78,13 @@ class EfibootguardBootPlugin(SourcePlugin):
             efibootguard in local.conf with WDOG_TIMEOUT=")
             exit(1)
 
-
         boot_files = source_params.get("files", "").split(' ')
-        uefi_kernel = source_params.get("unified-kernel")
+        unified_kernel = source_params.get("unified-kernel") or 'y'
         cmdline = bootloader.append
-        if uefi_kernel:
+        if unified_kernel == 'y':
             boot_image = cls._create_unified_kernel_image(rootfs_dir,
                                                           cr_workdir,
                                                           cmdline,
-                                                          uefi_kernel,
                                                           deploy_dir,
                                                           kernel_image,
                                                           initrd_image,
@@ -174,8 +172,8 @@ class EfibootguardBootPlugin(SourcePlugin):
 
     @classmethod
     def _create_unified_kernel_image(cls, rootfs_dir, cr_workdir, cmdline,
-                                     uefi_kernel, deploy_dir, kernel_image,
-                                     initrd_image, source_params):
+                                     deploy_dir, kernel_image, initrd_image,
+                                     source_params):
         # we need to map the distro_arch to uefi values
         distro_to_efi_arch = {
             "amd64": "x64",
diff --git a/wic/ebg-sysparts.inc b/wic/ebg-sysparts.inc
index dea99e8..18c879a 100644
--- a/wic/ebg-sysparts.inc
+++ b/wic/ebg-sysparts.inc
@@ -4,5 +4,5 @@
 part --source efibootguard-efi  --ondisk sda --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active
 
 # EFI Boot Guard environment/config partitions plus Kernel files
-part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,root=PARTUUID:fedcba98-7654-3210-cafe-5e0710000001"
-part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,root=PARTUUID:fedcba98-7654-3210-cafe-5e0710000002"
+part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2"
+part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1"
diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
index 72a6f8c..c47257b 100644
--- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
@@ -2,8 +2,8 @@
 include ebg-signed-bootloader.inc
 
 # EFI Boot Guard environment/config partitions plus Kernel files
-part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,unified-kernel=y,signwith=/usr/bin/sign_secure_image.sh"
-part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,unified-kernel=y,signwith=/usr/bin/sign_secure_image.sh"
+part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,signwith=/usr/bin/sign_secure_image.sh"
+part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,signwith=/usr/bin/sign_secure_image.sh"
 
 part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --ondisk sda --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
 part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --ondisk sda --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
-- 
2.34.1


