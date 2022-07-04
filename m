Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E37C433EF
	for <webhook@archiver.kernel.org>; Mon,  4 Jul 2022 17:21:32 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.74934.1656955287497641754
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Jul 2022 10:21:28 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155,
 mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 264HLP3f003732;
 Tue, 5 Jul 2022 02:21:25 +0900
X-Iguazu-Qid: 34tKBxeAi4XTSLpalM
X-Iguazu-QSIG: v=2; s=0; t=1656955285; q=34tKBxeAi4XTSLpalM;
 m=w0FVB3kFudUtUOsVLuefNeHdqCCPYfJOofx5eN1Now8=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1513) id 264HLOL7004736
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 5 Jul 2022 02:21:24 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH] security-testing.yml: Add kas option for IEC
 layer testing
Date: Mon,  4 Jul 2022 22:51:22 +0530
X-TSB-HOP2: ON
Message-Id: <20220704172122.11322-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 04 Jul 2022 17:21:22.0646 (UTC)
 FILETIME=[7B8D6760:01D88FCA]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Jul 2022 17:21:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8650

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

This kas option file adds additonal packages required only while testing
using cip-security-tests[1].

Also it provides additional rootfs size required for testing.

[1] https://gitlab.com/cip-project/cip-testing/cip-security-tests

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 kas/opt/security-testing.yml | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 kas/opt/security-testing.yml

diff --git a/kas/opt/security-testing.yml b/kas/opt/security-testing.yml
new file mode 100644
index 0000000..19215f1
--- /dev/null
+++ b/kas/opt/security-testing.yml
@@ -0,0 +1,20 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba Corporation, 2022
+#
+# Authors:
+#  Venkata Pyla <venkata.pyla@toshiba-tsip.com>
+#
+# SPDX-License-Identifier: MIT
+#
+header:
+  version: 10
+  includes:
+   - kas/opt/security.yml
+
+local_conf_header:
+     security_testing: |
+        IMAGE_PREINSTALL_append = " sshpass"
+        ROOTFS_EXTRA = "8192"
+
-- 
2.20.1



