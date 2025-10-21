Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98237CCD1AB
	for <webhook@archiver.kernel.org>; Tue, 21 Oct 2025 12:40:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.10627.1761050446459744153
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Oct 2025 05:40:46 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 59LCei6M4138321; Tue, 21 Oct 2025 21:40:44 +0900
X-Iguazu-Qid: 2rWhejjBIhxR9M3ydt
X-Iguazu-QSIG: v=2; s=0; t=1761050444; q=2rWhejjBIhxR9M3ydt; m=tLgREauDNWbcck08wCndYiD7oHzCrsCIuwuk7fflzZw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4crX2h1ydsz4vyh; Tue, 21 Oct 2025 21:40:43 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
Subject: [isar-cip-core][RFC v1 4/5] kas/opt/wfx.yml: Set wfx specific variables
Date: Tue, 21 Oct 2025 08:52:31 -0400
X-TSB-HOP2: ON
Message-Id: <20251021125233.1528087-5-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251021125233.1528087-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20251021125233.1528087-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 21 Oct 2025 12:40:37.0479 (UTC) FILETIME=[E6D1A770:01DC4287]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Oct 2025 12:40:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20207

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

This brings in a new .yml file for wfx specific variables

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 kas/opt/wfx.yml | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 kas/opt/wfx.yml

diff --git a/kas/opt/wfx.yml b/kas/opt/wfx.yml
new file mode 100644
index 0000000..978b406
--- /dev/null
+++ b/kas/opt/wfx.yml
@@ -0,0 +1,20 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba Corporation 2025
+#
+# Authors:
+#  Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
+#
+# SPDX-License-Identifier: MIT
+#
+# This kas file adds wfx backend options
+
+header:
+  version: 14
+
+local_conf_header:
+  wfx: |
+    OVERRIDES .= ":wfx"
+    WFX_URL ?= ""
+    IMAGE_INSTALL:append = " wfx-customizations"
-- 
2.39.5



