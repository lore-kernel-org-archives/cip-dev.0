Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CCEC05027
	for <webhook@archiver.kernel.org>; Sun, 12 Feb 2023 22:54:23 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.7539.1676190527045422079
 for <cip-dev@lists.cip-project.org>;
 Sun, 12 Feb 2023 00:28:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=molX4xgA;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-72506-202302120828456d8fa169a092f353e6-lmk4em@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202302120828456d8fa169a092f353e6
        for <cip-dev@lists.cip-project.org>;
        Sun, 12 Feb 2023 09:28:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xiiCHROD87do0DVkS7cz3pppyFRhEnd9hhzdyMS4wJs=;
 b=molX4xgA7aFRPB1NQmNTxN2m7bo8qqHJikASIbS2AagV4LZ3EGDrL8CQPxeKhjgyR3h+kz
 OVrm2PBxpqS8D3y6FupvY4+KI5WVuAzieuItYElPCR178xTcFlqZmMGNQ8k9dmDWTn0sPN1P
 QPJWGpEnaVSSJ+ZLtNHpiIf8Z5eSw=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: adriaan.schmidt@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v4 6/8] swu: replace custom image compression
Date: Sun, 12 Feb 2023 08:27:56 +0000
Message-Id: <20230212082758.1166262-7-felix.moessbauer@siemens.com>
In-Reply-To: <20230212082758.1166262-1-felix.moessbauer@siemens.com>
References: <20230212082758.1166262-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 12 Feb 2023 22:54:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10676

This patch replaces the custom compression logic for the rootfs in the
swupdate swu file by using the imagetype infrastructure. This handles
some corner-cases and in general streamlines the options used for
compressing. With the new infrastructure in place, we add support to
compress the image with zstd (only zlib and zstd are supported by
swupdate).

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes/swupdate.bbclass                    | 40 ++++++++++-----------
 recipes-core/images/swu/sw-description.tmpl |  2 +-
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 931ac30..6085dce 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -11,7 +11,9 @@
 # SPDX-License-Identifier: MIT
 SWU_ROOTFS_TYPE ?= "squashfs"
 SWU_ROOTFS_NAME ?= "${IMAGE_FULLNAME}"
-ROOTFS_PARTITION_NAME ?= "${SWU_ROOTFS_NAME}.${SWU_ROOTFS_TYPE}.gz"
+# compression type as defined by swupdate (zlib or zstd)
+SWU_COMPRESSION_TYPE ?= "zlib"
+ROOTFS_PARTITION_NAME ?= "${SWU_ROOTFS_NAME}.${SWU_ROOTFS_TYPE}.${@get_swu_compression_type(d)}"
 
 SWU_IMAGE_FILE ?= "${DEPLOY_DIR_IMAGE}/${PN}-${DISTRO}-${MACHINE}.swu"
 SWU_DESCRIPTION_FILE ?= "sw-description"
@@ -22,12 +24,25 @@ SWU_SIGNATURE_TYPE ?= "rsa"
 
 BUILDCHROOT_IMAGE_FILE ?= "${PP_DEPLOY}/${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
 
-IMAGE_TYPEDEP:swu = "wic ${SWU_ROOTFS_TYPE}.gz"
+IMAGE_TYPEDEP:swu = "wic ${SWU_ROOTFS_TYPE}.${@get_swu_compression_type(d)}"
 IMAGER_INSTALL:swu += "cpio ${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 
 IMAGE_SRC_URI:swu = "file://${SWU_DESCRIPTION_FILE}.tmpl"
 IMAGE_TEMPLATE_FILES:swu = "${SWU_DESCRIPTION_FILE}.tmpl"
-IMAGE_TEMPLATE_VARS:swu = "ROOTFS_PARTITION_NAME TARGET_IMAGE_UUID ABROOTFS_PART_UUID_A ABROOTFS_PART_UUID_B"
+IMAGE_TEMPLATE_VARS:swu = " \
+    ROOTFS_PARTITION_NAME \
+    TARGET_IMAGE_UUID \
+    ABROOTFS_PART_UUID_A \
+    ABROOTFS_PART_UUID_B \
+    SWU_COMPRESSION_TYPE"
+
+# convert between swupdate compressor name and imagetype extension
+def get_swu_compression_type(d):
+    swu_ct = d.getVar('SWU_COMPRESSION_TYPE', True)
+    swu_to_image = {'zlib': 'gz', 'zstd': 'zst'}
+    if swu_ct not in swu_to_image:
+        bb.fatal('requested SWU_COMPRESSION_TYPE is not supported by swupdate')
+    return swu_to_image[swu_ct]
 
 # This imagetype is neither machine nor distro specific. Hence, we cannot
 # use paths in FILESOVERRIDES. Manual modifications of this variable are
@@ -40,25 +55,6 @@ IMAGE_CMD:swu() {
     rm -f '${SWU_IMAGE_FILE}'
     cp '${WORKDIR}/${SWU_DESCRIPTION_FILE}' '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
 
-    # Compress files if requested
-    for file in ${SWU_ADDITIONAL_FILES}; do
-        basefile=$(basename "$file" .gz)
-        if [ "$basefile" = "$file" ]; then
-            continue
-        fi
-        for uncompressed in "${WORKDIR}/$basefile" "${DEPLOY_DIR_IMAGE}/$basefile"; do
-            if [ -e "$uncompressed" ]; then
-                rm  -f "$uncompressed.gz"
-                if [ -x "$(command -v pigz)" ]; then
-                    pigz "$uncompressed"
-                else
-                    gzip "$uncompressed"
-                fi
-                break
-            fi
-        done
-    done
-
     # Create symlinks for files used in the update image
     for file in ${SWU_ADDITIONAL_FILES}; do
         if [ -e "${WORKDIR}/$file" ]; then
diff --git a/recipes-core/images/swu/sw-description.tmpl b/recipes-core/images/swu/sw-description.tmpl
index 01c5f53..b5a8622 100644
--- a/recipes-core/images/swu/sw-description.tmpl
+++ b/recipes-core/images/swu/sw-description.tmpl
@@ -16,7 +16,7 @@ software =
             filename = "${ROOTFS_PARTITION_NAME}";
             device = "C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOTFS_PART_UUID_B}";
             type = "roundrobin";
-            compressed = "zlib";
+            compressed = "${SWU_COMPRESSION_TYPE}";
             properties: {
                         subtype = "image";
                         configfilecheck = "/etc/os-release@not_match@IMAGE_UUID=${TARGET_IMAGE_UUID}";
-- 
2.34.1


