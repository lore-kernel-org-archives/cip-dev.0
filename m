Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416D3C7EE23
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 13:56:20 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.23571.1684850178288749113
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 May 2023 06:56:19 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 34NDuGra007920; Tue, 23 May 2023 22:56:17 +0900
X-Iguazu-Qid: 34trKxHUsXucBThUSg
X-Iguazu-QSIG: v=2; s=0; t=1684850175; q=34trKxHUsXucBThUSg; m=g9IhUKfNEusqJcZwV4V1i1tvbjSZbuJDgT7FQF2ikXU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1512) id 34NDuFnb038648
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 23 May 2023 22:56:15 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 2/2] .reproducible-check-ci.yml: use repro-tests.sh in the CI check
Date: Tue, 23 May 2023 19:26:11 +0530
X-TSB-HOP2: ON
Message-Id: <20230523135611.31234-3-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230523135611.31234-1-venkata.pyla@toshiba-tsip.com>
References: <20230523135611.31234-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 May 2023 13:56:12.0841 (UTC) FILETIME=[55C37990:01D98D7E]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 13:56:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11616

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

The repro-test in CI helps to check all different artifacts produced by
the target build and gives the report.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .reproducible-check-ci.yml | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index d42359c..d8bfb40 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -28,16 +28,17 @@
     - if [ -f kas/opt/reproducible.yml ]; then base_yaml="${base_yaml}:kas/opt/reproducible.yml"; fi
     # Build 1st time
     - !reference [.build_base, script]
-    - mv build/tmp/deploy/images/${target}/cip-core-image-cip-core-${release}-${target}${artifact_suffix} image1
+    - mv build/tmp/deploy/images/${target} image1
     # clean
     - sudo rm -rf build/tmp
     - sudo rm -rf build/sstate-cache
     # Build 2nd time
     - !reference [.build_base, script]
-    - mv build/tmp/deploy/images/${target}/cip-core-image-cip-core-${release}-${target}${artifact_suffix} image2
+    - mv build/tmp/deploy/images/${target} image2
   artifacts:
     expire_in: 1 day
     paths:
+      - scripts/repro-tests.sh
       - image1
       - image2
 
@@ -54,12 +55,12 @@
   before_script:
     - apt update && DEBIAN_FRONTEND=noninteractive apt install -y diffoscope
   script:
-    - diffoscope --text diffoscope_output.txt image1 image2
+    - ./scripts/repro-tests.sh --release ${release} --target ${target} image1 image2
   artifacts:
     when: always
     expire_in: 1 day
     paths:
-      - diffoscope_output.txt
+      - "./*diffoscope_output.txt"
 
 
 # repro build
@@ -85,17 +86,23 @@ build:qemu-arm-base-repro-build:
 test:qemu-amd64-base-repro-test:
   extends:
     - .repro-test
+  variables:
+    target: qemu-amd64
   dependencies:
     - build:qemu-amd64-base-repro-build
 
 test:qemu-arm64-base-repro-test:
   extends:
     - .repro-test
+  variables:
+    target: qemu-arm64
   dependencies:
     - build:qemu-arm64-base-repro-build
 
 test:qemu-arm-base-repro-test:
   extends:
     - .repro-test
+  variables:
+    target: qemu-arm
   dependencies:
     - build:qemu-arm-base-repro-build
-- 
2.20.1



