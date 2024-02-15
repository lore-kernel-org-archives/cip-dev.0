Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BEEC48BC4
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 13:58:47 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.14387.1708005523852380005
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Feb 2024 05:58:44 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 41FDwe622192421; Thu, 15 Feb 2024 22:58:41 +0900
X-Iguazu-Qid: 2yAaO2s1xC5wn0YNv6
X-Iguazu-QSIG: v=2; s=0; t=1708005520; q=2yAaO2s1xC5wn0YNv6; m=QgfGLjqaxirWGIxVVNqecbrO54LeRNuziw5dywMsCik=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 41FDwd3W375546
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 15 Feb 2024 22:58:40 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v4 1/2] deploy-cip-core.sh: Deploy .swu only if "swu" is passed from .gitlab-ci.yml
Date: Thu, 15 Feb 2024 19:28:36 +0530
X-TSB-HOP2: ON
Message-Id: <20240215135837.3557922-2-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240215135837.3557922-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20240215135837.3557922-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 Feb 2024 13:58:37.0834 (UTC) FILETIME=[12E4A6A0:01DA6017]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Feb 2024 13:58:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14998

From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>

The .swu file is only deployed if "swu" is recieved by DEPLOY variable. Otherwise
.wic image, firmware binaries are deployed.

Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
---
 scripts/deploy-cip-core.sh | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index 7f6cbe9..8ff75a5 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -15,6 +15,7 @@ TARGET=$2
 EXTENSION=$3
 DTB=$4
 REF=$5
+DEPLOY=$6
 
 BASE_FILENAME=cip-core-image-cip-core-$RELEASE-$TARGET
 if [ "${EXTENSION}" != "none" ]; then
@@ -29,11 +30,18 @@ BASE_PATH=build/tmp/deploy/images/$TARGET/$BASE_FILENAME
 S3_TARGET=s3://download2.cip-project.org/cip-core/$REF/$TARGET/
 
 if [ -f "${BASE_PATH}.wic" ]; then
-	echo "Compressing $BASE_FILENAME.wic..."
-	xz -9 -k -T0 "${BASE_PATH}.wic"
-
 	echo "Uploading artifacts..."
-	aws s3 cp --no-progress --acl public-read "${BASE_PATH}.wic.xz" "${S3_TARGET}"
+	if [ "$DEPLOY" = "swu" ]; then
+		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.swu" "${S3_TARGET}"
+	else
+		echo "Compressing $BASE_FILENAME.wic..."
+		xz -9 -k -T0 "${BASE_PATH}.wic"
+		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.wic.xz" "${S3_TARGET}"
+
+		if [ -f "build/tmp/deploy/images/$TARGET/firmware.bin" ]; then
+			aws s3 cp --no-progress --acl public-read "build/tmp/deploy/images/$TARGET/firmware.bin" "${S3_TARGET}"
+		fi
+	fi
 else
 	if [ -f "${BASE_PATH}.tar.gz" ]; then
 		echo "Uploading artifacts..."
-- 
2.30.2



