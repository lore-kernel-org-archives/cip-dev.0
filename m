Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DEEC4451B
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 05:12:28 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2465.1784524341615591669
 for <cip-dev@lists.cip-project.org>;
 Sun, 19 Jul 2026 22:12:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 66K5CIKg277773; Mon, 20 Jul 2026 14:12:19 +0900
X-Iguazu-Qid: 2rWhDvWdRw8zdm6xC0
X-Iguazu-QSIG: v=2; s=1; t=1784524338; q=2rWhDvWdRw8zdm6xC0; m=WRNstX1OlnhSrw7wDWKuIsl5KMjOYAgvWmXrqefATWg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h3TCk3kJyz4vym; Mon, 20 Jul 2026 14:12:18 +0900 (JST)
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        kumar.dinesh.h95@mail.toshiba
Subject: [isar-cip-core][PATCH v1 2/2] swupdate.cfg.tmpl: Add digest-provider option for signature verification
Date: Mon, 20 Jul 2026 10:29:03 +0530
X-TSB-HOP2: ON
Message-Id: <20260720045903.733394-3-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720045903.733394-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20260720045903.733394-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Jul 2026 05:12:13.0993 (UTC) FILETIME=[53737990:01DD1806]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jul 2026 05:12:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23670

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

This option is introduced from v2025.12 onwards in the SWUpdate package.
It sets the crypto backend (mbedTLS) that the SWUpdate uses to verify
signed updates and compute digests when multiple provides are available.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 .../files/{swupdate.cfg => swupdate.cfg.tmpl}             | 1 +
 recipes-core/swupdate-config/swupdate-config_0.2.bb       | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)
 rename recipes-core/swupdate-config/files/{swupdate.cfg => swupdate.cfg.tmpl} (77%)

diff --git a/recipes-core/swupdate-config/files/swupdate.cfg b/recipes-core/swupdate-config/files/swupdate.cfg.tmpl
similarity index 77%
rename from recipes-core/swupdate-config/files/swupdate.cfg
rename to recipes-core/swupdate-config/files/swupdate.cfg.tmpl
index 3e2b45c..44d8d04 100644
--- a/recipes-core/swupdate-config/files/swupdate.cfg
+++ b/recipes-core/swupdate-config/files/swupdate.cfg.tmpl
@@ -2,4 +2,5 @@ globals :
 {
     bootloader = "ebg";
     public-key-file = "/usr/share/swupdate-signing/swupdate-sign.crt"
+    ${SWUPDATE_DIGEST_PROVIDER}
 };
diff --git a/recipes-core/swupdate-config/swupdate-config_0.2.bb b/recipes-core/swupdate-config/swupdate-config_0.2.bb
index b48e3d1..584706c 100644
--- a/recipes-core/swupdate-config/swupdate-config_0.2.bb
+++ b/recipes-core/swupdate-config/swupdate-config_0.2.bb
@@ -19,12 +19,14 @@ DEBIAN_PROVIDES := "${PN}"
 
 PN .= "-${MACHINE}"
 
-SRC_URI = "file://swupdate.cfg \
+SRC_URI = "file://swupdate.cfg.tmpl \
            file://hwrevision.tmpl"
 
+SWUPDATE_DIGEST_PROVIDER ??= ""
+SWUPDATE_DIGEST_PROVIDER:sid = "digest-provider = "pkcs#7mbedtls";"
 MACHINE_HW_VERSION ??= "cip-core-1.0"
-TEMPLATE_FILES += "hwrevision.tmpl"
-TEMPLATE_VARS += "MACHINE MACHINE_HW_VERSION"
+TEMPLATE_FILES += "hwrevision.tmpl swupdate.cfg.tmpl"
+TEMPLATE_VARS += "MACHINE MACHINE_HW_VERSION SWUPDATE_DIGEST_PROVIDER"
 
 do_install[cleandirs] = "${D}/etc/"
 do_install() {
-- 
2.39.5



