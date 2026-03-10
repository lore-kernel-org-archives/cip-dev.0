Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88083FCC9B6
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 04:30:42 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33055.1773117031842863722
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 21:30:32 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 62A4UTjp3654559; Tue, 10 Mar 2026 13:30:29 +0900
X-Iguazu-Qid: 2rWgzTVwjsoTWwxjDa
X-Iguazu-QSIG: v=2; s=0; t=1773117029; q=2rWgzTVwjsoTWwxjDa; m=uU20DH10mSwSMs8weQoQU5sr5eYAjw7yLO9+x7Tfg+c=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fVLXP45zqz1xnm; Tue, 10 Mar 2026 13:30:29 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        koshiro.onuki.h55@mail.toshiba, kazuhiro3.hayashi@toshiba.co.jp,
        michael.adler@siemens.com, christian.storm@siemens.com
Subject: [isar-cip-core][RFC v1 1/7] swupdate-config-wfx: Add the required configuration of wfx based onboarding
Date: Tue, 10 Mar 2026 00:45:48 -0400
X-TSB-HOP2: ON
Message-Id: <20260310044554.990348-2-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260310044554.990348-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20260310044554.990348-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Mar 2026 04:30:23.0967 (UTC) FILETIME=[9CD4E6F0:01DCB046]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Mar 2026 04:30:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22217

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

wfx onboarding plugin looks for a clientId of "onboarding" initially at first to
trigger the onboarding logic in the backend.

Once the onboarding swu is received and installed in the device, restart of the
swupdate service will now use the clientId received friom the swu for subsequent
communication with wfx.

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 .../files/suricatta_wfx_onboarding.conf.tmpl      | 10 ++++++++++
 .../files/swupdate_override.conf                  |  6 ++++++
 .../swupdate-config-wfx_0.1.bb                    | 15 +++++++++++----
 3 files changed, 27 insertions(+), 4 deletions(-)
 create mode 100644 recipes-core/swupdate-config-wfx/files/suricatta_wfx_onboarding.conf.tmpl
 create mode 100644 recipes-core/swupdate-config-wfx/files/swupdate_override.conf

diff --git a/recipes-core/swupdate-config-wfx/files/suricatta_wfx_onboarding.conf.tmpl b/recipes-core/swupdate-config-wfx/files/suricatta_wfx_onboarding.conf.tmpl
new file mode 100644
index 0000000..5a843d9
--- /dev/null
+++ b/recipes-core/swupdate-config-wfx/files/suricatta_wfx_onboarding.conf.tmpl
@@ -0,0 +1,10 @@
+WFX_CONFIG_FILE="/var/wfx/wfx_config.conf"
+
+if [ -f "$WFX_CONFIG_FILE" ]; then
+    CLIENT_ID=$(grep 'WFX_CLIENT_ID=' "$WFX_CONFIG_FILE" | awk -F'=' '{print $2}')
+else
+    CLIENT_ID="onboarding"
+fi
+
+SWUPDATE_SURICATTA_ARGS="--server lua -u ${WFX_URL} -i $CLIENT_ID"
+SWUPDATE_ARGS="--digest-provider opensslCMS $SWUPDATE_ARGS"
diff --git a/recipes-core/swupdate-config-wfx/files/swupdate_override.conf b/recipes-core/swupdate-config-wfx/files/swupdate_override.conf
new file mode 100644
index 0000000..fa19810
--- /dev/null
+++ b/recipes-core/swupdate-config-wfx/files/swupdate_override.conf
@@ -0,0 +1,6 @@
+[Unit]
+ConditionPathIsReadWrite=/etc
+
+[Service]
+ExecStartPre=
+ExecStartPre=/bin/sh -c 'sed -i "s|#MACHINE-ID#|$(cat /etc/machine-id)|" /etc/swupdate.cfg'
diff --git a/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb b/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb
index 3569888..2859503 100644
--- a/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb
+++ b/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb
@@ -15,13 +15,20 @@ PROVIDES := "${PN}"
 DEBIAN_PROVIDES := "${PN}"
 
 PN .= "-${MACHINE}"
+SURICATTA_WFX_CONF = "${@ 'suricatta_wfx_onboarding.conf' if 'wfx-onboard' in d.getVar('OVERRIDES') else 'suricatta_wfx.conf' }"
+SRC_URI:append = " ${@ 'file://' + d.getVar('SURICATTA_WFX_CONF') + '.tmpl'}"
+SRC_URI:append:wfx-onboard = " file://swupdate_override.conf"
 
-SRC_URI += "file://suricatta_wfx.conf.tmpl"
-
-TEMPLATE_FILES += " suricatta_wfx.conf.tmpl"
+TEMPLATE_FILES += " ${@ d.getVar('SURICATTA_WFX_CONF') + '.tmpl'}"
 TEMPLATE_VARS += " WFX_URL"
 
+do_install[cleandirs] = "${D}/etc/swupdate/conf.d/"
 do_install() {
     install -d ${D}/etc/swupdate/conf.d
-    install -m 0644 ${WORKDIR}/suricatta_wfx.conf ${D}/etc/swupdate/conf.d/suricatta_wfx.conf
+    install -m 0644 ${WORKDIR}/${SURICATTA_WFX_CONF} ${D}/etc/swupdate/conf.d/suricatta_wfx.conf
+}
+
+do_install:append:wfx-onboard() {
+    install -d ${D}/etc/systemd/system/swupdate.service.d
+    install -m 0644 ${WORKDIR}/swupdate_override.conf ${D}/etc/systemd/system/swupdate.service.d
 }
-- 
2.39.5



