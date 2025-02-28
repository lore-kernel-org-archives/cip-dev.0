Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83BDC282C5
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 12:47:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.14508.1740746820138654043
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Feb 2025 04:47:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key3.smx header.b=nq4QTGSb;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key3.smx;t=
	1740746818;x=1741956418;bh=OVwG+prVYlW//ilq+ANZfX7Az42gClZ4m3mS8L3eiRU=;b=nq4
	QTGSbEhCD8yTFt4iSz9Y7566k2etvNbZ2q4dzFL2pYO2hkYYmkc4+XjkaVm0Yox4hJrtQ0lKR2y/Y
	c9iQNvkCFYTLf9DPUsLBxYCH9+EzvVbGteWFt5OKIYVwck37zT/if8R0ANL3MrZperoJ3mKOkzfA1
	ScuMLzwl+TRVKlw3BBUa2RRx2H42k5XsAf2/NTUG/F7cIFl++1WMkEXixr2YDQ7FezuGZ4B3fCsqo
	dbIFx+3FBNpal57pdiT9YOjmi73TKTyjj2MPuGIBuZuG1qFV8XtarRVCSuPB3txl5PPcJdCe4iDsV
	KzQyS3eVQVwpCFQC8Dlfuj+jgadV+XA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 51SCkvIZ379921; Fri, 28 Feb 2025 21:46:58 +0900
X-Iguazu-Qid: 2rWhBFYKJ9iaA2Z64f
X-Iguazu-QSIG: v=2; s=0; t=1740746817; q=2rWhBFYKJ9iaA2Z64f; m=oV7LWV+ryu5M9WRvqfwOum7uRygJY7LP853ka4PmgKI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 51SCkuUO3245913
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 21:46:57 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [isar-cip-core][PATCH 1/2] kas/opt: Add option for not install kernel
Date: Fri, 28 Feb 2025 21:46:45 +0900
X-TSB-HOP2: ON
Message-Id: <1740746806-6557-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Feb 2025 12:47:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17984

This adds an option to create an image that does not contain the kernel.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .gitlab-ci.yml             | 28 ++++++++++++++++++++++-
 kas/opt/no_kernel.yml      | 17 ++++++++++++++
 scripts/deploy-cip-core.sh | 47 +++++++++++++++++++++++++++-----------
 3 files changed, 78 insertions(+), 14 deletions(-)
 create mode 100644 kas/opt/no_kernel.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 4df521b..a09eedd 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -27,6 +27,7 @@ variables:
   build_swu_v2: disable
   swupdate_version: default
   test_function: swupdate
+  no_kernel: disable
 
 stages:
   - build
@@ -67,9 +68,10 @@ default:
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
@@ -221,6 +223,30 @@ build:qemu-arm-test:
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
 build:x86-uefi-secure-boot:
   extends:
     - .build_base
diff --git a/kas/opt/no_kernel.yml b/kas/opt/no_kernel.yml
new file mode 100644
index 0000000..2338177
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
+    IMAGE_INSTALL:remove = "linux-image-cip linux-image-cip-rt"
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



