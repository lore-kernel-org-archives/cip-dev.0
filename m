Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474EBCCF9F0
	for <webhook@archiver.kernel.org>; Tue, 28 Oct 2025 12:09:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.9684.1761653340997341375
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Oct 2025 05:09:01 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 59SC8xvR134193; Tue, 28 Oct 2025 21:08:59 +0900
X-Iguazu-Qid: 2rWh3gygZ6NjzuPK7d
X-Iguazu-QSIG: v=2; s=0; t=1761653339; q=2rWh3gygZ6NjzuPK7d; m=4kSKQBuCC24k31a2wafhh9aDjORecKd5a6grv15afl4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cwq0q1pDXz4vyk; Tue, 28 Oct 2025 21:08:58 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
Subject: [isar-cip-core][RFC v3 4/5] kas/opt/wfx.yml: Set wfx specific variables
Date: Tue, 28 Oct 2025 08:20:41 -0400
X-TSB-HOP2: ON
Message-Id: <20251028122042.2355451-5-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251028122042.2355451-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20251028122042.2355451-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 Oct 2025 12:08:53.0471 (UTC) FILETIME=[A0D556F0:01DC4803]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Oct 2025 12:09:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20258

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



