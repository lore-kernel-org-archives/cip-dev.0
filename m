Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9A6E95A8F
	for <webhook@archiver.kernel.org>; Sun,  8 Oct 2023 14:26:30 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web11.31964.1696735008631492730
 for <cip-dev@lists.cip-project.org>;
 Sat, 07 Oct 2023 20:16:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=HZjSidfS;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-72506-20231008031646bc34d11b607e62f101-quex0w@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20231008031646bc34d11b607e62f101
        for <cip-dev@lists.cip-project.org>;
        Sun, 08 Oct 2023 05:16:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Y9ssTHLRb1jAVge1hhjkUscXzholaT5lEuN1sj7UIms=;
 b=HZjSidfSNEPNFcwnrXN1AhfYwSubFsHywFM1oswU36vDeREFygmtS+vY/YPKvo/S7lArJG
 XTSj5TazUITlb5kTG0nlFXrgfef5agny4H6RND2syIqq1fddR5GxXJsT26L72KZWAdppLLnN
 BDyh3+9RWpLMBEuyebLgkRpJpPM2Y=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 4/4] update ISAR to latest version on master branch
Date: Sun,  8 Oct 2023 11:15:29 +0800
Message-Id: <20231008031529.1338834-5-felix.moessbauer@siemens.com>
In-Reply-To: <20231008031529.1338834-1-felix.moessbauer@siemens.com>
References: <20231008031529.1338834-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 08 Oct 2023 14:26:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13311

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index c329248..84b7441 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: bf9c9fdd99bf26dca25fdf9e63b7eb5b053d962f
+    commit: dff8ad504b54a4e292a1b986cdc74ebc9e6e177a
     layers:
       meta:
 
-- 
2.39.2


