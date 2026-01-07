Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BA7CFD638
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 13:27:25 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5660.1767792443619166898
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 05:27:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=cqeAkvqM;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20260107132717d9d12aaeb8000207c9-zbodov@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260107132717d9d12aaeb8000207c9
        for <cip-dev@lists.cip-project.org>;
        Wed, 07 Jan 2026 14:27:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=tZ0Rbu+qeuyx35Ew4Z+Kbx27Lhzt6hxmYPehpLwRu8Y=;
 b=cqeAkvqMqTzhOrLLg7gQQn+jwbz/M1Tb3jXHWGWUFG18Nd72H4OonL2s08qbidgqqpigi/
 WQ/pWKMiKgHNelU0nTcForX6jN2Bsb35+kvH4Yjuplt5AjcGJ5KlX1zgljWH5rU1nZFbjP59
 Zrs7Ags7kwLZ4ET9KiEep05qJFMrFFeEXciAkay/jkbWIS7XU9WP5xRLQXL0h7gAoNzijROq
 ds3U6PgyDvA+HJSuesArXdih5FTuZmSNrPML578vj54doHaJ+uwXhnkd0Jcr+R/7v7sQTxDD
 d2s28mTHDPCGFOT9IyuYtHiFi/dFC0Gx84P/X38OZNLwTzckagNG1pRw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	clara.kowalsky@siemens.com,
	cip-dev@lists.cip-project.org,
	benedikt.niedermayr@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 3/7] Default SWUPDATE_BOOTLOADER to efibootguard
Date: Wed,  7 Jan 2026 14:26:26 +0100
Message-ID: <20260107132707.733180-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260107132707.733180-1-Quirin.Gylstorff@siemens.com>
References: <20260107132707.733180-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 13:27:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21405

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The variable SWUPDATE_BOOTLOADER is used to select the A/B root file
system bootloader. In isar-cip-core we default to efibootguard.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../swupdate-handler-roundrobin_0.1.bb                           | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
index d2edbbd..f5e513f 100644
--- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
+++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
@@ -17,6 +17,7 @@ SRCREV_swupdate-handler-roundrobin ?= "5deb75df5469c5a66cdd727eb72af83ce0784054"
 
 SWUPDATE_LUASCRIPT = "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
 
+SWUPDATE_BOOTLOADER ??= "efibootguard"
 SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG ?= "${@ 'swupdate.handler.efibootguard.ini' if d.getVar('SWUPDATE_BOOTLOADER') == 'efibootguard' else ''}"
 SRC_URI += "${@('file://' + d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG')) if d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG') else ''}"
 
-- 
2.51.2


