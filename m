Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00481C4167D
	for <webhook@archiver.kernel.org>; Thu, 10 Nov 2022 12:45:10 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.6912.1668084308939076149
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Nov 2022 04:45:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Q584MmiU;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20221110124506362991bf24a67221bf-ym11d7@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20221110124506362991bf24a67221bf
        for <cip-dev@lists.cip-project.org>;
        Thu, 10 Nov 2022 13:45:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=1mm5WXKFNaJTQGCFp8i/RrWjeryAXdhjZYirGNYNww4=;
 b=Q584MmiU/xkGYLRcea+wTVyiDPQjGU0H7OJuqLObxWwj7UZp44iV0sOLkUJtERP9NFkFPG
 chIXMYiEyjldlTfd18X/lX7SzfsxAYQCuArFRg8KyVCGmUnlR26liPT0zqSN1RNy8HSSlZT/
 QU2rpq0jxL/1VOJHDLUbvIo8CAUlc=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	christian.storm@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 4/5] image_uuid: read target_image_uuid
Date: Thu, 10 Nov 2022 13:45:02 +0100
Message-Id: <20221110124503.274124-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20221110124503.274124-1-Quirin.Gylstorff@siemens.com>
References: <20221110124503.274124-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Nov 2022 12:45:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9999

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This writes the target_image_uuid to the Variable TARGET_IMAGE_UUID
which can be used to validate a update against the root file system.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/image_uuid.bbclass | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
index 277941b..3e2e3de 100644
--- a/classes/image_uuid.bbclass
+++ b/classes/image_uuid.bbclass
@@ -13,6 +13,8 @@
 inherit rootfs
 inherit image
 
+# Generate the uuid from BB_TASKHASH to ensure a new
+# hash on each rebuild
 def generate_image_uuid(d):
     import uuid
 
@@ -23,6 +25,23 @@ def generate_image_uuid(d):
 
 IMAGE_UUID ?= "${@generate_image_uuid(d)}"
 
+def read_target_image_uuid(d):
+    import os.path
+
+    deploy_dir = d.getVar("DEPLOY_DIR_IMAGE")
+    image_full_name = d.getVar("IMAGE_FULLNAME")
+    uuid_file = f"{deploy_dir}/{image_full_name}.uuid.env"
+    if not os.path.isfile(uuid_file):
+        return None
+
+    target_image_uuid = None
+    with open(uuid_file, "r") as f:
+       uuid_file_content = f.read()
+       target_image_uuid = uuid_file_content.split('=')[1].strip(' \t\n\r').strip('\"')
+    return target_image_uuid
+
+TARGET_IMAGE_UUID = "${@read_target_image_uuid(d)}"
+
 do_generate_image_uuid[vardeps] += "IMAGE_UUID"
 do_generate_image_uuid[depends] = "buildchroot-target:do_build"
 do_generate_image_uuid[dirs] = "${DEPLOY_DIR_IMAGE}"
-- 
2.35.1


