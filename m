Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D9DCCFA1E
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 04:34:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10295.1762835646574729342
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Nov 2025 20:34:07 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 5AB4Y59b3490963; Tue, 11 Nov 2025 13:34:05 +0900
X-Iguazu-Qid: 2rWg9DyHEK4yAuZIRC
X-Iguazu-QSIG: v=2; s=0; t=1762835644; q=2rWg9DyHEK4yAuZIRC; m=IE4jzhwj+z9fS8Poq3ezOPN8boXlRed9mlUGO0uKDWw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4d5DFS63q7z4vym; Tue, 11 Nov 2025 13:34:04 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
Subject: [isar-cip-core][PATCH v2 2/2] .reproducible-check-ci.yml: Use S3 instead of the gitlab artifact storage
Date: Mon, 10 Nov 2025 23:47:20 -0500
X-TSB-HOP2: ON
Message-Id: <20251111044720.778805-3-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251111044720.778805-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20251111044720.778805-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Nov 2025 04:33:59.0429 (UTC) FILETIME=[66198B50:01DC52C4]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Nov 2025 04:34:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20488

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

So far we have been using the gitlab artifact storage for the build artifacts
from the RB tests. But this has the max artifact size per job set to 1 GB and
lately our builds seem to slightly go over this mark.

Let's use S3 to store the build artifacts and later fetch from the same during
the test stage.

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 .reproducible-check-ci.yml | 66 ++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 21 deletions(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index 7dc4b60..4db760c 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -24,23 +24,30 @@
   rules:
     - if: $CI_PIPELINE_SOURCE == "schedule" && $REPRODUCIBLE_BUILDS
   script:
+    - deploy_rb_artifacts() {
+        rb_build_num=$1;
+        for artifact in wic wic-partitions; do
+          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} ${artifact} ${rb_build_num};
+        done;
+        if [ "${extension}" != "none" ]; then
+          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} swu ${rb_build_num};
+        fi;
+      }
     # Build 1st time
     - !reference [.build_base, script]
-    - mv build/tmp/deploy/images/${target} image1
+    # Deploy .wic, .swu and wic partitions for build1
+    - deploy_rb_artifacts build1
     # clean
     - sudo rm -rf build/tmp
     - sudo rm -rf build/sstate-cache
     # Build 2nd time
     - !reference [.build_base, script]
-    - mv build/tmp/deploy/images/${target} image2
-    # Compress artifacts
-    - tar --ignore-failed-read -cJf image1.tar.xz image1/*.wic* image1/*.swu
-    - tar --ignore-failed-read -cJf image2.tar.xz image2/*.wic* image2/*.swu
+    # Deploy .wic, .swu and wic partitions for build2
+    - deploy_rb_artifacts build2
   artifacts:
     expire_in: 1 day
     paths:
       - scripts/repro-tests.sh
-      - image*.tar.xz
 
 .repro-test:
   image:
@@ -52,15 +59,37 @@
     - if: $CI_PIPELINE_SOURCE == "schedule" && $REPRODUCIBLE_BUILDS
   variables:
     GIT_STRATEGY: none
+    BASE_S3_URL: "https://s3.eu-central-1.amazonaws.com/download2.cip-project.org/cip-core"
     release: bookworm
     extension: security
+    image_base: "cip-core-image-cip-core"
   before_script:
-    - apt update && DEBIAN_FRONTEND=noninteractive apt install -y diffoscope
+    - apt update && DEBIAN_FRONTEND=noninteractive apt install -y diffoscope wget
   script:
-    - mkdir image1
-    - tar -xJf image1.tar.xz --strip-components=1 -C image1
-    - mkdir image2
-    - tar -xJf image2.tar.xz --strip-components=1 -C image2
+    - if [ "${extension}" = "security" ]; then
+        image_base="cip-core-image-security-cip-core";
+      fi
+    # Function to fetch artifacts for a build
+    - fetch_rb_artifacts() {
+        local build_num=$1;
+        local dir="image${build_num}";
+        local base_url="${BASE_S3_URL}/${CI_COMMIT_REF_SLUG}/${target}/rb/build${build_num}";
+
+        mkdir -p "$dir";
+        wget "${base_url}/${image_base}-${release}-${target}.wic.xz";
+        xz -d ${image_base}-${release}-${target}.wic.xz && mv ${image_base}-${release}-${target}.wic "$dir";
+
+        wget "${base_url}/${image_base}-${release}-${target}-wic-partitions.tar.xz";
+        tar -xJf ${image_base}-${release}-${target}-wic-partitions.tar.xz -C "$dir";
+        rm -f ${image_base}-${release}-${target}-wic-partitions.tar.xz;
+
+        if [ "${extension}" != "none" ]; then
+          wget "${base_url}/${image_base}-${release}-${target}.swu" && mv ${image_base}-${release}-${target}.swu "$dir";
+        fi;
+      }
+    # Fetch artifacts for both builds
+    - fetch_rb_artifacts 1
+    - fetch_rb_artifacts 2
     - ./scripts/repro-tests.sh --release ${release} --target ${target} --extension ${extension} image1 image2
   artifacts:
     when: always
@@ -108,24 +137,21 @@ test:qemu-amd64-repro-test:
     - .repro-test
   variables:
     target: qemu-amd64
-  dependencies:
-    - build:qemu-amd64-repro-build
+  needs: ["build:qemu-amd64-repro-build"]
 
 test:qemu-arm64-repro-test:
   extends:
     - .repro-test
   variables:
     target: qemu-arm64
-  dependencies:
-    - build:qemu-arm64-repro-build
+  needs: ["build:qemu-arm64-repro-build"]
 
 test:qemu-arm-repro-test:
   extends:
     - .repro-test
   variables:
     target: qemu-arm
-  dependencies:
-    - build:qemu-arm-repro-build
+  needs: ["build:qemu-arm-repro-build"]
 
 test:bbb-repro-test:
   extends:
@@ -133,13 +159,11 @@ test:bbb-repro-test:
   variables:
     target: bbb
     extension: "none"
-  dependencies:
-    - build:bbb-repro-build
+  needs: ["build:bbb-repro-build"]
 
 test:x86-uefi-repro-test:
   extends:
     - .repro-test
   variables:
     target: x86-uefi
-  dependencies:
-    - build:x86-uefi-repro-build
+  needs: ["build:x86-uefi-repro-build"]
-- 
2.39.5



