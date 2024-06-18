Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058E8C27C4F
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 04:50:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.78482.1718686224774438741
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jun 2024 21:50:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 45I4oMMX676336; Tue, 18 Jun 2024 13:50:23 +0900
X-Iguazu-Qid: 2rWhGbqYjXcQ4WOk8P
X-Iguazu-QSIG: v=2; s=0; t=1718686222; q=2rWhGbqYjXcQ4WOk8P; m=rg8VuvWV/6u0w1jn54RM4mV/BHekBdQDQp9i0IFNkY4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 45I4oLVK3265408
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 13:50:21 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 3/3] .gitlab-ci.yml: Break current test jobs to run one LAVA job per Gitlab job
Date: Tue, 18 Jun 2024 10:20:08 +0530
X-TSB-HOP2: ON
Message-Id: <20240618045008.1765300-4-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240618045008.1765300-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20240618045008.1765300-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 18 Jun 2024 04:50:07.0345 (UTC) FILETIME=[FDEF8E10:01DAC13A]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jun 2024 04:50:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16276

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 .gitlab-ci.yml | 80 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 71 insertions(+), 9 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b3f1fc6..b567556 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -26,6 +26,7 @@ variables:
   deploy_kernelci: disable
   build_swu_v2: disable
   swupdate_version: default
+  test_function: swupdate
 
 stages:
   - build
@@ -355,6 +356,8 @@ build:qemu-riscv64:
   tags:
     - small
   allow_failure: true
+  script:
+    - scripts/submit_lava.sh ${test_function} ${target} ${CI_COMMIT_SHORT_SHA} ${release} ${CI_COMMIT_REF_SLUG}
   artifacts:
     name: "$CI_JOB_NAME"
     when: always
@@ -364,23 +367,82 @@ build:qemu-riscv64:
     reports:
       junit: results/results*.xml
 
-test-qemu-secure-boot:
+test:qemu-amd64-secure-boot:
   extends:
     - .test-cip-core
-  script:
-    - scripts/submit_lava.sh secure-boot ${CI_COMMIT_SHA} ${release} ${CI_COMMIT_REF_SLUG}
+  variables:
+    target: qemu-amd64
+    test_function: secure-boot
 
-test-qemu-swupdate:
+test:qemu-arm64-secure-boot:
   extends:
     - .test-cip-core
-  script:
-    - scripts/submit_lava.sh swupdate ${CI_COMMIT_SHA} ${release} ${CI_COMMIT_REF_SLUG}
+  variables:
+    target: qemu-arm64
+    test_function: secure-boot
+
+test:qemu-arm-secure-boot:
+  extends:
+    - .test-cip-core
+  variables:
+    target: qemu-arm
+    test_function: secure-boot
+
+test:qemu-amd64-swupdate:
+  extends:
+    - .test-cip-core
+  variables:
+    target: qemu-amd64
+    test_function: swupdate
+
+test:qemu-arm64-swupdate:
+  extends:
+    - .test-cip-core
+  variables:
+    target: qemu-arm64
+    test_function: swupdate
+
+test:qemu-arm-swupdate:
+  extends:
+    - .test-cip-core
+  variables:
+    target: qemu-arm
+    test_function: swupdate
+
+test:qemu-amd64-swupdate-kernel-panic:
+  extends:
+    - .test-cip-core
+  variables:
+    target: qemu-amd64
+    test_function: kernel-panic
 
-test-qemu-IEC:
+test:qemu-amd64-swupdate-initramfs-crash:
+  extends:
+    - .test-cip-core
+  variables:
+    target: qemu-amd64
+    test_function: initramfs-crash
+
+test:qemu-amd64-IEC:
   extends:
    - .test-cip-core
-  script:
-    - scripts/submit_lava.sh IEC ${CI_COMMIT_SHA} ${release} ${CI_COMMIT_REF_SLUG}
+  variables:
+    target: qemu-amd64
+    test_function: IEC
+
+test:qemu-arm64-IEC:
+  extends:
+   - .test-cip-core
+  variables:
+    target: qemu-arm64
+    test_function: IEC
+
+test:qemu-arm-IEC:
+  extends:
+   - .test-cip-core
+  variables:
+    target: qemu-arm
+    test_function: IEC
 
 cve-checks:
   stage: cve-check
-- 
2.30.2



