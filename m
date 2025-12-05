Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4F0D2F7FF
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 14:15:51 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6506.1764944143691403910
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Dec 2025 06:15:44 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 5B5EFfsC3595696; Fri, 5 Dec 2025 23:15:42 +0900
X-Iguazu-Qid: 2yAafBYzB9Vq1ZEAue
X-Iguazu-QSIG: v=2; s=0; t=1764944141; q=2yAafBYzB9Vq1ZEAue; m=O0eF5V5dUGidl/i7sYbWCyoFMD7jyyXHUIHntBrhyeM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dND1T3rvWz1xnc; Fri,  5 Dec 2025 23:15:41 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
Subject: [isar-cip-core][PATCH v1 2/3] scripts/deploy-cip-core.sh: Check for the existence of the broken swu file before uploading
Date: Fri,  5 Dec 2025 09:29:26 -0500
X-TSB-HOP2: ON
Message-Id: <20251205142927.4087770-3-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251205142927.4087770-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20251205142927.4087770-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Dec 2025 14:15:38.0002 (UTC) FILETIME=[A12F2F20:01DC65F1]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Dec 2025 14:15:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20912

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Commit e1c4b6fa (ci: Build and deploy kernel-panic update artifact) introduced
deploying a broken swu file for kernel panic test in the CI. But not all CI jobs
builds a broken swu file (ex: Reproducible build tests)

Add a check for the existence of the broken swu file before attempting an upload

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 scripts/deploy-cip-core.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index e623f27..623c216 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -49,7 +49,9 @@ if [ -f "${BASE_PATH}.wic" ]; then
 	echo "Uploading artifacts..."
 	if [ "$DEPLOY" = "swus" ]; then
 		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.swu" "${S3_TARGET}"
-		aws s3 cp --no-progress --acl public-read "${BASE_PATH}-broken.swu" "${S3_TARGET}"
+		if [ -f "${BASE_PATH}-broken.swu" ]; then
+			aws s3 cp --no-progress --acl public-read "${BASE_PATH}-broken.swu" "${S3_TARGET}"
+		fi
 	elif [ "$DEPLOY" = "wic-partitions" ]; then
 		# deploy individual wic partitions, helpful for RB tests
 		cd build/tmp/deploy/images/"$TARGET"
-- 
2.39.5



