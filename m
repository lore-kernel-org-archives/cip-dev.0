Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A05C77B6E
	for <webhook@archiver.kernel.org>; Fri, 14 Apr 2023 11:46:00 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.4999.1681463650709354599
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Apr 2023 02:14:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=Ot3NJoVv;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-72506-20230414091408e5a4ccf57c18123fd7-qtg5ok@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230414091408e5a4ccf57c18123fd7
        for <cip-dev@lists.cip-project.org>;
        Fri, 14 Apr 2023 11:14:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=FZ/j/9WmH4kZEn+PIm1ThRYrX6qUGNcSbPdwsGGVb08=;
 b=Ot3NJoVvaDCOvzoZWZPcoS6LfDtpRet3Uu00mvLOgyFQrTLQlD0yMItoIbkcv3NMgZ/ASS
 5VlCZOgNVjQsl6CPyX4df0YRGId6CyvNXLEtdbazhXRYZOkAtYyeG2NYgFLDp8pN7JyoJSvd
 k+q6ri383J8id+v0kg+VA3gvSaLJU=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 2/3] swupdate: add support to disable compression
Date: Fri, 14 Apr 2023 17:13:47 +0800
Message-Id: <20230414091348.676809-2-felix.moessbauer@siemens.com>
In-Reply-To: <20230414091348.676809-1-felix.moessbauer@siemens.com>
References: <20230414091348.676809-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Apr 2023 11:46:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11221

This feature is useful for artifacts which are already compressed (like
squashfs). By that, double compression can be avoided, which speeds up
the deployment and also reduces the memory consumption.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes/swupdate.bbclass                    | 19 ++++++++++++++-----
 recipes-core/images/swu/sw-description.tmpl |  2 +-
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 0e738d7..16c615a 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -14,9 +14,9 @@ inherit template
 
 SWU_ROOTFS_TYPE ?= "squashfs"
 SWU_ROOTFS_NAME ?= "${IMAGE_FULLNAME}"
-# compression type as defined by swupdate (zlib or zstd)
+# compression type as defined by swupdate (zlib or zstd). Set to empty string to disable compression
 SWU_COMPRESSION_TYPE ?= "zlib"
-SWU_ROOTFS_PARTITION_NAME ?= "${SWU_ROOTFS_NAME}.${SWU_ROOTFS_TYPE}.${@get_swu_compression_type(d)}"
+SWU_ROOTFS_PARTITION_NAME ?= "${SWU_ROOTFS_NAME}.${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
 SWU_VERSION ?= "0.2"
 SWU_NAME ?= "cip software update"
 # space separated list of supported hw. Leave empty to leave out
@@ -31,7 +31,7 @@ SWU_SIGNATURE_TYPE ?= "rsa"
 
 SWU_BUILDCHROOT_IMAGE_FILE ?= "${PP_DEPLOY}/${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
 
-IMAGE_TYPEDEP:swu = "wic ${SWU_ROOTFS_TYPE}.${@get_swu_compression_type(d)}"
+IMAGE_TYPEDEP:swu = "wic ${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
 IMAGER_INSTALL:swu += "cpio ${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 
 IMAGE_SRC_URI:swu = "file://${SWU_DESCRIPTION_FILE}.tmpl"
@@ -41,8 +41,8 @@ IMAGE_TEMPLATE_VARS:swu = " \
     TARGET_IMAGE_UUID \
     ABROOTFS_PART_UUID_A \
     ABROOTFS_PART_UUID_B \
-    SWU_COMPRESSION_TYPE \
     SWU_HW_COMPAT_NODE \
+    SWU_COMPRESSION_NODE \
     SWU_VERSION \
     SWU_NAME"
 
@@ -55,13 +55,22 @@ python(){
             'hardware-compatibility: [ ' + hw_entries +' ];')
     else:
         d.setVar('SWU_HW_COMPAT_NODE', '')
+    
+    # create SWU_COMPRESSION_NODE node if compression is enabled
+    calgo = d.getVar('SWU_COMPRESSION_TYPE')
+    if calgo:
+        d.setVar('SWU_COMPRESSION_NODE', 'compressed = "' + calgo + '";')
+    else:
+        d.setVar('SWU_COMPRESSION_NODE', '')
 }
 
 
 # convert between swupdate compressor name and imagetype extension
 def get_swu_compression_type(d):
     swu_ct = d.getVar('SWU_COMPRESSION_TYPE', True)
-    swu_to_image = {'zlib': 'gz', 'zstd': 'zst'}
+    if not swu_ct:
+        return ''
+    swu_to_image = {'zlib': '.gz', 'zstd': '.zst'}
     if swu_ct not in swu_to_image:
         bb.fatal('requested SWU_COMPRESSION_TYPE is not supported by swupdate')
     return swu_to_image[swu_ct]
diff --git a/recipes-core/images/swu/sw-description.tmpl b/recipes-core/images/swu/sw-description.tmpl
index 8d43568..6b53a3c 100644
--- a/recipes-core/images/swu/sw-description.tmpl
+++ b/recipes-core/images/swu/sw-description.tmpl
@@ -17,7 +17,7 @@ software =
             filename = "${SWU_ROOTFS_PARTITION_NAME}";
             device = "C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOTFS_PART_UUID_B}";
             type = "roundrobin";
-            compressed = "${SWU_COMPRESSION_TYPE}";
+            ${SWU_COMPRESSION_NODE}
             properties: {
                         subtype = "image";
                         configfilecheck = "/etc/os-release@not_match@IMAGE_UUID=${TARGET_IMAGE_UUID}";
-- 
2.39.2


