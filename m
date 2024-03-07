Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553DAC54E49
	for <webhook@archiver.kernel.org>; Thu,  7 Mar 2024 07:46:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.18099.1709797557578798239
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Mar 2024 23:45:57 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 4277juGx829453; Thu, 7 Mar 2024 16:45:56 +0900
X-Iguazu-Qid: 2rWg6j0N7RLe8F3pah
X-Iguazu-QSIG: v=2; s=0; t=1709797555; q=2rWg6j0N7RLe8F3pah; m=PAYRmkbvZc3K6iwzgfdhlyLYm3e58hFuPN6QzykMZ4M=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 4277js5I996572
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 7 Mar 2024 16:45:55 +0900
From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][RFC v1 5/6] swupdate.bbclass: Generate swu for delta updates
Date: Thu,  7 Mar 2024 13:16:11 +0530
X-TSB-HOP2: ON
Message-Id: <20240307074612.1996609-6-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Mar 2024 07:45:48.0806 (UTC) FILETIME=[78969A60:01DA7063]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Mar 2024 07:46:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15257

This allows the creation of a swu file for delta update. The swu file
for delta update is only created when delta-update.yml file is included
at build time.

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 classes/swupdate.bbclass | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 2c69892..2964024 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -26,10 +26,13 @@ SWU_EBG_UPDATE ?= ""
 SWU_EFI_BOOT_DEVICE ?= "/dev/disk/by-uuid/4321-DCBA"
 SWU_BOOTLOADER ??= "ebg"
 SWU_DESCRIPITION_FILE_BOOTLOADER ??= "${SWU_DESCRIPTION_FILE}-${SWU_BOOTLOADER}"
+SWU_DESCRIPITION_FILE_DELTA_UPDATE ??= "${SWU_DESCRIPTION_FILE}-delta"
+SWU_DELTA_UPDATE_ARTIFACT = "${SWU_ROOTFS_NAME}.delta_update${@get_swu_compression_type(d)}"
+SWU_DELTA_UPDATE_ARTIFACT_TYPE = "delta_update${@get_swu_compression_type(d)}"
 
 SWU_IMAGE_FILE ?= "${IMAGE_FULLNAME}"
 SWU_DESCRIPTION_FILE ?= "sw-description"
-SWU_ADDITIONAL_FILES ?= "linux.efi ${SWU_ROOTFS_PARTITION_NAME}"
+SWU_ADDITIONAL_FILES ?= "linux.efi ${SWU_ROOTFS_PARTITION_NAME} ${SWU_DELTA_UPDATE_ARTIFACT}"
 SWU_SIGNED ??= ""
 SWU_SIGNATURE_EXT ?= "sig"
 SWU_SIGNATURE_TYPE ?= "cms"
@@ -37,6 +40,7 @@ SWU_SIGNATURE_TYPE ?= "cms"
 SWU_BUILDCHROOT_IMAGE_FILE ?= "${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
 
 IMAGE_TYPEDEP:swu = "${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
+IMAGE_TYPEDEP:swu += "${@ '${SWU_DELTA_UPDATE_ARTIFACT_TYPE}' if d.getVar('DELTA_UPDATE_TYPE') else ''}"
 IMAGER_BUILD_DEPS:swu += "${@'swupdate-certificates-key' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 IMAGER_INSTALL:swu += "cpio ${@'openssl swupdate-certificates-key' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
@@ -46,6 +50,7 @@ IMAGE_SRC_URI:swu = "file://${SWU_DESCRIPTION_FILE}.tmpl"
 IMAGE_SRC_URI:swu += "file://${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
 IMAGE_TEMPLATE_FILES:swu = "${SWU_DESCRIPTION_FILE}.tmpl"
 IMAGE_TEMPLATE_FILES:swu += "${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
+IMAGE_TEMPLATE_FILES:delta_update += "${SWU_DESCRIPITION_FILE_DELTA_UPDATE}.tmpl"
 IMAGE_TEMPLATE_VARS:swu = " \
     SWU_ROOTFS_PARTITION_NAME \
     TARGET_IMAGE_UUID \
@@ -58,6 +63,8 @@ IMAGE_TEMPLATE_VARS:swu = " \
     SWU_FILE_NODES \
     SWU_BOOTLOADER_FILE_NODE \
     SWU_SCRIPTS_NODE \
+    SWU_DELTA_UPDATE_ARTIFACT \
+    SWU_DELTA_UPDATE_ADDITIONAL_PROPERTIES \
     "
 
 # TARGET_IMAGE_UUID needs to be generated before completing the template
@@ -136,6 +143,22 @@ python add_scripts(){
     d.appendVar('SWU_SCRIPTS_NODE', swu_scripts_node)
 }
 
+SWU_EXTEND_SW_DESCRIPTION += "add_swu_delta_update_properties"
+python add_swu_delta_update_properties() {
+    delta_type = d.getVar('DELTA_UPDATE_TYPE')
+    swu_delta_update_properties = ""
+    if delta_type == "rdiff":
+        swu_delta_update_properties =  'chainhandler = "rdiff_image";'
+    elif delta_type == "zchunk":
+        zck_url = d.getVar('DELTA_ZCK_URL')
+        swu_delta_update_properties = f"""
+                        chainhandler = "delta";
+                        url = "{zck_url}";
+                        zckloglevel = "error";
+        """
+    d.setVar('SWU_DELTA_UPDATE_ADDITIONAL_PROPERTIES', swu_delta_update_properties)
+}
+
 # convert between swupdate compressor name and imagetype extension
 def get_swu_compression_type(d):
     swu_ct = d.getVar('SWU_COMPRESSION_TYPE')
@@ -154,13 +177,21 @@ FILESEXTRAPATHS:append = ":${LAYERDIR_cip-core}/recipes-core/images/swu"
 
 do_image_swu[depends] += "${PN}:do_transform_template"
 do_image_swu[stamp-extra-info] = "${DISTRO}-${MACHINE}"
-do_image_swu[cleandirs] += "${WORKDIR}/swu ${WORKDIR}/swu-${SWU_BOOTLOADER}"
+do_image_swu[cleandirs] += "${WORKDIR}/swu ${WORKDIR}/swu-${SWU_BOOTLOADER} ${WORKDIR}/swu-delta"
 IMAGE_CMD:swu() {
     rm -f '${DEPLOY_DIR_IMAGE}/${SWU_IMAGE_FILE}'*.swu
+    if [ -z "${DELTA_UPDATE_TYPE}" ]; then
+        rm -rf ${WORKDIR}/swu-delta
+    fi
+
     cp '${WORKDIR}/${SWU_DESCRIPTION_FILE}' '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
     if [ -f '${WORKDIR}/${SWU_DESCRIPITION_FILE_BOOTLOADER}' ]; then
         cp '${WORKDIR}/${SWU_DESCRIPITION_FILE_BOOTLOADER}' '${WORKDIR}/swu-${SWU_BOOTLOADER}/${SWU_DESCRIPTION_FILE}'
     fi
+    if [ -f '${WORKDIR}/${SWU_DESCRIPITION_FILE_DELTA_UPDATE}' ]; then
+        cp '${WORKDIR}/${SWU_DESCRIPITION_FILE_DELTA_UPDATE}' '${WORKDIR}/swu-delta/${SWU_DESCRIPTION_FILE}'
+    fi
+
 
     for swu_file in "${WORKDIR}"/swu*; do
         swu_file_base=$(basename $swu_file)
-- 
2.39.2



