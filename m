Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C73C46467
	for <webhook@archiver.kernel.org>; Thu,  5 Jan 2023 02:37:58 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.3821.1672885271307993461
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jan 2023 18:21:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=M6EOKoZp;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-72506-202301050221071da608d4d17d0ec1c7-xcguyf@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202301050221071da608d4d17d0ec1c7
        for <cip-dev@lists.cip-project.org>;
        Thu, 05 Jan 2023 03:21:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=zDEkw5TpFR2rKka2oscvBXrpcW+ZYc8T1gC/XT+XU/I=;
 b=M6EOKoZpI9owUpcwkNeP9cMknjM0QaKBwfmi3OnySziJfwDx9uIdvwptKFqgeqAwEpl38h
 Con0Mba2pVMXkhXwcb3C+wgiMWcJolOP0LNtSR4+hGhLEvotM7FGKUIvU655Zulod6sBG0t7
 ufllC/gM3Ml9F9Hx+YL81CTk2xa28=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	tengfei.wu@siemens.com,
	daniel.bovensiepen@siemens.com,
	jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v2 1/1] Use global variables for abrootfs partition uuids
Date: Thu,  5 Jan 2023 02:20:44 +0000
Message-Id: <20230105022044.1507793-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Jan 2023 02:37:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10320

This patch converts the abrootfs partition uuids to a template and adds
two global variables to control their values. By that, the partition
uuids used in the WIC files can be kept in sync with the uuids used in
the sw-description file. This helps to avoid issues where the part uuids
are inconsistent and hence the update using swupdate fails.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---

Changes since v1:

- fix: add ABROOTFS_PART_UUID_(A|B) to template vars for sw-description
- removed initialisation of variables from swupdate.inc file, as the
  check will catch it anyways
- simplified check for uuid values

I decided against the recommendation to move the UUID out of the swupdate.yml
kas file, because this would introduce yet another pattern how to handle things.
Downstream users are free to use a different method, but als long as CIP-Core
handles all globals via KAS, we should not diverge.

Best regards,
Felix

 kas/opt/swupdate.yml                          | 2 ++
 recipes-core/images/files/sw-description.tmpl | 2 +-
 recipes-core/images/swupdate.inc              | 8 +++++++-
 wic/bbb-efibootguard.wks.in                   | 4 ++--
 wic/qemu-amd64-efibootguard-secureboot.wks.in | 4 ++--
 wic/qemu-arm64-efibootguard-secureboot.wks.in | 4 ++--
 wic/qemu-arm64-efibootguard.wks.in            | 4 ++--
 wic/x86-efibootguard.wks.in                   | 4 ++--
 8 files changed, 20 insertions(+), 12 deletions(-)

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
index 0ba3a0e..9b2aedc 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -26,6 +26,12 @@ TEMPLATE_FILES += "sw-description.tmpl"
 do_transform_template[vardeps] += "TARGET_IMAGE_UUID"
 addtask do_transform_template before do_swupdate_binary after do_generate_image_uuid
 
-TEMPLATE_VARS += "ROOTFS_PARTITION_NAME TARGET_IMAGE_UUID"
+TEMPLATE_VARS += "ROOTFS_PARTITION_NAME TARGET_IMAGE_UUID ABROOTFS_PART_UUID_A ABROOTFS_PART_UUID_B"
 
 SWU_ADDITIONAL_FILES += "linux.efi ${ROOTFS_PARTITION_NAME}"
+
+python() {
+    for u in ['A', 'B']:
+        if not d.getVar('ABROOTFS_PART_UUID_' + u):
+            bb.fatal('ABROOTFS_PART_UUID_' + u + ' not set')
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


