Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF38C6379F
	for <webhook@archiver.kernel.org>; Tue, 21 Feb 2023 15:41:17 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.45857.1676994068929924795
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Feb 2023 07:41:09 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 31LFf63P021860; Wed, 22 Feb 2023 00:41:06 +0900
X-Iguazu-Qid: 34tr9ZSP4kbf0eq3Hs
X-Iguazu-QSIG: v=2; s=0; t=1676994066; q=34tr9ZSP4kbf0eq3Hs; m=H/1krpGOBdEd3b/iMN/tpTz/mam45h1of87JLpRw84I=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1510) id 31LFf55c012302
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 22 Feb 2023 00:41:06 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 1/2] kas/opt/reproducible.yml: Add kas file for reproducible builds target
Date: Tue, 21 Feb 2023 21:11:37 +0530
X-TSB-HOP2: ON
Message-Id: <20230221154138.15146-2-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230221154138.15146-1-venkata.pyla@toshiba-tsip.com>
References: <20230221154138.15146-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 21 Feb 2023 15:41:01.0895 (UTC) FILETIME=[E6BDB570:01D9460A]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Feb 2023 15:41:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10758

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

This kas file set the 'SOURCE_DATE_EPOCH' variable to last commit
timestamp required for building image reproducible.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 kas/opt/reproducible.yml | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 kas/opt/reproducible.yml

diff --git a/kas/opt/reproducible.yml b/kas/opt/reproducible.yml
new file mode 100644
index 0000000..173c018
--- /dev/null
+++ b/kas/opt/reproducible.yml
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba Corporation, 2023
+#
+# Authors:
+#  Venkata Pyla <venkata.pyla@toshiba-tsip.com>
+#
+# SPDX-License-Identifier: MIT
+#
+header:
+  version: 12
+
+local_conf_header:
+  reproducible-builds: |
+    SOURCE_DATE_EPOCH = "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
+
-- 
2.20.1



