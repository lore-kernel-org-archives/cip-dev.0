Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA82D5CCA6
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 11:52:02 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.13027.1730289112085161662
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Oct 2024 04:51:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=H4/TRmJg;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-202410301151486cd81627cc9a4dad47-_ttyqn@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202410301151486cd81627cc9a4dad47
        for <cip-dev@lists.cip-project.org>;
        Wed, 30 Oct 2024 12:51:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=y+wQn2Z49zpMpksHHOpRRL6r5tdWj4PNXhC1RMS8VJg=;
 b=H4/TRmJgHYKYGcHXGOaPAsKtnQSL9xpmNYq+OyXOcy9hEzYsDR1X2c2I+Aaore7yLEB15m
 sl7sfRQeVCYPq2EOL1JZMRY2289PL2vzYC0isVy/XwfPk4HGOauhTgj/6QKMFkOjLfETGoDL
 gobVOaoqeXidNEt5HQUYmVC8gkf86D+CdoAobJZkqfP62jnI4Tbhaej/x8I7hmjUtSGu5gU6
 JMW9o2nGmAqnSdKs+SzSPLE3gyDzPqe0Y5LJqQrDI7t6MAvAJPpDqoZPQcFpfLfO0pmNy5TT
 9uk0cWLt3UgcIgHWVFux8Ru/av6b0k85vQ1hZHZXdfOePM1vI1+V3t3Q==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 1/6] Make the read-only rootfs type configurable
Date: Wed, 30 Oct 2024 12:51:42 +0100
Message-ID: <3ab00a7235d5cc5c359b91566e69745a06f966a0.1730289107.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730289107.git.jan.kiszka@siemens.com>
References: <cover.1730289107.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Oct 2024 11:52:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17114

From: Jan Kiszka <jan.kiszka@siemens.com>

We so far use squashfs here and will keep that as default. But there
will be an option in the future to select EROFS as alternative. Prepare
for that.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/swupdate.bbclass             | 3 ++-
 classes/verity.bbclass               | 2 +-
 conf/distro/cip-core-common.inc      | 4 +++-
 kas/opt/swupdate.yml                 | 8 ++++----
 wic/bbb-efibootguard.wks.in          | 2 +-
 wic/hihope-rzg2m-efibootguard.wks.in | 2 +-
 wic/qemu-arm64-efibootguard.wks.in   | 2 +-
 wic/qemu-riscv64-efibootguard.wks.in | 2 +-
 wic/x86-uefi-efibootguard.wks.in     | 2 +-
 9 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 642fd795..5bf021ad 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -12,7 +12,7 @@
 
 inherit template
 
-SWU_ROOTFS_TYPE ?= "squashfs"
+SWU_ROOTFS_TYPE ?= "${RO_ROOTFS_TYPE}"
 SWU_ROOTFS_NAME ?= "${IMAGE_FULLNAME}"
 # compression type as defined by swupdate (zlib or zstd). Set to empty string to disable compression
 SWU_COMPRESSION_TYPE ?= "zlib"
@@ -55,6 +55,7 @@ IMAGE_SRC_URI:swu += "file://${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
 IMAGE_TEMPLATE_FILES:swu = "${SWU_DESCRIPTION_FILE}.tmpl"
 IMAGE_TEMPLATE_FILES:swu += "${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
 IMAGE_TEMPLATE_VARS:swu = " \
+    RO_ROOTFS_TYPE \
     SWU_ROOTFS_ARTIFACT_NAME \
     TARGET_IMAGE_UUID \
     ABROOTFS_PART_UUID_A \
diff --git a/classes/verity.bbclass b/classes/verity.bbclass
index b3aa9732..231d1729 100644
--- a/classes/verity.bbclass
+++ b/classes/verity.bbclass
@@ -12,7 +12,7 @@
 IMAGE_TYPEDEP:verity = "${VERITY_IMAGE_TYPE}"
 IMAGER_INSTALL:verity += "cryptsetup"
 
-VERITY_IMAGE_TYPE ?= "squashfs"
+VERITY_IMAGE_TYPE ?= "${RO_ROOTFS_TYPE}"
 VERITY_INPUT_IMAGE ?= "${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}"
 VERITY_OUTPUT_IMAGE ?= "${IMAGE_FULLNAME}.verity"
 VERITY_IMAGE_METADATA = "${VERITY_OUTPUT_IMAGE}.metadata"
diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
index 4bd4b840..3323dd0b 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019-2023
+# Copyright (c) Siemens AG, 2019-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -15,6 +15,8 @@ WKS_FILE ?= "${MACHINE}.wks"
 
 CIP_IMAGE_OPTIONS ?= ""
 
+RO_ROOTFS_TYPE ?= "squashfs"
+
 IMAGER_BUILD_DEPS:append = " dosfstools-native"
 IMAGER_BUILD_DEPS:remove:buster = "dosfstools-native"
 
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index 73982000..837efa7d 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2020
+# Copyright (c) Siemens AG, 2020-2024
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -20,12 +20,12 @@ local_conf_header:
     OVERRIDES .= ":swupdate"
 
   wic-swu: |
-    IMAGE_TYPEDEP:wic += "squashfs"
+    IMAGE_TYPEDEP:wic += "${RO_ROOTFS_TYPE}"
     IMAGE_FSTYPES:append = " swu"
-    # squashfs is already compressed
+    # input is already compressed
     SWU_COMPRESSION_TYPE = ""
     WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
-    INITRAMFS_INSTALL:append = " initramfs-squashfs-hook"
+    INITRAMFS_INSTALL:append = " initramfs-${RO_ROOTFS_TYPE}-hook"
     ABROOTFS_PART_UUID_A ?= "fedcba98-7654-3210-cafe-5e0710000001"
     ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
     PREFERRED_PROVIDER_swupdate-certificates-key ??= "swupdate-certificates-key-snakeoil"
diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-efibootguard.wks.in
index b5772c2d..e6c3e158 100644
--- a/wic/bbb-efibootguard.wks.in
+++ b/wic/bbb-efibootguard.wks.in
@@ -11,7 +11,7 @@ part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/u-boot.img" --no-
 
 include ebg-sysparts.inc
 
-part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
 
 # home and var are extra partitions
diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efibootguard.wks.in
index 164e8a92..fb3f090a 100644
--- a/wic/hihope-rzg2m-efibootguard.wks.in
+++ b/wic/hihope-rzg2m-efibootguard.wks.in
@@ -3,7 +3,7 @@
 
 include ebg-sysparts.inc
 
-part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
 
 # home and var are extra partitions
diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
index 6f034208..17434d15 100644
--- a/wic/qemu-arm64-efibootguard.wks.in
+++ b/wic/qemu-arm64-efibootguard.wks.in
@@ -3,7 +3,7 @@
 
 include ebg-sysparts.inc
 
-part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
 
 # home and var are extra partitions
diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efibootguard.wks.in
index 1704dede..1a2291e3 100644
--- a/wic/qemu-riscv64-efibootguard.wks.in
+++ b/wic/qemu-riscv64-efibootguard.wks.in
@@ -3,7 +3,7 @@
 
 include ebg-sysparts.inc
 
-part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
 
 # home and var are extra partitions
diff --git a/wic/x86-uefi-efibootguard.wks.in b/wic/x86-uefi-efibootguard.wks.in
index a1cebc1e..9d344f8a 100644
--- a/wic/x86-uefi-efibootguard.wks.in
+++ b/wic/x86-uefi-efibootguard.wks.in
@@ -3,7 +3,7 @@
 
 include ebg-sysparts.inc
 
-part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
 part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
 
 # home and var are extra partitions
-- 
2.43.0


