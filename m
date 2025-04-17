Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E645BC369C7
	for <webhook@archiver.kernel.org>; Thu, 17 Apr 2025 07:31:25 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.3259.1744875080082700082
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Apr 2025 00:31:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 53H7VG2N3761693; Thu, 17 Apr 2025 16:31:17 +0900
X-Iguazu-Qid: 2yAbRDIdvJ8cmaspCz
X-Iguazu-QSIG: v=2; s=0; t=1744875076; q=2yAbRDIdvJ8cmaspCz; m=TWkCZeWJvnqIGnfurkx4cmNpTwtAc3LfjIlQA7H1vQM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 53H7VFmH261958
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 16:31:15 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v4 1/2] .gitlab-ci.yml: Set timeout value to run IEC layer tests for different targets.
Date: Thu, 17 Apr 2025 12:57:07 +0530
X-TSB-HOP2: ON
Message-Id: <20250417072708.2757909-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 17 Apr 2025 07:31:13.0373 (UTC) FILETIME=[B280A0D0:01DBAF6A]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Apr 2025 07:31:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18520

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 .gitlab-ci.yml                   | 6 +++++-
 scripts/submit_lava.sh           | 7 +++++++
 tests/templates/IEC_template.yml | 2 +-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 146eb33..2c1deaa 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -334,7 +334,7 @@ build:qemu-riscv64:
   tags:
     - small
   script:
-    - scripts/submit_lava.sh ${test_function} ${target} ${CI_COMMIT_SHORT_SHA} ${release} ${CI_COMMIT_REF_SLUG}
+    - scripts/submit_lava.sh ${test_function} ${target} ${CI_COMMIT_SHORT_SHA} ${release} ${CI_COMMIT_REF_SLUG} ${iec_test_timeout}
   artifacts:
     name: "$CI_JOB_NAME"
     when: always
@@ -431,6 +431,7 @@ test:qemu-amd64-IEC:
   variables:
     target: qemu-amd64
     test_function: IEC
+    iec_test_timeout: 40
 
 test:qemu-arm64-IEC:
   extends:
@@ -439,6 +440,7 @@ test:qemu-arm64-IEC:
   variables:
     target: qemu-arm64
     test_function: IEC
+    iec_test_timeout: 40
 
 test:qemu-arm-IEC:
   extends:
@@ -447,6 +449,7 @@ test:qemu-arm-IEC:
   variables:
     target: qemu-arm
     test_function: IEC
+    iec_test_timeout: 40
 
 test:x86-uefi-IEC:
   extends:
@@ -455,6 +458,7 @@ test:x86-uefi-IEC:
   variables:
     target: x86-uefi
     test_function: IEC
+    iec_test_timeout: 60
 
 test:qemu-amd64-secure-boot-unsigned-kernel:
   extends:
diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index 9da083a..f69eadb 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -24,6 +24,10 @@ TARGET=$2
 COMMIT_REF=$3
 RELEASE=$4
 COMMIT_BRANCH=$5
+IEC_TEST_TIMEOUT_MINUTES=$6
+
+# Export to replace the timeout variable declared in IEC template
+export IEC_TEST_TIMEOUT_MINUTES
 
 if [ -z "$SUBMIT_ONLY" ]; then SUBMIT_ONLY=false; fi
 
@@ -334,6 +338,9 @@ else
 	exit 1
 fi
 
+# Replace the IEC_TEST_TIMEOUT_MINUTES variable in template files
+envsubst < ${job_dir}/*.yml > template.tmp && mv template.tmp ${job_dir}/*.yml
+
 if ! validate_job; then
 	clean_up
 	exit 1
diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
index 92944da..c8efe40 100644
--- a/tests/templates/IEC_template.yml
+++ b/tests/templates/IEC_template.yml
@@ -60,7 +60,7 @@ actions:
 # TEST_BLOCK
 - test:
      timeout:
-       minutes: 40
+       minutes: ${IEC_TEST_TIMEOUT_MINUTES}
      definitions:
      - repository: https://gitlab.com/cip-project/cip-testing/cip-security-tests.git
        from: git
-- 
2.30.2



