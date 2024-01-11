Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F44C47DAC
	for <webhook@archiver.kernel.org>; Thu, 11 Jan 2024 20:00:27 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.2396.1705003220053292853
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jan 2024 12:00:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=ULj8GdNm;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-2024011120001850d92f27cd5a9e9940-tcqhzy@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2024011120001850d92f27cd5a9e9940
        for <cip-dev@lists.cip-project.org>;
        Thu, 11 Jan 2024 21:00:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=2t8dBtjpvpiNRw0B3rozomNpA35PWh0+ITRoqxW2fS4=;
 b=ULj8GdNmSQamBqWK74nHX7i07DNxb92QgmtMRpfnHd+4YygC0SGNLpRmTaNLExfLg/qs4I
 Xqgz8bAS2ZTb/tgB17bIzv5GYPmmAJkM0WBqJbCTvnQX2oUNZCk+WtxOEmU7DW+i/lhFw6ny
 pGR5gxrhbP6PJfIY8jsMUltJZ3+rk=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 6/7] classes/swupdate: Generate swu containing only efibootguard
Date: Thu, 11 Jan 2024 20:59:50 +0100
Message-ID: <20240111200015.190376-7-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240111200015.190376-1-Quirin.Gylstorff@siemens.com>
References: <20240111200015.190376-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jan 2024 20:00:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14343

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to update the bootloader seperately from the rest of the
system.

It adds a new variable `SWU_DESCRIPITION_FILE_BOOTLOADER` for the
bootloader sw-descripition. The generated swu has the following naming
scheme ${SWU_IMAGE_FILE}-${SWU_BOOTLOADER}.swu.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate.bbclass                      | 102 +++++++++++-------
 .../images/swu/sw-description-ebg.tmpl        |  17 +++
 2 files changed, 81 insertions(+), 38 deletions(-)
 create mode 100644 recipes-core/images/swu/sw-description-ebg.tmpl

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 0f8ae23..8f1215d 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -25,15 +25,17 @@ SWU_HW_COMPAT ?= ""
 
 SWU_EBG_UPDATE ?= ""
 SWU_EFI_BOOT_DEVICE ?= "/dev/disk/by-uuid/4321-DCBA"
+SWU_BOOTLOADER ??= "ebg"
+SWU_DESCRIPITION_FILE_BOOTLOADER ??= "${SWU_DESCRIPTION_FILE}-${SWU_BOOTLOADER}"
 
-SWU_IMAGE_FILE ?= "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.swu"
+SWU_IMAGE_FILE ?= "${IMAGE_FULLNAME}"
 SWU_DESCRIPTION_FILE ?= "sw-description"
 SWU_ADDITIONAL_FILES ?= "linux.efi ${SWU_ROOTFS_PARTITION_NAME}"
 SWU_SIGNED ??= ""
 SWU_SIGNATURE_EXT ?= "sig"
 SWU_SIGNATURE_TYPE ?= "cms"
 
-SWU_BUILDCHROOT_IMAGE_FILE ?= "${PP_DEPLOY}/${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
+SWU_BUILDCHROOT_IMAGE_FILE ?= "${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
 
 IMAGE_TYPEDEP:swu = "${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
 IMAGER_BUILD_DEPS:swu += "${@'swupdate-certificates-key' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
@@ -42,7 +44,9 @@ IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SW
 
 
 IMAGE_SRC_URI:swu = "file://${SWU_DESCRIPTION_FILE}.tmpl"
+IMAGE_SRC_URI:swu += "file://${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
 IMAGE_TEMPLATE_FILES:swu = "${SWU_DESCRIPTION_FILE}.tmpl"
+IMAGE_TEMPLATE_FILES:swu += "${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
 IMAGE_TEMPLATE_VARS:swu = " \
     SWU_ROOTFS_PARTITION_NAME \
     TARGET_IMAGE_UUID \
@@ -53,6 +57,7 @@ IMAGE_TEMPLATE_VARS:swu = " \
     SWU_VERSION \
     SWU_NAME \
     SWU_FILE_NODES \
