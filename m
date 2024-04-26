Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1EFC4345F
	for <webhook@archiver.kernel.org>; Fri, 26 Apr 2024 11:38:55 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.7593.1714113008284762875
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Apr 2024 23:30:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kumar.rakesh@siemens.com header.s=fm1 header.b=DvtX/Zl6;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1325885-20240426063004d6041dc2348fc98f45-naoiu9@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240426063004d6041dc2348fc98f45
        for <cip-dev@lists.cip-project.org>;
        Fri, 26 Apr 2024 08:30:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=kumar.rakesh@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=2gV90FV3VxM9WuvyOahx0r1PVbbBuF+L3a2jfgrKgYQ=;
 b=DvtX/Zl63m+xwl19mU4/zv0Bmda6V6/AXUZkdvys7+zDnPrN3du7hw5Ddeo4HROpmahugd
 dcPAQVvJ9QjvFott3We6tfhmBywZBfS9TMtLzQAkgHGZR1enJnQMy5FziwogDGXOmZXamFxR
 frfCZDOjoo6IdbZW5N+6DSIVbJalM=;
From: Rakesh Kumar <kumar.rakesh@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Rakesh Kumar <kumar.rakesh@siemens.com>
Subject: [isar-cip-core] [PATCH] update ISAR to latest version on next branch
Date: Fri, 26 Apr 2024 11:59:18 +0530
Message-Id: <20240426062918.697435-1-kumar.rakesh@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1325885:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Apr 2024 11:38:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15772

One of the changes is DEBIAN_PROVIDES, which is required to
resolve the duplicate Provides problem in secure-boot-secrets
to ensure that the build process completes successfully.

Signed-off-by: Rakesh Kumar <kumar.rakesh@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 2c3c8b0..8a83951 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 9dc362cd7115074c0f60843e687ed89db5c9339a
+    commit: 3327e66994e1a487eb1b609902c12f383faa3b3a
     layers:
       meta:
 
-- 
2.39.2


