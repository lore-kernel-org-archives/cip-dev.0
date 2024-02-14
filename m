Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3E1C48BC4
	for <webhook@archiver.kernel.org>; Wed, 14 Feb 2024 15:34:12 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.44291.1707924847221191681
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Feb 2024 07:34:07 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 41EFY2Iu2753928; Thu, 15 Feb 2024 00:34:03 +0900
X-Iguazu-Qid: 2rWglQcuLRSR9xNBwm
X-Iguazu-QSIG: v=2; s=0; t=1707924841; q=2rWglQcuLRSR9xNBwm; m=I3XU1BQ60+gUsJEMNCuEISehQqmcnqMFFJJrLrzrFaQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 41EFXxXm3566061
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 15 Feb 2024 00:34:01 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 1/2] deploy-cip-core.sh: Upload only .swu file for v2 QEMU security targets
Date: Wed, 14 Feb 2024 21:03:40 +0530
X-TSB-HOP2: ON
Message-Id: <20240214153341.3543690-2-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240214153341.3543690-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20240214153341.3543690-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Feb 2024 15:33:41.0217 (UTC) FILETIME=[2FF61510:01DA5F5B]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Feb 2024 15:34:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14975

From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>

Currently software update testing is enabled for QEMU security targets,
so if "USE_SWU" switch is enabled then only the .swu file is uploaded
ignoring the v2 .wic image. Since the project directory in CI will be
cleaned after every job, so the compressed wic file is moved to s3 bucket
instead of copying to avoid "file exists" error in case of two consecutive
builds in a single job.

U-boot binaries are also uploaded for usage
when required in LAVA job definitionss.

Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
---
 scripts/deploy-cip-core.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index 7f6cbe9..aece4d1 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -15,6 +15,7 @@ TARGET=$2
 EXTENSION=$3
 DTB=$4
 REF=$5
+USE_SWU=$6
 
 BASE_FILENAME=cip-core-image-cip-core-$RELEASE-$TARGET
 if [ "${EXTENSION}" != "none" ]; then
@@ -33,7 +34,17 @@ if [ -f "${BASE_PATH}.wic" ]; then
 	xz -9 -k -T0 "${BASE_PATH}.wic"
 
 	echo "Uploading artifacts..."
-	aws s3 cp --no-progress --acl public-read "${BASE_PATH}.wic.xz" "${S3_TARGET}"
+	# Condition check to avoid deploying v2 security image and prefer only it's .swu artifact
+	if [ "$USE_SWU" = "enable" ]; then
+		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.swu" "${S3_TARGET}"
+	else
+		# Move the first wic.xz file to aws s3 bucket to avoid error while compressing v2 image
+		aws s3 mv --no-progress --acl public-read "${BASE_PATH}.wic.xz" "${S3_TARGET}"
+	fi
+
+	if [ -f "build/tmp/deploy/images/$TARGET/firmware.bin" ]; then
+		aws s3 cp --no-progress --acl public-read "build/tmp/deploy/images/$TARGET/firmware.bin" "${S3_TARGET}"
+	fi
 else
 	if [ -f "${BASE_PATH}.tar.gz" ]; then
 		echo "Uploading artifacts..."
-- 
2.30.2



