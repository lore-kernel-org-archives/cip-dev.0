Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D605C636F6
	for <webhook@archiver.kernel.org>; Mon, 25 Apr 2022 19:26:14 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web08.28337.1650887390969219166
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Apr 2022 04:49:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=aGEM7Jkt;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225,
 mailfrom: fm-294854-20220425114948332cc60febadafff5f-_y8plj@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 20220425114948332cc60febadafff5f
        for <cip-dev@lists.cip-project.org>;
        Mon, 25 Apr 2022 13:49:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=YzJbmX9PiE5V0/oi9FLDMOhvknc1bIdzcZxUCfeXFzk=;
 b=aGEM7Jktw2j8gNYtK3Sw44pl+IBxZwoStowUleDw+PPZo7Wy7lCIPvH+ACf8SSRjD9b8nX
 d0R8RrHYWcbDfWhRRzoJVHog6di133o9/XpBMQgiK1OYPEmw64SH07WVGsF5tVC150YBLG0t
 O9+5L6h4ocVrXBSthlagXp87a+FFw=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH v3 3/7] squashfs-img: Make sure
 DEPLOY_DIR_IMAGE exists
Date: Mon, 25 Apr 2022 13:49:40 +0200
Message-Id: 
 <18e7a6ef12a2307a98527639880c9f6a62458e27.1650887383.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1650887383.git.jan.kiszka@siemens.com>
References: <cover.1650887383.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Apr 2022 19:26:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8199

From: Jan Kiszka <jan.kiszka@siemens.com>

We only get it implicitly so far, but that may always change.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/squashfs-img.bbclass | 1 +
 1 file changed, 1 insertion(+)

diff --git a/classes/squashfs-img.bbclass b/classes/squashfs-img.bbclass
index 04bb67c..c22d7d6 100644
--- a/classes/squashfs-img.bbclass
+++ b/classes/squashfs-img.bbclass
@@ -29,6 +29,7 @@ python __anonymous() {
     d.appendVar('SQUASHFS_CREATION_ARGS', args)
 }
 
+do_squashfs_image[dirs] = "${DEPLOY_DIR_IMAGE}"
 do_squashfs_image() {
     rm -f '${DEPLOY_DIR_IMAGE}/${SQUASHFS_IMAGE_FILE}'
 
-- 
2.34.1


