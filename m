Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6833C05027
	for <webhook@archiver.kernel.org>; Sun, 12 Feb 2023 22:54:13 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.7476.1676190495478615198
 for <cip-dev@lists.cip-project.org>;
 Sun, 12 Feb 2023 00:28:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=RpZ4VqZh;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-72506-20230212082816420d1ec5e9ce729b25-od5j7t@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230212082816420d1ec5e9ce729b25
        for <cip-dev@lists.cip-project.org>;
        Sun, 12 Feb 2023 09:28:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=wn+EwePjQE5LWd6UBAuAIna9KpGeeLPoNQnMrkYT/Bs=;
 b=RpZ4VqZhziNWvEcKb+5kPD9V4n9J3VcIBV6NIAI63vCz7F64TQfqaAb5Tt9BK9O8T4rseB
 I6Y6qz4UaIk5nMaVurw29HmUTbwmMnC8h8fpN2+Q66yBWRMeK63ItLdvMUsT30Qd4mIF5eG/
 55pxBhlo+jqekhL5ADwfSq3TW/fXI=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: adriaan.schmidt@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v4 2/8] refactor: use imagetypes for swu generation
Date: Sun, 12 Feb 2023 08:27:52 +0000
Message-Id: <20230212082758.1166262-3-felix.moessbauer@siemens.com>
In-Reply-To: <20230212082758.1166262-1-felix.moessbauer@siemens.com>
References: <20230212082758.1166262-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 12 Feb 2023 22:54:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10671

This patch reworks the implementation of the swupdate type.
All generic aspects are moved from the swupdate.inc file into the
swupdate class and made conditional on the swu type.
The sw-description file is now referenced using the image-type
infrastructure, which avoids manual additions to FILESEXTRAPATHS and
accidental overwrites of SRC_URI. The templating logic is moved into the
generic one provided by imagetypes.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes/swupdate.bbclass                      | 26 ++++++++++++-------
 kas/opt/swupdate.yml                          |  5 +---
 .../images/{files => swu}/sw-description.tmpl |  0
 recipes-core/images/swupdate.inc              | 15 -----------
 4 files changed, 18 insertions(+), 28 deletions(-)
 rename recipes-core/images/{files => swu}/sw-description.tmpl (100%)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 5eb4936..966f7c0 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -8,23 +8,33 @@
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
 #
 # SPDX-License-Identifier: MIT
+ROOTFS_PARTITION_NAME ?= "${IMAGE_FULLNAME}.wic.p4.gz"
 
 SWU_IMAGE_FILE ?= "${DEPLOY_DIR_IMAGE}/${PN}-${DISTRO}-${MACHINE}.swu"
 SWU_DESCRIPTION_FILE ?= "sw-description"
-SWU_ADDITIONAL_FILES ?= ""
+SWU_ADDITIONAL_FILES ?= "linux.efi ${ROOTFS_PARTITION_NAME}"
 SWU_SIGNED ?= ""
 SWU_SIGNATURE_EXT ?= "sig"
 SWU_SIGNATURE_TYPE ?= "rsa"
 
 BUILDCHROOT_IMAGE_FILE ?= "${PP_DEPLOY}/${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
 
-IMAGER_INSTALL += "cpio"
-IMAGER_INSTALL += "${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
+IMAGE_TYPEDEP:wic += "squashfs"
+IMAGE_TYPEDEP:swu = "wic"
+IMAGER_INSTALL:swu += "cpio ${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 
-do_swupdate_binary[stamp-extra-info] = "${DISTRO}-${MACHINE}"
-do_swupdate_binary[cleandirs] += "${WORKDIR}/swu"
-do_swupdate_binary[network] = "${TASK_USE_SUDO}"
-do_swupdate_binary() {
+IMAGE_SRC_URI:swu = "file://${SWU_DESCRIPTION_FILE}.tmpl"
+IMAGE_TEMPLATE_FILES:swu = "${SWU_DESCRIPTION_FILE}.tmpl"
+IMAGE_TEMPLATE_VARS:swu = "ROOTFS_PARTITION_NAME TARGET_IMAGE_UUID ABROOTFS_PART_UUID_A ABROOTFS_PART_UUID_B"
+
+# This imagetype is neither machine nor distro specific. Hence, we cannot
+# use paths in FILESOVERRIDES. Manual modifications of this variable are
+# discouradged and hard to implement. Instead, we register this path explicitly
+FILESEXTRAPATHS:prepend = "${LAYERDIR_cip-core}/recipes-core/images/swu:"
+
+do_image_swu[stamp-extra-info] = "${DISTRO}-${MACHINE}"
+do_image_swu[cleandirs] += "${WORKDIR}/swu"
+IMAGE_CMD:swu() {
     rm -f '${SWU_IMAGE_FILE}'
     cp '${WORKDIR}/${SWU_DESCRIPTION_FILE}' '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
 
@@ -91,5 +101,3 @@ do_swupdate_binary() {
            fi
         done | cpio -ovL -H crc > "${BUILDCHROOT_IMAGE_FILE}"'
 }
-
-addtask swupdate_binary before do_build after do_deploy do_copy_boot_files do_install_imager_deps do_transform_template
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index ae5e3a1..80cd86e 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -19,11 +19,8 @@ local_conf_header:
     CIP_IMAGE_OPTIONS:append = " swupdate.inc"
 
   wic-swu: |
-    IMAGE_CLASSES += "squashfs"
-    IMAGE_TYPEDEP:wic += "squashfs"
-    IMAGE_FSTYPES = "wic"
+    IMAGE_FSTYPES += "swu"
     WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
     INITRAMFS_INSTALL:append = " initramfs-squashfs-hook"
-    WIC_DEPLOY_PARTITIONS = "1"
     ABROOTFS_PART_UUID_A ?= "fedcba98-7654-3210-cafe-5e0710000001"
     ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
diff --git a/recipes-core/images/files/sw-description.tmpl b/recipes-core/images/swu/sw-description.tmpl
similarity index 100%
rename from recipes-core/images/files/sw-description.tmpl
rename to recipes-core/images/swu/sw-description.tmpl
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index ee893dd..f4f5c42 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -10,26 +10,11 @@
 #
 
 inherit image_uuid
-inherit swupdate
 inherit read-only-rootfs
 
 IMAGE_INSTALL += " swupdate"
 IMAGE_INSTALL += " swupdate-handler-roundrobin"
 
-ROOTFS_PARTITION_NAME = "${IMAGE_FULLNAME}.wic.p4.gz"
-
-FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
-
-SRC_URI += "file://sw-description.tmpl"
-TEMPLATE_FILES += "sw-description.tmpl"
-
-do_transform_template[vardeps] += "TARGET_IMAGE_UUID"
-addtask do_transform_template before do_swupdate_binary after do_generate_image_uuid
-
-TEMPLATE_VARS += "ROOTFS_PARTITION_NAME TARGET_IMAGE_UUID ABROOTFS_PART_UUID_A ABROOTFS_PART_UUID_B"
-
-SWU_ADDITIONAL_FILES += "linux.efi ${ROOTFS_PARTITION_NAME}"
-
 python() {
     for u in ['A', 'B']:
         if not d.getVar('ABROOTFS_PART_UUID_' + u):
-- 
2.34.1


