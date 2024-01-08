Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F130C47422
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 10:26:54 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web11.3830.1704709602844891662
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jan 2024 02:26:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Kr5xZumD;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-51332-20240108102640a4d37fbeb36121538d-23nfbq@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20240108102640a4d37fbeb36121538d
        for <cip-dev@lists.cip-project.org>;
        Mon, 08 Jan 2024 11:26:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=VFMresEGEC2+Wf485b0y3AB3+Zdr1GLHzwF0CrRZ0so=;
 b=Kr5xZumDbC8h1n/V0x2JPtRAfnpNXmKza3Y0psRcw+nDuWO4yn/HmMb8KFLI8t9SgWisk9
 U6QgX13YIALlR2vFEGMEcCvjMnsvggwGkuDk+NQTywVe46hfhEl7iBDcx1ZNyr8QwBAB2y/O
 0RuRpoRjxGh5cIu0vSyRbik3gdFJQ=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v4 5/6] swupdate: Extend sw-description to update efibootguard
Date: Mon,  8 Jan 2024 11:25:53 +0100
Message-ID: <20240108102638.2966221-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240108102638.2966221-1-Quirin.Gylstorff@siemens.com>
References: <20240108102638.2966221-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jan 2024 10:26:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14272

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If the variable `SWU_EBG_UPDATE` is set to `1` an additional file
element is added to the sw-description to replace the ebg.

Use python as newlines are part of the sw-description syntax an
therefore cannot be hold in a bitbake variable, see note in[1].

The efibootguard binary has the property 'atomic-install' which
copies the file to a tempory location before replacing the original with
new file[2].

IMPORTANT: Even if the property 'atomic-install' is set FAT does not
support atomic writes or renames so a powercut can still corrupt the
system[3].

[1]: https://docs.yoctoproject.org/bitbake/2.2/bitbake-user-manual/bitbake-user-manual-metadata.html#line-joining
[2]: https://sbabic.github.io/swupdate/sw-description.html#files
[3]: https://lore.kernel.org/linux-fsdevel/20191022105413.pj6i3ydetnfgnkzh@pali/

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate.bbclass                    | 34 +++++++++++++++++++--
 recipes-core/images/swu/sw-description.tmpl |  2 +-
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index dfe8ef1..0f8ae23 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2020-2023
+# Copyright (c) Siemens AG, 2020-2024
 #
 # Authors:
 #  Christian Storm <christian.storm@siemens.com>
@@ -11,6 +11,7 @@
 # SPDX-License-Identifier: MIT
 
 inherit template
+inherit efibootguard
 
 SWU_ROOTFS_TYPE ?= "squashfs"
 SWU_ROOTFS_NAME ?= "${IMAGE_FULLNAME}"
@@ -22,6 +23,9 @@ SWU_NAME ?= "cip software update"
 # space separated list of supported hw. Leave empty to leave out
 SWU_HW_COMPAT ?= ""
 
+SWU_EBG_UPDATE ?= ""
+SWU_EFI_BOOT_DEVICE ?= "/dev/disk/by-uuid/4321-DCBA"
+
 SWU_IMAGE_FILE ?= "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.swu"
 SWU_DESCRIPTION_FILE ?= "sw-description"
 SWU_ADDITIONAL_FILES ?= "linux.efi ${SWU_ROOTFS_PARTITION_NAME}"
@@ -47,7 +51,14 @@ IMAGE_TEMPLATE_VARS:swu = " \
     SWU_HW_COMPAT_NODE \
     SWU_COMPRESSION_NODE \
     SWU_VERSION \
-    SWU_NAME"
+    SWU_NAME \
+    SWU_FILE_NODES \
+    "
+
+# Add the bootloader file
+def efi_bootloader_name(d):
+    efi_arch = distro_to_efi_arch(d)
+    return "boot{}.efi".format(efi_arch)
 
 # TARGET_IMAGE_UUID needs to be generated before completing the template
 addtask do_transform_template after do_generate_image_uuid
@@ -83,6 +94,25 @@ python add_swu_compression(){
         d.setVar('SWU_COMPRESSION_NODE', '')
 }
 
+SWU_EXTEND_SW_DESCRIPTION += "${@ 'add_ebg_update' if d.getVar('SWU_EBG_UPDATE') == '1' else ''}"
+python add_ebg_update(){
+   efi_boot_loader_file = efi_bootloader_name(d)
+   efi_boot_device = d.getVar('SWU_EFI_BOOT_DEVICE')
+   swu_ebg_update_node = f""",
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
+   d.appendVar('SWU_FILE_NODES', swu_ebg_update_node)
+   d.appendVar('SWU_ADDITIONAL_FILES', " " + efi_boot_loader_file)
+}
 
 # convert between swupdate compressor name and imagetype extension
 def get_swu_compression_type(d):
diff --git a/recipes-core/images/swu/sw-description.tmpl b/recipes-core/images/swu/sw-description.tmpl
index 6b53a3c..c52372c 100644
--- a/recipes-core/images/swu/sw-description.tmpl
+++ b/recipes-core/images/swu/sw-description.tmpl
@@ -34,5 +34,5 @@ software =
                         subtype = "kernel";
             };
             sha256 = "linux.efi-sha256";
-    });
+    }${SWU_FILE_NODES});
 }
-- 
2.43.0


