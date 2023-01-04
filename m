Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA31C4332F
	for <webhook@archiver.kernel.org>; Wed,  4 Jan 2023 12:37:12 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.3112.1672801360410240668
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jan 2023 19:02:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=J4RXK+rC;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-72506-202301040302370c30d3413053d7ca04-zw_zun@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202301040302370c30d3413053d7ca04
        for <cip-dev@lists.cip-project.org>;
        Wed, 04 Jan 2023 04:02:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=jwfEq99j9D1HNHIh0NS2dIB8mwiAM1/ps+fQC4RMFhc=;
 b=J4RXK+rCRcAFIRlNmZPo0/J2qOpcm60Njxtdc+zwqlmc6IRyf2tnPuGzy5YvnEmU0ufgGV
 o8n7BiH0qSvNjk9d7izXzMn2on7iMzEZpTBEHW5ayaf0P9HSEPaNlfAMYEe7ZMcPcL08+isV
 aQ3+oD2+OUWlZ0gRlNLW2Pv+dk7c8=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	tengfei.wu@siemens.com,
	daniel.bovensiepen@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/1] Use global variables for abrootfs partition uuids
Date: Wed,  4 Jan 2023 03:02:14 +0000
Message-Id: <20230104030214.465039-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jan 2023 12:37:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10299

This patch converts the abrootfs partition uuids to a template and adds
two global variables to control their values. By that, the partition
uuids used in the WIC files can be kept in sync with the uuids used in
the sw-description file. This helps to avoid issues where the part uuids
are inconsistent and hence the update using swupdate fails.

To help users migrate, we also add a check for the validity of the UUIDs
added to ABROOTFS_PART_UUID_(A|B).

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 kas/opt/swupdate.yml                          |  2 ++
 recipes-core/images/files/sw-description.tmpl |  2 +-
 recipes-core/images/swupdate.inc              | 19 +++++++++++++++++++
 wic/bbb-efibootguard.wks.in                   |  4 ++--
 wic/qemu-amd64-efibootguard-secureboot.wks.in |  4 ++--
 wic/qemu-arm64-efibootguard-secureboot.wks.in |  4 ++--
 wic/qemu-arm64-efibootguard.wks.in            |  4 ++--
 wic/x86-efibootguard.wks.in                   |  4 ++--
 8 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index f0d3f1b..60a4aec 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -25,3 +25,5 @@ local_conf_header:
     WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
     INITRAMFS_INSTALL_append = " initramfs-squashfs-hook"
     WIC_DEPLOY_PARTITIONS = "1"
+    ABROOTFS_PART_UUID_A ?= "fedcba98-7654-3210-cafe-5e0710000001"
+    ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
diff --git a/recipes-core/images/files/sw-description.tmpl b/recipes-core/images/files/sw-description.tmpl
index f7105c7..05125e6 100644
--- a/recipes-core/images/files/sw-description.tmpl
+++ b/recipes-core/images/files/sw-description.tmpl
@@ -14,7 +14,7 @@ software =
     name = "cip software update";
     images: ({
             filename = "${ROOTFS_PARTITION_NAME}";
-            device = "C:BOOT0:linux.efi->fedcba98-7654-3210-cafe-5e0710000001,C:BOOT1:linux.efi->fedcba98-7654-3210-cafe-5e0710000002";
+            device = "C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOTFS_PART_UUID_B}";
             type = "roundrobin";
             compressed = "zlib";
             filesystem = "ext4";
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 0ba3a0e..f98082c 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -16,6 +16,11 @@ inherit read-only-rootfs
 IMAGE_INSTALL += " swupdate"
 IMAGE_INSTALL += " swupdate-handler-roundrobin"
 
+# The uuids correspond to the partition uuids
+# in the wic script. Set via machine or local config.
+ABROOTFS_PART_UUID_A ??= ""
+ABROOTFS_PART_UUID_B ??= ""
+
 ROOTFS_PARTITION_NAME = "${IMAGE_FULLNAME}.wic.p4.gz"
 
 FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
@@ -29,3 +34,17 @@ addtask do_transform_template before do_swupdate_binary after do_generate_image_
 TEMPLATE_VARS += "ROOTFS_PARTITION_NAME TARGET_IMAGE_UUID"
 
 SWU_ADDITIONAL_FILES += "linux.efi ${ROOTFS_PARTITION_NAME}"
+
+python() {
+    import uuid
+    def is_valid(value):
+        try:
+            uuid.UUID(value)
+        except ValueError:
+            return False
+        return True
+
+    for u in ['A', 'B']:
+        if not is_valid(d.getVar('ABROOTFS_PART_UUID_' + u)):
+            bb.fatal('ABROOTFS_PART_UUID_' + u + ' is not a valid UUID')
+}
diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-efibootguard.wks.in
index e48cc7f..a714694 100644
--- a/wic/bbb-efibootguard.wks.in
+++ b/wic/bbb-efibootguard.wks.in
@@ -11,8 +11,8 @@ part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/u-boot.img" --no-
 
 include ebg-sysparts.inc
 
-part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
-part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
 
 # home and var are extra partitions
 part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
index 0e298bc..8305ebd 100644
--- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
@@ -1,7 +1,7 @@
 include ebg-signed-sysparts.inc
 
-part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
-part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
 
 # home and var are extra partitions
 part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
index 3b8dadd..6b01443 100644
--- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
@@ -1,7 +1,7 @@
 include ebg-signed-sysparts.inc
 
-part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
-part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
 
 # home and var are extra partitions
 part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
index 9ff03e1..bc684f3 100644
--- a/wic/qemu-arm64-efibootguard.wks.in
+++ b/wic/qemu-arm64-efibootguard.wks.in
@@ -3,8 +3,8 @@
 
 include ebg-sysparts.inc
 
-part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
-part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
 
 # home and var are extra partitions
 part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
index c71253d..0604deb 100644
--- a/wic/x86-efibootguard.wks.in
+++ b/wic/x86-efibootguard.wks.in
@@ -3,8 +3,8 @@
 
 include ebg-sysparts.inc
 
-part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
-part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
 
 # home and var are extra partitions
 part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
-- 
2.34.1


