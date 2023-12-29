Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BC2C46CD4
	for <webhook@archiver.kernel.org>; Fri, 29 Dec 2023 12:31:26 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.145900.1703853077149302998
 for <cip-dev@lists.cip-project.org>;
 Fri, 29 Dec 2023 04:31:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=oyBRBs4w;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-2023122912311505452c4c83a0977127-mmn_1a@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2023122912311505452c4c83a0977127
        for <cip-dev@lists.cip-project.org>;
        Fri, 29 Dec 2023 13:31:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=7gHnhlyNKtrsuS4aR2Oo096eNq55FBb/1ZuK5H7AZSw=;
 b=oyBRBs4w4+9/IhrOsnocxOYJDT1OZ+KVmFNxd6sBs3v+nOcROkQXAGAYuWObpY0mRq6Iy6
 DyLJGY0v7Pmmd6hjrgzAH2rS309FovavLlH2H7Qx0xc3pziLNbGrZIVWXYkimoKjHtYTZmox
 Jahd5O+lO04y7bgzU08XgshVjuZ5k=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][RFC v3 2/5] swupdate.bbclass: Add SWU_EXTEND_SW_DESCRIPTION
Date: Fri, 29 Dec 2023 13:30:40 +0100
Message-ID: <20231229123111.400555-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20231229123111.400555-1-Quirin.Gylstorff@siemens.com>
References: <20231229123111.400555-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Dec 2023 12:31:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14216

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


