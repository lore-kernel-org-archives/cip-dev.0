Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DBAD43341
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 10:58:14 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.69365.1730977083585632412
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Nov 2024 02:58:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=hz3/wV76;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-202411071058051fe8616d155c6bb9a2-kxv7_p@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202411071058051fe8616d155c6bb9a2
        for <cip-dev@lists.cip-project.org>;
        Thu, 07 Nov 2024 11:58:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=a/Jfd5aceguohp26jkuaW5iyVUY8ZWGlxv40MJW1E2g=;
 b=hz3/wV76YlMRNWviniYan8up8Ke+OfN1R+Y1eK87YHg8AjxmbY2PcyvzZeaF1O8TSLID01
 RYzQIJ4LZhIrobBm3/6yUMKsp+YLn3z9W+GgBu8oKfogUlbXHfWegqahJZL2RjcXoyVwSOfM
 kUZYAuedlohtGuTfk6Dbx3y/f2RqK+Un6k1HGd62HK7PYNOPTbgCz/pjcM7DxfF6uEsuayIm
 f+7LgFWruE7e7S8HEcsYKWT4ZuCNif9Fzu70OBTLLx45k/+UmtHiCbl9CH4EVxepFuStsSYX
 yk9jPzUZ9D2YBNbPBL20wLVB0HqUTLr1dLI/MrmmV7c5fQZusy4HJB9w==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Cedric Hombourger <cedric.hombourger@siemens.com>,
	Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
Subject: [isar-cip-core][PATCH 9/9] Replace sid with trixie
Date: Thu,  7 Nov 2024 11:57:57 +0100
Message-ID: <c5e414840b5a7a91b6cb89d0b0371e4620e5675e.1730977077.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730977077.git.jan.kiszka@siemens.com>
References: <cover.1730977077.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Nov 2024 10:58:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17212

From: Jan Kiszka <jan.kiszka@siemens.com>

The only reasons to have sid support in isar-cip-core so far was riscv64
and also testing of zchunk-based delta-updates. Both can now be
addressed in a more stable way via upcoming Debian 13 / trixie.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml                                |  6 +++---
 Kconfig                                       |  5 -----
 classes/delta-update.bbclass                  |  4 ++--
 conf/distro/cip-core-sid.conf                 | 20 -------------------
 doc/README.swupdate.md                        | 16 +++++++--------
 kas/opt/sid.yml                               | 15 --------------
 .../efibootguard/efibootguard_0.18-1+cip.bb   |  1 -
 start-qemu.sh                                 |  4 +---
 8 files changed, 14 insertions(+), 57 deletions(-)
 delete mode 100644 conf/distro/cip-core-sid.conf
 delete mode 100644 kas/opt/sid.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2c6a688b..6f824102 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -62,7 +62,7 @@ default:
     - if [ "${release}" = "buster" ]; then base_yaml="${base_yaml}:kas/opt/buster.yml"; fi
     - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
     - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
-    - if [ "${release}" = "sid" ]; then base_yaml="${base_yaml}:kas/opt/sid.yml"; fi
+    - if [ "${release}" = "trixie" ]; then base_yaml="${base_yaml}:kas/opt/trixie.yml"; fi
     - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-data.yml"; fi
     - if [ "${swupdate_version}" = "2022.12" ]; then base_yaml="${base_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
     - echo "Building ${base_yaml}"
@@ -333,13 +333,13 @@ build:qemu-amd64-secure-boot-buster:
     deploy: disable
     encrypt: enable
 
-# riscv64 (sid)
+# trixie images
 build:qemu-riscv64:
   extends:
     - .build_base
   variables:
     target: qemu-riscv64
-    release: sid
+    release: trixie
     use_rt: disable
     targz: disable
     deploy: disable
diff --git a/Kconfig b/Kconfig
index 09bb7699..3c246fa5 100644
--- a/Kconfig
+++ b/Kconfig
@@ -139,10 +139,6 @@ config DEBIAN_BOOKWORM
 config DEBIAN_TRIXIE
 	bool "trixie (testing)"
 
-config DEBIAN_SID
-	bool "sid (unstable)"
-	depends on ARCH_RISCV64
-
 endchoice
 
 config KAS_INCLUDE_DEBIAN
@@ -151,7 +147,6 @@ config KAS_INCLUDE_DEBIAN
 	default "kas/opt/bullseye.yml" if DEBIAN_BULLSEYE
 	default "kas/opt/bookworm.yml" if DEBIAN_BOOKWORM
 	default "kas/opt/trixie.yml" if DEBIAN_TRIXIE
-	default "kas/opt/sid.yml" if DEBIAN_SID
 
 comment "Image features"
 
diff --git a/classes/delta-update.bbclass b/classes/delta-update.bbclass
index ae2453d7..ab11be59 100644
--- a/classes/delta-update.bbclass
+++ b/classes/delta-update.bbclass
@@ -27,8 +27,8 @@ python () {
         if d.getVar("DELTA_RDIFF_REF_IMAGE") == "":
             bb.fatal("You must set DELTA_RDIFF_REF_IMAGE and provide the required files as artifacts to this recipe")
     elif d.getVar("DELTA_UPDATE_TYPE") == "zchunk":
-        if d.getVar("BASE_DISTRO_CODENAME") != "sid":
-            bb.fatal("Zchunk based delta update is only supported from sid")
+        if d.getVar("BASE_DISTRO_CODENAME") != "trixie":
+            bb.fatal("Zchunk based delta update is only supported from trixie onward")
     else:
         disable_delta_update_tasks(d)
 }
