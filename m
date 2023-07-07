Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BF4C001E0
	for <webhook@archiver.kernel.org>; Fri,  7 Jul 2023 14:16:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.13567.1688739361717570349
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jul 2023 07:16:01 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 367EG0Yb1354922; Fri, 7 Jul 2023 23:16:00 +0900
X-Iguazu-Qid: 2rWhJyZQYC149c8XjN
X-Iguazu-QSIG: v=2; s=0; t=1688739359; q=2rWhJyZQYC149c8XjN; m=E3pTSjC4sRYum0CDC21WLH6YlxY5OP17mnQg7meDVh0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 367EFuog1298407
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 7 Jul 2023 23:15:59 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v3 2/8] .reproducible-check-ci.yml: Drop 'base' in job names
Date: Fri,  7 Jul 2023 19:45:44 +0530
X-TSB-HOP2: ON
Message-Id: <20230707141550.27805-3-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <176E5CF032D87010.7887@lists.cip-project.org>
References: <176E5CF032D87010.7887@lists.cip-project.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Jul 2023 14:15:54.0230 (UTC) FILETIME=[8A83E160:01D9B0DD]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jul 2023 14:16:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12268

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Now the reproducible check is not restricted to minimal(base) image but
also it include other features like swupdate, secureboot, and security
extensions, so drop the name 'base' in the job names to avoid confusion.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .reproducible-check-ci.yml | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index f4250ce..a9e3996 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -64,7 +64,7 @@
 
 
 # repro build
-build:qemu-amd64-base-repro-build:
+build:qemu-amd64-repro-build:
   extends:
     - .repro-build
   variables:
@@ -72,7 +72,7 @@ build:qemu-amd64-base-repro-build:
     extension: ebg-swu
     wic_targz: enable
 
-build:qemu-arm64-base-repro-build:
+build:qemu-arm64-repro-build:
   extends:
     - .repro-build
   variables:
@@ -80,7 +80,7 @@ build:qemu-arm64-base-repro-build:
     extension: ebg-swu
     wic_targz: enable
 
-build:qemu-arm-base-repro-build:
+build:qemu-arm-repro-build:
   extends:
     - .repro-build
   variables:
@@ -89,26 +89,26 @@ build:qemu-arm-base-repro-build:
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



