Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F168CCA484
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 10:08:20 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.10455.1654596491768362113
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jun 2022 03:08:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1
 header.b=Gysm+bp/;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-51332-2022060710080840ec878607639b7c0c-guhf9x@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 2022060710080840ec878607639b7c0c
        for <cip-dev@lists.cip-project.org>;
        Tue, 07 Jun 2022 12:08:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=rFNJBtJw3b7CVzwfLmApmBqE4cPazOVsZW3l1r/BYAg=;
 b=Gysm+bp/jNLP4ROxrj/Q5i4d3OgFoyalUUwbk65rCYO8PUnj4UVdj2mmIlUDQNL+ky7Zli
 ZnCRTxkH7tn7GeLtYcJtXkEIg8Oh/Gj0WFLtc3pAig2Ljpi6gL+8+ilJG7D/Eneftivkia0b
 RvwYcXRo+xIKIOKfTOXGm8OLiVeHo=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	adriaan.schmidt@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v2 3/4] Adapt swupdate and verity to use
 new IMAGE_CMD_*
Date: Tue,  7 Jun 2022 12:08:05 +0200
Message-Id: <20220607100806.133889-4-Quirin.Gylstorff@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8505

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The image types wic-swu-img and secure-wic-swu-img were removed.
Rename `squashfs-img` to squashfs according new naming scheme.

To use squashfs include:

    IMAGE_CLASSES += "squashfs"
    IMAGE_TYPEDEP_wic += "squashfs"

The modifications for a read-only root file system are now part
of a bbclass which can be include directly into the image
recipe.

The modifications to generate a SWUpdate update package are
also no longer part of the image build process and in a seperate
bbclass. This class needs to be included in the image recipe.

To create a verity based image to following line need to be added
to the local.conf or similar configuration:

    IMAGE_CLASSES += "verity"

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ...u-img.bbclass => read-only-rootfs.bbclass} | 11 +---
 classes/secure-wic-swu-img.bbclass            | 15 ------
 ...{squashfs-img.bbclass => squashfs.bbclass} | 15 ++----
 ...{swupdate-img.bbclass => swupdate.bbclass} |  8 +--
 .../{verity-img.bbclass => verity.bbclass}    | 50 +++++++++----------
 kas/opt/ebg-secure-boot-snakeoil.yml          |  3 +-
 kas/opt/swupdate.yml                          |  2 +
 recipes-core/images/swupdate.inc              |  7 ++-
 .../initramfs-verity-hook_0.1.bb              |  2 +-
 wic/qemu-amd64-efibootguard-secureboot.wks.in |  4 +-
 wic/qemu-arm64-efibootguard-secureboot.wks.in |  4 +-
 wic/x86-efibootguard.wks.in                   |  4 +-
 12 files changed, 51 insertions(+), 74 deletions(-)
 rename classes/{wic-swu-img.bbclass => read-only-rootfs.bbclass} (75%)
 delete mode 100644 classes/secure-wic-swu-img.bbclass
 rename classes/{squashfs-img.bbclass => squashfs.bbclass} (66%)
 rename classes/{swupdate-img.bbclass => swupdate.bbclass} (92%)
 rename classes/{verity-img.bbclass => verity.bbclass} (78%)

diff --git a/classes/wic-swu-img.bbclass b/classes/read-only-rootfs.bbclass
similarity index 75%
rename from classes/wic-swu-img.bbclass
rename to classes/read-only-rootfs.bbclass
index 41b2164..6f91f66 100644
--- a/classes/wic-swu-img.bbclass
+++ b/classes/read-only-rootfs.bbclass
@@ -9,16 +9,10 @@
 # SPDX-License-Identifier: MIT
 #
 
-SQUASHFS_EXCLUDE_DIRS += "home var"
-
-inherit squashfs-img
-inherit wic-img
-inherit swupdate-img
-
 INITRAMFS_RECIPE ?= "cip-core-initramfs"
 INITRD_IMAGE = "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
 
-do_wic_image[depends] += "${INITRAMFS_RECIPE}:do_build"
+do_image_wic[depends] += "${INITRAMFS_RECIPE}:do_build"
 
 IMAGE_INSTALL += "home-fs"
 IMAGE_INSTALL += "tmp-fs"
@@ -37,6 +31,3 @@ devtmpfs	/dev		devtmpfs	mode=0755,nosuid		0	0
 EOF
 }
 
-addtask do_wic_image after do_squashfs_image
-
-addtask do_swupdate_image after do_wic_image
diff --git a/classes/secure-wic-swu-img.bbclass b/classes/secure-wic-swu-img.bbclass
deleted file mode 100644
index 5e8e48a..0000000
--- a/classes/secure-wic-swu-img.bbclass
+++ /dev/null
@@ -1,15 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2021-2022
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-inherit verity-img
-inherit wic-swu-img
-
-addtask do_wic_image after do_verity_image
diff --git a/classes/squashfs-img.bbclass b/classes/squashfs.bbclass
similarity index 66%
rename from classes/squashfs-img.bbclass
rename to classes/squashfs.bbclass
index c22d7d6..376ddfe 100644
--- a/classes/squashfs-img.bbclass
+++ b/classes/squashfs.bbclass
@@ -9,9 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-SQUASHFS_IMAGE_FILE = "${IMAGE_FULLNAME}.squashfs.img"
-
-IMAGER_INSTALL += "squashfs-tools"
+IMAGER_INSTALL_squashfs += "squashfs-tools"
 
 SQUASHFS_EXCLUDE_DIRS ?= ""
 SQUASHFS_CONTENT ?= "${PP_ROOTFS}"
