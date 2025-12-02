Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0D8D116FE
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 09:21:38 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4095.1764667289339425387
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 01:21:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=RrdGi7Rm;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-202512020921222672e0a1d600020729-f0grr0@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202512020921222672e0a1d600020729
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 Dec 2025 10:21:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=yazheNFjGZfrnBNYBKXIbS3pP1+gfdHwYXLLHRBwijQ=;
 b=RrdGi7Rmp58uKA6M0iuiaE3Xv9tfs4mLocw9JU+dETZBEFZRdXbjOWNXdJL3c7KVW49GR4
 4mifjk3UPu1ziCT4hFZLWpT0pNTXX2KtK+6mdlXKzFnKG1TwVVU8nXevnpTxMg4zIPKOKcnI
 ZwyNZgKvt12TX7d75O13p1dPNbpwA7+XsPdVlfwpySH53ayuzvO6aXQwO2gMoJTG24PLuBCc
 40HD9P4tqiCDyPhpKLD9ExTCE/1W/1wJ1nVvNZ7YgBCw3N7CtgT+bvPQw7KwoFt8ZcAE1qRv
 N5V85FbrU+WVwXwN4Z3/fRl6Byr/5xIrwzTbdQXvol2SWkw0zLNyi4NQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 14/14] ci: Switch to trixie based builds and tests
Date: Tue,  2 Dec 2025 10:21:19 +0100
Message-ID: <a41bb8285f4f85c857b78b7b90843b1243ce128e.1764667279.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1764667279.git.jan.kiszka@siemens.com>
References: <cover.1764667279.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 09:21:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20801

From: Jan Kiszka <jan.kiszka@siemens.com>

Only keep a qemu-amd64 and a hihope-rzg2m build target. The former is
used to continue running the IEC tests also for bookworm as those are
currently under certification using that release.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml             | 93 +++++++++++++++++++++++---------------
 .reproducible-check-ci.yml |  4 +-
 2 files changed, 58 insertions(+), 39 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b01daae2..fa372e0d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -14,7 +14,7 @@
 
 variables:
   GIT_STRATEGY: clone
-  release: bookworm
+  release: trixie
   extension: none
   use_rt: enable
   encrypt: disable
@@ -116,13 +116,6 @@ build:de0-nano-soc-base:
     target: de0-nano-soc
     dtb: socfpga_cyclone5_de0_nano_soc.dtb
 
-build:iwg20m-base:
-  extends:
-    - .build_base
-  variables:
-    target: iwg20m
-    dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
-
 build:hihope-rzg2m-base:
   extends:
     - .build_base
@@ -193,7 +186,14 @@ build:qemu-arm-base-kernelci:
     use_rt: disable
     #deploy_kernelci: enable
 
-# test
+build:qemu-riscv64:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-riscv64
+    use_rt: disable
+
+# test images
 build:x86-uefi-test:
   extends:
     - .build_base
@@ -209,14 +209,6 @@ build:bbb-test:
     extension: test
     dtb: am335x-boneblack.dtb
 
-build:iwg20m-test:
-  extends:
-    - .build_base
-  variables:
-    target: iwg20m
-    extension: test
-    dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
-
 build:hihope-rzg2m-test:
   extends:
     - .build_base
@@ -257,7 +249,6 @@ build:qemu-riscv64-test-nokernel:
     - .build_base
   variables:
     target:  qemu-riscv64
-    release: trixie
     extension: test
     use_rt: disable
     no_kernel: enable
@@ -284,6 +275,43 @@ build:qemu-amd64-swupdate:
     use_rt: disable
     factory_reset: enable
 
+build:ti-am62px-sk-secure-boot:
+  extends:
+    - .build_base
+  variables:
+    target: ti-am62px-sk
+    extension: ebg-secure-boot-snakeoil
+    use_rt: disable
+    encrypt: enable
+
+# bookworm images
+build:qemu-amd64-bookworm:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-amd64
+    extension: security
+    security_test: enable
+    use_rt: disable
+    release: bookworm
+
+build:iwg20m-bookworm-test:
+  extends:
+    - .build_base
+  variables:
+    target: iwg20m
+    extension: test
+    dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
+    release: bookworm
+
+build:hihope-rzg2m-bookworm:
+  extends:
+    - .build_base
+  variables:
+    target: hihope-rzg2m
+    dtb: r8a774a1-hihope-rzg2m-ex.dtb
+    release: bookworm
+
 # bullseye images
 build:iwg20m-bullseye:
   extends:
@@ -340,25 +368,6 @@ build:qemu-amd64-secure-boot-buster:
     use_rt: disable
     encrypt: enable
 
-# trixie images
-build:qemu-riscv64:
-  extends:
-    - .build_base
-  variables:
-    target: qemu-riscv64
-    release: trixie
-    use_rt: disable
-
-build:ti-am62px-sk-secure-boot:
-  extends:
-    - .build_base
-  variables:
-    target: ti-am62px-sk
-    release: trixie
-    extension: ebg-secure-boot-snakeoil
-    use_rt: disable
-    encrypt: enable
-
 .test-cip-core:
   stage: test
   image: $CI_REGISTRY_IMAGE/lavacli
@@ -470,6 +479,16 @@ test:qemu-amd64-IEC:
     test_function: IEC
     iec_test_timeout: 40
 
+test:qemu-amd64-IEC-bookworm:
+  extends:
+   - .test-cip-core
+  needs: ["build:qemu-amd64-bookworm"]
+  variables:
+    target: qemu-amd64
+    release: bookworm
+    test_function: IEC
+    iec_test_timeout: 40
+
 test:qemu-arm64-IEC:
   extends:
    - .test-cip-core
diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index 8b02ccc1..a545b0d9 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -14,7 +14,7 @@
   variables:
     use_rt: disable
     base_yaml: "kas-cip.yml:kas/board/${target}.yml:kas/opt/reproducible.yml"
-    release: bookworm
+    release: trixie
     # This target include base + swupdate + secureboot + security
     extension: security
   stage: build
@@ -59,7 +59,7 @@
   variables:
     GIT_STRATEGY: none
     BASE_S3_URL: "https://s3.eu-central-1.amazonaws.com/download2.cip-project.org/cip-core"
-    release: bookworm
+    release: trixie
     extension: security
     image_base: "cip-core-image-cip-core"
   before_script:
-- 
2.51.0


