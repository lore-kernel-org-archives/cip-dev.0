Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2941C47080
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:06 +0000 (UTC)
Received: from mta-64-227.flowmailer.net (mta-64-227.flowmailer.net
 [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web12.3486.1649834200902452012
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 00:16:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=VlzkLj15;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-294854-2022041307163729e15825d4c9639e62-casall@rts-flowmailer.siemens.com)
Received: by mta-64-227.flowmailer.net with ESMTPSA id
 2022041307163729e15825d4c9639e62
        for <cip-dev@lists.cip-project.org>;
        Wed, 13 Apr 2022 09:16:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=RITniMLEOpnZDqyj8tzCxqWyJz8knzT0vusUqmVL7ao=;
 b=VlzkLj15bHVqfe948CCgSN5vuOVfA8o/EIf+jD6oCfByTojWXKu67JqzJR51ZcTJxeJHn6
 tpAZFUsziFH7DUMvDT7HBnXUIQNcrB9B1Gbhhlt7BVdC+QK30jOtKzkpuknuO9gQ63EYxuVn
 zGTqFGFMta6FcFXbwMABznNrPi2S4=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 02/19] swupdate: Simplify secure-swupdate-img
 class
Date: Wed, 13 Apr 2022 09:16:19 +0200
Message-Id: 
 <c37f0832cefa71207560edddc60a65d4544b31ca.1649834193.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1649834193.git.jan.kiszka@siemens.com>
References: <cover.1649834193.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Apr 2022 15:48:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8051

From: Jan Kiszka <jan.kiszka@siemens.com>

Directly include wic-swu-img, avoiding code duplication this way.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/secure-swupdate-img.bbclass | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/classes/secure-swupdate-img.bbclass b/classes/secure-swupdate-img.bbclass
index 330f619..c2b2402 100644
--- a/classes/secure-swupdate-img.bbclass
+++ b/classes/secure-swupdate-img.bbclass
@@ -20,11 +20,7 @@ do_wic_image[depends] += "${INITRAMFS_RECIPE}:do_build"
 INITRD_IMAGE = "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
 
 inherit verity-img
-inherit wic-img
-inherit swupdate-img
-
-SOURCE_IMAGE_FILE = "${WIC_IMAGE_FILE}"
+inherit wic-swu-img
 
 addtask do_verity_image after do_${SECURE_IMAGE_FSTYPE}_image
 addtask do_wic_image after do_verity_image
-addtask do_swupdate_image after do_wic_image
-- 
2.34.1


