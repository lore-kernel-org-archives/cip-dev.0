Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F8DC04FDE
	for <webhook@archiver.kernel.org>; Fri,  9 Dec 2022 14:58:34 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.3361.1670597912293675122
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Dec 2022 06:58:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=o7BwXqHa;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20221209145829b79c0980716c4b406a-bikecf@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20221209145829b79c0980716c4b406a
        for <cip-dev@lists.cip-project.org>;
        Fri, 09 Dec 2022 15:58:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=fhGePBZsI9OWlZXpepBPy74nCvkb2pUcb1aiPEcJLo0=;
 b=o7BwXqHa8SstnZGgKgnT4KGWqX30xCij0qRtfZnoxR/g4vmF7Wb/bJD7AYgWrxFhS/lyO6
 yt9wzs/DqA7Wmb3G2lICcD6trpMuBAHiE+OvE1VhqW6vjhr8qQblyYqSFbOtlE78uykA/RKf
 q6QGSO1D617um5oVODQljTWXTZv5A=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 3/4] image_uuid: read target_image_uuid
Date: Fri,  9 Dec 2022 15:58:26 +0100
Message-Id: <20221209145827.1309521-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20221209145827.1309521-1-Quirin.Gylstorff@siemens.com>
References: <20221209145827.1309521-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Dec 2022 14:58:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10175

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This writes the target_image_uuid to the Variable TARGET_IMAGE_UUID
which can be used to validate a update against the root file system.

"${@} is evaluated when the variable is expanded. Variables are expanded
when the are used." [1]

[1]: https://www.openembedded.org/pipermail/bitbake-devel/2012-April/011704.html

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


