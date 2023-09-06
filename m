Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549C4EB8FAD
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 04:56:59 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.1743.1693976211404141481
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Sep 2023 21:56:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 3864unBQ2554810; Wed, 6 Sep 2023 13:56:49 +0900
X-Iguazu-Qid: 2rWgJRkMVz8CLeFe42
X-Iguazu-QSIG: v=2; s=0; t=1693976208; q=2rWgJRkMVz8CLeFe42; m=MOGfv3ksqrBQPu3CI7hB6vljOjGHLN+NRdBf9SnrmBA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 3864ulI6181514
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 6 Sep 2023 13:56:48 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 2/3] .gitlab-ci.yml: Added a new variable to control deployment
Date: Wed,  6 Sep 2023 10:26:42 +0530
X-TSB-HOP2: ON
Message-Id: <20230906045643.2640096-3-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230906045643.2640096-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20230906045643.2640096-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 06 Sep 2023 04:56:43.0187 (UTC) FILETIME=[87BBC030:01D9E07E]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 04:56:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12973

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

This "EXTRA_ARTIFACT" variable is enabled by default so that it can be
disabled for targets where the uploading of only disk image is
necessary.

As per the requirement, only disk image upload is sufficient for security
image. So the EXTRA_ARTIFACT is disabled for the targets involving
security extension.

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 .gitlab-ci.yml             |  6 +++++-
 scripts/deploy-cip-core.sh | 31 +++++++++++++++++--------------
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 8ccd617..f1308ee 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -25,6 +25,7 @@ variables:
   dtb: none
   deploy: enable
   deploy_kernelci: disable
+  extra_artifact: enable
 
 stages:
   - build
@@ -60,7 +61,7 @@ default:
     - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-partitions.yml"; fi
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
-    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
+    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} ${extra_artifact}; fi
     - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
 
 # base image
@@ -100,6 +101,7 @@ build:qemu-amd64-base:
     use_rt: disable
     wic_targz: disable
     targz: enable
+    extra_artifact: disable
 
 build:qemu-amd64-base-kernelci:
   extends:
@@ -122,6 +124,7 @@ build:qemu-arm64-base:
     use_rt: disable
     wic_targz: disable
     targz: enable
+    extra_artifact: disable
 
 build:qemu-arm64-base-kernelci:
   extends:
@@ -144,6 +147,7 @@ build:qemu-arm-base:
     use_rt: disable
     wic_targz: disable
     targz: enable
+    extra_artifact: disable
 
 build:qemu-arm-base-kernelci:
   extends:
diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index eaa8974..76e80ce 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -15,6 +15,7 @@ TARGET=$2
 EXTENSION=$3
 DTB=$4
 REF=$5
+EXTRA_ARTIFACT=$6
 
 BASE_FILENAME=cip-core-image-cip-core-$RELEASE-$TARGET
 if [ "${EXTENSION}" != "none" ]; then
@@ -36,20 +37,22 @@ if [ -f "${BASE_PATH}.wic" ]; then
 	aws s3 cp --no-progress --acl public-read "${BASE_PATH}.wic.xz" "${S3_TARGET}"
 fi
 
-if [ -f "${BASE_PATH}.tar.gz" ]; then
-	echo "Uploading artifacts..."
-	aws s3 cp --no-progress --acl public-read "${BASE_PATH}.tar.gz" "${S3_TARGET}"
-fi
+if [ ${EXTRA_ARTIFACT} == "enable" ]; then
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



