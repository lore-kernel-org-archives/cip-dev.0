Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F07C4707A
	for <webhook@archiver.kernel.org>; Tue, 19 Apr 2022 17:48:47 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web08.1387.1650384423096486753
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Apr 2022 09:07:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=jlpOH+Ra;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226,
 mailfrom: fm-294854-202204191606594111a61313db6640ec-usukku@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 202204191606594111a61313db6640ec
        for <cip-dev@lists.cip-project.org>;
        Tue, 19 Apr 2022 18:07:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=MEQHPFoVUTyR9c3RGz46MbfJnoGDZWiBQLofLmUz97M=;
 b=jlpOH+Rag3I/WIZl0OjceTGroOjIRuyL0UYgMYx+1rOH5fS8gG+tINWNXPERcTCn4LuHZm
 M8Lf2SamKqZgIF5zb0Cy293nlxPQ5jCQbr3PqtVBM3T7Bt/iPW7cwyHvfEBcZoq4U85GijxW
 NXE3OEHwm86Ka8muLRPqUXwzCwSp4=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 3/5] swupdate: Make rootfs read-only also in
 non-secure setup
Date: Tue, 19 Apr 2022 18:06:56 +0200
Message-Id: 
 <35eb6427e61911e9b209169271a043c9ebafa76a.1650384418.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1650384418.git.jan.kiszka@siemens.com>
References: <cover.1650384418.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Apr 2022 17:48:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8111

From: Jan Kiszka <jan.kiszka@siemens.com>

This is more logical because the rootfs is going to be overwritten
completely on updates. Everything that is supposed to stay should go
into the overlays.

Along this, wic-swu-img.bbclass is aligned to its big brother
secure-wic-swu-img.bbclass pulling the image include read-only.inc in.

To reduce the (already existing) duplication between
qemu-amd64-efibootguard.wks.in and simatic-ipc227e-efibootguard.wks.in,
replace both by a link to a common wks file.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/wic-swu-img.bbclass             | 23 +++++++++++++++++++
 kas/opt/ebg-secure-boot-snakeoil.yml    |  7 +++---
 kas/opt/efibootguard.yml                |  2 +-
 kas/opt/swupdate.yml                    |  2 +-
 recipes-core/images/read-only.inc       | 30 -------------------------
 wic/qemu-amd64-efibootguard.wks         |  6 -----
 wic/qemu-amd64-efibootguard.wks.in      |  1 +
 wic/simatic-ipc227e-efibootguard.wks    |  7 ------
 wic/simatic-ipc227e-efibootguard.wks.in |  1 +
 wic/swupdate-partition.inc              |  2 --
 wic/x86-efibootguard.wks.in             | 13 +++++++++++
 11 files changed, 43 insertions(+), 51 deletions(-)
 delete mode 100644 recipes-core/images/read-only.inc
 delete mode 100644 wic/qemu-amd64-efibootguard.wks
 create mode 120000 wic/qemu-amd64-efibootguard.wks.in
 delete mode 100644 wic/simatic-ipc227e-efibootguard.wks
 create mode 120000 wic/simatic-ipc227e-efibootguard.wks.in
 delete mode 100644 wic/swupdate-partition.inc
 create mode 100644 wic/x86-efibootguard.wks.in

diff --git a/classes/wic-swu-img.bbclass b/classes/wic-swu-img.bbclass
index f03befa..231b249 100644
--- a/classes/wic-swu-img.bbclass
+++ b/classes/wic-swu-img.bbclass
@@ -9,7 +9,30 @@
 # SPDX-License-Identifier: MIT
 #
 
+SQUASHFS_EXCLUDE_DIRS += "home var"
+
+inherit squashfs-img
 inherit wic-img
 inherit swupdate-img
 
+IMAGE_INSTALL += "etc-overlay-fs"
+IMAGE_INSTALL += "home-fs"
+IMAGE_INSTALL += "tmp-fs"
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
+
+addtask do_wic_image after do_squashfs_image
+
 addtask do_swupdate_image after do_wic_image
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index be58b15..14a5d6a 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -15,15 +15,14 @@ header:
    - kas/opt/efibootguard.yml
 
 local_conf_header:
-  image-options-swupdate-ro: |
-    CIP_IMAGE_OPTIONS_append = " swupdate.inc read-only.inc"
+  image-options-swupdate: |
+    CIP_IMAGE_OPTIONS_append = " swupdate.inc"
 
   swupdate: |
     IMAGE_INSTALL_append = " swupdate"
     IMAGE_INSTALL_append = " swupdate-handler-roundrobin"
 
-  verity-img: |
-    SECURE_IMAGE_FSTYPE = "squashfs"
+  secure-boot-image: |
     IMAGE_FSTYPES = "secure-wic-swu-img"
     WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
 
diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
index 0502b9c..ce89756 100644
--- a/kas/opt/efibootguard.yml
+++ b/kas/opt/efibootguard.yml
@@ -25,7 +25,7 @@ local_conf_header:
     WDOG_TIMEOUT ?= "60"
     WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE"
     IMAGE_FSTYPES ?= "wic-img"
-    WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
+    WKS_FILE ?= "${MACHINE}-efibootguard.wks.in"
 
   ovmf-binaries: |
     # Add ovmf binaries for qemu
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index 1b2aff4..31cd0d1 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -24,4 +24,4 @@ local_conf_header:
 
   wic-swu: |
     IMAGE_FSTYPES = "wic-swu-img"
-    WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
+    WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
diff --git a/recipes-core/images/read-only.inc b/recipes-core/images/read-only.inc
deleted file mode 100644
index c031e39..0000000
--- a/recipes-core/images/read-only.inc
+++ /dev/null
@@ -1,30 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2021
-#
-# Authors:
-#  Quirin Gylstorff <Quriin.Gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-SQUASHFS_EXCLUDE_DIRS += "home var"
-
-IMAGE_INSTALL += "etc-overlay-fs"
-IMAGE_INSTALL += "home-fs"
-IMAGE_INSTALL += "tmp-fs"
-
-image_configure_fstab() {
-    sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
-# Begin /etc/fstab
-/dev/root	/		auto		defaults,ro			0	0
-LABEL=var	/var		auto		defaults			0	0
-proc		/proc		proc		nosuid,noexec,nodev		0	0
-sysfs		/sys		sysfs		nosuid,noexec,nodev		0	0
-devpts		/dev/pts	devpts		gid=5,mode=620			0	0
-tmpfs		/run		tmpfs		nodev,nosuid,size=500M,mode=755	0	0
-devtmpfs	/dev		devtmpfs	mode=0755,nosuid		0	0
-# End /etc/fstab
-EOF
-}
diff --git a/wic/qemu-amd64-efibootguard.wks b/wic/qemu-amd64-efibootguard.wks
deleted file mode 100644
index 6653068..0000000
--- a/wic/qemu-amd64-efibootguard.wks
+++ /dev/null
@@ -1,6 +0,0 @@
-# short-description: Qemu-amd64 with Efibootguard and SWUpdate
-# long-description: Disk image for qemu-amd64 with EFI Boot Guard and SWUpdate
-include ebg-sysparts.inc
-include swupdate-partition.inc
-
-bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk"
diff --git a/wic/qemu-amd64-efibootguard.wks.in b/wic/qemu-amd64-efibootguard.wks.in
new file mode 120000
index 0000000..b3a73fa
--- /dev/null
+++ b/wic/qemu-amd64-efibootguard.wks.in
@@ -0,0 +1 @@
+x86-efibootguard.wks.in
\ No newline at end of file
diff --git a/wic/simatic-ipc227e-efibootguard.wks b/wic/simatic-ipc227e-efibootguard.wks
deleted file mode 100644
index f6191bc..0000000
--- a/wic/simatic-ipc227e-efibootguard.wks
+++ /dev/null
@@ -1,7 +0,0 @@
-# short-description: Simatic-ipc227e with EFI Boot Guard and SWUpdate
-# long-description: Disk image for Simatic-ipc227e with EFI Boot Guard and SWUpdate
-
-include ebg-sysparts.inc
-include swupdate-partition.inc
-
-bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk"
diff --git a/wic/simatic-ipc227e-efibootguard.wks.in b/wic/simatic-ipc227e-efibootguard.wks.in
new file mode 120000
index 0000000..b3a73fa
--- /dev/null
+++ b/wic/simatic-ipc227e-efibootguard.wks.in
@@ -0,0 +1 @@
+x86-efibootguard.wks.in
\ No newline at end of file
diff --git a/wic/swupdate-partition.inc b/wic/swupdate-partition.inc
deleted file mode 100644
index 6912542..0000000
--- a/wic/swupdate-partition.inc
+++ /dev/null
@@ -1,2 +0,0 @@
-part --source rootfs --uuid "fedcba98-7654-3210-cafe-5e0710000001" --size 1000M   --extra-space 128M --overhead-factor 1 --label systema --align 1024 --fstype=ext4 --mkfs-extraopts "-T default"
-part  --source rootfs --uuid "fedcba98-7654-3210-cafe-5e0710000002" --size 1000M   --extra-space 128M --overhead-factor 1 --label systemb --align 1024 --fstype=ext4 --mkfs-extraopts "-T default"
diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
new file mode 100644
index 0000000..f60ebcf
--- /dev/null
+++ b/wic/x86-efibootguard.wks.in
@@ -0,0 +1,13 @@
+# short-description: x86 with EFI Boot Guard and SWUpdate
+# long-description: Disk image for x86 machines with EFI Boot Guard and SWUpdate
+
+include ebg-sysparts.inc
+
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
+
+# home and var are extra partitions
+part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
+part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G
+
+bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk"
-- 
2.34.1


