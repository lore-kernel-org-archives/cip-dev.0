Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984B4CD5BD0
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 14:44:57 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.11029.1695134613486234022
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Sep 2023 07:43:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=midLhtlZ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-72506-20230919144329e1baa34564ed69f566-urgwjy@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230919144329e1baa34564ed69f566
        for <cip-dev@lists.cip-project.org>;
        Tue, 19 Sep 2023 16:43:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ad2giKFXReghyzqOnu+i+K7vlmwVjNLV8+3sg3o/nlc=;
 b=midLhtlZTRx4mU4u00tEE9dSnJ13F00PPM3utbeZ0P7ElZBo7CNw++BYfAfy/Zb1dTgugo
 EN/ui+GRbyIayMG+NwtuuSGiE4hZ4SntskTYtQN8MuOhsp5gVzfO62e/rPuygL567ok3ZSXH
 yoL95CxIPmNtm8jwNtJGEe+Glns88=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/1] drop dependency to no longer existing buildchroot
Date: Tue, 19 Sep 2023 14:43:09 +0000
Message-Id: <20230919144309.3499738-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 14:44:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13154

For a long time, the buildchroot(-target) has not been used anymore.
However this target was still available in ISAR for downstream users. As
this is now dropped from ISAR, we also must drop this (obsolete)
dependency in the image_uuid class.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes/image_uuid.bbclass | 1 -
 1 file changed, 1 deletion(-)

diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
index 37e86d9..2cd8459 100644
--- a/classes/image_uuid.bbclass
+++ b/classes/image_uuid.bbclass
@@ -42,7 +42,6 @@ def read_target_image_uuid(d):
 TARGET_IMAGE_UUID = "${@read_target_image_uuid(d)}"
 
 do_generate_image_uuid[vardeps] += "IMAGE_UUID"
-do_generate_image_uuid[depends] = "buildchroot-target:do_build"
 do_generate_image_uuid[dirs] = "${DEPLOY_DIR_IMAGE}"
 do_generate_image_uuid[network] = "${TASK_USE_SUDO}"
 do_generate_image_uuid() {
-- 
2.34.1


