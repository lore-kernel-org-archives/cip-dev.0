Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B42CD11DC
	for <webhook@archiver.kernel.org>; Wed, 20 Mar 2024 10:32:01 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.40306.1710930717437342179
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Mar 2024 03:31:57 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 42KAVsv72310932; Wed, 20 Mar 2024 19:31:55 +0900
X-Iguazu-Qid: 2rWgsWh2CfKM0v34CG
X-Iguazu-QSIG: v=2; s=0; t=1710930714; q=2rWgsWh2CfKM0v34CG; m=F6/9kRZY/D7+UfCcsxridlJ2rC+940ZlOnYGvt9EaBA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 42KAVqrg849698
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 20 Mar 2024 19:31:54 +0900
From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, adithya.balakumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][RFC v2 3/4] swupdate.bbclass: Generate swu for delta updates
Date: Wed, 20 Mar 2024 16:02:28 +0530
X-TSB-HOP2: ON
Message-Id: <20240320103229.1078738-4-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240320103229.1078738-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20240320103229.1078738-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Mar 2024 10:31:46.0724 (UTC) FILETIME=[CF570E40:01DA7AB1]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Mar 2024 10:32:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15383

This allows the creation of a swu file for delta update.

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 classes/swupdate.bbclass                      | 32 ++++++++++++++-
 .../images/swu/sw-description-delta.tmpl      | 39 +++++++++++++++++++
 2 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 recipes-core/images/swu/sw-description-delta.tmpl

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index e23261d..1c495da 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -26,10 +26,12 @@ SWU_EBG_UPDATE ?= ""
 SWU_EFI_BOOT_DEVICE ?= "/dev/disk/by-uuid/4321-DCBA"
 SWU_BOOTLOADER ??= "ebg"
 SWU_DESCRIPITION_FILE_BOOTLOADER ??= "${SWU_DESCRIPTION_FILE}-${SWU_BOOTLOADER}"
+SWU_DESCRIPITION_FILE_DELTA_UPDATE ??= "${SWU_DESCRIPTION_FILE}-delta"
+SWU_DELTA_UPDATE_ARTIFACT = "${SWU_ROOTFS_NAME}.delta_update${@get_swu_compression_type(d)}"
+SWU_DELTA_UPDATE_ARTIFACT_TYPE = "delta_update${@get_swu_compression_type(d)}"
 
 SWU_IMAGE_FILE ?= "${IMAGE_FULLNAME}"
 SWU_DESCRIPTION_FILE ?= "sw-description"
-SWU_ADDITIONAL_FILES ?= "linux.efi ${SWU_ROOTFS_PARTITION_NAME}"
 SWU_SIGNED ??= ""
 SWU_SIGNATURE_EXT ?= "sig"
 SWU_SIGNATURE_TYPE ?= "cms"
@@ -37,6 +39,7 @@ SWU_SIGNATURE_TYPE ?= "cms"
 SWU_BUILDCHROOT_IMAGE_FILE ?= "${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
 
 IMAGE_TYPEDEP:swu = "${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
+IMAGE_TYPEDEP:swu += "${@ '${SWU_DELTA_UPDATE_ARTIFACT_TYPE}' if d.getVar('DELTA_UPDATE_TYPE') else ''}"
 IMAGER_BUILD_DEPS:swu += "${@'swupdate-certificates-key' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 IMAGER_INSTALL:swu += "cpio ${@'openssl swupdate-certificates-key' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
@@ -44,8 +47,10 @@ IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SW
 
 IMAGE_SRC_URI:swu = "file://${SWU_DESCRIPTION_FILE}.tmpl"
 IMAGE_SRC_URI:swu += "file://${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
+IMAGE_SRC_URI:delta_update += "file://${SWU_DESCRIPITION_FILE_DELTA_UPDATE}.tmpl"
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
+    SWU_DELTA_UPDATE_PROPERTIES \
     "
 
 # TARGET_IMAGE_UUID needs to be generated before completing the template
@@ -148,6 +155,22 @@ python add_scripts_node() {
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
@@ -167,13 +190,20 @@ FILESEXTRAPATHS:append = ":${LAYERDIR_cip-core}/recipes-core/images/swu"
 do_image_swu[depends] += "${PN}:do_transform_template"
 do_image_swu[stamp-extra-info] = "${DISTRO}-${MACHINE}"
 do_image_swu[cleandirs] += "${WORKDIR}/swu ${WORKDIR}/swu-${SWU_BOOTLOADER}"
+do_image_swu[cleandirs] += "${@ d.getVar("WORKDIR")+'/swu-delta' if d.getVar("DELTA_UPDATE_TYPE") else ''}"
 do_image_swu[prefuncs] = "do_extend_sw_description"
 IMAGE_CMD:swu() {
     rm -f '${DEPLOY_DIR_IMAGE}/${SWU_IMAGE_FILE}'*.swu
+    if [ -z "${DELTA_UPDATE_TYPE}" ]; then
+        rm -rf ${WORKDIR}/swu-delta
+    fi
     cp '${WORKDIR}/${SWU_DESCRIPTION_FILE}' '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
     if [ -f '${WORKDIR}/${SWU_DESCRIPITION_FILE_BOOTLOADER}' ]; then
         cp '${WORKDIR}/${SWU_DESCRIPITION_FILE_BOOTLOADER}' '${WORKDIR}/swu-${SWU_BOOTLOADER}/${SWU_DESCRIPTION_FILE}'
     fi
+    if [ ! -z "${DELTA_UPDATE_TYPE}" ] && [ -f '${WORKDIR}/${SWU_DESCRIPITION_FILE_DELTA_UPDATE}' ]; then
+        cp '${WORKDIR}/${SWU_DESCRIPITION_FILE_DELTA_UPDATE}' '${WORKDIR}/swu-delta/${SWU_DESCRIPTION_FILE}'
+    fi
 
     for swu_file in "${WORKDIR}"/swu*; do
         swu_file_base=$(basename $swu_file)
diff --git a/recipes-core/images/swu/sw-description-delta.tmpl b/recipes-core/images/swu/sw-description-delta.tmpl
new file mode 100644
index 0000000..7f7d623
--- /dev/null
+++ b/recipes-core/images/swu/sw-description-delta.tmpl
@@ -0,0 +1,39 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2020
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+software =
+{
+    version = "${SWU_VERSION}";
+    name = "${SWU_NAME}";
+    ${SWU_HW_COMPAT_NODE}
+    images: ({
+            filename = "${SWU_DELTA_UPDATE_ARTIFACT}";
+            device = "C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOTFS_PART_UUID_B}";
+            type = "roundrobin";
+            ${SWU_COMPRESSION_NODE}
+            properties: {
+                        subtype = "image";
+                        configfilecheck = "/etc/os-release@not_match@IMAGE_UUID=${TARGET_IMAGE_UUID}";
+			${SWU_DELTA_UPDATE_PROPERTIES}
+            };
+            sha256 = "${SWU_DELTA_UPDATE_ARTIFACT}-sha256";
+    });
+    files: ({
+            filename = "linux.efi";
+            path = "linux.efi";
+            type = "roundrobin";
+            device = "C:BOOT0:linux.efi->BOOT0,C:BOOT1:linux.efi->BOOT1";
+            filesystem = "vfat";
+            properties: {
+                        subtype = "kernel";
+            };
+            sha256 = "linux.efi-sha256";
+    }${SWU_FILE_NODES});
+}
-- 
2.39.2



