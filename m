Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68680C4453C
	for <webhook@archiver.kernel.org>; Wed, 22 Jul 2026 12:01:13 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.46185.1784721671965873133
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2026 05:01:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 66MC1ACn1578880; Wed, 22 Jul 2026 21:01:10 +0900
X-Iguazu-Qid: 2yAbkFS0M1a7LkYW6T
X-Iguazu-QSIG: v=2; s=1; t=1784721670; q=2yAbkFS0M1a7LkYW6T; m=HjdYmZ7BsJXQcg7LZ5cwvug0645GNHmtJyTYGM2+bWQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h4tBY6VYGzyPQ; Wed, 22 Jul 2026 21:01:09 +0900 (JST)
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <shivanand.kunijadar.v45@mail.toshiba>,
        kazuhiro.hayashi.f74@mail.toshiba, kumar.dinesh.h95@mail.toshiba,
        Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
Subject: [isar-cip-core][PATCH v2 1/3] swupdate-handler-roundrobin: Keep default lua version as 5.5
Date: Wed, 22 Jul 2026 17:17:51 +0530
X-TSB-HOP2: ON
Message-Id: <20260722114753.627244-2-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260722114753.627244-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20260722114753.627244-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Jul 2026 12:01:06.0192 (UTC) FILETIME=[C69B7900:01DD19D1]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jul 2026 12:01:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23710

From: Shivanand Kunijadar <shivanand.kunijadar.v45@mail.toshiba>

Keep default lua version as 5.5 which will be used by forky/sid and
add debian version specific variables for defining other lua versions.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 .../swupdate-handler-roundrobin_0.1.bb                    | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
index e3cc7f8..f991483 100644
--- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
+++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
@@ -25,7 +25,13 @@ SRC_URI += "${@('file://' + d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG')) if
 
 # The lua version used by swupdate to search for additional handler is hard coded in debian/rules
 # see https://salsa.debian.org/debian/swupdate/-/blob/6ccd44a8539ebb880bf0dac408d5db5de7e2de99/debian/rules#L13
-SWUPDATE_LUA_VERSION ??= "5.4"
+
+SWUPDATE_LUA_VERSION = "5.5"
+SWUPDATE_LUA_VERSION:trixie = "5.4"
+SWUPDATE_LUA_VERSION:bookworm = "5.3"
+SWUPDATE_LUA_VERSION:bullseye = "5.3"
+SWUPDATE_LUA_VERSION:buster = "5.3"
+
 SWUPDATE_ADDITIONAL_LUA_VERSIONS ??= "5.3"
 
 do_prepare_build:append() {
-- 
2.39.5