diff --git a/conf/distro/cip-core-sid.conf b/conf/distro/cip-core-sid.conf
deleted file mode 100644
index eefcbb59..00000000
--- a/conf/distro/cip-core-sid.conf
+++ /dev/null
@@ -1,20 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2022-2024
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-require conf/distro/debian-sid.conf
-require cip-core-common.inc
-
-# corresponds to 20240211T000000Z
-ISAR_APT_SNAPSHOT_TIMESTAMP ?= "1707606000"
-ISAR_USE_APT_SNAPSHOT ?= "1"
-
-PREFERRED_VERSION_linux-cip ?= "6.1.%"
-PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index 027a8fd7..5308a50f 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -435,27 +435,27 @@ host$ scp -P 22222 ./cip-core-image-cip-core-bookworm-qemu-amd64.swu root@localh
 
 ## Delta Software Update using zchunk handler
 
-Currently zchunk based delta updates are supported only in Sid images. Make sure to build the first image with Sid as the distribution with the following command:
+Currently zchunk based delta updates are supported only in trixie images. Make sure to build the first image with trixie as the distribution with the following command:
 ```
-host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/sid.yml
+host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/trixie.yml
 ```
 For Delta update with zchunk, set the variable `DELTA_ZCK_URL` with the URL of the zck file that is hosted in a http server and set the `DELTA_UPDATE_TYPE` to `zchunk` in `delta-update.yml` file.
 
 Build the second image with the modification as shown above with the following command:
 ```
-KAS_BUILD_DIR=build-v2 ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/sid.yml:kas/opt/delta-update.yml
+KAS_BUILD_DIR=build-v2 ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/trixie.yml:kas/opt/delta-update.yml
 ```
 Now start the first image. Run the following commands:
 ```
-host$ DISTRO_RELEASE=sid SWUPDATE_BOOT=y ./start-qemu.sh amd64
+host$ DISTRO_RELEASE=trixie SWUPDATE_BOOT=y ./start-qemu.sh amd64
 ```
-Copy `cip-core-image-cip-core-sid-qemu-amd64.swu` file from `build-v2/tmp/deploy/images/qemu-amd64/` folder into the running system:
+Copy `cip-core-image-cip-core-trixie-qemu-amd64.swu` file from `build-v2/tmp/deploy/images/qemu-amd64/` folder into the running system:
 ```
 host$ cd build-v2/tmp/deploy/images/qemu-amd64/
-host$ scp -P 22222 ./cip-core-image-cip-core-sid-qemu-amd64.swu root@localhost:
+host$ scp -P 22222 ./cip-core-image-cip-core-trixie-qemu-amd64.swu root@localhost:
 ```
-The `cip-core-image-cip-core-sid-qemu-amd64.zck` file must be hosted in a http server.
-Any http server (service) can be used to host the .zck file as long as the http server supports http range requests. Copy the `build-v2/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-sid-qemu-amd64.zck` to the server directory. For more information on the integration of zchunk handler in swupdate, refer the [documentation](https://sbabic.github.io/swupdate/delta-update.html#integration-in-swupdate-the-delta-handler)
+The `cip-core-image-cip-core-trixie-qemu-amd64.zck` file must be hosted in a http server.
+Any http server (service) can be used to host the .zck file as long as the http server supports http range requests. Copy the `build-v2/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-trixie-qemu-amd64.zck` to the server directory. For more information on the integration of zchunk handler in swupdate, refer the [documentation](https://sbabic.github.io/swupdate/delta-update.html#integration-in-swupdate-the-delta-handler)
 
 ## Delta Software Update Verification
 
diff --git a/kas/opt/sid.yml b/kas/opt/sid.yml
deleted file mode 100644
index be2eeb47..00000000
--- a/kas/opt/sid.yml
+++ /dev/null
@@ -1,15 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2022-2024
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-header:
-  version: 14
-
-distro: cip-core-sid
diff --git a/recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb
index 5f1a47e8..6d32833a 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb
@@ -39,7 +39,6 @@ DEPENDS:bullseye = "python-shtab"
 DEPENDS:bookworm = "python-shtab"
 
 DEPENDS:trixie = "gnu-efi"
-DEPENDS:sid    = "gnu-efi"
 
 # needed for buster, bullseye could use compat >= 13
 python() {
diff --git a/start-qemu.sh b/start-qemu.sh
index 0e425ea7..e8f1cfc3 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -40,9 +40,7 @@ if [ -n "${QEMU_PATH}" ]; then
 fi
 
 if [ -z "${DISTRO_RELEASE}" ]; then
-	if grep -s -q "DEBIAN_SID: true" .config.yaml; then
-		DISTRO_RELEASE="sid"
-	elif grep -s -q "DEBIAN_BUSTER: true" .config.yaml; then
+	if grep -s -q "DEBIAN_BUSTER: true" .config.yaml; then
 		DISTRO_RELEASE="buster"
 	elif grep -s -q "DEBIAN_BOOKWORM: true" .config.yaml; then
 		DISTRO_RELEASE="bookworm"
-- 
2.43.0


