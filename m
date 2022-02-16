Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608B2C433EF
	for <webhook@archiver.kernel.org>; Wed, 16 Feb 2022 13:05:06 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web09.11479.1645016704997386204
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Feb 2022 05:05:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1
 header.b=Vn6A2Ua/;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225,
 mailfrom: fm-51332-202202161303180675bdc42c4f7c8eba-ukgffg@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 202202161303180675bdc42c4f7c8eba
        for <cip-dev@lists.cip-project.org>;
        Wed, 16 Feb 2022 14:05:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ooucsh9hpBlFYt4n4pcERz5TPqhOUnKfUjdFe1pf6m8=;
 b=Vn6A2Ua/5yHnEb9oBJAe+7o1KY4jhNztEr6I6evojnWnEO7qizUu+BhfMp6Y2WLQV+35fR
 nV33I0RBnlZ7kwbrbV+Veyom7ipRzBJGWMrTn7XCp3i+MbobWkEVh2hUHtKmMtelY1a6vuNv
 x2Kn1Likery1FWNv4ntiohXu3P8ro=;
From: Quirin.Gylstorff@siemens.com
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 1/2] Update ISAR to next
Date: Wed, 16 Feb 2022 14:03:16 +0100
Message-Id: <20220216130317.3018990-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20220216130317.3018990-1-Quirin.Gylstorff@siemens.com>
References: <20220216130317.3018990-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Feb 2022 13:05:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7620

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

refspec is now cf3f18a649ff42726677a58b224b9bb58ea4ba46

This adds Debian build profile support

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 9c8ac9f..fce176b 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: 33b5aa65fa3f28987525799d0731fb4e7050207d
+    refspec: cf3f18a649ff42726677a58b224b9bb58ea4ba46
     layers:
       meta:
     patches:
-- 
2.34.1


