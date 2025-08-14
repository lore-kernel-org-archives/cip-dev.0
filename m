Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E75CA0EEA
	for <webhook@archiver.kernel.org>; Thu, 14 Aug 2025 10:31:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.19462.1755167474964708130
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Aug 2025 03:31:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 57EAVCSf3008136; Thu, 14 Aug 2025 19:31:13 +0900
X-Iguazu-Qid: 2yAbaKzOkuVpvfxGWe
X-Iguazu-QSIG: v=2; s=0; t=1755167472; q=2yAbaKzOkuVpvfxGWe; m=YSgJNAkMIEExQSj+JAVLH70b3Mxdiq8IPeK7UVKM6WY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 57EAVBIv2491303
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 19:31:12 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v2 3/5] Add delta update support for kernel binary update using rdiff_file handler
Date: Thu, 14 Aug 2025 15:51:13 +0530
X-TSB-HOP2: ON
Message-Id: <20250814102117.2608463-4-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814102117.2608463-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20250814102117.2608463-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Aug 2025 10:31:07.0351 (UTC) FILETIME=[8B5F3670:01DC0D06]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Aug 2025 10:31:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19745

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 classes/delta-update.bbclass                | 33 +++++++++++++++------
 classes/swupdate.bbclass                    | 24 +++++++++++----
 recipes-core/images/swu/sw-description.tmpl |  7 +++--
 3 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/classes/delta-update.bbclass b/classes/delta-update.bbclass
index ab11be5..d033df0 100644
--- a/classes/delta-update.bbclass
+++ b/classes/delta-update.bbclass
@@ -15,6 +15,7 @@ FILESEXTRAPATHS:prepend = "${TOPDIR}/previous-image:"
 
 DELTA_UPDATE_TYPE ??= ""
 DELTA_RDIFF_REF_IMAGE ??= ""
+DELTA_RDIFF_REF_KERNEL_IMAGE ??= ""
 DELTA_ZCK_URL ??= ""
 DELTA_PREV_IMAGE_PATH ??= "${TOPDIR}/previous-image"
 
