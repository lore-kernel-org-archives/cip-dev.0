Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492C5C001DD
	for <webhook@archiver.kernel.org>; Mon,  3 Jul 2023 06:22:40 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.21550.1688365358071367568
 for <cip-dev@lists.cip-project.org>;
 Sun, 02 Jul 2023 23:22:38 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 3636MZoL3097883; Mon, 3 Jul 2023 15:22:36 +0900
X-Iguazu-Qid: 2rWhi9UHbwDwXEfRGz
X-Iguazu-QSIG: v=2; s=0; t=1688365355; q=2rWhi9UHbwDwXEfRGz; m=PM3kTgh9oS3uiqleHPK/84aNwr0h2Ci9pMG2RWo0jcY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 3636MYb4688591
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 3 Jul 2023 15:22:34 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 2/6] .reproducible-check-ci.yml: Drop 'base' in job names
Date: Mon,  3 Jul 2023 11:52:27 +0530
X-TSB-HOP2: ON
Message-Id: <20230703062231.18183-3-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <176C1D7D866704FB.6977@lists.cip-project.org>
References: <176C1D7D866704FB.6977@lists.cip-project.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 03 Jul 2023 06:22:31.0546 (UTC) FILETIME=[BF8B3DA0:01D9AD76]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jul 2023 06:22:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12173

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Now the reproducible check is not restricted to minimal(base) image but
also it include other features like swupdate, secureboot, and security
extensions, so drop the name 'base' in the job names to avoid confusion.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .reproducible-check-ci.yml | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index 021d4ef..f19bd2c 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -66,7 +66,7 @@
 
 
 # repro build
-build:qemu-amd64-base-repro-build:
+build:qemu-amd64-repro-build:
   extends:
     - .repro-build
   variables:
@@ -74,7 +74,7 @@ build:qemu-amd64-base-repro-build:
     extension: ebg-swu
     wic_targz: enable
 
-build:qemu-arm64-base-repro-build:
+build:qemu-arm64-repro-build:
   extends:
     - .repro-build
   variables:
@@ -82,7 +82,7 @@ build:qemu-arm64-base-repro-build:
     extension: ebg-swu
     wic_targz: enable
 
-build:qemu-arm-base-repro-build:
+build:qemu-arm-repro-build:
   extends:
     - .repro-build
   variables:
@@ -91,26 +91,26 @@ build:qemu-arm-base-repro-build:
     wic_targz: enable
 
 # repro build test
-test:qemu-amd64-base-repro-test:
+test:qemu-amd64-repro-test:
   extends:
     - .repro-test
   variables:
     target: qemu-amd64
   dependencies:
-    - build:qemu-amd64-base-repro-build
+    - build:qemu-amd64-repro-build
 
-test:qemu-arm64-base-repro-test:
+test:qemu-arm64-repro-test:
   extends:
     - .repro-test
   variables:
     target: qemu-arm64
   dependencies:
-    - build:qemu-arm64-base-repro-build
+    - build:qemu-arm64-repro-build
 
-test:qemu-arm-base-repro-test:
+test:qemu-arm-repro-test:
   extends:
     - .repro-test
   variables:
     target: qemu-arm
   dependencies:
-    - build:qemu-arm-base-repro-build
+    - build:qemu-arm-repro-build
-- 
2.20.1



