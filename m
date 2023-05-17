Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C8DC77B75
	for <webhook@archiver.kernel.org>; Wed, 17 May 2023 11:58:09 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.47357.1684324686778642021
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 May 2023 04:58:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=LSS2Wl/F;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-2023051711580414aef36cb726d737e5-wzef__@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2023051711580414aef36cb726d737e5
        for <cip-dev@lists.cip-project.org>;
        Wed, 17 May 2023 13:58:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=AeKC+RRbh9LUXRbvC9v+HbuUO0c95IK31Y/tsDJ73S4=;
 b=LSS2Wl/FuHTINPDMPdKmgHClXD2DCw9cVy5ic9rBsRnfUy3VCAbj4RrLQeCnk1pM9D6fuE
 GDX+Mx/9nTOd7aATrI2WGH+NutBsFuiSkP7GFhMPX9XLVLJquwbHxX3CodPYDmXv/UkmsYoF
 AXZ3pqdQtVdpiom6W6vh2A6neN1hQ=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] classes/image_uuid: Correct task_order
Date: Wed, 17 May 2023 13:58:02 +0200
Message-Id: <20230517115802.1416043-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 11:58:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11491

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The file sw-description is generated from a template and requires
the TARGET_IMAGE_UUID. Therefore the image_uuid needs to be generated
before the template is evaluated.

Reported-by: Gokhan Cetin <gokhan.cetin@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/image_uuid.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
index 9ffe14d..1578a88 100644
--- a/classes/image_uuid.bbclass
+++ b/classes/image_uuid.bbclass
@@ -54,4 +54,4 @@ do_generate_image_uuid() {
     echo "TARGET_IMAGE_UUID=\"${IMAGE_UUID}\"" \
         > "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.uuid.env"
 }
-addtask generate_image_uuid before do_rootfs_finalize after do_rootfs_postprocess
+addtask generate_image_uuid before do_rootfs_finalize do_transform_template after do_rootfs_install
-- 
2.39.2


