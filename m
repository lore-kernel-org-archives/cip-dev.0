Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EF2CCD1BF
	for <webhook@archiver.kernel.org>; Tue, 28 Oct 2025 05:34:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.5107.1761629680635689504
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Oct 2025 22:34:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 59S5YcUC2086644; Tue, 28 Oct 2025 14:34:39 +0900
X-Iguazu-Qid: 2yAbeZagRX8A4JYW1l
X-Iguazu-QSIG: v=2; s=0; t=1761629678; q=2yAbeZagRX8A4JYW1l; m=VPqmYw8FJg78FOH4Qq29RKT2nJOtAX5/pigBjppAtZo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cwfFp53KCz1xnZ; Tue, 28 Oct 2025 14:34:38 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
Subject: [isar-cip-core][RFC v2 2/5] recipes-core/swupdate-config: Add suricatta section in swupdate.cfg
Date: Tue, 28 Oct 2025 01:46:19 -0400
X-TSB-HOP2: ON
Message-Id: <20251028054623.2268466-3-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251028054623.2268466-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20251028054623.2268466-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 Oct 2025 05:34:35.0052 (UTC) FILETIME=[8B5116C0:01DC47CC]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Oct 2025 05:34:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20243

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

wfx requires options to be set via the suricatta section of swupdate.cfg,
let's add a suricatta section to the swupdate.cfg file and also an
additional suricatta arguments file to allow swupdate to start in
suricatta daemon mode at boot time.

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 recipes-core/swupdate-config/files/suricatta  |  1 +
 .../files/{swupdate.cfg => swupdate.cfg.tmpl} |  2 ++
 .../swupdate-config/swupdate-config_0.2.bb    | 27 +++++++++++++++++--
 3 files changed, 28 insertions(+), 2 deletions(-)
 create mode 100644 recipes-core/swupdate-config/files/suricatta
 rename recipes-core/swupdate-config/files/{swupdate.cfg => swupdate.cfg.tmpl} (83%)

diff --git a/recipes-core/swupdate-config/files/suricatta b/recipes-core/swupdate-config/files/suricatta
new file mode 100644
index 0000000..8c045e0
--- /dev/null
+++ b/recipes-core/swupdate-config/files/suricatta
@@ -0,0 +1 @@
+SWUPDATE_SURICATTA_ARGS="-S lua"
diff --git a/recipes-core/swupdate-config/files/swupdate.cfg b/recipes-core/swupdate-config/files/swupdate.cfg.tmpl
similarity index 83%
rename from recipes-core/swupdate-config/files/swupdate.cfg
rename to recipes-core/swupdate-config/files/swupdate.cfg.tmpl
index 3e2b45c..076daf2 100644
--- a/recipes-core/swupdate-config/files/swupdate.cfg
+++ b/recipes-core/swupdate-config/files/swupdate.cfg.tmpl
@@ -3,3 +3,5 @@ globals :
     bootloader = "ebg";
     public-key-file = "/usr/share/swupdate-signing/swupdate-sign.crt"
 };
+
+${SURICATTA_SECTION}
diff --git a/recipes-core/swupdate-config/swupdate-config_0.2.bb b/recipes-core/swupdate-config/swupdate-config_0.2.bb
index 63fa320..cdc1b4c 100644
--- a/recipes-core/swupdate-config/swupdate-config_0.2.bb
+++ b/recipes-core/swupdate-config/swupdate-config_0.2.bb
@@ -16,13 +16,30 @@ DEBIAN_PROVIDES := "${PN}"
 
 PN .= "-${MACHINE}"
 
-SRC_URI = "file://swupdate.cfg \
+SRC_URI = "file://swupdate.cfg.tmpl \
            file://hwrevision.tmpl"
+SRC_URI:append:wfx = " file://suricatta"
 
 MACHINE_HW_VERSION ??= "cip-core-1.0"
-TEMPLATE_FILES += "hwrevision.tmpl"
+SURICATTA_SECTION ??= ""
+TEMPLATE_FILES += "hwrevision.tmpl swupdate.cfg.tmpl"
 TEMPLATE_VARS += "MACHINE MACHINE_HW_VERSION"
 
+python add_suricatta_section() {
+    wfx_url = d.getVar('WFX_URL')
+    swupdate_cfg_suricatta = f"""
+suricatta :
+{{
+    id = "__DEVICE_ID__";
+    url = "{wfx_url}";
+    polldelay = 20;
+}};
+"""
+    d.setVar('SURICATTA_SECTION', swupdate_cfg_suricatta)
+    d.appendVar('TEMPLATE_VARS', ' SURICATTA_SECTION')
+}
+do_transform_template[prefuncs] += "${@' add_suricatta_section' if 'wfx' in d.getVar('OVERRIDES').split(':') else ''}"
+
 do_install[cleandirs] = "${D}/etc/"
 do_install() {
     install -v -m 644 "${WORKDIR}"/swupdate.cfg "${D}"/etc/
@@ -30,3 +47,9 @@ do_install() {
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



