Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49382C369C2
	for <webhook@archiver.kernel.org>; Wed, 16 Apr 2025 14:55:55 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.21206.1744815352777979393
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Apr 2025 07:55:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 53GEtnXA1738430; Wed, 16 Apr 2025 23:55:50 +0900
X-Iguazu-Qid: 2yAbyr8UpjJNc7Cdmq
X-Iguazu-QSIG: v=2; s=0; t=1744815349; q=2yAbyr8UpjJNc7Cdmq; m=9IvQnYwr321R16bn4lpVUPF2yp9OOZq8GLC7vHRSaRg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 53GEtmjB1888842
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 23:55:48 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v3 1/2] .gitlab-ci.yml: Set timeout value to run IEC layer tests for different targets.
Date: Wed, 16 Apr 2025 20:21:40 +0530
X-TSB-HOP2: ON
Message-Id: <20250416145141.2678093-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Apr 2025 14:55:46.0326 (UTC) FILETIME=[A2688360:01DBAEDF]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Apr 2025 14:55:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18511

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 .gitlab-ci.yml                   | 6 +++++-
 scripts/submit_lava.sh           | 5 +++++
 tests/templates/IEC_template.yml | 2 +-
 3 files changed, 11 insertions(+), 2 deletions(-)

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
index 9da083a..028bad8 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -24,6 +24,7 @@ TARGET=$2
 COMMIT_REF=$3
 RELEASE=$4
 COMMIT_BRANCH=$5
+IEC_TEST_TIMEOUT_MINUTES=$6
 
 if [ -z "$SUBMIT_ONLY" ]; then SUBMIT_ONLY=false; fi
 
@@ -55,6 +56,8 @@ add_firmware_artifacts () {
 create_job_qemu () {
 	if [ "$1" = "IEC" ]; then
 		cp $LAVA_TEMPLATES/IEC_template.yml "${job_dir}/${1}_${2}.yml"
+		export IEC_TEST_TIMEOUT_MINUTES
+		envsubst < "${job_dir}/${1}_${2}.yml" > IEC.tmp && mv IEC.tmp "${job_dir}/${1}_${2}.yml"
 
 	elif [ "$1" = "swupdate" ]; then
 		cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}/${1}_${2}.yml"
@@ -163,6 +166,8 @@ create_job_mcom () {
 	cp $LAVA_TEMPLATES/M-COM-x86.yml "${job_dir}/${1}_${2}.yml"
 	if [ "$1" = "IEC" ]; then
 		grep -A 9 "# TEST_BLOCK" "$LAVA_TEMPLATES/$1_template.yml" >> "${job_dir}/${1}_${2}.yml"
+		export IEC_TEST_TIMEOUT_MINUTES
+		envsubst < "${job_dir}/${1}_${2}.yml" > IEC.tmp && mv IEC.tmp "${job_dir}/${1}_${2}.yml"
 	elif [ "$1" = "secure-boot" ]; then
 		grep -A 1 "parameters" "$LAVA_TEMPLATES/secureboot_template.yml" >> "${job_dir}/${1}_${2}.yml"
 	else
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



