Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2350C48BC1
	for <webhook@archiver.kernel.org>; Wed, 14 Feb 2024 12:28:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.39993.1707913696478259037
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Feb 2024 04:28:17 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 41ECSEKE3288720; Wed, 14 Feb 2024 21:28:14 +0900
X-Iguazu-Qid: 2yAaCKdk3pTytn0JKm
X-Iguazu-QSIG: v=2; s=0; t=1707913693; q=2yAaCKdk3pTytn0JKm; m=ZFBftaSkxYdQvG/nhOdtr06bM4x5vJgyT96XqcbdE1E=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 41ECSCgw3070139
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 14 Feb 2024 21:28:13 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 1/2] deploy-cip-core.sh: Upload only .swu file for v2 QEMU security targets
Date: Wed, 14 Feb 2024 17:58:08 +0530
X-TSB-HOP2: ON
Message-Id: <20240214122809.3541505-2-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240214122809.3541505-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20240214122809.3541505-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Feb 2024 12:28:09.0896 (UTC) FILETIME=[452D4A80:01DA5F41]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Feb 2024 12:28:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14963

From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>

Currently software update testing is enabled for QEMU security targets,
so if "USE_SWU" switch is enabled then only the .swu file is uploaded
ignoring the v2 .wic image. U-boot binaries for qemu-arm64 and qemu-arm
targets are also uploaded for usage in LAVA job definitions.

Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
---
 scripts/deploy-cip-core.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index 7f6cbe9..17d4ed0 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -15,6 +15,7 @@ TARGET=$2
 EXTENSION=$3
 DTB=$4
 REF=$5
+USE_SWU=$6
 
 BASE_FILENAME=cip-core-image-cip-core-$RELEASE-$TARGET
 if [ "${EXTENSION}" != "none" ]; then
@@ -33,7 +34,16 @@ if [ -f "${BASE_PATH}.wic" ]; then
 	xz -9 -k -T0 "${BASE_PATH}.wic"
 
 	echo "Uploading artifacts..."
-	aws s3 cp --no-progress --acl public-read "${BASE_PATH}.wic.xz" "${S3_TARGET}"
+	# Condition check to avoid deploying v2 base image and prefer only it's .swu artifact
+	if [ "$USE_SWU" = "enable" ]; then
+		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.swu" "${S3_TARGET}"
+	else
+		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.wic.xz" "${S3_TARGET}"
+	fi
+	# Upload firmware for arm64 & armhf security targets required to boot security image in LAVA environment
+	if [ "$EXTENSION" = "security" ] && { [ "$TARGET" = "qemu-arm64" ] || [ "$TARGET" = "qemu-arm" ]; } then
+		aws s3 cp --no-progress --acl public-read "build/tmp/deploy/images/$TARGET/firmware.bin" "${S3_TARGET}"
+	fi
 else
 	if [ -f "${BASE_PATH}.tar.gz" ]; then
 		echo "Uploading artifacts..."
-- 
2.30.2



