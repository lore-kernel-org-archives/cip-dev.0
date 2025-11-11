Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7390CCCF9E3
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 04:34:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10294.1762835646571851366
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Nov 2025 20:34:07 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 5AB4Y47f3490901; Tue, 11 Nov 2025 13:34:04 +0900
X-Iguazu-Qid: 2rWgiXlvbRSde6y72l
X-Iguazu-QSIG: v=2; s=0; t=1762835643; q=2rWgiXlvbRSde6y72l; m=QAv+Pz0AEbetORwW9XoPro9fBwcjjrNkymrmC9MLnho=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4d5DFR5bCVz1xnc; Tue, 11 Nov 2025 13:34:03 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
Subject: [isar-cip-core][PATCH v2 1/2] scripts/deploy-cip-core.sh: Support deploying artifacts for RB tests
Date: Mon, 10 Nov 2025 23:47:19 -0500
X-TSB-HOP2: ON
Message-Id: <20251111044720.778805-2-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251111044720.778805-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20251111044720.778805-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Nov 2025 04:33:59.0335 (UTC) FILETIME=[660B3370:01DC52C4]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Nov 2025 04:34:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20487

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

RB tests require two sets of build artifacts to test for reproducibility.
Let's support uploading two of artifacts to S3 when RB test is enabled and
also support uploading individual wic partitions which are useful for the
RB tests.

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 scripts/deploy-cip-core.sh | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index 5647381..7920d63 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -18,6 +18,13 @@ DTB=$5
 REF=$6
 DEPLOY=$7
 
+# Reproducible Builds specific variables
+RB_BUILD_NUM=""
+
+if [ $8 != "" ]; then
+	RB_BUILD_NUM=$8
+fi
+
 BASE_FILENAME=cip-core-image-cip-core-$RELEASE-$TARGET
 if [ "${EXTENSION}" != "none" ]; then
 	if [ "${EXTENSION}" = "security" ]; then
@@ -30,6 +37,10 @@ fi
 BASE_PATH=build/tmp/deploy/images/$TARGET/$BASE_FILENAME
 S3_TARGET=s3://download2.cip-project.org/cip-core/$REF/$TARGET/
 
+if [ "${RB_BUILD_NUM}" != "" ]; then
+	S3_TARGET="${S3_TARGET}rb/${RB_BUILD_NUM}/"
+fi
+
 if [ "${NO_KERNEL}" = "enable" ]; then
 	__BASE_PATH=${BASE_PATH}
 	BASE_PATH="${BASE_PATH}-nokernel"
@@ -51,6 +62,12 @@ if [ -f "${BASE_PATH}.wic" ]; then
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
@@ -100,4 +117,6 @@ DPKG_STATUS_FILENAME=${CI_JOB_NAME#build:}.dpkg_status
 if ! echo "$CI_JOB_NAME" | grep -q "$1"; then
 	DPKG_STATUS_FILENAME=${CI_JOB_NAME#build:}-$1.dpkg_status
 fi
-aws s3 cp --no-progress build/tmp/deploy/images/"$TARGET"/cip-core-image-*.dpkg_status s3://download.cip-project.org/cip-core/cve-checks/dpkg-status/"$DPKG_STATUS_FILENAME"
+if [ "${RB_BUILD_NUM}" = "" ]; then
+	aws s3 cp --no-progress build/tmp/deploy/images/"$TARGET"/cip-core-image-*.dpkg_status s3://download.cip-project.org/cip-core/cve-checks/dpkg-status/"$DPKG_STATUS_FILENAME"
+fi
-- 
2.39.5



