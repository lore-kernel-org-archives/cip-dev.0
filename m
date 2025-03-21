Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FA9C35FFF
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 08:04:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.16105.1742544244082481260
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 01:04:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key3.smx header.b=BVT6DAxW;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key3.smx;t=
	1742544242;x=1743753842;bh=AHk2DqinYXySbge1etfuR2Jk5UYFq4xhwltHisfvRcI=;b=BVT
	6DAxWOLoDY1yGiBM6YBKY6bZsc05iemRM8OQMfVzU9vSIOUOXPJax8Wc41w772ploB8VTSkLxL2dI
	f6TM570v7ksTyvORidnBJroybr/EZ7d7vTigCN00JjLdaTOimoNU56rMnpx4ILoRxwKkA7qWs/Np4
	BjT0iisA+EcZgWKxOoqIazlOeYgToTZ1WR3r/XWQu2tKmCpSjQv4vOpLRMRHqwTR9WIfnLdHwzTll
	Zt9bJmqSDImOWXW+8CP779YNo+pE0XJi5C9X7eXi0CyuTkb6jeTt4qYgVxouNmkdk1MzJs+YJ1Wb2
	TvXvqiVRLeDQe+tM6X+XVqtvF3ZgWJg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 52L841St1652938; Fri, 21 Mar 2025 17:04:02 +0900
X-Iguazu-Qid: 2rWhMjEQJODEAAhAmp
X-Iguazu-QSIG: v=2; s=0; t=1742544241; q=2rWhMjEQJODEAAhAmp; m=9zIQ/SP3g+cfoa7CjTa6atU7MGKAzwroFLPVxkQgmRA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 52L840Oq2973156
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 17:04:01 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [isar-cip-core][PATCH v2 1/2] kas/opt: Add option for not install kernel
Date: Fri, 21 Mar 2025 17:03:49 +0900
X-TSB-HOP2: ON
Message-Id: <1742544230-24109-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 08:04:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18302

This adds an option to create an image that does not contain the kernel.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

---

v2:
  - Use KERNEL_NAME instead of IMAGE_INSTALL:remove
  - Add build:qemu-riscv64-test-nokerne; pipeline

 .gitlab-ci.yml             | 36 ++++++++++++++++++++++++++++-
 kas/opt/no_kernel.yml      | 17 ++++++++++++++
 scripts/deploy-cip-core.sh | 47 +++++++++++++++++++++++++++-----------
 3 files changed, 86 insertions(+), 14 deletions(-)
 create mode 100644 kas/opt/no_kernel.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index ec9ec2e..a744cec 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -28,6 +28,7 @@ variables:
   swupdate_version: default
   test_function: swupdate
   separate_home_partition: disable
+  no_kernel: disable
 
 stages:
   - build
