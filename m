Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67C8C77B77
	for <webhook@archiver.kernel.org>; Fri, 14 Apr 2023 11:46:00 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.4895.1681463649934574433
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Apr 2023 02:14:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=hTBXgEz0;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-72506-20230414091406b6cf19ccb93a279b00-5f2ky5@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230414091406b6cf19ccb93a279b00
        for <cip-dev@lists.cip-project.org>;
        Fri, 14 Apr 2023 11:14:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=J29qKoNoZ5OGnfgfszhwt4WsdPT4pZW3Lo0GK6LIzfg=;
 b=hTBXgEz08NgPnsEFIDBSl1DCvXEqN335NzeENKJdv6P9FQ6Jt72XCmsoIuMsHmrnWuAkIQ
 Z2ZivXtJ7kwo6LsjwX31G23vpHa0T9sq4nXXJ0Ul/i8In3TlwrXziUHOohIcTogRifE9agi3
 t9PBr1+MNQN3Y37Z+jIWAmmkqRxQw=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/3] make name, version and hw-compat available via bb
Date: Fri, 14 Apr 2023 17:13:46 +0800
Message-Id: <20230414091348.676809-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Apr 2023 11:46:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11220

This patch adds bitbake variables to control the corresponding entries
in the sw-description file. The following variables are added:

- SWU_NAME: software->name
- SWU_VERSION: software->version
- SWU_HW_COMPAT: software->compatibility (only if non empty)

By providing these variables, downstream users more often can use the
default sw-description file. This makes it easier to maintain and evolve
the swupdate infrastructure without breaking downstream use-cases.
It also brings as closer to the way swupdate is integrated into yocto.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes/swupdate.bbclass                    | 21 ++++++++++++++++++++-
 recipes-core/images/swu/sw-description.tmpl |  5 +++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index e12a4d2..0e738d7 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -17,6 +17,10 @@ SWU_ROOTFS_NAME ?= "${IMAGE_FULLNAME}"
 # compression type as defined by swupdate (zlib or zstd)
 SWU_COMPRESSION_TYPE ?= "zlib"
 SWU_ROOTFS_PARTITION_NAME ?= "${SWU_ROOTFS_NAME}.${SWU_ROOTFS_TYPE}.${@get_swu_compression_type(d)}"
+SWU_VERSION ?= "0.2"
+SWU_NAME ?= "cip software update"
+# space separated list of supported hw. Leave empty to leave out
+SWU_HW_COMPAT ?= ""
 
 SWU_IMAGE_FILE ?= "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.swu"
 SWU_DESCRIPTION_FILE ?= "sw-description"
@@ -37,7 +41,22 @@ IMAGE_TEMPLATE_VARS:swu = " \
     TARGET_IMAGE_UUID \
     ABROOTFS_PART_UUID_A \
     ABROOTFS_PART_UUID_B \
-    SWU_COMPRESSION_TYPE"
+    SWU_COMPRESSION_TYPE \
+    SWU_HW_COMPAT_NODE \
+    SWU_VERSION \
+    SWU_NAME"
+
+python(){
+    # create SWU_HW_COMPAT_NODE based on list of supported hw
+    hw_compat = d.getVar('SWU_HW_COMPAT')
+    if hw_compat:
+        hw_entries = ', '. join(['"' + h + '"' for h in hw_compat.split()])
+        d.setVar('SWU_HW_COMPAT_NODE',
+            'hardware-compatibility: [ ' + hw_entries +' ];')
+    else:
+        d.setVar('SWU_HW_COMPAT_NODE', '')
+}
+
 
 # convert between swupdate compressor name and imagetype extension
 def get_swu_compression_type(d):
diff --git a/recipes-core/images/swu/sw-description.tmpl b/recipes-core/images/swu/sw-description.tmpl
index cade7c3..8d43568 100644
--- a/recipes-core/images/swu/sw-description.tmpl
+++ b/recipes-core/images/swu/sw-description.tmpl
@@ -10,8 +10,9 @@
 #
 software =
 {
-    version = "0.2";
-    name = "cip software update";
+    version = "${SWU_VERSION}";
+    name = "${SWU_NAME}";
+    ${SWU_HW_COMPAT_NODE}
     images: ({
             filename = "${SWU_ROOTFS_PARTITION_NAME}";
             device = "C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOTFS_PART_UUID_B}";
-- 
2.39.2


