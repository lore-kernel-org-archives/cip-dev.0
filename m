Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35E0C4167B
	for <webhook@archiver.kernel.org>; Thu, 10 Nov 2022 12:45:10 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.6816.1668084308351436441
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Nov 2022 04:45:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Tjilh0K4;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20221110124506c9a9d7feb2d2038547-olyany@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20221110124506c9a9d7feb2d2038547
        for <cip-dev@lists.cip-project.org>;
        Thu, 10 Nov 2022 13:45:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=cs/QbgjFWz0BZ/r3l4ewpdB79r4ZHrCP90UoqVYUTG0=;
 b=Tjilh0K4qkVYM1390lUbAAOBP7Zen6QrvdHmcGUN16SCPSU7VtiynXOepQFhF1SDCQbDK2
 9iw0xf2Sqxr/C4Uh5gsSzvf/+/tJ57ST/e/jce9nsd2f5qP9xlCASXKFKW0T1QaoGHJfUKCD
 VMZWsFMwKFg7MAm/+q6u+d6uOCqk8=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	christian.storm@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 2/5] swupdate-handler-roundrobin: Increase revision
Date: Thu, 10 Nov 2022 13:45:00 +0100
Message-Id: <20221110124503.274124-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20221110124503.274124-1-Quirin.Gylstorff@siemens.com>
References: <20221110124503.274124-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Nov 2022 12:45:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9998

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../swupdate-handler-roundrobin_0.1.bb                          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
index 5801113..65cd652 100644
--- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
+++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
@@ -13,7 +13,7 @@ inherit dpkg-raw
 PROVIDES = "swupdate-handlers"
 
 SRC_URI += "git://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin;nobranch=1"
-SRCREV_swupdate-handler-roundrobin ?= "bf73f04b1eec0b8714d3a1b56bfcd1431c58ba10"
+SRCREV_swupdate-handler-roundrobin ?= "fbc8d8a7e4ae8c381198cab81ae3fb13398a028e"
 
 SWUPDATE_LUASCRIPT = "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
 
-- 
2.35.1


