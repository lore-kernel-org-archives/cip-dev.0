Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CF2C0219C
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 15:08:03 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.71481.1738940880841167835
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Feb 2025 07:08:01 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 517F7w5g241438; Sat, 8 Feb 2025 00:07:59 +0900
X-Iguazu-Qid: 2rWhWAeBjSXMJr6cm9
X-Iguazu-QSIG: v=2; s=0; t=1738940877; q=2rWhWAeBjSXMJr6cm9; m=kVyhUbEFqAMuvAGx41mUPa8idJQtDhBi2sz6BPXaPHY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 517F7uEe323866
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 8 Feb 2025 00:07:57 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v1 3/5] submit_lava.sh: Include functionality to prepare M-COM job defintions
Date: Fri,  7 Feb 2025 20:34:37 +0530
X-TSB-HOP2: ON
Message-Id: <20250207150439.392479-4-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250207150439.392479-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20250207150439.392479-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Feb 2025 15:07:52.0891 (UTC) FILETIME=[0F6288B0:01DB7972]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Feb 2025 15:08:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17775

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 scripts/submit_lava.sh | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index 1f55c3b..49a4401 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -52,7 +52,7 @@ add_firmware_artifacts () {
 
 # This method creates LAVA job definitions for QEMU amd64, arm64 and armhf
 # The created job definitions test SWUpdate, Secureboot and IEC layer
-create_job () {
+create_job_qemu () {
 	if [ "$1" = "IEC" ]; then
 		cp $LAVA_TEMPLATES/IEC_template.yml "${job_dir}/${1}_${2}.yml"
 
@@ -93,6 +93,33 @@ create_job () {
 	sed -i "s@#context-architecture#@${arch}@g" "${job_dir}"/*.yml
 }
 
+# This method creates LAVA job definitions for M-COM-x86
+# The created job definitions test SWUpdate, Secureboot and IEC layer
+create_job_mcom () {
+	cp $LAVA_TEMPLATES/M-COM-x86.yml "${job_dir}/${1}_${2}.yml"
+	if [ "$1" = "IEC" ]; then
+		grep -A 9 "# TEST_BLOCK" $LAVA_TEMPLATES/$1_template.yml >> "${job_dir}/${1}_${2}.yml"
+	elif [ "$1" = "secure-boot" ]; then
+		grep -A 1 "parameters" $LAVA_TEMPLATES/secureboot_template.yml >> "${job_dir}/${1}_${2}.yml"
+	else
+		# swupdate -d option does not work on M-COM, so .swu file is deployed to downloads
+		grep -A 7 "deploy:" "${job_dir}/${1}_${2}.yml" > "${job_dir}/swupdate_deploy_download.yml"
+		sed -i -e "s@flasher@downloads@g" -e "s@wic.xz@swu@g" "${job_dir}/swupdate_deploy_download.yml"
+		sed -i -e "/actions/r ${job_dir}/swupdate_deploy_download.yml" "${job_dir}/${1}_${2}.yml"
+
+		# Remove the deploy to download yml file once it is placed in the job definition
+		rm "${job_dir}/swupdate_deploy_download.yml"
+
+		# swupdate test action on M-COM is different from the test block used in QEMU
+		cat $LAVA_TEMPLATES/swupdate-test-action-M-COM.yml | tee -a "${job_dir}/${1}_${2}.yml" > /dev/null
+		grep -A 12 "# BOOT BLOCK" $LAVA_TEMPLATES/M-COM-x86.yml >> "${job_dir}/${1}_${2}.yml"
+		grep -A 16 "# TEST BLOCK 2" $LAVA_TEMPLATES/$1_template.yml >> "${job_dir}/${1}_${2}.yml"
+		sed -i -e "s@#updatestate#@2@g" -e "s@overlay-1.1.1.4@overlay-2.1.1.4@g" "${job_dir}/${1}_${2}.yml"
+	fi
+	sed -i -e "s@#test_function#@${1}@g" -e "s@#branch#@${COMMIT_BRANCH}@g" "${job_dir}/${1}_${2}.yml"
+	sed -i -e "s@#distribution#@${RELEASE}@g" -e "s@#project_url#@${PROJECT_URL}@g" "${job_dir}/${1}_${2}.yml"
+}
+
 # This method attaches SQUAD watch job to the submitted LAVA job
 # $1: LAVA Job ID
 submit_squad_watch_job(){
@@ -231,7 +258,14 @@ get_junit_test_results () {
 
 set_up
 
-create_job "$TEST" "$TARGET"
+if [[ $TARGET =~ "qemu" ]]; then
+	create_job_qemu "$TEST" "$TARGET"
+elif [[ $TARGET =~ "x86-uefi" ]]; then
+	create_job_mcom "$TEST" "$TARGET"
+else
+	echo "Invalid target"
+	exit 1
+fi
 
 if ! validate_job; then
 	clean_up
-- 
2.30.2