+    SWU_BOOTLOADER_FILE_NODE \
     "
 
 # Add the bootloader file
@@ -94,11 +99,11 @@ python add_swu_compression(){
         d.setVar('SWU_COMPRESSION_NODE', '')
 }
 
-SWU_EXTEND_SW_DESCRIPTION += "${@ 'add_ebg_update' if d.getVar('SWU_EBG_UPDATE') == '1' else ''}"
+SWU_EXTEND_SW_DESCRIPTION += "add_ebg_update"
 python add_ebg_update(){
    efi_boot_loader_file = efi_bootloader_name(d)
    efi_boot_device = d.getVar('SWU_EFI_BOOT_DEVICE')
-   swu_ebg_update_node = f""",
+   swu_ebg_update_node = f"""
    {{
           filename = "{efi_boot_loader_file}";
           path = "EFI/BOOT/{efi_boot_loader_file}";
@@ -110,7 +115,11 @@ python add_ebg_update(){
           }};
    }}
    """
-   d.appendVar('SWU_FILE_NODES', swu_ebg_update_node)
+
+   d.setVar('SWU_BOOTLOADER_FILE_NODE', swu_ebg_update_node)
+   ebg_update = d.getVar('SWU_EBG_UPDATE') or ""
+   if ebg_update:
+     d.appendVar('SWU_FILE_NODES', "," + swu_ebg_update_node)
    d.appendVar('SWU_ADDITIONAL_FILES', " " + efi_boot_loader_file)
 }
 
@@ -132,46 +141,63 @@ FILESEXTRAPATHS:append = ":${LAYERDIR_cip-core}/recipes-core/images/swu"
 
 do_image_swu[depends] += "${PN}:do_transform_template"
 do_image_swu[stamp-extra-info] = "${DISTRO}-${MACHINE}"
-do_image_swu[cleandirs] += "${WORKDIR}/swu"
+do_image_swu[cleandirs] += "${WORKDIR}/swu ${WORKDIR}/swu-${SWU_BOOTLOADER}"
 IMAGE_CMD:swu() {
-    rm -f '${SWU_IMAGE_FILE}'
+    rm -f '${DEPLOY_DIR_IMAGE}/${SWU_IMAGE_FILE}'*.swu
     cp '${WORKDIR}/${SWU_DESCRIPTION_FILE}' '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
+    if [ -f '${WORKDIR}/${SWU_DESCRIPITION_FILE_BOOTLOADER}' ]; then
+        cp '${WORKDIR}/${SWU_DESCRIPITION_FILE_BOOTLOADER}' '${WORKDIR}/swu-${SWU_BOOTLOADER}/${SWU_DESCRIPTION_FILE}'
+    fi
 
-    # Create symlinks for files used in the update image
-    for file in ${SWU_ADDITIONAL_FILES}; do
-        if [ -e "${WORKDIR}/$file" ]; then
-            ln -s "${PP_WORK}/$file" "${WORKDIR}/swu/$file"
-        else
-            ln -s "${PP_DEPLOY}/$file" "${WORKDIR}/swu/$file"
-        fi
-    done
-
-    # Prepare for signing
-    export sign='${@'x' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}'
-
-    imager_run -p -d ${PP_WORK} -u root <<'EOIMAGER'
-        # Fill in file check sums
+    for swu_file in "${WORKDIR}"/swu*; do
+        swu_file_base=$(basename $swu_file)
+        # Create symlinks for files used in the update image
         for file in ${SWU_ADDITIONAL_FILES}; do
-            sed -i "s:$file-sha256:$(sha256sum "${PP_WORK}/swu/"$file | cut -f 1 -d " "):g" \
-                "${PP_WORK}/swu/${SWU_DESCRIPTION_FILE}"
-        done
-        cd "${PP_WORK}/swu"
-        for file in "${SWU_DESCRIPTION_FILE}" ${SWU_ADDITIONAL_FILES}; do
-            # Set file timestamps for reproducible builds
-            if [ -n "${SOURCE_DATE_EPOCH}" ]; then
-                touch -d@"${SOURCE_DATE_EPOCH}" "$file"
+            if grep -q "$file" "${WORKDIR}/$swu_file_base/${SWU_DESCRIPTION_FILE}"; then
+                if [ -e "${WORKDIR}/$file" ]; then
+                    ln -s "${PP_WORK}/$file" "${WORKDIR}/$swu_file_base/$file"
+                else
+                    ln -s "${PP_DEPLOY}/$file" "${WORKDIR}/$swu_file_base/$file"
+                fi
             fi
-            echo "$file"
-            if [ -n "$sign" -a "${SWU_DESCRIPTION_FILE}" = "$file" ]; then
-                sign-swu "$file" "$file.${SWU_SIGNATURE_EXT}"
-                # Set file timestamps for reproducible builds
-                if [ -n "${SOURCE_DATE_EPOCH}" ]; then
-                    touch -d@"${SOURCE_DATE_EPOCH}" "$file.${SWU_SIGNATURE_EXT}"
+        done
+
+        # Prepare for signing
+        export sign='${@'x' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}'
+        export swu_file_base
+        # create a exetension to differ between swus
+        swu_file_extension=""
+        if [ "$swu_file_base" != "swu" ]; then
+            swu_file_extension=${swu_file_base#swu}
+        fi
+        export swu_file_extension
+        imager_run -p -d ${PP_WORK} -u root <<'EOIMAGER'
+            # Fill in file check sums
+            for file in ${SWU_ADDITIONAL_FILES}; do
+                sed -i "s:$file-sha256:$(sha256sum "${PP_WORK}/$swu_file_base/"$file | cut -f 1 -d " "):g" \
+                    "${PP_WORK}/$swu_file_base/${SWU_DESCRIPTION_FILE}"
+            done
+            cd "${PP_WORK}/$swu_file_base"
+            for file in "${SWU_DESCRIPTION_FILE}" ${SWU_ADDITIONAL_FILES}; do
+                if [ "$file" = "${SWU_DESCRIPTION_FILE}" ] || \
+                    grep -q "$file" "${PP_WORK}/$swu_file_base/${SWU_DESCRIPTION_FILE}"; then
+                    # Set file timestamps for reproducible builds
+                    if [ -n "${SOURCE_DATE_EPOCH}" ]; then
+                        touch -d@"${SOURCE_DATE_EPOCH}" "$file"
+                    fi
+                    echo "$file"
+                    if [ -n "$sign" -a "${SWU_DESCRIPTION_FILE}" = "$file" ]; then
+                        sign-swu "$file" "$file.${SWU_SIGNATURE_EXT}"
+                        # Set file timestamps for reproducible builds
+                        if [ -n "${SOURCE_DATE_EPOCH}" ]; then
+                            touch -d@"${SOURCE_DATE_EPOCH}" "$file.${SWU_SIGNATURE_EXT}"
+                        fi
+                        echo "$file.${SWU_SIGNATURE_EXT}"
+                    fi
                 fi
-                echo "$file.${SWU_SIGNATURE_EXT}"
-           fi
-        done | cpio -ovL --reproducible -H crc > "${SWU_BUILDCHROOT_IMAGE_FILE}"
+            done | cpio -ovL --reproducible -H crc > "${PP_DEPLOY}/${SWU_IMAGE_FILE}$swu_file_extension.swu"
 EOIMAGER
+    done
 }
 
 python do_check_swu_partition_uuids() {
diff --git a/recipes-core/images/swu/sw-description-ebg.tmpl b/recipes-core/images/swu/sw-description-ebg.tmpl
new file mode 100644
index 0000000..c19157c
--- /dev/null
+++ b/recipes-core/images/swu/sw-description-ebg.tmpl
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
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
+    files: (${SWU_BOOTLOADER_FILE_NODE});
+}
-- 
2.43.0


