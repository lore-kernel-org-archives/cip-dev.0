Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC09C636D6
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 11:43:46 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.133])
 by mx.groups.io with SMTP id smtpd.web11.6708.1677066217950353580
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Feb 2023 03:43:38 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.133, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 31MBhZhk019786; Wed, 22 Feb 2023 20:43:35 +0900
X-Iguazu-Qid: 2wHHmhMsFP5xe8dUzy
X-Iguazu-QSIG: v=2; s=0; t=1677066215; q=2wHHmhMsFP5xe8dUzy; m=S1xZHgoncDc/baeaGK5RSQfUPMldFjFuw49e/FLZCps=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1110) id 31MBhYIU022732
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 22 Feb 2023 20:43:35 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v3 1/2] kas/opt/reproducible.yml: Add kas file for reproducible builds target
Date: Wed, 22 Feb 2023 17:14:07 +0530
X-TSB-HOP2: ON
Message-Id: <20230222114408.32155-2-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <2e6c36f78e3873f0627fa5c3912108fe1283438e.camel@siemens.com>
References: <2e6c36f78e3873f0627fa5c3912108fe1283438e.camel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Feb 2023 11:43:31.0950 (UTC) FILETIME=[E38668E0:01D946B2]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Feb 2023 11:43:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10779

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
index 0000000..0de59ed
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
+          SOURCE_DATE_EPOCH := "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
+
-- 
2.20.1