@@ -69,9 +70,10 @@ default:
     - if [ "${watchdog}" = "disable" ]; then base_yaml="${base_yaml}:kas/opt/disable-watchdog.yml"; fi
     - if [ "${security_test}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/security_test.yml"; fi
     - if [ "${swupdate_version}" = "2022.12" ]; then base_yaml="${base_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
+    - if [ "${no_kernel}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/no_kernel.yml"; fi
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
-    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi
+    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi
     - if [ "${build_swu_v2}" = "enable" ]; then
           mkdir build/previous-image;
           if [ "${extension}" = "security" ] || [ "${extension}" = "ebg-secure-boot-snakeoil" ]; then
@@ -226,6 +228,38 @@ build:qemu-arm-test:
     target:  qemu-arm
     extension: test
 
+build:qemu-amd64-test-nokernel:
+  extends:
+    - .build_base
+  variables:
+    target:  qemu-amd64
+    extension: test
+    no_kernel: enable
+
+build:qemu-arm64-test-nokernel:
+  extends:
+    - .build_base
+  variables:
+    target:  qemu-arm64
+    extension: test
+    no_kernel: enable
+
+build:qemu-arm-test-nokernel:
+  extends:
+    - .build_base
+  variables:
+    target:  qemu-arm
+    extension: test
+    no_kernel: enable
+
+build:qemu-riscv64-test-nokernel:
+  extends:
+    - .build_base
+  variables:
+    target:  qemu-riscv64
+    extension: test
+    no_kernel: enable
+
 build:x86-uefi-secure-boot:
   extends:
     - .build_base
diff --git a/kas/opt/no_kernel.yml b/kas/opt/no_kernel.yml
new file mode 100644
index 0000000..7bba6a5
--- /dev/null
+++ b/kas/opt/no_kernel.yml
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba Corporation 2025
+#
+# Authors:
+#  Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+local_conf_header:
+  kernel-version: |
+    KERNEL_NAME = ""
diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index 6e4dfd7..6cb4968 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -13,9 +13,10 @@ fi
 RELEASE=$1
 TARGET=$2
 EXTENSION=$3
-DTB=$4
-REF=$5
-DEPLOY=$6
+NO_KERNEL=$4
+DTB=$5
+REF=$6
+DEPLOY=$7
 
 BASE_FILENAME=cip-core-image-cip-core-$RELEASE-$TARGET
 if [ "${EXTENSION}" != "none" ]; then
@@ -29,6 +30,23 @@ fi
 BASE_PATH=build/tmp/deploy/images/$TARGET/$BASE_FILENAME
 S3_TARGET=s3://download2.cip-project.org/cip-core/$REF/$TARGET/
 
+if [ "${NO_KERNEL}" = "enable" ]; then
+	__BASE_PATH=${BASE_PATH}
+	BASE_PATH="${BASE_PATH}-nokernel"
+
+	echo "Rename from ${BASE_FILENAME}.* to ${BASE_FILENAME}-nokernel.*"
+
+	if [ -f "${__BASE_PATH}.tar.gz" ]; then
+		mv "${__BASE_PATH}.tar.gz" "${BASE_PATH}.tar.gz"
+	fi
+	if [ -f "${__BASE_PATH}.swu" ]; then
+		mv "${__BASE_PATH}.swu" "${BASE_PATH}.swu"
+	fi
+	if [ -f "${__BASE_PATH}.wic" ]; then
+		mv "${__BASE_PATH}.wic" "${BASE_PATH}.wic"
+	fi
+fi
+
 if [ -f "${BASE_PATH}.wic" ]; then
 	echo "Uploading artifacts..."
 	if [ "$DEPLOY" = "swu" ]; then
@@ -48,17 +66,20 @@ else
 		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.tar.gz" "${S3_TARGET}"
 	fi
 
-	KERNEL_IMAGE="$BASE_PATH-vmlinu[xz]"
-	# iwg20m workaround
-	if [ -f "build/tmp/deploy/images/$TARGET/zImage" ]; then
-		KERNEL_IMAGE=build/tmp/deploy/images/$TARGET/zImage
-	fi
-	# shellcheck disable=SC2086
-	aws s3 cp --no-progress --acl public-read $KERNEL_IMAGE "${S3_TARGET}"
-	aws s3 cp --no-progress --acl public-read "${BASE_PATH}-initrd.img" "${S3_TARGET}"
+	if [ "$NO_KERNEL" = "false" ]; then
+		KERNEL_IMAGE="$BASE_PATH-vmlinu[xz]"
+		# iwg20m workaround
+		if [ -f "build/tmp/deploy/images/$TARGET/zImage" ]; then
+			KERNEL_IMAGE=build/tmp/deploy/images/$TARGET/zImage
+		fi
 
-	if [ "$DTB" != "none" ]; then
-		aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/"$DTB" "${S3_TARGET}"
+		# shellcheck disable=SC2086
+		aws s3 cp --no-progress --acl public-read $KERNEL_IMAGE "${S3_TARGET}"
+		aws s3 cp --no-progress --acl public-read "${BASE_PATH}-initrd.img" "${S3_TARGET}"
+
+		if [ "$DTB" != "none" ]; then
+			aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/"$DTB" "${S3_TARGET}"
+		fi
 	fi
 fi
 
-- 
2.45.2



