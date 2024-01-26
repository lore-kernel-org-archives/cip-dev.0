Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08C8C47422
	for <webhook@archiver.kernel.org>; Fri, 26 Jan 2024 09:07:30 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.11829.1706260043222202379
 for <cip-dev@lists.cip-project.org>;
 Fri, 26 Jan 2024 01:07:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=ilGwWpCh;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20240126090720313c86753b2a102caa-yum96j@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240126090720313c86753b2a102caa
        for <cip-dev@lists.cip-project.org>;
        Fri, 26 Jan 2024 10:07:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=gEEuRKkUDSS0SdJcQFSA9lPJbrj85kr8mmRvu3V6Bj4=;
 b=ilGwWpChKUNPsQUvIQwr/lWRYKp2huYpmaz0LhtHYrX3tVB8f+GcLxFFjOQajqQBeTCLVh
 cJy9I8hfKI2ibvPDawex8/0JF0uuFKp9pfwYbItiq8Q3YX9U0eJfS1cGJnSbieJ1H/H/a3BS
 TCy3L4vnOtv5961WRAVblGjFOOEw4=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] swupdate.bbclass: Remove
Date: Fri, 26 Jan 2024 10:06:42 +0100
Message-ID: <20240126090719.634980-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Jan 2024 09:07:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14468

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This avoids a transient inclusion of efibootguard to all images due
to `swupdate` added as a FSTYPE in the layer.conf.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/efibootguard.bbclass | 29 +++++++++++++++++++++++++++++
 classes/swupdate.bbclass     | 30 ------------------------------
 2 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/classes/efibootguard.bbclass b/classes/efibootguard.bbclass
index 26291b7..31fcdcc 100644
--- a/classes/efibootguard.bbclass
+++ b/classes/efibootguard.bbclass
@@ -40,3 +40,32 @@ def distro_to_lib_arch(d):
     return DISTRO_TO_LIB_ARCH[distro_arch]
 
 EFI_LIB_ARCH := "${@distro_to_lib_arch(d)}"
+
+# Add the bootloader file
+def efi_bootloader_name(d):
+    efi_arch = distro_to_efi_arch(d)
+    return "boot{}.efi".format(efi_arch)
+
+SWU_EXTEND_SW_DESCRIPTION += "add_ebg_update"
+python add_ebg_update(){
+   efi_boot_loader_file = efi_bootloader_name(d)
+   efi_boot_device = d.getVar('SWU_EFI_BOOT_DEVICE')
+   swu_ebg_update_node = f"""
+   {{
+          filename = "{efi_boot_loader_file}";
+          path = "EFI/BOOT/{efi_boot_loader_file}";
+          device = "{efi_boot_device}";
+          filesystem = "vfat";
+          sha256 = "{efi_boot_loader_file}-sha256";
+          properties: {{
+               atomic-install = "true";
+          }};
+   }}
+   """
+
+   d.setVar('SWU_BOOTLOADER_FILE_NODE', swu_ebg_update_node)
+   ebg_update = d.getVar('SWU_EBG_UPDATE') or ""
+   if ebg_update:
+     d.appendVar('SWU_FILE_NODES', "," + swu_ebg_update_node)
+   d.appendVar('SWU_ADDITIONAL_FILES', " " + efi_boot_loader_file)
+}
diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 8f1215d..403bdef 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -11,7 +11,6 @@
 # SPDX-License-Identifier: MIT
 
 inherit template
-inherit efibootguard
 
 SWU_ROOTFS_TYPE ?= "squashfs"
 SWU_ROOTFS_NAME ?= "${IMAGE_FULLNAME}"
@@ -60,11 +59,6 @@ IMAGE_TEMPLATE_VARS:swu = " \
     SWU_BOOTLOADER_FILE_NODE \
     "
 
-# Add the bootloader file
-def efi_bootloader_name(d):
-    efi_arch = distro_to_efi_arch(d)
-    return "boot{}.efi".format(efi_arch)
-
 # TARGET_IMAGE_UUID needs to be generated before completing the template
 addtask do_transform_template after do_generate_image_uuid
 
@@ -99,30 +93,6 @@ python add_swu_compression(){
         d.setVar('SWU_COMPRESSION_NODE', '')
 }
 
-SWU_EXTEND_SW_DESCRIPTION += "add_ebg_update"
-python add_ebg_update(){
-   efi_boot_loader_file = efi_bootloader_name(d)
-   efi_boot_device = d.getVar('SWU_EFI_BOOT_DEVICE')
-   swu_ebg_update_node = f"""
-   {{
-          filename = "{efi_boot_loader_file}";
-          path = "EFI/BOOT/{efi_boot_loader_file}";
-          device = "{efi_boot_device}";
-          filesystem = "vfat";
-          sha256 = "{efi_boot_loader_file}-sha256";
-          properties: {{
-               atomic-install = "true";
-          }};
-   }}
-   """
-
-   d.setVar('SWU_BOOTLOADER_FILE_NODE', swu_ebg_update_node)
-   ebg_update = d.getVar('SWU_EBG_UPDATE') or ""
-   if ebg_update:
-     d.appendVar('SWU_FILE_NODES', "," + swu_ebg_update_node)
-   d.appendVar('SWU_ADDITIONAL_FILES', " " + efi_boot_loader_file)
-}
-
 # convert between swupdate compressor name and imagetype extension
 def get_swu_compression_type(d):
     swu_ct = d.getVar('SWU_COMPRESSION_TYPE')
-- 
2.43.0


