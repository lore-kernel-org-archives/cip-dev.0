Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D252DC001B3
	for <webhook@archiver.kernel.org>; Fri, 23 Jun 2023 14:06:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.42886.1687529165449111755
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Jun 2023 07:06:06 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.153, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 35NE63ur025695; Fri, 23 Jun 2023 23:06:03 +0900
X-Iguazu-Qid: 34trY2IxWgf5xJJi9j
X-Iguazu-QSIG: v=2; s=0; t=1687529162; q=34trY2IxWgf5xJJi9j; m=79zY4YvIolEDpuQ0+4hoYUkIWPNeiGvPyyHzRQsr6Y0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1513) id 35NE61mQ021172
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 23 Jun 2023 23:06:02 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 1/3] .reproducible-check-ci.yml: Add swupdate targets in reproducible check
Date: Fri, 23 Jun 2023 19:35:53 +0530
X-TSB-HOP2: ON
Message-Id: <20230623140555.11428-2-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230623140555.11428-1-venkata.pyla@toshiba-tsip.com>
References: <20230623140555.11428-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Jun 2023 14:05:59.0395 (UTC) FILETIME=[D62EC330:01D9A5DB]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Jun 2023 14:06:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12144

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .reproducible-check-ci.yml | 49 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index d8bfb40..5ea7857 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -82,6 +82,30 @@ build:qemu-arm-base-repro-build:
   variables:
     target: qemu-arm
 
+build:qemu-amd64-swupdate-repro-build:
+  extends:
+    - .repro-build
+  variables:
+    target: qemu-amd64
+    extension: ebg-swu
+    wic_targz: enable
+
+build:qemu-arm64-swupdate-repro-build:
+  extends:
+    - .repro-build
+  variables:
+    target: qemu-arm64
+    extension: ebg-swu
+    wic_targz: enable
+
+build:qemu-arm-swupdate-repro-build:
+  extends:
+    - .repro-build
+  variables:
+    target: qemu-arm
+    extension: ebg-swu
+    wic_targz: enable
+
 # repro build test
 test:qemu-amd64-base-repro-test:
   extends:
@@ -106,3 +130,28 @@ test:qemu-arm-base-repro-test:
     target: qemu-arm
   dependencies:
     - build:qemu-arm-base-repro-build
+
+test:qemu-amd64-swupdate-repro-test:
+  extends:
+    - .repro-test
+  variables:
+    target: qemu-amd64
+  dependencies:
+    - build:qemu-amd64-swupdate-repro-build
+
+test:qemu-arm64-swupdate-repro-test:
+  extends:
+    - .repro-test
+  variables:
+    target: qemu-arm64
+  dependencies:
+    - build:qemu-arm64-swupdate-repro-build
+
+test:qemu-arm-swupdate-repro-test:
+  extends:
+    - .repro-test
+  variables:
+    target: qemu-arm
+  dependencies:
+    - build:qemu-arm-swupdate-repro-build
+
-- 
2.20.1



