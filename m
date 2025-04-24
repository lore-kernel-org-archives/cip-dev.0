Return-Path: <clara.kowalsky@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790A7C369C2
	for <webhook@archiver.kernel.org>; Thu, 24 Apr 2025 13:24:34 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.15029.1745501073456546172
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Apr 2025 06:24:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=clara.kowalsky@siemens.com header.s=fm1 header.b=SeXQu6NO;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1047747-2025042413242990a5afcbdee10518b8-uss3ge@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2025042413242990a5afcbdee10518b8
        for <cip-dev@lists.cip-project.org>;
        Thu, 24 Apr 2025 15:24:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=CfqwOyFhCn5s2CtZxBLzgv1j41cjvBWCh6wsp04/zMk=;
 b=SeXQu6NOAW6DR/3SWF05pLl5Ohj5bVTNDTFL3dtrDddg6PwDbRm8jIrpHJMydZYFoLdb62
 xDo/LaScrDm1jRjmZNRVWaVM03HG9tmpmOe1z3UOT8efZzMDiJBnXcCB6UkN7PTVGPLeeBVO
 w0l0mkLYwMr5bskxQMbc/aC4RSjg+J3aTgWDAw3gEdMRCBnNI+J8oeZztvJzOoIFUoa87P1w
 /gjrcevfxnUEERA5DaNgcs4PDUbZow3Vb3jiBPEnr4PBO5uU+gwJy7fQqQWX83OR/0drRohy
 T6VIEOjf8brEKd+zO30ZylDQtKtxwJ8BR7j1+w/K5aQeihPmR96IIulw==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH] doc/README.swupdate.md: fix type for lua script
Date: Thu, 24 Apr 2025 15:24:24 +0200
Message-ID: <20250424132424.3537137-1-clara.kowalsky@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Apr 2025 13:24:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18599

This uses the correct type flag in the lua example.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 doc/README.swupdate.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index 5308a50..36a150a 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -116,7 +116,7 @@ and is added:
 ```
 SWU_SCRIPTS = "luascript"
 SWU_SCRIPT_luascript[file] = "luascript.lua"
-SWU_SCRIPT_luascript[type] = "luascript"
+SWU_SCRIPT_luascript[type] = "lua"
 SWU_SCRIPT_luascript[data] = "some_data"
 ```
 
-- 
2.49.0


