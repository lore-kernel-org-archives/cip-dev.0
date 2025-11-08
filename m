Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81A6CD1292
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 11:02:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3387.1762599719338734243
 for <cip-dev@lists.cip-project.org>;
 Sat, 08 Nov 2025 03:01:59 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 5A8B1vV54068169; Sat, 8 Nov 2025 20:01:57 +0900
X-Iguazu-Qid: 2yAakGMojZpTx8Kkvw
X-Iguazu-QSIG: v=2; s=0; t=1762599716; q=2yAakGMojZpTx8Kkvw; m=h+OUVVNAbIy6AqhY6EZVMtpSW13WPHRWk2dD2o27lrY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4d3Y0N5MZzzyPQ; Sat,  8 Nov 2025 20:01:56 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
Subject: [isar-cip-core][PATCH v1 1/3] scripts/deploy-cip-core.sh: Support deploying artifacts for RB tests
Date: Sat,  8 Nov 2025 06:15:15 -0500
X-TSB-HOP2: ON
Message-Id: <20251108111517.752691-2-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251108111517.752691-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20251108111517.752691-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 08 Nov 2025 11:01:53.0953 (UTC) FILETIME=[178ED110:01DC509F]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 08 Nov 2025 11:02:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20481

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

RB tests require two sets of build artifacts to test for reproducibility.
Let's support uploading two of artifacts to S3 when RB test is enabled and
also support uploading individual wic partitions which are useful for the
RB tests.

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 scripts/deploy-cip-core.sh | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index 5647381..aeded7e 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -16,7 +16,12 @@ EXTENSION=$3
 NO_KERNEL=$4
 DTB=$5
 REF=$6
-DEPLOY=$7
+
+# RB specific variables
+RB_TEST=$7
+RB_BUILD_NUM=$8
+
+DEPLOY=$9
 
 BASE_FILENAME=cip-core-image-cip-core-$RELEASE-$TARGET
 if [ "${EXTENSION}" != "none" ]; then
@@ -30,6 +35,10 @@ fi
 BASE_PATH=build/tmp/deploy/images/$TARGET/$BASE_FILENAME
 S3_TARGET=s3://download2.cip-project.org/cip-core/$REF/$TARGET/
 
+if [ "${RB_TEST}" = "enable" ]; then
+	S3_TARGET="${S3_TARGET}rb/${RB_BUILD_NUM}/"
+fi
+
 if [ "${NO_KERNEL}" = "enable" ]; then
 	__BASE_PATH=${BASE_PATH}
 	BASE_PATH="${BASE_PATH}-nokernel"
@@ -51,6 +60,12 @@ if [ -f "${BASE_PATH}.wic" ]; then
 	echo "Uploading artifacts..."
 	if [ "$DEPLOY" = "swu" ]; then
 		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.swu" "${S3_TARGET}"
+	elif [ "$DEPLOY" = "wic-partitions" ]; then
+		# deploy individual wic partitions, helpful for RB tests
+		cd build/tmp/deploy/images/$TARGET
+		tar --ignore-failed-read -cJf "${BASE_FILENAME}-wic-partitions.tar.xz" ${BASE_FILENAME}.wic.p*
+		aws s3 cp --no-progress --acl public-read "${BASE_FILENAME}-wic-partitions.tar.xz" "${S3_TARGET}"
+		cd -
 	else
 		echo "Compressing $BASE_FILENAME.wic..."
 		xz -9 -k -T0 "${BASE_PATH}.wic"
@@ -100,4 +115,6 @@ DPKG_STATUS_FILENAME=${CI_JOB_NAME#build:}.dpkg_status
 if ! echo "$CI_JOB_NAME" | grep -q "$1"; then
 	DPKG_STATUS_FILENAME=${CI_JOB_NAME#build:}-$1.dpkg_status
 fi
-aws s3 cp --no-progress build/tmp/deploy/images/"$TARGET"/cip-core-image-*.dpkg_status s3://download.cip-project.org/cip-core/cve-checks/dpkg-status/"$DPKG_STATUS_FILENAME"
+if [ "${RB_TEST}" = "disable" ]; then
+	aws s3 cp --no-progress build/tmp/deploy/images/"$TARGET"/cip-core-image-*.dpkg_status s3://download.cip-project.org/cip-core/cve-checks/dpkg-status/"$DPKG_STATUS_FILENAME"
+fi
-- 
2.39.5



