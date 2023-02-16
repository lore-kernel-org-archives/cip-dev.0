Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E74C61DA4
	for <webhook@archiver.kernel.org>; Thu, 16 Feb 2023 03:46:56 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.2608.1676519211625394888
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Feb 2023 19:46:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=BvgzEBok;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-72506-2023021603464910ceed91ce5c6991c8-xebnkb@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2023021603464910ceed91ce5c6991c8
        for <cip-dev@lists.cip-project.org>;
        Thu, 16 Feb 2023 04:46:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ScAG0jE1nnnd6tTya54ccV+qmx/xOJr9VBvgp0eU5yw=;
 b=BvgzEBokWb2IKb5ZbdnLUi18mUKxJxDyBssT+SmovSOTGuwZQ3fM1b7jx72rg5PIZ1UR/n
 LFqh5uoq5z79hgnhICvJ4RdZbaAZPeW8wBO429nF8FweCatKlSka2+pZX50T98qeASmTvOa5
 0d1+Mand73X7oCN+x7nHhv7aJ9tU8=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: adriaan.schmidt@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v5 7/8] prefix swu related variables with SWU
Date: Thu, 16 Feb 2023 03:45:17 +0000
Message-Id: <20230216034518.1993074-3-felix.moessbauer@siemens.com>
In-Reply-To: <20230216034518.1993074-1-felix.moessbauer@siemens.com>
References: <20230216034518.1993074-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Feb 2023 03:46:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10707

This patch ensures that all variables used in the swupdate.bbclass are
either only active when swu is selected, or are prefixed with SWU. By
that, we avoid accidental name collisions in the image recipe, as this
recipe always inherits the swupdate class (via the imagetype logic).

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes/swupdate.bbclass                    | 10 +++++-----
 recipes-core/images/swu/sw-description.tmpl |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 5f1ab6e..9fcaf3c 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -13,16 +13,16 @@ SWU_ROOTFS_TYPE ?= "squashfs"
 SWU_ROOTFS_NAME ?= "${IMAGE_FULLNAME}"
 # compression type as defined by swupdate (zlib or zstd)
 SWU_COMPRESSION_TYPE ?= "zlib"
-ROOTFS_PARTITION_NAME ?= "${SWU_ROOTFS_NAME}.${SWU_ROOTFS_TYPE}.${@get_swu_compression_type(d)}"
+SWU_ROOTFS_PARTITION_NAME ?= "${SWU_ROOTFS_NAME}.${SWU_ROOTFS_TYPE}.${@get_swu_compression_type(d)}"
 
 SWU_IMAGE_FILE ?= "${DEPLOY_DIR_IMAGE}/${PN}-${DISTRO}-${MACHINE}.swu"
 SWU_DESCRIPTION_FILE ?= "sw-description"
-SWU_ADDITIONAL_FILES ?= "linux.efi ${ROOTFS_PARTITION_NAME}"
+SWU_ADDITIONAL_FILES ?= "linux.efi ${SWU_ROOTFS_PARTITION_NAME}"
 SWU_SIGNED ?= ""
 SWU_SIGNATURE_EXT ?= "sig"
 SWU_SIGNATURE_TYPE ?= "rsa"
 
-BUILDCHROOT_IMAGE_FILE ?= "${PP_DEPLOY}/${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
+SWU_BUILDCHROOT_IMAGE_FILE ?= "${PP_DEPLOY}/${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
 
 IMAGE_TYPEDEP:swu = "wic ${SWU_ROOTFS_TYPE}.${@get_swu_compression_type(d)}"
 IMAGER_INSTALL:swu += "cpio ${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
@@ -30,7 +30,7 @@ IMAGER_INSTALL:swu += "cpio ${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SI
 IMAGE_SRC_URI:swu = "file://${SWU_DESCRIPTION_FILE}.tmpl"
 IMAGE_TEMPLATE_FILES:swu = "${SWU_DESCRIPTION_FILE}.tmpl"
 IMAGE_TEMPLATE_VARS:swu = " \
-    ROOTFS_PARTITION_NAME \
+    SWU_ROOTFS_PARTITION_NAME \
     TARGET_IMAGE_UUID \
     ABROOTFS_PART_UUID_A \
     ABROOTFS_PART_UUID_B \
@@ -98,7 +98,7 @@ IMAGE_CMD:swu() {
                 fi
                 echo "$file.${SWU_SIGNATURE_EXT}"
            fi
-        done | cpio -ovL -H crc > "${BUILDCHROOT_IMAGE_FILE}"'
+        done | cpio -ovL -H crc > "${SWU_BUILDCHROOT_IMAGE_FILE}"'
 }
 
 python do_check_swu_partition_uuids() {
diff --git a/recipes-core/images/swu/sw-description.tmpl b/recipes-core/images/swu/sw-description.tmpl
index b5a8622..cade7c3 100644
--- a/recipes-core/images/swu/sw-description.tmpl
+++ b/recipes-core/images/swu/sw-description.tmpl
@@ -13,7 +13,7 @@ software =
     version = "0.2";
     name = "cip software update";
     images: ({
-            filename = "${ROOTFS_PARTITION_NAME}";
+            filename = "${SWU_ROOTFS_PARTITION_NAME}";
             device = "C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOTFS_PART_UUID_B}";
             type = "roundrobin";
             compressed = "${SWU_COMPRESSION_TYPE}";
@@ -21,7 +21,7 @@ software =
                         subtype = "image";
                         configfilecheck = "/etc/os-release@not_match@IMAGE_UUID=${TARGET_IMAGE_UUID}";
             };
-            sha256 = "${ROOTFS_PARTITION_NAME}-sha256";
+            sha256 = "${SWU_ROOTFS_PARTITION_NAME}-sha256";
     });
     files: ({
             filename = "linux.efi";
-- 
2.34.1


