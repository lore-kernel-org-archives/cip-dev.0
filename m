Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28CFC4707B
	for <webhook@archiver.kernel.org>; Thu, 11 Jan 2024 20:00:26 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web11.2398.1705003220271012477
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jan 2024 12:00:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=iLA31CHS;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-51332-202401112000177aeb156ac66becbb88-ug8fpj@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202401112000177aeb156ac66becbb88
        for <cip-dev@lists.cip-project.org>;
        Thu, 11 Jan 2024 21:00:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=7gHnhlyNKtrsuS4aR2Oo096eNq55FBb/1ZuK5H7AZSw=;
 b=iLA31CHS1+uu7TNEVKQOxGcXlCsXt2oGq3ArSEGGhqNcmUj/JwA3p+WymgUpaLt2RQU4Fo
 5pjF/EMHW93U+dDXLOMxitja3k3QJBhk1PoJvGlw5xlsuTpH3yz25c4tREd5Jx53G/vyUiKR
 tiL6cIhjsBuF5lRrEf37kBB6IK2Mk=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 4/7] swupdate.bbclass: Add SWU_EXTEND_SW_DESCRIPTION
Date: Thu, 11 Jan 2024 20:59:48 +0100
Message-ID: <20240111200015.190376-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240111200015.190376-1-Quirin.Gylstorff@siemens.com>
References: <20240111200015.190376-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jan 2024 20:00:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14344

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The elements of the new variable are called as functions. This
allows the user to extend the sw-description file with new template
variables and new entries.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate.bbclass | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 117f9fe..dfe8ef1 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -53,6 +53,16 @@ IMAGE_TEMPLATE_VARS:swu = " \
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
@@ -61,7 +71,10 @@ python(){
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
2.43.0


