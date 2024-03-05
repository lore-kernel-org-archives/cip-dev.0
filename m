Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DD7C54798
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 11:05:44 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.20145.1709636736840194343
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Mar 2024 03:05:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=On7jnOKV;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20240305110313f80ebd3b307855f1b3-3pjoup@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240305110313f80ebd3b307855f1b3
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 Mar 2024 12:05:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=YNpxQQAUr5Cj+pSMthy93Vwi95vCRXnuxZe+zA2F49I=;
 b=On7jnOKVdxm/ygjfJ+K74ixl3Zu23HbBRl3MvsfTXYDK1m2LFTkif7v+5SvH/vdF3sw8pj
 +H0BND95Rqc6FnLeYU7Gj9zgINbOTK0H9kDYXgAfdUs0oBN/7mYYRJdH7vjRQQLNyWHsNbYD
 97BJeXvklutJ1QES2ecKcWVcvk2p4=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 4/4] fix do not add files to each image recipe
Date: Tue,  5 Mar 2024 12:02:46 +0100
Message-ID: <20240305110311.2073425-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240305110311.2073425-1-Quirin.Gylstorff@siemens.com>
References: <20240305110311.2073425-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 11:05:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15219

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Due to the use of an anonym python function each image recipe was
partial build even if not requested.
To avoid this remove the anonym image function by adding
it as an prefunc to do_image_swu and do_transform_template.

The SRC_URI is appended with a function.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/efibootguard.bbclass |  1 -
 classes/swupdate.bbclass     | 42 ++++++++++++++++++++++++------------
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/classes/efibootguard.bbclass b/classes/efibootguard.bbclass
index 31fcdcc..2b4f09e 100644
--- a/classes/efibootguard.bbclass
+++ b/classes/efibootguard.bbclass
@@ -67,5 +67,4 @@ python add_ebg_update(){
    ebg_update = d.getVar('SWU_EBG_UPDATE') or ""
    if ebg_update:
      d.appendVar('SWU_FILE_NODES', "," + swu_ebg_update_node)
-   d.appendVar('SWU_ADDITIONAL_FILES', " " + efi_boot_loader_file)
 }
diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index c62f43f..c82d20c 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -63,7 +63,7 @@ IMAGE_TEMPLATE_VARS:swu = " \
 # TARGET_IMAGE_UUID needs to be generated before completing the template
 addtask do_transform_template after do_generate_image_uuid
 
-python(){
+python do_extend_sw_description(){
     cmds = d.getVar("SWU_EXTEND_SW_DESCRIPTION")
     if cmds is None or not cmds.strip():
         return
@@ -71,6 +71,7 @@ python(){
     for cmd in cmds:
         bb.build.exec_func(cmd, d)
 }
+do_transform_template[prefuncs] += "do_extend_sw_description"
 
 SWU_EXTEND_SW_DESCRIPTION += "add_swu_hw_compat"
 python add_swu_hw_compat(){
@@ -94,9 +95,22 @@ python add_swu_compression(){
         d.setVar('SWU_COMPRESSION_NODE', '')
 }
 
+def add_scripts_to_src_uri(d):
+    swu_scripts = d.getVar('SWU_SCRIPTS')
+    if not swu_scripts:
+        return ""
+    swu_script_entries = swu_scripts.split()
+    script_file_list = []
+    for entry in swu_script_entries:
+        script_entry = f"SWU_SCRIPT_{entry}"
+        script_file = d.getVarFlag(script_entry, "file")
+        script_file_list.append(f" file://{script_file}")
+    return ' '.join([n for n in script_file_list])
 
-SWU_EXTEND_SW_DESCRIPTION += "add_scripts"
-python add_scripts(){
+SRC_URI += "${@add_scripts_to_src_uri(d)}"
+
+SWU_EXTEND_SW_DESCRIPTION += "add_scripts_node"
+python add_scripts_node(){
     swu_scripts = d.getVar('SWU_SCRIPTS')
     if not swu_scripts:
         return
@@ -129,8 +143,6 @@ python add_scripts(){
           sha256 = "{script_file}-sha256";
         }}"""
         script_node_list.append(node)
-        d.appendVar('SWU_ADDITIONAL_FILES', " " + script_file)
-        d.appendVar('SRC_URI', f" file://{script_file}")
 
     swu_scripts_node = "scripts: (" + ','.join([n for n in script_node_list]) + ");"
     d.appendVar('SWU_SCRIPTS_NODE', swu_scripts_node)
@@ -155,6 +167,7 @@ FILESEXTRAPATHS:append = ":${LAYERDIR_cip-core}/recipes-core/images/swu"
 do_image_swu[depends] += "${PN}:do_transform_template"
 do_image_swu[stamp-extra-info] = "${DISTRO}-${MACHINE}"
 do_image_swu[cleandirs] += "${WORKDIR}/swu ${WORKDIR}/swu-${SWU_BOOTLOADER}"
+do_image_swu[prefuncs] = "do_extend_sw_description"
 IMAGE_CMD:swu() {
     rm -f '${DEPLOY_DIR_IMAGE}/${SWU_IMAGE_FILE}'*.swu
     cp '${WORKDIR}/${SWU_DESCRIPTION_FILE}' '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
@@ -165,13 +178,14 @@ IMAGE_CMD:swu() {
     for swu_file in "${WORKDIR}"/swu*; do
         swu_file_base=$(basename $swu_file)
         # Create symlinks for files used in the update image
-        for file in ${SWU_ADDITIONAL_FILES}; do
-            if grep -q "$file" "${WORKDIR}/$swu_file_base/${SWU_DESCRIPTION_FILE}"; then
-                if [ -e "${WORKDIR}/$file" ]; then
-                    ln -s "${PP_WORK}/$file" "${WORKDIR}/$swu_file_base/$file"
-                else
-                    ln -s "${PP_DEPLOY}/$file" "${WORKDIR}/$swu_file_base/$file"
-                fi
+        swu_files=$(awk '$1=="filename"{gsub(/[",;]/, "", $3); print $3}' \
+            "${WORKDIR}/$swu_file_base/${SWU_DESCRIPTION_FILE}")
+        export swu_files
+        for file in $swu_files; do
+            if [ -e "${WORKDIR}/$file" ]; then
+                ln -s "${PP_WORK}/$file" "${WORKDIR}/$swu_file_base/$file"
+            else
+                ln -s "${PP_DEPLOY}/$file" "${WORKDIR}/$swu_file_base/$file"
             fi
         done
 
@@ -186,7 +200,7 @@ IMAGE_CMD:swu() {
         export swu_file_extension
         imager_run -p -d ${PP_WORK} -u root <<'EOIMAGER'
             # Fill in file check sums
-            for file in ${SWU_ADDITIONAL_FILES}; do
+            for file in $swu_files; do
                 sed -i "s:$file-sha256:$(sha256sum "${PP_WORK}/$swu_file_base/"$file | cut -f 1 -d " "):g" \
                     "${PP_WORK}/$swu_file_base/${SWU_DESCRIPTION_FILE}"
             done
@@ -205,7 +219,7 @@ IMAGE_CMD:swu() {
             fi
 
             # sw-description must be first file in *.swu
-            for cpio_file in $cpio_files ${SWU_ADDITIONAL_FILES}; do
+            for cpio_file in $cpio_files $swu_files; do
                 if [ -f "$cpio_file" ]; then
                     # Set file timestamps for reproducible builds
                     if [ -n "${SOURCE_DATE_EPOCH}" ]; then
-- 
2.43.0


