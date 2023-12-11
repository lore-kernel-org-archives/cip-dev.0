Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF2FC46CA3
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 12:25:43 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.7067.1702297533062429793
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 04:25:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=CPgWY/J2;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20231211122530dbe127542ad8420c6d-ssauts@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20231211122530dbe127542ad8420c6d
        for <cip-dev@lists.cip-project.org>;
        Mon, 11 Dec 2023 13:25:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=RczFvt+kYeoan1amViGxKYD6TnWnXVS+GRjeHbRz9rY=;
 b=CPgWY/J2kTaj/JfKYWx9maKEV5F0O89t0wk885QmjhmV9LLgwxSxWKiD6QiLsxrT6Nfa16
 t+6eKQAv7nyZvlEDCFb0CnCJ0fqLGivYbOyPwA/hM1dy8RQTKYg29D82wGT2J1uRB3Tz0+nl
 psk5W+vxXDp34+RQf1Lmo8k7PDWGc=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dec][isar-cip-core][RFC v2 2/3] swupdate.bbclass: Add SWU_EXTEND_SW_DESCRIPTION
Date: Mon, 11 Dec 2023 13:19:20 +0100
Message-ID: <20231211122528.486786-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
References: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 12:25:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14021

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The elements of the new variable are called as functions. This
allows the user to extend the sw-description file with new template
variables and new entries.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate.bbclass | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 117f9fe..0e95e3c 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -22,6 +22,7 @@ SWU_NAME ?= "cip software update"
 # space separated list of supported hw. Leave empty to leave out
 SWU_HW_COMPAT ?= ""
 
+
 SWU_IMAGE_FILE ?= "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.swu"
 SWU_DESCRIPTION_FILE ?= "sw-description"
 SWU_ADDITIONAL_FILES ?= "linux.efi ${SWU_ROOTFS_PARTITION_NAME}"
@@ -53,6 +54,16 @@ IMAGE_TEMPLATE_VARS:swu = " \
 addtask do_transform_template after do_generate_image_uuid
 
 python(){
+    cmds = d.getVar("SWU_EXTEND_SW_DESCRIPTION")
+    if cmds is None or not cmds.strip():
+        return
+    cmds = cmds.split()
+    for cmd in cmds:
+        bb.build.exec_func(cmd, d)
+}
+
+SWU_EXTEND_SW_DESCRIPTION += "add_swu_hw_compat"
+python add_swu_hw_compat(){
     # create SWU_HW_COMPAT_NODE based on list of supported hw
     hw_compat = d.getVar('SWU_HW_COMPAT')
     if hw_compat:
@@ -61,7 +72,10 @@ python(){
             'hardware-compatibility: [ ' + hw_entries +' ];')
     else:
         d.setVar('SWU_HW_COMPAT_NODE', '')
+}
 
+SWU_EXTEND_SW_DESCRIPTION += "add_swu_compression"
+python add_swu_compression(){
     # create SWU_COMPRESSION_NODE node if compression is enabled
     calgo = d.getVar('SWU_COMPRESSION_TYPE')
     if calgo:
-- 
2.42.0


