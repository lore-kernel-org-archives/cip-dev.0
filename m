Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8417BFCC9C2
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 04:30:43 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33060.1773117034988910417
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 21:30:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 62A4UXtD1788514; Tue, 10 Mar 2026 13:30:33 +0900
X-Iguazu-Qid: 2rWgBS9jVzU78oNgLR
X-Iguazu-QSIG: v=2; s=0; t=1773117033; q=2rWgBS9jVzU78oNgLR; m=R3FwzgegX8cG0xSUcv6DmxBglPVm2jJJZGAAn8oX6x8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fVLXT1CLHz4vys; Tue, 10 Mar 2026 13:30:33 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        koshiro.onuki.h55@mail.toshiba, kazuhiro3.hayashi@toshiba.co.jp,
        michael.adler@siemens.com, christian.storm@siemens.com
Subject: [isar-cip-core][RFC v1 6/7] kas/opt/wfx.yml: Consolidate wfx options into a separate kas yml file
Date: Tue, 10 Mar 2026 00:45:53 -0400
X-TSB-HOP2: ON
Message-Id: <20260310044554.990348-7-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260310044554.990348-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20260310044554.990348-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Mar 2026 04:30:24.0312 (UTC) FILETIME=[9D098B80:01DCB046]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Mar 2026 04:30:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22222

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 kas/opt/wfx.yml                  | 22 ++++++++++++++++++++++
 recipes-core/images/swupdate.inc |  4 ----
 2 files changed, 22 insertions(+), 4 deletions(-)
 create mode 100644 kas/opt/wfx.yml

diff --git a/kas/opt/wfx.yml b/kas/opt/wfx.yml
new file mode 100644
index 0000000..bd80616
--- /dev/null
+++ b/kas/opt/wfx.yml
@@ -0,0 +1,22 @@
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
+# This kas file adds wfx options
+header:
+  version: 14
+
+local_conf_header:
+  wfx: |
+    WFX_URL ??= ""
+    IMAGE_INSTALL:append = " swupdate-config-wfx"
+  wfx-onboard: |
+    WFX_BASED_ONBOARDING ??= "0"
+    OVERRIDES .= "${@':wfx-onboard' if bb.utils.to_boolean(d.getVar("WFX_BASED_ONBOARDING")) else ''}"
+    IMAGE_INSTALL:append:wfx-onboard = " wfx-onboarding-progress-client"
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 00e972e..7cd816a 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -57,9 +57,5 @@ python() {
 IMAGE_INSTALL:append = "${@' swupdate' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ''}"
 IMAGE_PREINSTALL:append = "${@'' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ' swupdate'}"
 
-WFX_URL ??= ""
-# check for wfx url to enable support for wfx backend based updates
-IMAGE_INSTALL:append = "${@' swupdate-config-wfx' if d.getVar("WFX_URL") else ''}"
-
 IMAGE_INSTALL += " swupdate-handler-roundrobin"
 IMAGE_INSTALL += " swupdate-config"
-- 
2.39.5



