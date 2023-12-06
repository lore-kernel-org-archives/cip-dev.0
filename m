Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6689BC10F07
	for <webhook@archiver.kernel.org>; Wed,  6 Dec 2023 14:35:38 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.32787.1701873332272314546
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Dec 2023 06:35:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=TVpU0MZ6;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20231206143529fec8ecccf5fec10b6c-hn3hrx@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20231206143529fec8ecccf5fec10b6c
        for <cip-dev@lists.cip-project.org>;
        Wed, 06 Dec 2023 15:35:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=+NQTBB/VFklC46ERz6Gu+NZmE/XqwEpwSOq5fGrL7A4=;
 b=TVpU0MZ611+00IbQX/lRILeEpd8z2jm7WySpCyrGThpCJv98yi/9hf+GzAHNsKtn+MurbP
 qAdjQeTFr937fKTkQmiCmwb5fgkVUHjEjwJ1YV+QEbxLYWa6GxpurM5BLO3tT0xEswbPzyGj
 zAt9DLzfpMki61Ik4j6b5IYHt9i80=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][RFC 2/2] swupdate.bbclass: Add boot<ARCH>.efi to swu
Date: Wed,  6 Dec 2023 15:33:22 +0100
Message-ID: <20231206143528.1900797-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20231206143528.1900797-1-Quirin.Gylstorff@siemens.com>
References: <20231206143528.1900797-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Dec 2023 14:35:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13801

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to update the bootloader with swupdate.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate.bbclass                    | 18 +++++++++++++++---
 recipes-core/images/swu/sw-description.tmpl |  7 +++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 117f9fe..4c496c2 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -17,14 +17,15 @@ SWU_ROOTFS_NAME ?= "${IMAGE_FULLNAME}"
 # compression type as defined by swupdate (zlib or zstd). Set to empty string to disable compression
 SWU_COMPRESSION_TYPE ?= "zlib"
 SWU_ROOTFS_PARTITION_NAME ?= "${SWU_ROOTFS_NAME}.${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
-SWU_VERSION ?= "0.2"
+SWU_VERSION ?= "0.3"
 SWU_NAME ?= "cip software update"
 # space separated list of supported hw. Leave empty to leave out
 SWU_HW_COMPAT ?= ""
 
+
 SWU_IMAGE_FILE ?= "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.swu"
 SWU_DESCRIPTION_FILE ?= "sw-description"
-SWU_ADDITIONAL_FILES ?= "linux.efi ${SWU_ROOTFS_PARTITION_NAME}"
+SWU_ADDITIONAL_FILES ?= "linux.efi ${SWU_ROOTFS_PARTITION_NAME} boot${SWU_EFI_ARCH}.efi"
 SWU_SIGNED ??= ""
 SWU_SIGNATURE_EXT ?= "sig"
 SWU_SIGNATURE_TYPE ?= "cms"
@@ -47,7 +48,8 @@ IMAGE_TEMPLATE_VARS:swu = " \
     SWU_HW_COMPAT_NODE \
     SWU_COMPRESSION_NODE \
     SWU_VERSION \
-    SWU_NAME"
+    SWU_NAME \
+    SWU_EFI_ARCH"
 
 # TARGET_IMAGE_UUID needs to be generated before completing the template
 addtask do_transform_template after do_generate_image_uuid
@@ -68,6 +70,16 @@ python(){
         d.setVar('SWU_COMPRESSION_NODE', 'compressed = "' + calgo + '";')
     else:
         d.setVar('SWU_COMPRESSION_NODE', '')
+    # create SWU_EFI_ARCH from DISTRO_ARCH
+    distro_arch = d.getVar('DISTRO_ARCH')
+    distro_to_efi_arch = {
+            "amd64": "x64",
+            "arm64": "aa64",
+            "armhf": "arm",
+            "i386": "ia32",
+            "riscv64": "riscv64"
+    }
+    d.setVar('SWU_EFI_ARCH',distro_to_efi_arch[distro_arch])
 }
 
 
diff --git a/recipes-core/images/swu/sw-description.tmpl b/recipes-core/images/swu/sw-description.tmpl
index 6b53a3c..eaf30ea 100644
--- a/recipes-core/images/swu/sw-description.tmpl
+++ b/recipes-core/images/swu/sw-description.tmpl
@@ -34,5 +34,12 @@ software =
                         subtype = "kernel";
             };
             sha256 = "linux.efi-sha256";
+    },
+    {
+            filename = "boot${SWU_EFI_ARCH}.efi"
+            path = "EFI/BOOT/boot${SWU_EFI_ARCH}.efi";
+            device = "/dev/disk/by-uuid/4321-DCBA";
+            filesystem = "vfat";
+            sha256 = "boot${SWU_EFI_ARCH}.efi-sha256";
     });
 }
-- 
2.42.0


