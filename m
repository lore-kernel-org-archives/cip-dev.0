Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CB3C43217
	for <webhook@archiver.kernel.org>; Tue, 28 Sep 2021 18:49:54 +0000 (UTC)
Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web11.760.1632854993278843682
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Sep 2021 11:49:53 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.40, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 18SInopS021516
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Sep 2021 20:49:50 +0200
Received: from md2dvrtc.fritz.box ([139.22.32.51])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 18SInmh0026555;
	Tue, 28 Sep 2021 20:49:49 +0200
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, dinesh.kumar@toshiba-tsip.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH 2/2] kas/opt/efibootguard: Move
 setting of IMAGE_TYPE
Date: Tue, 28 Sep 2021 20:49:48 +0200
Message-Id: <20210928184948.737071-3-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210928184948.737071-1-Quirin.Gylstorff@siemens.com>
References: <20210928184948.737071-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Sep 2021 18:49:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6758

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This seperates the image type from the boot loader.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/efibootguard.yml |  1 -
 kas/opt/wic-img.yml      | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100644 kas/opt/wic-img.yml

diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
index 705a76d..4e8be69 100644
--- a/kas/opt/efibootguard.yml
+++ b/kas/opt/efibootguard.yml
@@ -23,6 +23,5 @@ local_conf_header:
   efibootguard-wic: |
     WDOG_TIMEOUT ?= "60"
     WICVARS += "WDOG_TIMEOUT"
-    IMAGE_TYPE ?= "wic-img"
     WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
 
diff --git a/kas/opt/wic-img.yml b/kas/opt/wic-img.yml
new file mode 100644
index 0000000..2b02b42
--- /dev/null
+++ b/kas/opt/wic-img.yml
@@ -0,0 +1,19 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2021
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+# This kas file set the IMAGE_TYPE to wic-img
+# The device specific WKS_FILE needs to be set seperately.
+
+header:
+  version: 10
+
+local_conf_header:
+  image-type: |
+    IMAGE_TYPE = "wic-img"
-- 
2.30.2


