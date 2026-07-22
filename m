Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D540DC44536
	for <webhook@archiver.kernel.org>; Wed, 22 Jul 2026 15:11:26 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2322.1784733079177873180
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2026 08:11:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 66MFBGO23678510; Thu, 23 Jul 2026 00:11:17 +0900
X-Iguazu-Qid: 2rWhDvWdS0FZQddDIv
X-Iguazu-QSIG: v=2; s=1; t=1784733076; q=2rWhDvWdS0FZQddDIv; m=VKFEf8m1VsP+R0jatzsbu6WKdYAeXVLRwdla4/vcmXs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h4yPw3xZkz1xng; Thu, 23 Jul 2026 00:11:16 +0900 (JST)
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        kazuhiro.hayashi.f74@mail.toshiba, kumar.dinesh.h95@mail.toshiba
Subject: [isar-cip-core][PATCH v3 2/3] swupdate-handler-roundrobin: Remove adding additional lua version paths
Date: Wed, 22 Jul 2026 20:27:54 +0530
X-TSB-HOP2: ON
Message-Id: <20260722145755.641375-3-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260722145755.641375-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20260722145755.641375-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Jul 2026 15:11:08.0541 (UTC) FILETIME=[52EFDAD0:01DD19EC]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jul 2026 15:11:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23720

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

The additional lua version paths were required to support multiple debian
versions, now we have declared a debian version specific lua version paths.
This variable is not needed now, so remove it.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 .../swupdate-handler-roundrobin_0.1.bb                    | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
index f991483..6e923e4 100644
--- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
+++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
@@ -32,14 +32,6 @@ SWUPDATE_LUA_VERSION:bookworm = "5.3"
 SWUPDATE_LUA_VERSION:bullseye = "5.3"
 SWUPDATE_LUA_VERSION:buster = "5.3"
 
-SWUPDATE_ADDITIONAL_LUA_VERSIONS ??= "5.3"
-
-do_prepare_build:append() {
-    for lua_version in ${SWUPDATE_ADDITIONAL_LUA_VERSIONS}; do
-        echo "usr/share/lua/${SWUPDATE_LUA_VERSION} usr/share/lua/$lua_version" >> ${WORKDIR}/${PN}-${PV}/debian/${PN}.links
-    done
-}
-
 do_install[cleandirs] = "${D}/etc \
                          ${D}/usr/share/lua/${SWUPDATE_LUA_VERSION}"
 do_install() {
-- 
2.39.5



