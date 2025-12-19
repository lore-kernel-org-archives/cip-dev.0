Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B49DD767CB
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 10:33:58 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14212.1766140433426305686
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Dec 2025 02:33:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=Gq6pt8d0;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20251219103351462bc5f7b5000207e5-fjlwx1@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20251219103351462bc5f7b5000207e5
        for <cip-dev@lists.cip-project.org>;
        Fri, 19 Dec 2025 11:33:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=tZ0Rbu+qeuyx35Ew4Z+Kbx27Lhzt6hxmYPehpLwRu8Y=;
 b=Gq6pt8d0gZl0M0ItMeDJpPNUAcsyTsZlqM8POw03dYswZtD/q0IEdZo8TTKqiBngOCSbST
 zu58PryDj39aw1Rr66UdINu7j8NKSeqXak9ruLqSEWng7tPV4t0TwYt9C5IRI8/TUscPTXnr
 IMY1wUoIPBAaMLyMw1MlLCmnSGyL2v3ZofLhiwSkZ7Yy/EsxNMGmc/uCyqS5aaxmys4fF1ic
 Tz2jmrYnk9968Nmo8xSqmejO3w5TDWAmkkaMOoDyHJkZ4fQp/6N4Ua8/Z41eXnJgQctrbvA3
 BIkGYKZHCj7ysKr0xttu0ypwDg1OmETmHYNsnkEg5RfOAEZm+u+0vGiA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	clara.kowalsky@siemens.com,
	cip-dev@lists.cip-project.org,
	benedikt.niedermayr@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 3/6] Default SWUPDATE_BOOTLOADER to efibootguard
Date: Fri, 19 Dec 2025 11:31:23 +0100
Message-ID: <20251219103349.1227710-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20251219103349.1227710-1-Quirin.Gylstorff@siemens.com>
References: <20251219103349.1227710-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Dec 2025 10:33:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21172

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


