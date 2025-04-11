Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC63C369A8
	for <webhook@archiver.kernel.org>; Fri, 11 Apr 2025 10:34:50 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.22656.1744367679625077437
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Apr 2025 03:34:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 53BAYbVJ3962280; Fri, 11 Apr 2025 19:34:37 +0900
X-Iguazu-Qid: 2rWhg4sy2JwAQFUWHa
X-Iguazu-QSIG: v=2; s=0; t=1744367676; q=2rWhg4sy2JwAQFUWHa; m=wJsevGjiV7WJuJi0kmZ/dhgvPUbR8v4URS0NFCLA3GI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 53BAYZlk2442162
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 19:34:36 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] scripts/submit_lava.sh: Set test shell timeout to 60 mins in case of M-COM
Date: Fri, 11 Apr 2025 16:00:28 +0530
X-TSB-HOP2: ON
Message-Id: <20250411103028.2081593-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Apr 2025 10:34:33.0715 (UTC) FILETIME=[50BD1C30:01DBAACD]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Apr 2025 10:34:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18502

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

Based on recent observations, 40 minutes seems to be insufficent to run all
IEC test cases on M-COM x86. The test execution is quite slow when compared to
QEMU. So the timeout has been increased to 60 minutes in case of M-COM x86.

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 scripts/submit_lava.sh           | 2 ++
 tests/templates/IEC_template.yml | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index 0e437e0..61f08e3 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -55,6 +55,7 @@ add_firmware_artifacts () {
 create_job_qemu () {
 	if [ "$1" = "IEC" ]; then
 		cp $LAVA_TEMPLATES/IEC_template.yml "${job_dir}/${1}_${2}.yml"
+		sed -i "s@#iec-tests-timeout#@40@g" "${job_dir}"/*.yml
 
 	elif [ "$1" = "swupdate" ]; then
 		cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}/${1}_${2}.yml"
@@ -163,6 +164,7 @@ create_job_mcom () {
 	cp $LAVA_TEMPLATES/M-COM-x86.yml "${job_dir}/${1}_${2}.yml"
 	if [ "$1" = "IEC" ]; then
 		grep -A 9 "# TEST_BLOCK" "$LAVA_TEMPLATES/$1_template.yml" >> "${job_dir}/${1}_${2}.yml"
+		sed -i "s@#iec-tests-timeout#@60@g" "${job_dir}"/*.yml
 	elif [ "$1" = "secure-boot" ]; then
 		grep -A 1 "parameters" "$LAVA_TEMPLATES/secureboot_template.yml" >> "${job_dir}/${1}_${2}.yml"
 	else
diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
index 72901bb..e50f041 100644
--- a/tests/templates/IEC_template.yml
+++ b/tests/templates/IEC_template.yml
@@ -60,7 +60,7 @@ actions:
 # TEST_BLOCK
 - test:
      timeout:
-       minutes: 40
+       minutes: #iec-tests-timeout#
      definitions:
      - repository: https://gitlab.com/cip-project/cip-testing/cip-security-tests.git
        from: git
-- 
2.30.2



