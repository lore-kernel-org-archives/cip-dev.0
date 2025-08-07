Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFD6C87FCB
	for <webhook@archiver.kernel.org>; Thu,  7 Aug 2025 02:46:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.41784.1754534756485865000
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Aug 2025 19:45:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=cNXupFX3;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=
	1754534754;x=1755744354;bh=gyhvGrWBmzpr6030/ZjDfaBSZWpWmpMqwPHsIGlZ4UA=;b=cNX
	upFX3g6NFfEMhyteiXdz5d4NsW2AOg51pqpBln7PdxVEBE5a3OonuwtOXxW0K4CLi4pP3aETBsa6E
	plvyGreDRRc9CtndZk2lNxPfPtzZY90V6Pgr0e2TFGn810IHR71lnAHgmtQybgsGxhDbU5TNbEcPV
	JjtXOyNpewdE70jzeofxeufP7Og0K29742wl2lkau71dxZVJl6vKh0wejTcmOGZ+L6bR3yFiCIzAM
	JFDJ5cu6S8owMgMUILMYMvuS/wadjmOmwNPrb4xA4WOBNzAHma70MeFhU6hU8CrmOlvK2oQ3s6RJM
	Bact4fswo42jWlbUa/NE9+SwluWHStw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 5772jstr255364; Thu, 7 Aug 2025 11:45:54 +0900
X-Iguazu-Qid: 2rWhEqwpng2w28R9zm
X-Iguazu-QSIG: v=2; s=0; t=1754534753; q=2rWhEqwpng2w28R9zm; m=gUgqDTxpbnDtdFsVnWWWcxpHT0Zgm30nhUB3CU8GXLk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 5772jq4O2554036
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 7 Aug 2025 11:45:53 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [isar-cip-core][PATCH v5 1/3] kas/opt: Add option for not install kernel
Date: Thu,  7 Aug 2025 11:45:47 +0900
X-TSB-HOP2: ON
Message-Id: <1754534749-19754-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Aug 2025 02:46:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19699

This adds an option to create an image that does not contain the kernel.
This is mainly intended to provide images for kernel testing.
When testing the kernel, kernel image files that are not used for testing
are not necessary in rootfs. Providing images with these files removed
allows you to reduce the size of the rootfs image.

wo_kernel is false:
  -rw-r--r-- 1 iwamatsu iwamatsu 351M Jul 25 17:31 cip-core-image-cip-core-bookworm-qemu-amd64.ext4

no_kernel is true:
  -rw-r--r-- 1 iwamatsu iwamatsu 275M Jul 25 17:09 cip-core-image-cip-core-bookworm-qemu-amd64.ext4

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
[Jan: update all call sites of deploy-cip-core.sh]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

---

v5:
  - Set 'use_rt: false'
  - Set 'release: trixie' to build:qemu-riscv64-test-nokernel pipeline
v4:
  - Fix the NO_KERNEL check to 'enable' only.
v3:
  - Update commit message.
v2:
  - Use KERNEL_NAME instead of IMAGE_INSTALL:remove
  - Add build:qemu-riscv64-test-nokerne; pipeline

 .gitlab-ci.yml             | 43 +++++++++++++++++++++++++++++++--
 kas/opt/no_kernel.yml      | 17 +++++++++++++
 scripts/deploy-cip-core.sh | 49 ++++++++++++++++++++++++++++----------
 3 files changed, 94 insertions(+), 15 deletions(-)
 create mode 100644 kas/opt/no_kernel.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 628e624..3a4ba73 100644
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
@@ -81,7 +83,7 @@ default:
           fi;
           echo "PV = \"2.0\"" >> recipes-core/images/cip-core-image-security.bb;
           kas build ${base_yaml}:kas/opt/delta-update.yml;
-          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} swu;
+          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} swu;
       fi
     - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
 
@@ -229,6 +231,43 @@ build:qemu-arm-test:
     target:  qemu-arm
     extension: test
 
+build:qemu-amd64-test-nokernel:
+  extends:
+    - .build_base
+  variables:
+    target:  qemu-amd64
+    extension: test
+    use_rt: disable
+    no_kernel: enable
+
+build:qemu-arm64-test-nokernel:
+  extends:
+    - .build_base
+  variables:
+    target:  qemu-arm64
+    extension: test
+    use_rt: disable
+    no_kernel: enable
+
+build:qemu-arm-test-nokernel:
+  extends:
+    - .build_base
+  variables:
+    target:  qemu-arm
+    extension: test
+    use_rt: disable
+    no_kernel: enable
+
+build:qemu-riscv64-test-nokernel:
+  extends:
+    - .build_base
+  variables:
+    target:  qemu-riscv64
+    release: trixie
+    extension: test
+    use_rt: disable
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
index 6e4dfd7..5647381 100755
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
@@ -48,17 +66,22 @@ else
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
+	if [ "${NO_KERNEL}" = "enable" ]; then
+		echo "The image does not include the linux kernel. Therefore, kernel related files will not be uploaded."
+	else
+		KERNEL_IMAGE="$BASE_PATH-vmlinu[xz]"
+		# iwg20m workaround
+		if [ -f "build/tmp/deploy/images/$TARGET/zImage" ]; then
+			KERNEL_IMAGE=build/tmp/deploy/images/$TARGET/zImage
+		fi
+
+		# shellcheck disable=SC2086
+		aws s3 cp --no-progress --acl public-read $KERNEL_IMAGE "${S3_TARGET}"
+		aws s3 cp --no-progress --acl public-read "${BASE_PATH}-initrd.img" "${S3_TARGET}"
 
-	if [ "$DTB" != "none" ]; then
-		aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/"$DTB" "${S3_TARGET}"
+		if [ "$DTB" != "none" ]; then
+			aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/"$DTB" "${S3_TARGET}"
+		fi
 	fi
 fi
 
-- 
2.50.0



