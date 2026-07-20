Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E61FC44515
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 05:12:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2462.1784524339156994187
 for <cip-dev@lists.cip-project.org>;
 Sun, 19 Jul 2026 22:12:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 66K5CHY43170934; Mon, 20 Jul 2026 14:12:17 +0900
X-Iguazu-Qid: 2yAbqIO4LeN0sIqDtw
X-Iguazu-QSIG: v=2; s=1; t=1784524337; q=2yAbqIO4LeN0sIqDtw; m=nuxlv4SOSiPoi019N7sodHWnE6zgig8Rp0ta/Mv34XU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h3TCj0n2vzyPQ; Mon, 20 Jul 2026 14:12:16 +0900 (JST)
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        kumar.dinesh.h95@mail.toshiba
Subject: [isar-cip-core][PATCH v1 1/2] swupdate-handler-roundrobin: Keep Lua version 5.5 for sid
Date: Mon, 20 Jul 2026 10:29:02 +0530
X-TSB-HOP2: ON
Message-Id: <20260720045903.733394-2-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720045903.733394-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20260720045903.733394-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Jul 2026 05:12:13.0977 (UTC) FILETIME=[53710890:01DD1806]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jul 2026 05:12:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23669

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

Update the Lua version to 5.5 as the SWUpdate package in sid
checks the lua script at /usr/share/lua/5.5/

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 .../swupdate-handler-roundrobin_0.1.bb                           | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
index e3cc7f8..3505a35 100644
--- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
+++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
@@ -26,6 +26,7 @@ SRC_URI += "${@('file://' + d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG')) if
 # The lua version used by swupdate to search for additional handler is hard coded in debian/rules
 # see https://salsa.debian.org/debian/swupdate/-/blob/6ccd44a8539ebb880bf0dac408d5db5de7e2de99/debian/rules#L13
 SWUPDATE_LUA_VERSION ??= "5.4"
+SWUPDATE_LUA_VERSION:sid = "5.5"
 SWUPDATE_ADDITIONAL_LUA_VERSIONS ??= "5.3"
 
 do_prepare_build:append() {
-- 
2.39.5