@@ -29,14 +27,11 @@ python __anonymous() {
     d.appendVar('SQUASHFS_CREATION_ARGS', args)
 }
 
-do_squashfs_image[dirs] = "${DEPLOY_DIR_IMAGE}"
-do_squashfs_image() {
+IMAGE_CMD_squashfs[depends] = "${PN}:do_transform_template"
+IMAGE_CMD_squashfs() {
     rm -f '${DEPLOY_DIR_IMAGE}/${SQUASHFS_IMAGE_FILE}'
 
-    image_do_mounts
-
-    sudo chroot "${BUILDCHROOT_DIR}" /bin/mksquashfs  \
-        "${SQUASHFS_CONTENT}" "${PP_DEPLOY}/${SQUASHFS_IMAGE_FILE}" \
+    ${SUDO_CHROOT} /bin/mksquashfs \
+        '${SQUASHFS_CONTENT}' '${IMAGE_FILE_CHROOT}' \
         ${SQUASHFS_CREATION_ARGS}
 }
-addtask do_squashfs_image before do_image after do_image_tools do_excl_directories
diff --git a/classes/swupdate-img.bbclass b/classes/swupdate.bbclass
similarity index 92%
rename from classes/swupdate-img.bbclass
rename to classes/swupdate.bbclass
index 1437c07..c3fc303 100644
--- a/classes/swupdate-img.bbclass
+++ b/classes/swupdate.bbclass
@@ -18,9 +18,9 @@ SWU_SIGNATURE_TYPE ?= "rsa"
 
 IMAGER_INSTALL += "${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 
-do_swupdate_image[stamp-extra-info] = "${DISTRO}-${MACHINE}"
-do_swupdate_image[cleandirs] += "${WORKDIR}/swu"
-do_swupdate_image() {
+do_swupdate_binary[stamp-extra-info] = "${DISTRO}-${MACHINE}"
+do_swupdate_binary[cleandirs] += "${WORKDIR}/swu"
+do_swupdate_binary() {
     rm -f '${SWU_IMAGE_FILE}'
     cp '${WORKDIR}/${SWU_DESCRIPTION_FILE}' '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
 
@@ -91,4 +91,4 @@ do_swupdate_image() {
     cd -
 }
 
-addtask swupdate_image before do_build after do_copy_boot_files do_install_imager_deps do_transform_template
+addtask swupdate_binary before do_build after do_deploy do_copy_boot_files do_install_imager_deps do_transform_template
diff --git a/classes/verity-img.bbclass b/classes/verity.bbclass
similarity index 78%
rename from classes/verity-img.bbclass
rename to classes/verity.bbclass
index b7d7f08..0f154fb 100644
--- a/classes/verity-img.bbclass
+++ b/classes/verity.bbclass
@@ -11,10 +11,14 @@
 
 VERITY_IMAGE_TYPE ?= "squashfs"
 
-inherit ${VERITY_IMAGE_TYPE}-img
+inherit ${VERITY_IMAGE_TYPE}
 
-VERITY_INPUT_IMAGE ?= "${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.img"
-VERITY_OUTPUT_IMAGE ?= "${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img"
+IMAGE_TYPEDEP_verity = "${VERITY_IMAGE_TYPE}"
+IMAGE_TYPEDEP_wic += "verity"
+IMAGER_INSTALL_verity += "cryptsetup"
+
+VERITY_INPUT_IMAGE ?= "${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}"
+VERITY_OUTPUT_IMAGE ?= "${IMAGE_FULLNAME}.verity"
 VERITY_IMAGE_METADATA = "${VERITY_OUTPUT_IMAGE}.metadata"
 VERITY_HASH_BLOCK_SIZE ?= "1024"
 VERITY_DATA_BLOCK_SIZE ?= "1024"
@@ -37,14 +41,28 @@ create_verity_env_file() {
     done < $input
 }
 
-verity_setup() {
+python calculate_verity_data_blocks() {
+    import os
+
+    image_file = os.path.join(
+        d.getVar("DEPLOY_DIR_IMAGE"),
+        d.getVar("VERITY_INPUT_IMAGE")
+    )
+    data_block_size = int(d.getVar("VERITY_DATA_BLOCK_SIZE"))
+    size = os.stat(image_file).st_size
+    assert size % data_block_size == 0, f"image is not well-sized!"
+    d.setVar("VERITY_INPUT_IMAGE_SIZE", str(size))
+    d.setVar("VERITY_DATA_BLOCKS", str(size // data_block_size))
+}
+do_image_verity[cleandirs] = "${WORKDIR}/verity"
+do_image_verity[prefuncs] = "calculate_verity_data_blocks"
+IMAGE_CMD_verity() {
     rm -f ${DEPLOY_DIR_IMAGE}/${VERITY_OUTPUT_IMAGE}
     rm -f ${WORKDIR}/${VERITY_IMAGE_METADATA}
 
     cp -a ${DEPLOY_DIR_IMAGE}/${VERITY_INPUT_IMAGE} ${DEPLOY_DIR_IMAGE}/${VERITY_OUTPUT_IMAGE}
 
-    image_do_mounts
-    sudo chroot "${BUILDCHROOT_DIR}" /sbin/veritysetup format \
+    ${SUDO_CHROOT} /sbin/veritysetup format \
         --hash-block-size "${VERITY_HASH_BLOCK_SIZE}"  \
         --data-block-size "${VERITY_DATA_BLOCK_SIZE}"  \
         --data-blocks "${VERITY_DATA_BLOCKS}" \
@@ -55,23 +73,5 @@ verity_setup() {
 
     echo "Hash offset:    	${VERITY_INPUT_IMAGE_SIZE}" \
         >>"${WORKDIR}/${VERITY_IMAGE_METADATA}"
+    create_verity_env_file
 }
-
-do_verity_image[cleandirs] = "${WORKDIR}/verity"
-python do_verity_image() {
-    import os
-
-    image_file = os.path.join(
-        d.getVar("DEPLOY_DIR_IMAGE"),
-        d.getVar("VERITY_INPUT_IMAGE")
-    )
-    data_block_size = int(d.getVar("VERITY_DATA_BLOCK_SIZE"))
-    size = os.stat(image_file).st_size
-    assert size % data_block_size == 0, f"image is not well-sized!"
-    d.setVar("VERITY_INPUT_IMAGE_SIZE", str(size))
-    d.setVar("VERITY_DATA_BLOCKS", str(size // data_block_size))
-
-    bb.build.exec_func('verity_setup', d)
-    bb.build.exec_func('create_verity_env_file', d)
-}
-addtask verity_image before do_image after do_${VERITY_IMAGE_TYPE}_image
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index 3f2a794..2822cef 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -23,7 +23,8 @@ local_conf_header:
     IMAGE_INSTALL_append = " swupdate-handler-roundrobin"
 
   secure-boot-image: |
-    IMAGE_FSTYPES = "secure-wic-swu-img"
+    IMAGE_CLASSES += "verity"
+    IMAGE_FSTYPES = "wic"
     WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
     INITRAMFS_INSTALL_append = " initramfs-verity-hook"
 
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index 72429c6..c2bd15c 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -23,5 +23,7 @@ local_conf_header:
     CIP_IMAGE_OPTIONS_append = " swupdate.inc"
 
   wic-swu: |
+    IMAGE_CLASSES += "squashfs"
+    IMAGE_TYPEDEP_wic += "squashfs"
     IMAGE_FSTYPES = "wic"
     WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 64887df..e0252df 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -9,9 +9,12 @@
 # SPDX-License-Identifier: MIT
 #
 
-FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
+inherit swupdate
+inherit read-only-rootfs
+
+ROOTFS_PARTITION_NAME = "${IMAGE_FULLNAME}.wic.p4.gz"
 
-ROOTFS_PARTITION_NAME = "${IMAGE_FULLNAME}.wic.img.p4.gz"
+FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
 
 SRC_URI += "file://sw-description.tmpl"
 TEMPLATE_FILES += "sw-description.tmpl"
diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
index f0d2d68..60ee8da 100644
--- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
@@ -28,7 +28,7 @@ VERITY_IMAGE_RECIPE ?= "cip-core-image"
 
 VERITY_ENV_FILE = "${DEPLOY_DIR_IMAGE}/${VERITY_IMAGE_RECIPE}-${DISTRO}-${MACHINE}.verity.env"
 
-do_install[depends] += "${VERITY_IMAGE_RECIPE}:do_verity_image"
+do_install[depends] += "${VERITY_IMAGE_RECIPE}:do_image_verity"
 do_install[cleandirs] += " \
     ${D}/usr/share/initramfs-tools/hooks \
     ${D}/usr/share/verity-env \
diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
index e097eac..0e298bc 100644
--- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
@@ -1,7 +1,7 @@
 include ebg-signed-sysparts.inc
 
-part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
-part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
 
 # home and var are extra partitions
 part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
index b3bbed4..3b8dadd 100644
--- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
@@ -1,7 +1,7 @@
 include ebg-signed-sysparts.inc
 
-part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
-part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
 
 # home and var are extra partitions
 part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
index f60ebcf..c71253d 100644
--- a/wic/x86-efibootguard.wks.in
+++ b/wic/x86-efibootguard.wks.in
@@ -3,8 +3,8 @@
 
 include ebg-sysparts.inc
 
-part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
-part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
 
 # home and var are extra partitions
 part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
-- 
2.35.1


