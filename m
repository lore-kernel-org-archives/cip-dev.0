Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA723EE7FEB
	for <webhook@archiver.kernel.org>; Fri,  8 Sep 2023 12:42:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.38006.1694176966429744861
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Sep 2023 05:42:47 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 388Cggca2121131; Fri, 8 Sep 2023 21:42:43 +0900
X-Iguazu-Qid: 2rWgyA9ool9xfV7xTt
X-Iguazu-QSIG: v=2; s=0; t=1694176961; q=2rWgyA9ool9xfV7xTt; m=nrN1Sl7jy1HERNtKIGZkperA6augSJ7OrEofxn4gbmk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 388Cgemt227502
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 8 Sep 2023 21:42:41 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 2/3][v2] deploy-cip-core.sh: Deploy only the .wic image if it is present
Date: Fri,  8 Sep 2023 18:12:36 +0530
X-TSB-HOP2: ON
Message-Id: <20230908124237.508469-3-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230908124237.508469-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20230908124237.508469-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 08 Sep 2023 12:42:38.0110 (UTC) FILETIME=[F2FDFBE0:01D9E251]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Sep 2023 12:42:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13010

From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>

Deploy seperate artifacts like tar.gz, kernel and initrd image only
if .wic image is not present.

Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
---
 scripts/deploy-cip-core.sh | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index eaa8974..5855acb 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -34,22 +34,22 @@ if [ -f "${BASE_PATH}.wic" ]; then
 
 	echo "Uploading artifacts..."
 	aws s3 cp --no-progress --acl public-read "${BASE_PATH}.wic.xz" "${S3_TARGET}"
-fi
-
-if [ -f "${BASE_PATH}.tar.gz" ]; then
-	echo "Uploading artifacts..."
-	aws s3 cp --no-progress --acl public-read "${BASE_PATH}.tar.gz" "${S3_TARGET}"
-fi
+else
+	if [ -f "${BASE_PATH}.tar.gz" ]; then
+		echo "Uploading artifacts..."
+		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.tar.gz" "${S3_TARGET}"
+	fi
 
-KERNEL_IMAGE="$BASE_PATH-vmlinu[xz]"
-# iwg20m workaround
-if [ -f "build/tmp/deploy/images/$TARGET/zImage" ]; then
-	KERNEL_IMAGE=build/tmp/deploy/images/$TARGET/zImage
-fi
-# shellcheck disable=SC2086
-aws s3 cp --no-progress --acl public-read $KERNEL_IMAGE "${S3_TARGET}"
-aws s3 cp --no-progress --acl public-read "${BASE_PATH}-initrd.img" "${S3_TARGET}"
+	KERNEL_IMAGE="$BASE_PATH-vmlinu[xz]"
+	# iwg20m workaround
+	if [ -f "build/tmp/deploy/images/$TARGET/zImage" ]; then
+		KERNEL_IMAGE=build/tmp/deploy/images/$TARGET/zImage
+	fi
+	# shellcheck disable=SC2086
+	aws s3 cp --no-progress --acl public-read $KERNEL_IMAGE "${S3_TARGET}"
+	aws s3 cp --no-progress --acl public-read "${BASE_PATH}-initrd.img" "${S3_TARGET}"
 
-if [ "$DTB" != "none" ]; then
-	aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/"$DTB" "${S3_TARGET}"
+	if [ "$DTB" != "none" ]; then
+		aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/"$DTB" "${S3_TARGET}"
+	fi
 fi
-- 
2.30.2



