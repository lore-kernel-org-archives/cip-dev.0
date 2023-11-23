Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF39C5AD4C
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 10:29:36 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.88322.1700735369858814031
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Nov 2023 02:29:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=GJhK3Q3p;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20231123102927d16289eacfe2d4dcaf-lhisgl@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20231123102927d16289eacfe2d4dcaf
        for <cip-dev@lists.cip-project.org>;
        Thu, 23 Nov 2023 11:29:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=BgMCR2yA1DR+cpA2pWGqlzABlEpl0De5kVPeKm2zzt8=;
 b=GJhK3Q3pQImcAeNnDMwq5Wh874onIjyu73lbVUV0LDCkmiDOm25baowO+uOLHPXSeX82D6
 78Hi6BHP1Hn5rfJw1looruVuh6NS48YIfJRWeO0aMteODydBWXXr9wgAfpWzaq0dT0IjV0/R
 krnGQlIOv4snUSovYutIGGu7bzSu0=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC] swupdate: Add symmetric encryption
Date: Thu, 23 Nov 2023 11:18:21 +0100
Message-ID: <20231123102923.1405219-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Nov 2023 10:29:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13661

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

by setting the variable `SWU_ENCRYPTED = "1"` all files will be
encrypted with the symmetric key SWU_ENCRYPTED_KEY and
SWUPDATE_ENCRYPTED_IV.
This key will be stored on the device to decrypt a received *.swu.
The default location of the key is in /etc/swupdate as it can be
encrypted.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate.bbclass                      | 26 +++++++++++++++++--
 recipes-core/customizations/common.inc        | 12 ++++++---
 .../files/{swupdate.cfg => swupdate.cfg.tmpl} |  3 ++-
 recipes-core/images/swu/sw-description.tmpl   |  2 ++
 recipes-core/swupdate-key/swupdate-key_0.1.bb | 22 ++++++++++++++++
 5 files changed, 58 insertions(+), 7 deletions(-)
 rename recipes-core/customizations/files/{swupdate.cfg => swupdate.cfg.tmpl} (76%)
 create mode 100644 recipes-core/swupdate-key/swupdate-key_0.1.bb

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 38c2e0a..3f396a1 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -25,6 +25,9 @@ SWU_HW_COMPAT ?= ""
 SWU_IMAGE_FILE ?= "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.swu"
 SWU_DESCRIPTION_FILE ?= "sw-description"
 SWU_ADDITIONAL_FILES ?= "linux.efi ${SWU_ROOTFS_PARTITION_NAME}"
+SWU_ENCRYPTED ??= ""
+SWU_ENCRYPTED_KEY ?= ""
+SWU_ENCRYPTED_IV ?= ""
 SWU_SIGNED ??= ""
 SWU_SIGNATURE_EXT ?= "sig"
 SWU_SIGNATURE_TYPE ?= "cms"
