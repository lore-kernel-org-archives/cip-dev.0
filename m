Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409EBC4332F
	for <webhook@archiver.kernel.org>; Fri, 12 Nov 2021 11:50:23 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web10.14761.1636717821913071647
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Nov 2021 03:50:22 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1ACBoJOH008795
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 12:50:19 +0100
Received: from md2dvrtc.fritz.box ([167.87.35.150])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1ACBoHAl023845;
	Fri, 12 Nov 2021 12:50:19 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 5/8] Create an read-only rootfs with
 dm-verity
Date: Fri, 12 Nov 2021 12:50:14 +0100
Message-Id: <20211112115017.401779-7-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211112115017.401779-1-Quirin.Gylstorff@siemens.com>
References: <20211112115017.401779-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Nov 2021 11:50:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6886

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This root file system supports SWUpdate and secure boot.
We need a writable /tmp and /var for a boot without error messages.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/wic-verity-img.bbclass                |  8 ++++-
 kas/opt/verity.yml                            | 34 +++++++++++++++++++
 .../images/cip-core-image-read-only.bb        | 24 +++++++++++++
 recipes-core/tmp-fs/files/postinst            |  3 ++
 recipes-core/tmp-fs/files/tmp.mount           | 11 ++++++
 recipes-core/tmp-fs/tmp-fs_0.1.bb             |  9 +++++
 wic/qemu-amd64-read-only.wks.in               | 13 +++++++
 7 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 kas/opt/verity.yml
 create mode 100644 recipes-core/images/cip-core-image-read-only.bb
 create mode 100755 recipes-core/tmp-fs/files/postinst
 create mode 100644 recipes-core/tmp-fs/files/tmp.mount
 create mode 100644 recipes-core/tmp-fs/tmp-fs_0.1.bb
 create mode 100644 wic/qemu-amd64-read-only.wks.in

diff --git a/classes/wic-verity-img.bbclass b/classes/wic-verity-img.bbclass
index e185cf8..9b8a79e 100644
--- a/classes/wic-verity-img.bbclass
+++ b/classes/wic-verity-img.bbclass
@@ -12,6 +12,12 @@
 inherit squashfs-img
 inherit verity-img
 inherit wic-img
+inherit extract-partition
+inherit swupdate-img
 
-addtask verity_image after do_squashfs_image
+SOURCE_IMAGE_FILE = "${WIC_IMAGE_FILE}"
+
+addtask do_verity_image after do_squashfs_image
 addtask do_wic_image after do_verity_image
+addtask do_extract_partition after do_wic_image
+addtask do_swupdate_image after do_extract_partition
diff --git a/kas/opt/verity.yml b/kas/opt/verity.yml
new file mode 100644
index 0000000..088f44a
--- /dev/null
+++ b/kas/opt/verity.yml
@@ -0,0 +1,34 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2020
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+# This kas file creates a image with a read-only rootfs
+# and secure-boot
+
+header:
+  version: 10
+  includes:
+   - efibootguard.yml
+
+target: cip-core-image-read-only
+
+local_conf_header:
+  verity-img: |
+    IMAGE_TYPE = "wic-verity-img"
+    WKS_FILE = "${MACHINE}-read-only.wks.in"
+    VERITY_IMAGE_TYPE = "squashfs"
+  swupdate: |
+    IMAGE_INSTALL_append = " swupdate"
+    IMAGE_INSTALL_append = " swupdate-handler-roundrobin"
+    SWU_DESCRIPTION = "secureboot"
+    SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG = "secureboot/swupdate.handler.${SWUPDATE_BOOTLOADER}.ini"
+  secure-boot: |
+    # Add snakeoil and ovmf binaries for qemu
+    IMAGER_BUILD_DEPS += "ebg-secure-boot-snakeoil ovmf-binaries"
+    IMAGER_INSTALL += "ebg-secure-boot-snakeoil"
diff --git a/recipes-core/images/cip-core-image-read-only.bb b/recipes-core/images/cip-core-image-read-only.bb
new file mode 100644
index 0000000..24ace3c
--- /dev/null
+++ b/recipes-core/images/cip-core-image-read-only.bb
@@ -0,0 +1,24 @@
+require cip-core-image.bb
+
+INITRAMFS_RECIPE = "cip-core-initramfs"
+INITRD_IMAGE = "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
+do_wic_image[depends] += "${INITRAMFS_RECIPE}:do_build"
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
diff --git a/wic/qemu-amd64-read-only.wks.in b/wic/qemu-amd64-read-only.wks.in
new file mode 100644
index 0000000..c4ea0c8
--- /dev/null
+++ b/wic/qemu-amd64-read-only.wks.in
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


