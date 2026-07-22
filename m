Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4574C44539
	for <webhook@archiver.kernel.org>; Wed, 22 Jul 2026 15:11:26 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2321.1784733079110665843
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2026 08:11:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 66MFBHdG2073077; Thu, 23 Jul 2026 00:11:17 +0900
X-Iguazu-Qid: 2rWhJyGIBoznjEXCaW
X-Iguazu-QSIG: v=2; s=1; t=1784733077; q=2rWhJyGIBoznjEXCaW; m=h1ZNuTQv/kTDGqCl3CDAzOChq84MkhAVi+n8ajZdy8M=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h4yPx0KXjz4vym; Thu, 23 Jul 2026 00:11:17 +0900 (JST)
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        kazuhiro.hayashi.f74@mail.toshiba, kumar.dinesh.h95@mail.toshiba
Subject: [isar-cip-core][PATCH v3 3/3] swupdate.cfg.tmpl: Add digest-provider option for signature verification
Date: Wed, 22 Jul 2026 20:27:55 +0530
X-TSB-HOP2: ON
Message-Id: <20260722145755.641375-4-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260722145755.641375-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20260722145755.641375-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Jul 2026 15:11:08.0556 (UTC) FILETIME=[52F224C0:01DD19EC]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jul 2026 15:11:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23719

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

This option is introduced from v2025.12 onwards in the SWUpdate package.
It sets the crypto backend (mbedTLS) that the SWUpdate uses to verify
signed updates and compute digests when multiple provides are available.

Add this option by default (forky/sid), and keep the variable as empty for other
Debian versions as it is not needed.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 .../files/{swupdate.cfg => swupdate.cfg.tmpl}        |  3 ++-
 recipes-core/swupdate-config/swupdate-config_0.2.bb  | 12 +++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)
 rename recipes-core/swupdate-config/files/{swupdate.cfg => swupdate.cfg.tmpl} (72%)

diff --git a/recipes-core/swupdate-config/files/swupdate.cfg b/recipes-core/swupdate-config/files/swupdate.cfg.tmpl
similarity index 72%
rename from recipes-core/swupdate-config/files/swupdate.cfg
rename to recipes-core/swupdate-config/files/swupdate.cfg.tmpl
index 3e2b45c..5faa713 100644
--- a/recipes-core/swupdate-config/files/swupdate.cfg
+++ b/recipes-core/swupdate-config/files/swupdate.cfg.tmpl
@@ -1,5 +1,6 @@
 globals :
 {
     bootloader = "ebg";
-    public-key-file = "/usr/share/swupdate-signing/swupdate-sign.crt"
+    public-key-file = "/usr/share/swupdate-signing/swupdate-sign.crt";
+    ${SWUPDATE_DIGEST_PROVIDER}
 };
diff --git a/recipes-core/swupdate-config/swupdate-config_0.2.bb b/recipes-core/swupdate-config/swupdate-config_0.2.bb
index b48e3d1..99e7a16 100644
--- a/recipes-core/swupdate-config/swupdate-config_0.2.bb
+++ b/recipes-core/swupdate-config/swupdate-config_0.2.bb
@@ -19,12 +19,18 @@ DEBIAN_PROVIDES := "${PN}"
 
 PN .= "-${MACHINE}"
 
-SRC_URI = "file://swupdate.cfg \
+SRC_URI = "file://swupdate.cfg.tmpl \
            file://hwrevision.tmpl"
 
+SWUPDATE_DIGEST_PROVIDER = "digest-provider = "pkcs#7mbedtls";"
+SWUPDATE_DIGEST_PROVIDER:trixie = ""
+SWUPDATE_DIGEST_PROVIDER:bookworm = ""
+SWUPDATE_DIGEST_PROVIDER:bullseye = ""
+SWUPDATE_DIGEST_PROVIDER:buster = ""
+
 MACHINE_HW_VERSION ??= "cip-core-1.0"
-TEMPLATE_FILES += "hwrevision.tmpl"
-TEMPLATE_VARS += "MACHINE MACHINE_HW_VERSION"
+TEMPLATE_FILES += "hwrevision.tmpl swupdate.cfg.tmpl"
+TEMPLATE_VARS += "MACHINE MACHINE_HW_VERSION SWUPDATE_DIGEST_PROVIDER"
 
 do_install[cleandirs] = "${D}/etc/"
 do_install() {
-- 
2.39.5