@@ -35,6 +38,7 @@ IMAGE_TYPEDEP:swu = "${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
 IMAGER_BUILD_DEPS:swu += "${@'swupdate-certificates-key' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 IMAGER_INSTALL:swu += "cpio ${@'openssl swupdate-certificates-key' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
+IMAGE_INSTALL += "${@'swupdate-key' if bb.utils.to_boolean(d.getVar('SWU_ENCRYPTED')) else ''}"
 
 
 IMAGE_SRC_URI:swu = "file://${SWU_DESCRIPTION_FILE}.tmpl"
@@ -46,6 +50,7 @@ IMAGE_TEMPLATE_VARS:swu = " \
     ABROOTFS_PART_UUID_B \
     SWU_HW_COMPAT_NODE \
     SWU_COMPRESSION_NODE \
+    SWU_ENCRYPTION_NODE \
     SWU_VERSION \
     SWU_NAME"
 
@@ -68,6 +73,15 @@ python(){
         d.setVar('SWU_COMPRESSION_NODE', 'compressed = "' + calgo + '";')
     else:
         d.setVar('SWU_COMPRESSION_NODE', '')
+    # create SWU_ENCRYPTION_NODE node if encryption is enabled
+    encrypted = d.getVar('SWU_ENCRYPTED')
+    if encrypted:
+        encrypted_iv = d.getVar('SWU_ENCRYPTED_IV')
+        if not encrypted_iv:
+            bb.fatal('SWU_ENCRYPTED_IV is not set!')
+        d.setVar('SWU_ENCRYPTION_NODE', 'encrypted = true;\n\tivt = "' + encrypted_iv + '";')
+    else:
+        d.setVar('SWU_ENCRYPTION_NODE', '')
 }
 
 
@@ -94,21 +108,29 @@ IMAGE_CMD:swu() {
     rm -f '${SWU_IMAGE_FILE}'
     cp '${WORKDIR}/${SWU_DESCRIPTION_FILE}' '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
 
+    export encrypted='${@'x' if bb.utils.to_boolean(d.getVar('SWU_ENCRYPTED')) else ''}'
     # Create symlinks for files used in the update image
     for file in ${SWU_ADDITIONAL_FILES}; do
         if [ -e "${WORKDIR}/$file" ]; then
             ln -s "${PP_WORK}/$file" "${WORKDIR}/swu/$file"
         else
-            ln -s "${PP_DEPLOY}/$file" "${WORKDIR}/swu/$file"
+            if [ -n "$encrypted" ]; then
+                cp "${DEPLOY_DIR_IMAGE}/$file" "${WORKDIR}/swu/$file"
+            else
+                ln -s "${PP_DEPLOY}/$file" "${WORKDIR}/swu/$file"
+            fi
         fi
     done
-
     # Prepare for signing
     export sign='${@'x' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}'
 
     imager_run -p -d ${PP_WORK} -u root <<'EOIMAGER'
         # Fill in file check sums
         for file in ${SWU_ADDITIONAL_FILES}; do
+            if [ -n "$encrypted" ] ; then
+                openssl enc -aes-256-cbc -in "${PP_WORK}/swu/$file" -out "${PP_WORK}/swu/$file.enc" -K ${SWU_ENCRYPTED_KEY} -iv ${SWU_ENCRYPTED_IV}
+                mv "${PP_WORK}/swu/$file.enc" "${PP_WORK}/swu/$file"
+            fi
             sed -i "s:$file-sha256:$(sha256sum "${PP_WORK}/swu/"$file | cut -f 1 -d " "):g" \
                 "${PP_WORK}/swu/${SWU_DESCRIPTION_FILE}"
         done
diff --git a/recipes-core/customizations/common.inc b/recipes-core/customizations/common.inc
index 79bf80d..d1f1330 100644
--- a/recipes-core/customizations/common.inc
+++ b/recipes-core/customizations/common.inc
@@ -19,22 +19,26 @@ SRC_URI = " \
     file://99-silent-printk.conf \
     file://99-watchdog.conf"
 
-SRC_URI:append:swupdate = " file://swupdate.cfg"
+SRC_URI:append:swupdate = " file://swupdate.cfg.tmpl"
 
 CUSTOM_HOSTNAME ??= "demo"
 WIRELESS_FIRMWARE_PACKAGE ?= ""
 INSTALL_WIRELESS_TOOLS ??= "0"
 
-TEMPLATE_FILES += "postinst.tmpl"
-TEMPLATE_VARS += "CUSTOM_HOSTNAME"
+TEMPLATE_FILES += "postinst.tmpl swupdate.cfg.tmpl"
+TEMPLATE_VARS += "CUSTOM_HOSTNAME SWU_KEY_LOCATION"
 
 DEPENDS += "sshd-regen-keys change-root-homedir"
+DEPENDS += "${@'swupdate-key' if bb.utils.to_boolean(d.getVar('SWU_ENCRYPTED')) else ''}"
+SWU_KEY_LOCATION = "${@'/etc/swupdate/swupdate.key' if bb.utils.to_boolean(d.getVar('SWU_ENCRYPTED')) else ''}"
 
 DEBIAN_DEPENDS = " \
     ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys, \
     change-root-homedir \
     ${@(', iw, wireless-regdb, ' + d.getVar('WIRELESS_FIRMWARE_PACKAGE')) \
-	if d.getVar('INSTALL_WIRELESS_TOOLS') == '1' else ''}"
+	if d.getVar('INSTALL_WIRELESS_TOOLS') == '1' else ''} \
+    ${@'swupdate-key' if bb.utils.to_boolean(d.getVar('SWU_ENCRYPTED')) else ''} \
+    "
 
 do_install() {
 	install -v -d ${D}/etc/network/interfaces.d
diff --git a/recipes-core/customizations/files/swupdate.cfg b/recipes-core/customizations/files/swupdate.cfg.tmpl
similarity index 76%
rename from recipes-core/customizations/files/swupdate.cfg
rename to recipes-core/customizations/files/swupdate.cfg.tmpl
index 3e2b45c..a985a40 100644
--- a/recipes-core/customizations/files/swupdate.cfg
+++ b/recipes-core/customizations/files/swupdate.cfg.tmpl
@@ -1,5 +1,6 @@
 globals :
 {
     bootloader = "ebg";
-    public-key-file = "/usr/share/swupdate-signing/swupdate-sign.crt"
+    public-key-file = "/usr/share/swupdate-signing/swupdate-sign.crt";
+    ${SWU_KEY_LOCATION}
 };
diff --git a/recipes-core/images/swu/sw-description.tmpl b/recipes-core/images/swu/sw-description.tmpl
index 6b53a3c..75bedc0 100644
--- a/recipes-core/images/swu/sw-description.tmpl
+++ b/recipes-core/images/swu/sw-description.tmpl
@@ -17,6 +17,7 @@ software =
             filename = "${SWU_ROOTFS_PARTITION_NAME}";
             device = "C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOTFS_PART_UUID_B}";
             type = "roundrobin";
+            ${SWU_ENCRYPTION_NODE}
             ${SWU_COMPRESSION_NODE}
             properties: {
                         subtype = "image";
@@ -30,6 +31,7 @@ software =
             type = "roundrobin";
             device = "C:BOOT0:linux.efi->BOOT0,C:BOOT1:linux.efi->BOOT1";
             filesystem = "vfat";
+            ${SWU_ENCRYPTION_NODE}
             properties: {
                         subtype = "kernel";
             };
diff --git a/recipes-core/swupdate-key/swupdate-key_0.1.bb b/recipes-core/swupdate-key/swupdate-key_0.1.bb
new file mode 100644
index 0000000..ce75f26
--- /dev/null
+++ b/recipes-core/swupdate-key/swupdate-key_0.1.bb
@@ -0,0 +1,22 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg-raw
+DESCRIPTION = "Add symmetric key for swupdate "
+
+SWU_ENCRYPTED_KEY ?= ""
+SWU_ENCRYPTED_IV ?= ""
+
+do_install[cleandirs] = "${D}/etc/swupdate/"
+do_install () {
+    if [ -n ${SWU_ENCRYPTED_KEY} ] && [ -n ${SWU_ENCRYPTED_IV} ] ; then
+        echo "${SWU_ENCRYPTED_KEY} ${SWU_ENCRYPTED_IV}" > ${D}/etc/swupdate/swupdate.key
+    fi
+}
-- 
2.42.0


