Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D949FCC9C0
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 04:30:43 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33012.1773117031904983678
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 21:30:32 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 62A4UUUJ1788290; Tue, 10 Mar 2026 13:30:30 +0900
X-Iguazu-Qid: 2rWgslAGiWIEJwHmro
X-Iguazu-QSIG: v=2; s=0; t=1773117030; q=2rWgslAGiWIEJwHmro; m=Cq8zOh/EX3yhMH6sHAd1EBVaaNbSKNK4wwXTPxuKHYA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fVLXQ0cKbz4vyh; Tue, 10 Mar 2026 13:30:30 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        koshiro.onuki.h55@mail.toshiba, kazuhiro3.hayashi@toshiba.co.jp,
        michael.adler@siemens.com, christian.storm@siemens.com
Subject: [isar-cip-core][RFC v1 3/7] swupdate-config: Add custom-http-headers section in swupdate.cfg
Date: Tue, 10 Mar 2026 00:45:50 -0400
X-TSB-HOP2: ON
Message-Id: <20260310044554.990348-4-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260310044554.990348-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20260310044554.990348-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Mar 2026 04:30:24.0062 (UTC) FILETIME=[9CE365E0:01DCB046]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Mar 2026 04:30:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22216

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Onboarding function relies on custom http headers sent by suricatta to the wfx backend.
Add option to append custom-http-headers section if wfx onboarding is enabled.

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 .../files/{swupdate.cfg => swupdate.cfg.tmpl}  |  2 ++
 .../swupdate-config/swupdate-config_0.2.bb     | 18 +++++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)
 rename recipes-core/swupdate-config/files/{swupdate.cfg => swupdate.cfg.tmpl} (73%)

diff --git a/recipes-core/swupdate-config/files/swupdate.cfg b/recipes-core/swupdate-config/files/swupdate.cfg.tmpl
similarity index 73%
rename from recipes-core/swupdate-config/files/swupdate.cfg
rename to recipes-core/swupdate-config/files/swupdate.cfg.tmpl
index 3e2b45c..7c00244 100644
--- a/recipes-core/swupdate-config/files/swupdate.cfg
+++ b/recipes-core/swupdate-config/files/swupdate.cfg.tmpl
@@ -3,3 +3,5 @@ globals :
     bootloader = "ebg";
     public-key-file = "/usr/share/swupdate-signing/swupdate-sign.crt"
 };
+
+${WFX_ADDITIONAL_HTTP_HEADERS_SECTION}
\ No newline at end of file
diff --git a/recipes-core/swupdate-config/swupdate-config_0.2.bb b/recipes-core/swupdate-config/swupdate-config_0.2.bb
index 63fa320..992ac39 100644
--- a/recipes-core/swupdate-config/swupdate-config_0.2.bb
+++ b/recipes-core/swupdate-config/swupdate-config_0.2.bb
@@ -16,12 +16,24 @@ DEBIAN_PROVIDES := "${PN}"
 
 PN .= "-${MACHINE}"
 
-SRC_URI = "file://swupdate.cfg \
+SRC_URI = "file://swupdate.cfg.tmpl \
            file://hwrevision.tmpl"
 
 MACHINE_HW_VERSION ??= "cip-core-1.0"
-TEMPLATE_FILES += "hwrevision.tmpl"
-TEMPLATE_VARS += "MACHINE MACHINE_HW_VERSION"
+WFX_ADDITIONAL_HTTP_HEADERS_SECTION ??= ""
+TEMPLATE_FILES += "hwrevision.tmpl swupdate.cfg.tmpl"
+TEMPLATE_VARS += "MACHINE MACHINE_HW_VERSION WFX_ADDITIONAL_HTTP_HEADERS_SECTION"
+
+python do_add_http_header_section() {
+    if "wfx-onboard" in d.getVar('OVERRIDES'):
+        additional_http_headers = f"""
+custom-http-headers: (
+    {{ name = "X-Machine-Serial-No"; value="#MACHINE-ID#" }},
+);
+        """
+        d.setVar('WFX_ADDITIONAL_HTTP_HEADERS_SECTION', additional_http_headers)
+}
+do_transform_template[prefuncs] += "do_add_http_header_section"
 
 do_install[cleandirs] = "${D}/etc/"
 do_install() {
-- 
2.39.5



