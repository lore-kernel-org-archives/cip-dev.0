Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2606DD48986
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 11:49:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4372.1768564145902419654
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Jan 2026 03:49:06 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 60GBn3la4092968; Fri, 16 Jan 2026 20:49:04 +0900
X-Iguazu-Qid: 2yAbeDG1VrwKVautAO
X-Iguazu-QSIG: v=2; s=0; t=1768564143; q=2yAbeDG1VrwKVautAO; m=m+MlfgDDNmXD+7X2ZvB67EkJGStgwMYm5GC8pmergVU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dsymv4NyGzyPZ; Fri, 16 Jan 2026 20:49:03 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        akunuri.sahithi@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
        michael.adler@siemens.com
Subject: [isar-cip-core][PATCH v5 1/4] swupdate-config-wfx: Recipe to set configs for wfx backend based updates
Date: Fri, 16 Jan 2026 07:03:44 -0500
X-TSB-HOP2: ON
Message-Id: <20260116120347.1733494-2-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260116120347.1733494-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20260116120347.1733494-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Jan 2026 11:49:00.0605 (UTC) FILETIME=[1AE06ED0:01DC86DE]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Jan 2026 11:49:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21631

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

wfx requires a unique clientId for each client device for targeted jobs for
each client. Additionally, start SWUpdate in suricatta daemon mode with the
built-in wfx lua client.

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 .../files/suricatta_wfx.conf.tmpl             |  1 +
 .../swupdate-config-wfx_0.1.bb                | 27 +++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl
 create mode 100644 recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb

diff --git a/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl b/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl
new file mode 100644
index 0000000..744b426
--- /dev/null
+++ b/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl
@@ -0,0 +1 @@
+SWUPDATE_SURICATTA_ARGS="--server lua -u ${WFX_URL} -i $(cat /etc/machine-id)"
diff --git a/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb b/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb
new file mode 100644
index 0000000..3569888
--- /dev/null
+++ b/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb
@@ -0,0 +1,27 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba Corporation, 2026
+#
+# Authors:
+#  Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg-raw
+
+PROVIDES := "${PN}"
+DEBIAN_PROVIDES := "${PN}"
+
+PN .= "-${MACHINE}"
+
+SRC_URI += "file://suricatta_wfx.conf.tmpl"
+
+TEMPLATE_FILES += " suricatta_wfx.conf.tmpl"
+TEMPLATE_VARS += " WFX_URL"
+
+do_install() {
+    install -d ${D}/etc/swupdate/conf.d
+    install -m 0644 ${WORKDIR}/suricatta_wfx.conf ${D}/etc/swupdate/conf.d/suricatta_wfx.conf
+}
-- 
2.39.5



