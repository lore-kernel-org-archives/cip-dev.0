Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C35C88E41
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 02:59:19 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31377.1789095554405412308
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Sep 2026 19:59:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=srinuvasan.a@siemens.com header.s=fm1 header.b=SjohdkDB;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1324425-202609110259105265d8241f00020780-4wepws@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202609110259105265d8241f00020780
        for <cip-dev@lists.cip-project.org>;
        Fri, 11 Sep 2026 04:59:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=srinuvasan.a@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=bW27i1M+5PR2b91B1qMtAHJhkHaZ38PltuKpDsiR2+k=;
 b=SjohdkDBH412TJwrkNUvUvO7kYWDRuSofBXgGBOVlmdbevpoZvq9TXsGE7f+N7N4pY8lXp
 1qbNzbk27Rq6+t9K3op9ihDg8FI1qW8unvFH1bLfJu14TSUlrN6rFa5KwfHUq6jPqdq6WcnA
 H+B1iqiCGIrvglFcAynS/RzL4YOP5ehTXo9sAJSGaGDJ/erfQ4GbPLm26nsxo2VzDzo4qg6N
 WvhQCOI21KhYISnUymIXr2D7+Bw3lechl4AraX4JPauP2vERlkPUvzFm/N8wJyHUm5Qfv5O9
 Xa9UiP20E96UAbF5wwQgcR0tnCWUD+fLuPBLFZIWPyMrclMPqWQOaefQ==;
From: srinuvasan.a@siemens.com
To: cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] remove do_rootfs_postprocess from task dependencies
Date: Fri, 11 Sep 2026 08:29:45 +0530
Message-Id: <20260911025945.739807-1-srinuvasan.a@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1324425:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 02:59:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24117

From: Srinuvasan A <srinuvasan.a@siemens.com>

Latest Isar has merged do_rootfs_postprocess into
do_rootfs_install.

Update tasks depending on do_rootfs_postprocess to use
do_rootfs_install instead.

Ref: https://github.com/ilbers/isar/commit/c7a63750

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 classes-recipe/image_uuid.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes-recipe/image_uuid.bbclass b/classes-recipe/image_uuid.bbclass
index da54625..247f272 100644
--- a/classes-recipe/image_uuid.bbclass
+++ b/classes-recipe/image_uuid.bbclass
@@ -52,4 +52,4 @@ do_generate_image_uuid() {
     echo "TARGET_IMAGE_UUID=\"${IMAGE_UUID}\"" \
         > "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.uuid.env"
 }
-addtask generate_image_uuid before do_rootfs_finalize after do_rootfs_postprocess
+addtask generate_image_uuid before do_rootfs_finalize after do_rootfs_install
-- 
2.39.5


