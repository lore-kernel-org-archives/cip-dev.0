Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE107C25B4F
	for <webhook@archiver.kernel.org>; Tue,  7 May 2024 09:14:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.7201.1715073258288174807
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 May 2024 02:14:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 4479EGBg3257108; Tue, 7 May 2024 18:14:16 +0900
X-Iguazu-Qid: 2yAbrn6vFUkJaO52I7
X-Iguazu-QSIG: v=2; s=0; t=1715073256; q=2yAbrn6vFUkJaO52I7; m=tff3F6bz9c+mkrr+9G1ymU3T/4ZWpvNyTghkIkUYOso=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 4479EFxH1182938
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 7 May 2024 18:14:16 +0900
From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: quirin.gylstorff@siemens.com, felix.moessbauer@siemens.com,
        shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v6 2/4] swupdate.bbclass: Generate swu for delta updates
Date: Tue,  7 May 2024 14:44:30 +0530
X-TSB-HOP2: ON
Message-Id: <20240507091432.895626-3-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240507091432.895626-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20240507091432.895626-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 May 2024 09:14:11.0140 (UTC) FILETIME=[EC395040:01DAA05E]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 May 2024 09:14:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15852

This allows the creation of a swu file for delta update when a delta
update is chosen through the DELTA_UPDATE_TYPE variable

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 classes/swupdate.bbclass                    | 32 +++++++++++++++++++--
 recipes-core/images/swu/sw-description.tmpl |  5 ++--
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 1a7cd4d..e91238d 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -26,17 +26,26 @@ SWU_EBG_UPDATE ?= ""
 SWU_EFI_BOOT_DEVICE ?= "/dev/disk/by-uuid/4321-DCBA"
 SWU_BOOTLOADER ??= "ebg"
 SWU_DESCRIPITION_FILE_BOOTLOADER ??= "${SWU_DESCRIPTION_FILE}-${SWU_BOOTLOADER}"
+SWU_DELTA_UPDATE_ARTIFACT = "${SWU_ROOTFS_NAME}.delta_update${@get_swu_compression_type(d)}"
+SWU_ROOTFS_ARTIFACT_NAME = "${@ '${SWU_DELTA_UPDATE_ARTIFACT}' \
+    if d.getVar('DELTA_UPDATE_TYPE') == "rdiff" or d.getVar('DELTA_UPDATE_TYPE') == "zchunk" \
+    else '${SWU_ROOTFS_PARTITION_NAME}'}"
 
 SWU_IMAGE_FILE ?= "${IMAGE_FULLNAME}"
 SWU_DESCRIPTION_FILE ?= "sw-description"
-SWU_ADDITIONAL_FILES ?= "linux.efi ${SWU_ROOTFS_PARTITION_NAME}"
+SWU_ADDITIONAL_FILES ?= "linux.efi ${SWU_ROOTFS_ARTIFACT_NAME}"
 SWU_SIGNED ??= ""
 SWU_SIGNATURE_EXT ?= "sig"
 SWU_SIGNATURE_TYPE ?= "cms"
 
 SWU_BUILDCHROOT_IMAGE_FILE ?= "${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
 
-IMAGE_TYPEDEP:swu = "${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
+SWU_UPDATE_ARTIFACT_TYPE = "${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
+SWU_DELTA_UPDATE_ARTIFACT_TYPE = "delta_update${@get_swu_compression_type(d)}"
+IMAGE_TYPEDEP:swu = "${@ '${SWU_DELTA_UPDATE_ARTIFACT_TYPE}' \
+    if d.getVar('DELTA_UPDATE_TYPE') == "rdiff" or d.getVar('DELTA_UPDATE_TYPE') == "zchunk" \
+    else '${SWU_UPDATE_ARTIFACT_TYPE}' }"
+
 IMAGER_BUILD_DEPS:swu += "${@'swupdate-certificates-key' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 IMAGER_INSTALL:swu += "cpio ${@'openssl swupdate-certificates-key' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
@@ -47,7 +56,7 @@ IMAGE_SRC_URI:swu += "file://${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
 IMAGE_TEMPLATE_FILES:swu = "${SWU_DESCRIPTION_FILE}.tmpl"
 IMAGE_TEMPLATE_FILES:swu += "${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
 IMAGE_TEMPLATE_VARS:swu = " \
-    SWU_ROOTFS_PARTITION_NAME \
+    SWU_ROOTFS_ARTIFACT_NAME \
     TARGET_IMAGE_UUID \
     ABROOTFS_PART_UUID_A \
     ABROOTFS_PART_UUID_B \
@@ -58,6 +67,7 @@ IMAGE_TEMPLATE_VARS:swu = " \
     SWU_FILE_NODES \
     SWU_BOOTLOADER_FILE_NODE \
     SWU_SCRIPTS_NODE \
+    SWU_DELTA_UPDATE_PROPERTIES \
     "
 
 # TARGET_IMAGE_UUID needs to be generated before completing the template
@@ -148,6 +158,22 @@ python add_scripts_node() {
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
+    d.setVar('SWU_DELTA_UPDATE_PROPERTIES', swu_delta_update_properties)
+}
+
 # convert between swupdate compressor name and imagetype extension
 def get_swu_compression_type(d):
     swu_ct = d.getVar('SWU_COMPRESSION_TYPE')
diff --git a/recipes-core/images/swu/sw-description.tmpl b/recipes-core/images/swu/sw-description.tmpl
index 88cb475..eeb8fc2 100644
--- a/recipes-core/images/swu/sw-description.tmpl
+++ b/recipes-core/images/swu/sw-description.tmpl
@@ -14,15 +14,16 @@ software =
     name = "${SWU_NAME}";
     ${SWU_HW_COMPAT_NODE}
     images: ({
-            filename = "${SWU_ROOTFS_PARTITION_NAME}";
+            filename = "${SWU_ROOTFS_ARTIFACT_NAME}";
             device = "C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOTFS_PART_UUID_B}";
             type = "roundrobin";
             ${SWU_COMPRESSION_NODE}
             properties: {
                         subtype = "image";
                         configfilecheck = "/etc/os-release@not_match@IMAGE_UUID=${TARGET_IMAGE_UUID}";
+                        ${SWU_DELTA_UPDATE_PROPERTIES}
             };
-            sha256 = "${SWU_ROOTFS_PARTITION_NAME}-sha256";
+            sha256 = "${SWU_ROOTFS_ARTIFACT_NAME}-sha256";
     });
     files: ({
             filename = "linux.efi";
-- 
2.39.2



