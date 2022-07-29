Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C8CC19F2C
	for <webhook@archiver.kernel.org>; Fri, 29 Jul 2022 08:39:42 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web08.5736.1659083975764345696
 for <cip-dev@lists.cip-project.org>;
 Fri, 29 Jul 2022 01:39:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2
 header.b=GxCijerQ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227,
 mailfrom: fm-51332-2022072908393302b9bc62f4214d84f0-6tr_s_@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 2022072908393302b9bc62f4214d84f0
        for <cip-dev@lists.cip-project.org>;
        Fri, 29 Jul 2022 10:39:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=6tfF+LeY8sv88eafGsGifG4xffM8cFOvgWhohz/sj6Y=;
 b=GxCijerQjinLbI/tQS3rUEX9eejL1CVY80t66vhFWH/dKSEwCS11ADq6q8BlsRaOfHus0x
 bPB4ALb254qbeNapS1k425Zy2+69IDaG6jNh0196f5/UDCVCDNDOl4q6/1VqBR9afDRrkewJ
 Z2H130A+N//j8C3XM6JDGyu38UIqw=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 1/4] Update ISAR for sbuild
 integration
Date: Fri, 29 Jul 2022 10:39:28 +0200
Message-Id: <20220729083931.419731-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20220729083931.419731-1-Quirin.Gylstorff@siemens.com>
References: <20220729083931.419731-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Jul 2022 08:39:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8972

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index c3477ed..a39820f 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: 1000df8e98b9a5849a7897698039687fd0cdd7d3
+    refspec: 64c755053d1252d183757b294cf9849fced64799
     layers:
       meta:
 
-- 
2.35.1


