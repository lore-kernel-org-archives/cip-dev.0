Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B1EC4167D
	for <webhook@archiver.kernel.org>; Tue, 16 Nov 2021 11:27:58 +0000 (UTC)
Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web12.8540.1637062077187309049
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Nov 2021 03:27:57 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.40, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AGBRsHg005092
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Tue, 16 Nov 2021 12:27:54 +0100
Received: from md2dvrtc.fritz.box ([167.87.1.223])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AGBRqNU006209;
	Tue, 16 Nov 2021 12:27:54 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: raphael.lisicki@siemens.com, jan.kiszka@siemens.com,
        cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core]RFC v2 5/9] Create an read-only rootfs with
 dm-verity
Date: Tue, 16 Nov 2021 12:27:48 +0100
Message-Id: <20211116112752.1521211-6-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211116112752.1521211-1-Quirin.Gylstorff@siemens.com>
References: <20211116112752.1521211-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Nov 2021 11:27:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6933

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This root file system supports SWUpdate and secure boot.
We need a writable /tmp and /var for a boot without error messages.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 Kconfig                                       |  3 +-
 classes/secure-swupdate-img.bbclass           | 32 +++++++++++++++++++
 kas/opt/ebg-secure-boot-base.yml              |  2 ++
 kas/opt/ebg-secure-boot-snakeoil.yml          | 13 +++++++-
 kas/opt/ebg-snakeoil-swu.yml                  | 16 ----------
 .../images/cip-core-image-read-only.bb        | 20 ++++++++++++
 recipes-core/tmp-fs/files/postinst            |  3 ++
 recipes-core/tmp-fs/files/tmp.mount           | 11 +++++++
 recipes-core/tmp-fs/tmp-fs_0.1.bb             |  9 ++++++
 wic/qemu-amd64-efibootguard-secureboot.wks    | 11 -------
 wic/qemu-amd64-efibootguard-secureboot.wks.in | 13 ++++++++
 11 files changed, 103 insertions(+), 30 deletions(-)
 create mode 100644 classes/secure-swupdate-img.bbclass
 delete mode 100644 kas/opt/ebg-snakeoil-swu.yml
 create mode 100644 recipes-core/images/cip-core-image-read-only.bb
 create mode 100755 recipes-core/tmp-fs/files/postinst
 create mode 100644 recipes-core/tmp-fs/files/tmp.mount
 create mode 100644 recipes-core/tmp-fs/tmp-fs_0.1.bb
 delete mode 100644 wic/qemu-amd64-efibootguard-secureboot.wks
 create mode 100644 wic/qemu-amd64-efibootguard-secureboot.wks.in

diff --git a/Kconfig b/Kconfig
index 8421f1b..e97cb03 100644
--- a/Kconfig
+++ b/Kconfig
@@ -141,7 +141,6 @@ config IMAGE_SECURE_BOOT
 config KAS_INCLUDE_SWUPDATE_SECBOOT
 	string
 	default "kas/opt/ebg-swu.yml" if IMAGE_SWUPDATE && !IMAGE_SECURE_BOOT
-	default "kas/opt/ebg-secure-boot-snakeoil.yml" if !IMAGE_SWUPDATE && IMAGE_SECURE_BOOT
-	default "kas/opt/ebg-snakeoil-swu.yml" if IMAGE_SWUPDATE && IMAGE_SECURE_BOOT
+	default "kas/opt/ebg-secure-boot-snakeoil.yml" if IMAGE_SECURE_BOOT
 
 endif
diff --git a/classes/secure-swupdate-img.bbclass b/classes/secure-swupdate-img.bbclass
new file mode 100644
index 0000000..431939b
--- /dev/null
+++ b/classes/secure-swupdate-img.bbclass
@@ -0,0 +1,32 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2021
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+SECURE_IMAGE_FSTYPE ?= "squashfs"
+
+inherit ${SECURE_IMAGE_FSTYPE}-img
+
+VERITY_IMAGE_TYPE = "${SECURE_IMAGE_FSTYPE}"
+
+INITRAMFS_RECIPE ?= "cip-core-initramfs"
+do_wic_image[depends] += "${INITRAMFS_RECIPE}:do_build"
+INITRD_IMAGE = "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
+
+inherit verity-img
+inherit wic-img
+inherit extract-partition
+inherit swupdate-img
+
+SOURCE_IMAGE_FILE = "${WIC_IMAGE_FILE}"
+
+addtask do_verity_image after do_${SECURE_IMAGE_FSTYPE}_image
+addtask do_wic_image after do_verity_image
+addtask do_extract_partition after do_wic_image
+addtask do_swupdate_image after do_extract_partition
diff --git a/kas/opt/ebg-secure-boot-base.yml b/kas/opt/ebg-secure-boot-base.yml
index 8f769b6..acb4de0 100644
--- a/kas/opt/ebg-secure-boot-base.yml
+++ b/kas/opt/ebg-secure-boot-base.yml
@@ -19,3 +19,5 @@ local_conf_header:
     IMAGE_INSTALL += "initramfs-abrootfs-secureboot"
     SWU_DESCRIPTION = "secureboot"
     SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG = "secureboot/swupdate.handler.${SWUPDATE_BOOTLOADER}.ini"
+  kernel: |
+    SECURE_BOOT_KERNEL = "1"
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index 2f45bde..4a9185c 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -14,13 +14,24 @@ header:
   includes:
    - kas/opt/ebg-secure-boot-base.yml
 
+target: cip-core-image-read-only
 
 local_conf_header:
