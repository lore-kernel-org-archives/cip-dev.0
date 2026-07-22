Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8B9C4453E
	for <webhook@archiver.kernel.org>; Wed, 22 Jul 2026 15:11:26 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2371.1784733078272557676
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2026 08:11:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 66MFBGJN1514952; Thu, 23 Jul 2026 00:11:16 +0900
X-Iguazu-Qid: 2yAbeCtgw28OEk3ON6
X-Iguazu-QSIG: v=2; s=1; t=1784733076; q=2yAbeCtgw28OEk3ON6; m=FzD2dAtMEZMTw+05gdmVNDAdM0xsttLN8jS9oS369i8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h4yPw05TxzyPQ; Thu, 23 Jul 2026 00:11:15 +0900 (JST)
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        kazuhiro.hayashi.f74@mail.toshiba, kumar.dinesh.h95@mail.toshiba
Subject: [isar-cip-core][PATCH v3 1/3] swupdate-handler-roundrobin: Keep default lua version as 5.5
Date: Wed, 22 Jul 2026 20:27:53 +0530
X-TSB-HOP2: ON
Message-Id: <20260722145755.641375-2-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260722145755.641375-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20260722145755.641375-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Jul 2026 15:11:08.0447 (UTC) FILETIME=[52E182F0:01DD19EC]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jul 2026 15:11:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23718

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

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



