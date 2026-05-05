Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25D9FF8855
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 15:25:41 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42380.1777994734968402626
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 May 2026 08:25:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=L32lCTQx;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-20260505152532f4bd3c6e7300020724-2oy0en@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260505152532f4bd3c6e7300020724
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 May 2026 17:25:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=nduFC3d1Y5bbzIlKDKdFmQuJ+kT6BtpjG7rOZb6XiJw=;
 b=L32lCTQxcsO+d/PKVYV28D32IcmoIUxCrEFhhryTKFV7XkGo9P0KFEQiW/1bkbmyStD4Q/
 K2qhQoGhqJobkrrXczGJD/tGT47dUM2YXF4PdfvHhUumGLPbZILkGwcRL0AASKitr6qc/GJo
 b0Oe9jTXQorL57NVBkiui7bqJg7CpMyIMMKJWNEaNE8OyXrvsCaiiXp/ZAzWf4OJo4pMOGy0
 zjp37v3Y3cG0xegtiRyTIOabSWpDShtW1uIh3XK+t/8rxmqYeyuVMc9qil5ijT6e4394NI4n
 bE9HUDMyBzz51khNnrvuefjLiJcfsSngVuVTQBW4hNFx0V2Oa7PV83+Q==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 1/3] Update Isar to 1.1-rc2
Date: Tue,  5 May 2026 17:25:28 +0200
Message-ID: <35b3ea9200d7257a67b7c2a5b5bf72d3a6be2cbf.1777994730.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1777994730.git.jan.kiszka@siemens.com>
References: <cover.1777994730.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 May 2026 15:25:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22888

From: Jan Kiszka <jan.kiszka@siemens.com>

Brings some valuable updates, e.g. for SBOM, skips the 1.0 deployment
path glitches and provides upstream some additional test coverage.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index a3e9b24e..4d47ea9b 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 33ca03c711e34d38d303ca38c1259cb6c5fe55ef
+    commit: 22ee5352eab6c38ac395da60895d09bacfe7b201
     layers:
       meta:
 
-- 
2.47.3