+  swupdate: |
+    IMAGE_INSTALL_append = " swupdate"
+    IMAGE_INSTALL_append = " swupdate-handler-roundrobin"
+
+  verity-img: |
+    SECURE_BOOT_KERNEL = "1"
+    SECURE_IMAGE_FSTYPE = "squashfs"
+    VERITY_IMAGE_RECIPE = "cip-core-image-read-only"
+    IMAGE_TYPE = "secure-swupdate-img"
+    WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
+
   secure-boot: |
     # Add snakeoil and ovmf binaries for qemu
     IMAGER_BUILD_DEPS += "ebg-secure-boot-snakeoil ovmf-binaries"
     IMAGER_INSTALL += "ebg-secure-boot-snakeoil"
-    WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks"
 
   ovmf: |
     # snakeoil certs are only part of backports
diff --git a/kas/opt/ebg-snakeoil-swu.yml b/kas/opt/ebg-snakeoil-swu.yml
deleted file mode 100644
index 2f15c0e..0000000
--- a/kas/opt/ebg-snakeoil-swu.yml
+++ /dev/null
@@ -1,16 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2021
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-header:
-  version: 10
-  includes:
-   - kas/opt/ebg-secure-boot-snakeoil.yml
-   - kas/opt/swupdate.yml
diff --git a/recipes-core/images/cip-core-image-read-only.bb b/recipes-core/images/cip-core-image-read-only.bb
new file mode 100644
index 0000000..7ef2dc2
--- /dev/null
+++ b/recipes-core/images/cip-core-image-read-only.bb
@@ -0,0 +1,20 @@
+require cip-core-image.bb
+
+SQUASHFS_EXCLUDE_DIRS += "home var"
+
+IMAGE_INSTALL += "tmp-fs"
+IMAGE_INSTALL_remove += "initramfs-abrootfs-secureboot"
+
+image_configure_fstab() {
+    sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
+# Begin /etc/fstab
+/dev/root	/		auto		defaults,ro			0	0
+LABEL=var	/var		auto		defaults			0	0
+proc		/proc		proc		nosuid,noexec,nodev		0	0
+sysfs		/sys		sysfs		nosuid,noexec,nodev		0	0
+devpts		/dev/pts	devpts		gid=5,mode=620			0	0
+tmpfs		/run		tmpfs		nodev,nosuid,size=500M,mode=755	0	0
+devtmpfs	/dev		devtmpfs	mode=0755,nosuid		0	0
+# End /etc/fstab
+EOF
+}
diff --git a/recipes-core/tmp-fs/files/postinst b/recipes-core/tmp-fs/files/postinst
new file mode 100755
index 0000000..07017fd
--- /dev/null
+++ b/recipes-core/tmp-fs/files/postinst
@@ -0,0 +1,3 @@
+#!/bin/sh
+
+deb-systemd-helper enable tmp.mount  || true
diff --git a/recipes-core/tmp-fs/files/tmp.mount b/recipes-core/tmp-fs/files/tmp.mount
new file mode 100644
index 0000000..7a31ed6
--- /dev/null
+++ b/recipes-core/tmp-fs/files/tmp.mount
@@ -0,0 +1,11 @@
+[Unit]
+Description=Create /tmp
+
+[Mount]
+What=tmpfs
+Where=/tmp
+Type=tmpfs
+Options=nodev,nosuid,size=500M,mode=755
+
+[Install]
+WantedBy=local-fs.target
diff --git a/recipes-core/tmp-fs/tmp-fs_0.1.bb b/recipes-core/tmp-fs/tmp-fs_0.1.bb
new file mode 100644
index 0000000..4e0c467
--- /dev/null
+++ b/recipes-core/tmp-fs/tmp-fs_0.1.bb
@@ -0,0 +1,9 @@
+inherit dpkg-raw
+
+SRC_URI = "file://postinst \
+           file://tmp.mount"
+
+do_install[cleandirs]+="${D}/lib/systemd/system"
+do_install() {
+    install -m 0644 ${WORKDIR}/tmp.mount ${D}/lib/systemd/system/tmp.mount
+}
diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks b/wic/qemu-amd64-efibootguard-secureboot.wks
deleted file mode 100644
index ff351db..0000000
--- a/wic/qemu-amd64-efibootguard-secureboot.wks
+++ /dev/null
@@ -1,11 +0,0 @@
-# short-description: Qemu-amd64 with Efibootguard and SWUpdate
-# long-description: Disk image for qemu-amd64 with EFI Boot Guard and SWUpdate
-include ebg-signed-bootloader.inc
-
-# EFI Boot Guard environment/config partitions plus Kernel files
-part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,unified-kernel=y,signwith=/usr/bin/sign_secure_image.sh"
-part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,unified-kernel=y,signwith=/usr/bin/sign_secure_image.sh"
-
-include swupdate-partition.inc
-
-bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk panic=0"
diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
new file mode 100644
index 0000000..c4ea0c8
--- /dev/null
+++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
@@ -0,0 +1,13 @@
+# EFI partition containing efibootguard bootloader binary
+part --source efibootguard-efi  --ondisk sda --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --sourceparams "signwith=/usr/bin/sign_secure_image.sh"
+
+# EFI Boot Guard environment/config partitions plus Kernel files
+part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,unified-kernel=y,signwith=/usr/bin/sign_secure_image.sh"
+part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,unified-kernel=y,signwith=/usr/bin/sign_secure_image.sh"
+
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --ondisk sda --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --ondisk sda --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
+
+part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --ondisk sda --fstype=ext4 --label var --align 1024  --size 2G
+
+bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait rw earlyprintk"
-- 
2.30.2


