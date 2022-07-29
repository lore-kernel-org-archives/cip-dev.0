Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A97C19F2D
	for <webhook@archiver.kernel.org>; Fri, 29 Jul 2022 10:04:43 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web08.6285.1659089075649344442
 for <cip-dev@lists.cip-project.org>;
 Fri, 29 Jul 2022 03:04:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2
 header.b=PFdBpETc;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-51332-20220729100433c468c2ff6757ca6063-uxceaz@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20220729100433c468c2ff6757ca6063
        for <cip-dev@lists.cip-project.org>;
        Fri, 29 Jul 2022 12:04:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=3hLabKd3Nk5uIOWRkV7vDpLamzL46+KrNMvy+g31ERw=;
 b=PFdBpETcljsEAiqoNoVfZrfHDgxNr7sJpTK3dE3cGuAVe7FHLzdBc2a15NA3LVxMDUrDYj
 tnm2icL/mw/TLco0M8QZHBkl3HpkfLj+EHqrjw4v594eomMBbWQxEz2dg5d1QwoddY6zwfD9
 nbAwtjPR6+qAU1Fbdy08WS/3M7eCQ=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 4/4] Update ISAR for sbuild
 integration
Date: Fri, 29 Jul 2022 12:04:31 +0200
Message-Id: <20220729100431.453463-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20220729100431.453463-1-Quirin.Gylstorff@siemens.com>
References: <20220729100431.453463-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Jul 2022 10:04:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8982

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index ab61aa8..5a43cd1 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: 1000df8e98b9a5849a7897698039687fd0cdd7d3
+    refspec: 64c755053d1252d183757b294cf9849fced64799
     layers:
       meta:
     patches:
-- 
2.35.1