@@ -24,8 +25,8 @@ def disable_delta_update_tasks (d):
 
 python () {
     if d.getVar("DELTA_UPDATE_TYPE") == "rdiff":
-        if d.getVar("DELTA_RDIFF_REF_IMAGE") == "":
-            bb.fatal("You must set DELTA_RDIFF_REF_IMAGE and provide the required files as artifacts to this recipe")
+        if d.getVar("DELTA_RDIFF_REF_IMAGE") == "" or d.getVar("DELTA_RDIFF_REF_KERNEL_IMAGE") == "":
+            bb.fatal("You must set DELTA_RDIFF_REF_IMAGE and DELTA_RDIFF_REF_KERNEL_IMAGE and also provide the required files as artifacts to this recipe")
     elif d.getVar("DELTA_UPDATE_TYPE") == "zchunk":
         if d.getVar("BASE_DISTRO_CODENAME") != "trixie":
             bb.fatal("Zchunk based delta update is only supported from trixie onward")
@@ -35,11 +36,13 @@ python () {
 
 python do_fetch_delta_rdiff_ref_image () {
     if d.getVar("DELTA_UPDATE_TYPE") == "rdiff":
-        path = d.getVar("DELTA_PREV_IMAGE_PATH") + "/" + d.getVar("DELTA_RDIFF_REF_IMAGE")
-        if not os.path.isfile(path):
-            bb.fatal("No such file found: "+ path + ". Provide the required files at "+ d.getVar("DELTA_PREV_IMAGE_PATH") + " for rdiff based delta update")
+        rootfs_path = d.getVar("DELTA_PREV_IMAGE_PATH") + "/" + d.getVar("DELTA_RDIFF_REF_IMAGE")
+        kernel_path = d.getVar("DELTA_PREV_IMAGE_PATH") + "/" + d.getVar("DELTA_RDIFF_REF_KERNEL_IMAGE")
+        if not os.path.isfile(rootfs_path) or not os.path.isfile(kernel_path):
+            bb.fatal("No such files found: "+ rootfs_path + "," + kernel_path + ". Provide the required files at "+ d.getVar("DELTA_PREV_IMAGE_PATH") + " for rdiff based delta update")
         else:
             d.appendVar("SRC_URI", " file://" + d.getVar("DELTA_RDIFF_REF_IMAGE"))
+            d.appendVar("SRC_URI", " file://" + d.getVar("DELTA_RDIFF_REF_KERNEL_IMAGE"))
 }
 
 do_fetch[prefuncs] += "do_fetch_delta_rdiff_ref_image"
@@ -47,18 +50,30 @@ do_unpack[prefuncs] += "do_fetch_delta_rdiff_ref_image"
 
 create_rdiff_delta_artifact() {
     rm -f ${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.delta
-    # create signature file with rdiff
+    # create signature file with rdiff for rootfs
     ${SUDO_CHROOT} /usr/bin/rdiff signature ${WORKDIR}/${DELTA_RDIFF_REF_IMAGE} \
         ${WORKDIR}/delta_interim_artifacts/old-image-rootfs.sig
 
-    # create delta file with the signature file
+    # create delta file with the signature file for rootfs
     ${SUDO_CHROOT} /usr/bin/rdiff delta ${WORKDIR}/delta_interim_artifacts/old-image-rootfs.sig \
         ${PP_DEPLOY}/${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE} ${PP_DEPLOY}/${IMAGE_FULLNAME}.delta
 
-    DELTA_ARTIFACT_SWU=${IMAGE_FULLNAME}.delta
+    DELTA_ARTIFACT_ROOTFS_SWU=${IMAGE_FULLNAME}.delta
 
     # create a symbolic link as IMAGE_CMD expects a *.delta_update file in deploy image directory
-    ln -sf ${DELTA_ARTIFACT_SWU} ${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.delta_update
+    ln -sf ${DELTA_ARTIFACT_ROOTFS_SWU} ${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.delta_update
+
+    rm -f ${DEPLOY_DIR_IMAGE}/linux.efi.delta
+
+    # create signature file with rdiff for kernel
+    ${SUDO_CHROOT} /usr/bin/rdiff signature ${WORKDIR}/${DELTA_RDIFF_REF_KERNEL_IMAGE} \
+        ${WORKDIR}/delta_interim_artifacts/old-linux.efi.sig
+
+    # create delta file with the signature file for kernel
+    ${SUDO_CHROOT} /usr/bin/rdiff delta ${WORKDIR}/delta_interim_artifacts/old-linux.efi.sig \
+        ${PP_DEPLOY}/linux.efi ${PP_DEPLOY}/linux.efi.delta
+
+    ln -sf linux.efi.delta ${DEPLOY_DIR_IMAGE}/linux.efi.delta_update
 }
 
 create_zchunk_delta_artifact() {
diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index b0b05d5..c18aaa9 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -15,6 +15,7 @@ inherit template
 RO_ROOTFS_TYPE ??= "squashfs"
 SWU_ROOTFS_TYPE ?= "${RO_ROOTFS_TYPE}"
 SWU_ROOTFS_NAME ?= "${IMAGE_FULLNAME}"
+SWU_KERNEL_NAME ?= "linux.efi"
 # compression type as defined by swupdate (zlib or zstd). Set to empty string to disable compression
 SWU_COMPRESSION_TYPE ?= "zlib"
 SWU_ROOTFS_PARTITION_NAME ?= "${SWU_ROOTFS_NAME}.${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
@@ -32,9 +33,14 @@ SWU_ROOTFS_ARTIFACT_NAME = "${@ '${SWU_DELTA_UPDATE_ARTIFACT}' \
     if d.getVar('DELTA_UPDATE_TYPE') == "rdiff" or d.getVar('DELTA_UPDATE_TYPE') == "zchunk" \
     else '${SWU_ROOTFS_PARTITION_NAME}'}"
 
+SWU_DELTA_UPDATE_KERNEL_ARTIFACT = "${SWU_KERNEL_NAME}.delta_update"
+SWU_KERNEL_ARTIFACT_NAME = "${@ '${SWU_DELTA_UPDATE_KERNEL_ARTIFACT}' \
+    if d.getVar('DELTA_UPDATE_TYPE') == "rdiff" \
+    else '${SWU_KERNEL_NAME}'}"
+
 SWU_IMAGE_FILE ?= "${IMAGE_FULLNAME}"
 SWU_DESCRIPTION_FILE ?= "sw-description"
-SWU_ADDITIONAL_FILES ?= "linux.efi ${SWU_ROOTFS_ARTIFACT_NAME}"
+SWU_ADDITIONAL_FILES ?= "${SWU_KERNEL_ARTIFACT_NAME} ${SWU_ROOTFS_ARTIFACT_NAME}"
 SWU_SIGNED ??= ""
 SWU_SIGNATURE_EXT ?= "sig"
 SWU_SIGNATURE_TYPE ?= "cms"
@@ -58,6 +64,7 @@ IMAGE_TEMPLATE_FILES:swu += "${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
 IMAGE_TEMPLATE_VARS:swu = " \
     RO_ROOTFS_TYPE \
     SWU_ROOTFS_ARTIFACT_NAME \
+    SWU_KERNEL_ARTIFACT_NAME \
     TARGET_IMAGE_UUID \
     ABROOTFS_PART_UUID_A \
     ABROOTFS_PART_UUID_B \
@@ -68,7 +75,8 @@ IMAGE_TEMPLATE_VARS:swu = " \
     SWU_FILE_NODES \
     SWU_BOOTLOADER_FILE_NODE \
     SWU_SCRIPTS_NODE \
-    SWU_DELTA_UPDATE_PROPERTIES \
+    SWU_DELTA_UPDATE_ROOTFS_PROPERTIES \
+    SWU_DELTA_UPDATE_KERNEL_PROPERTIES \
     "
 
 # TARGET_IMAGE_UUID needs to be generated before completing the template
@@ -163,17 +171,21 @@ python add_scripts_node() {
 SWU_EXTEND_SW_DESCRIPTION += "add_swu_delta_update_properties"
 python add_swu_delta_update_properties() {
     delta_type = d.getVar('DELTA_UPDATE_TYPE')
-    swu_delta_update_properties = ""
+    swu_delta_update_rootfs_properties = ""
+    swu_delta_update_kernel_properties = ""
     if delta_type == "rdiff":
-        swu_delta_update_properties =  'chainhandler = "rdiff_image";'
+        swu_delta_update_rootfs_properties =  'chainhandler = "rdiff_image";'
+        swu_delta_update_kernel_properties =  'chainhandler = "rdiff_file";'
     elif delta_type == "zchunk":
         zck_url = d.getVar('DELTA_ZCK_URL')
-        swu_delta_update_properties = f"""
+        swu_delta_update_rootfs_properties = f"""
                         chainhandler = "delta";
                         url = "{zck_url}";
                         zckloglevel = "error";
         """
-    d.setVar('SWU_DELTA_UPDATE_PROPERTIES', swu_delta_update_properties)
+    d.setVar('SWU_DELTA_UPDATE_ROOTFS_PROPERTIES', swu_delta_update_rootfs_properties)
+    d.setVar('SWU_DELTA_UPDATE_KERNEL_PROPERTIES', swu_delta_update_kernel_properties)
+
 }
 
 # convert between swupdate compressor name and imagetype extension
diff --git a/recipes-core/images/swu/sw-description.tmpl b/recipes-core/images/swu/sw-description.tmpl
index eeb8fc2..3d7898c 100644
--- a/recipes-core/images/swu/sw-description.tmpl
+++ b/recipes-core/images/swu/sw-description.tmpl
@@ -21,20 +21,21 @@ software =
             properties: {
                         subtype = "image";
                         configfilecheck = "/etc/os-release@not_match@IMAGE_UUID=${TARGET_IMAGE_UUID}";
-                        ${SWU_DELTA_UPDATE_PROPERTIES}
+                        ${SWU_DELTA_UPDATE_ROOTFS_PROPERTIES}
             };
             sha256 = "${SWU_ROOTFS_ARTIFACT_NAME}-sha256";
     });
     files: ({
-            filename = "linux.efi";
+            filename = "${SWU_KERNEL_ARTIFACT_NAME}";
             path = "linux.efi";
             type = "roundrobin";
             device = "C:BOOT0:linux.efi->BOOT0,C:BOOT1:linux.efi->BOOT1";
             filesystem = "vfat";
             properties: {
                         subtype = "kernel";
+                        ${SWU_DELTA_UPDATE_KERNEL_PROPERTIES}
             };
-            sha256 = "linux.efi-sha256";
+            sha256 = "${SWU_KERNEL_ARTIFACT_NAME}-sha256";
     }${SWU_FILE_NODES});
     ${SWU_SCRIPTS_NODE}
 }
-- 
2.39.5



