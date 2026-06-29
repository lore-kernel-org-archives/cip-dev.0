Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11BEC43458
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 09:10:55 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88286.1782724247954127467
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2026 02:10:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 65T9AjlD2193669; Mon, 29 Jun 2026 18:10:46 +0900
X-Iguazu-Qid: 2yAaj7rWyJ4vjznuoU
X-Iguazu-QSIG: v=2; s=1; t=1782724245; q=2yAaj7rWyJ4vjznuoU; m=9mjuZjOuuE0ZXX/DJGT84W7ff3e/gW8kww8gan0sTGk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gpgVY2pHyz1xnZ; Mon, 29 Jun 2026 18:10:45 +0900 (JST)
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, Adithya.Balakumar@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH] swupdate-handler-roundrobin: Update revision to latest master
Date: Mon, 29 Jun 2026 14:27:30 +0530
X-TSB-HOP2: ON
Message-Id: <20260629085730.416650-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 29 Jun 2026 09:10:43.0390 (UTC) FILETIME=[29D76DE0:01DD07A7]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2026 09:10:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23299

The round robin handler is updated to support Debian sid by making minor
changes required for Lua 5.5 version.

Closes #160

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 .../swupdate-handler-roundrobin_0.1.bb                         | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
index 2ba192c..9d9f6d7 100644
--- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
+++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
@@ -15,8 +15,7 @@ MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
 PROVIDES = "swupdate-handlers"
 
 SRC_URI += "git://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin;nobranch=1"
-SRCREV_swupdate-handler-roundrobin ?= "5deb75df5469c5a66cdd727eb72af83ce0784054"
-
+SRCREV_swupdate-handler-roundrobin ?= "105ba14dca6fbf168292a1182e8c1e18a728bcd4"
 SWUPDATE_LUASCRIPT = "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
 
 SWUPDATE_BOOTLOADER ??= "efibootguard"
-- 
2.39.5



