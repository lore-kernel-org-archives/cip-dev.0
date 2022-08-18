Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73161C25B0E
	for <webhook@archiver.kernel.org>; Thu, 18 Aug 2022 04:12:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.38229.1660795954663093844
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Aug 2022 21:12:35 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.153,
 mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 27I4CWZ9006018;
 Thu, 18 Aug 2022 13:12:33 +0900
X-Iguazu-Qid: 34tKqchBWzQtdtd1ar
X-Iguazu-QSIG: v=2; s=0; t=1660795952; q=34tKqchBWzQtdtd1ar;
 m=uo8JsbZM3EBYAZo86qqv+49FJ5hgZpokyzsGT2RDL+M=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1513) id 27I4CWco040388
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Aug 2022 13:12:32 +0900
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 2/4] SWUpdate: add SWUpdate support to BBB
Date: Thu, 18 Aug 2022 09:34:26 +0530
X-TSB-HOP2: ON
Message-Id: <20220818040428.11124-3-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220818040428.11124-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20220818040428.11124-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 18 Aug 2022 04:12:28.0189 (UTC)
 FILETIME=[BA9B34D0:01D8B2B8]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Aug 2022 04:12:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9287

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

This patch adds following changes to support swupdate on BBB
-  swupdate handler configuration file
-  Add settings related to swupdate to bbb.conf
-  Add u-boot specific sw-description.tmpl

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 conf/machine/bbb.conf                         | 23 ++++++++++++++--
 recipes-core/images/files/sw-description.tmpl | 15 +++--------
 recipes-core/images/swupdate.inc              |  7 ++---
 .../files/swupdate.handler.u-boot.ini         | 26 +++++++++++++++++++
 4 files changed, 54 insertions(+), 17 deletions(-)
 create mode 100644 recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-boot.ini

diff --git a/conf/machine/bbb.conf b/conf/machine/bbb.conf
index b592f4d..9cde442 100644
--- a/conf/machine/bbb.conf
+++ b/conf/machine/bbb.conf
@@ -8,7 +8,26 @@
 
 DISTRO_ARCH = "armhf"
 
-IMAGE_FSTYPES ?= "wic"
-IMAGER_INSTALL += "u-boot-omap"
+IMAGE_FSTYPES ?= "ext4-img"
+
+PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-bbb"
+PREFERRED_PROVIDER_u-boot-tools = "u-boot-bbb"
+
+DTB_FILES = "am335x-boneblack.dtb"
+
+IMAGE_BOOT_FILES = " \
+    /usr/lib/u-boot/bbb/u-boot.img;u-boot.img \
+    /usr/lib/u-boot/bbb/MLO;MLO \
+    ${DEPLOY_DIR_IMAGE}/boot.scr;boot.scr \
+    ${DEPLOY_DIR_IMAGE}/uboot.env;uboot.env \
+    ${DEPLOY_DIR_IMAGE}/${DTB_FILES};${DTB_FILES} \
+    ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGE};vmlinuz \
+    ${DEPLOY_DIR_IMAGE}/${INITRD_IMAGE};initrd"
 
 IMAGE_INSTALL += "u-boot-script"
+
+IMAGER_INSTALL += "u-boot-bbb"
+IMAGER_BUILD_DEPS += "u-boot-bbb"
+
+# Currently supported bootloader bindings for SWUpdate are 'u-boot' and 'efibootguard'.
+SWUPDATE_BOOTLOADER = "u-boot"
diff --git a/recipes-core/images/files/sw-description.tmpl b/recipes-core/images/files/sw-description.tmpl
index f5cafeb..f6e7bdc 100644
--- a/recipes-core/images/files/sw-description.tmpl
+++ b/recipes-core/images/files/sw-description.tmpl
@@ -11,10 +11,10 @@
 software =
 {
     version = "0.2";
-    name = "cip software update";
+    name = "cip software update"
     images: ({
             filename = "${ROOTFS_PARTITION_NAME}";
-            device = "C:BOOT0:linux.efi->fedcba98-7654-3210-cafe-5e0710000001,C:BOOT1:linux.efi->fedcba98-7654-3210-cafe-5e0710000002";
+            device = "/dev/mmcblk0p2,/dev/mmcblk0p3";
             type = "roundrobin";
             compressed = "zlib";
             filesystem = "ext4";
@@ -22,14 +22,5 @@ software =
                         subtype = "image";
             };
     });
-    files: ({
-            filename = "linux.efi";
-            path = "linux.efi";
-            type = "roundrobin";
-            device = "C:BOOT0:linux.efi->BOOT0,C:BOOT1:linux.efi->BOOT1";
-            filesystem = "vfat";
-            properties: {
-                        subtype = "kernel";
-            };
-    });
 }
+
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index e0252df..2677046 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -14,11 +14,12 @@ inherit read-only-rootfs
 
 ROOTFS_PARTITION_NAME = "${IMAGE_FULLNAME}.wic.p4.gz"
 
-FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
+EXTRACT_PARTITIONS = "img4"
+ROOTFS_PARTITION_NAME = "${IMAGE_FULLNAME}.wic.p2.gz"
 
 SRC_URI += "file://sw-description.tmpl"
 TEMPLATE_FILES += "sw-description.tmpl"
+TEMPLATE_VARS += "PN ROOTFS_PARTITION_NAME KERNEL_IMAGE INITRD_IMAGE"
 
-TEMPLATE_VARS += "ROOTFS_PARTITION_NAME"
+SWU_ADDITIONAL_FILES += "${ROOTFS_PARTITION_NAME}"
 
-SWU_ADDITIONAL_FILES += "linux.efi ${ROOTFS_PARTITION_NAME}"
diff --git a/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-boot.ini b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-boot.ini
new file mode 100644
index 0000000..aff1105
--- /dev/null
+++ b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-boot.ini
@@ -0,0 +1,26 @@
+[image]
+chainhandler=raw
+
+[image.selector]
+method=cmdline_rr
+key=root
+
+[image.bootenv]
+ustate=1
+
+[kernel]
+chainhandler=rawfile
+
+[kernel.selector]
+method=cmdline_rrmap
+key=root
+
+[kernel.bootenv]
+kernelfile=C:BOOT${rrindex}:vmlinuz-linux
+
+[initrd]
+chainhandler=rawfile
+
+[initrd.selector]
+method=cmdline_rrmap
+key=root
-- 
2.20.1



