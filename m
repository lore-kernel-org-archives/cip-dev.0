Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3F2CCD184
	for <webhook@archiver.kernel.org>; Tue, 21 Oct 2025 12:40:44 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.10739.1761050443574672230
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Oct 2025 05:40:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 59LCef7n1901577; Tue, 21 Oct 2025 21:40:42 +0900
X-Iguazu-Qid: 2yAbc3FhhcGK0f6cXA
X-Iguazu-QSIG: v=2; s=0; t=1761050441; q=2yAbc3FhhcGK0f6cXA; m=HUsOV8dEkY9Yjea58NH8LWb4FCKsemDlpKaLM+PsCOg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4crX2d2RLQzyPZ; Tue, 21 Oct 2025 21:40:41 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
Subject: [isar-cip-core][RFC v1 2/5] recipes-core/swupdate-config: Add suricatta section in swupdate.cfg
Date: Tue, 21 Oct 2025 08:52:29 -0400
X-TSB-HOP2: ON
Message-Id: <20251021125233.1528087-3-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251021125233.1528087-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20251021125233.1528087-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 21 Oct 2025 12:40:37.0245 (UTC) FILETIME=[E6ADF2D0:01DC4287]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Oct 2025 12:40:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20204

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

wfx requires options to be set via the suricatta section of swupdate.cfg,
let's add a suricatta section to the swupdate.cfg file and also an
additional suricatta arguments file to allow swupdate to start in
suricatta daemon mode at boot time.

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 recipes-core/swupdate-config/files/suricatta         |  1 +
 .../files/{swupdate.cfg => swupdate.cfg.tmpl}        |  7 +++++++
 recipes-core/swupdate-config/swupdate-config_0.2.bb  | 12 ++++++++++--
 3 files changed, 18 insertions(+), 2 deletions(-)
 create mode 100644 recipes-core/swupdate-config/files/suricatta
 rename recipes-core/swupdate-config/files/{swupdate.cfg => swupdate.cfg.tmpl} (55%)

diff --git a/recipes-core/swupdate-config/files/suricatta b/recipes-core/swupdate-config/files/suricatta
new file mode 100644
index 0000000..1dbdd5a
--- /dev/null
+++ b/recipes-core/swupdate-config/files/suricatta
@@ -0,0 +1 @@
+SWUPDATE_SURICATTA_ARGS="-S lua"
\ No newline at end of file
diff --git a/recipes-core/swupdate-config/files/swupdate.cfg b/recipes-core/swupdate-config/files/swupdate.cfg.tmpl
similarity index 55%
rename from recipes-core/swupdate-config/files/swupdate.cfg
rename to recipes-core/swupdate-config/files/swupdate.cfg.tmpl
index 3e2b45c..8a60f4b 100644
--- a/recipes-core/swupdate-config/files/swupdate.cfg
+++ b/recipes-core/swupdate-config/files/swupdate.cfg.tmpl
@@ -3,3 +3,10 @@ globals :
     bootloader = "ebg";
     public-key-file = "/usr/share/swupdate-signing/swupdate-sign.crt"
 };
+
+suricatta :
+{
+    id = "__DEVICE_ID__";
+    url = "${WFX_URL}";
+    polldelay = 20;
+};
diff --git a/recipes-core/swupdate-config/swupdate-config_0.2.bb b/recipes-core/swupdate-config/swupdate-config_0.2.bb
index 63fa320..218174a 100644
--- a/recipes-core/swupdate-config/swupdate-config_0.2.bb
+++ b/recipes-core/swupdate-config/swupdate-config_0.2.bb
@@ -16,12 +16,14 @@ DEBIAN_PROVIDES := "${PN}"
 
 PN .= "-${MACHINE}"
 
-SRC_URI = "file://swupdate.cfg \
+SRC_URI = "file://swupdate.cfg.tmpl \
            file://hwrevision.tmpl"
+SRC_URI:append:wfx = " file://suricatta"
 
 MACHINE_HW_VERSION ??= "cip-core-1.0"
-TEMPLATE_FILES += "hwrevision.tmpl"
+TEMPLATE_FILES += "hwrevision.tmpl swupdate.cfg.tmpl"
 TEMPLATE_VARS += "MACHINE MACHINE_HW_VERSION"
+TEMPLATE_VARS:append:wfx = " WFX_URL"
 
 do_install[cleandirs] = "${D}/etc/"
 do_install() {
@@ -30,3 +32,9 @@ do_install() {
         install -v -m 644 "${WORKDIR}"/hwrevision "${D}"/etc/
     fi
 }
+
+do_install:append:wfx () {
+    # start swupdate service in suricatta mode
+    install -d ${D}/etc/swupdate/conf.d
+    install -m 0644 ${WORKDIR}/suricatta ${D}/etc/swupdate/conf.d
+}
-- 
2.39.5



