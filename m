Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467FEC7EE2A
	for <webhook@archiver.kernel.org>; Mon, 22 May 2023 12:16:19 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.20424.1684757768300913266
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 May 2023 05:16:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=RUwyGu1+;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-202305221216054af1840b1d0fbca6ca-wrfwyg@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202305221216054af1840b1d0fbca6ca
        for <cip-dev@lists.cip-project.org>;
        Mon, 22 May 2023 14:16:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=lFMPODVv50GS8daA4MngmkQImPzHpyonKLhz3eAXqPo=;
 b=RUwyGu1+OlCAdDX7G6ka6ug2zXXqvUAnElq5REEaA1FdAGK4GoD9bEdUuzkxfmeZ/bvg8a
 KDsmhnP3XMYILN3PLgBcWeYpgyAx0iu8CFdJufix6HtWJEFvdm4+NVy0s+04OH0772Zha4ii
 qyiewxC9kMpysUOb/s6WeITt8yJBk=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2] classes/swupdate: Correct task_order
Date: Mon, 22 May 2023 14:16:04 +0200
Message-Id: <20230522121604.2175830-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 May 2023 12:16:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11585

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The file sw-description is generated from a template and requires
the TARGET_IMAGE_UUID. Therefore the image_uuid needs to be generated
before the template is evaluated.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---

Changes v2:
 - move task order from image_uuid to swupdate.bbclass
 - adapt commit message

 classes/swupdate.bbclass | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 9a4d509..af9d12a 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -46,6 +46,9 @@ IMAGE_TEMPLATE_VARS:swu = " \
     SWU_VERSION \
     SWU_NAME"
 
+# TARGET_IMAGE_UUID needs to be generated before completing the template
+addtask do_transform_template after do_generate_image_uuid
+
 python(){
     # create SWU_HW_COMPAT_NODE based on list of supported hw
     hw_compat = d.getVar('SWU_HW_COMPAT')
-- 
2.39.2


