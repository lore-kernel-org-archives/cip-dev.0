Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C802DCFD2F6
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 09:21:38 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3931.1764667288322094607
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 01:21:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=Xemvah8b;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-202512020921227d294c21cb000207ee-3ygm1g@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202512020921227d294c21cb000207ee
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 Dec 2025 10:21:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=9tRFAArkcslTg28ct66V2owNEA8QI2tRxD3gORkMnmo=;
 b=Xemvah8bJmVetEpTaLUbhNVSvixBIjbOUIVLBKO3kXaqKLOkthd4rHk81Bba1ijRCgFgg4
 xlfcasA0Fxn4q6LV0ZtQlFX5VEX6BDzj0snrd1X42XHI87Bs4BUAndCfaPPlA94q6JA5hfHo
 ufMT6q5R31A8xqSIlxIlKRs9hAYEdkM/TZTHHToaCojAir5kPxxorNfz+AwdrglUbfB7ATQf
 kLHU56UAp2GkeFOBZBXN3F1ZP6o72fp3UmxfTu9Rx+uhSOhzLg+eNTsTCU1ETVoSJqJitbf1
 bQYQqAsHGTENBVuMIKu8qo3f6BWray9Ae5XpixghLr4sTbbQALod5VPg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 11/14] ci: Make deployment opt-in
Date: Tue,  2 Dec 2025 10:21:16 +0100
Message-ID: <8678b0d2d2b80881929b753ce2cb84d8f5656d89.1764667279.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20797

From: Jan Kiszka <jan.kiszka@siemens.com>

For now, this only deploys to s3 what we need for the test stage. We can
re-enable further deployments if they are still used.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml             | 14 +++++---------
 .reproducible-check-ci.yml |  1 -
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 1042bc62..3b0c9239 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -19,7 +19,7 @@ variables:
   use_rt: enable
   encrypt: disable
   dtb: none
-  deploy: enable
+  deploy: disable
   deploy_kernelci: disable
   build_swu_v2: disable
   swupdate_version: default
@@ -132,6 +132,7 @@ build:qemu-amd64-base:
     use_rt: disable
     build_swu_v2: enable
     separate_home_partition: enable
+    deploy: enable
 
 build:qemu-amd64-base-kernelci:
   extends:
@@ -140,7 +141,6 @@ build:qemu-amd64-base-kernelci:
     target: qemu-amd64
     extension: kernelci
     use_rt: disable
-    deploy: disable
     #deploy_kernelci: enable
 
 build:qemu-arm64-base:
@@ -153,6 +153,7 @@ build:qemu-arm64-base:
     use_rt: disable
     build_swu_v2: enable
     separate_home_partition: enable
+    deploy: enable
 
 build:qemu-arm64-base-kernelci:
   extends:
@@ -161,7 +162,6 @@ build:qemu-arm64-base-kernelci:
     target: qemu-arm64
     extension: kernelci
     use_rt: disable
-    deploy: disable
     #deploy_kernelci: enable
 
 build:qemu-arm-base:
@@ -174,6 +174,7 @@ build:qemu-arm-base:
     use_rt: disable
     build_swu_v2: enable
     separate_home_partition: enable
+    deploy: enable
 
 build:qemu-arm-base-kernelci:
   extends:
@@ -182,7 +183,6 @@ build:qemu-arm-base-kernelci:
     target: qemu-arm
     extension: kernelci
     use_rt: disable
-    deploy: disable
     #deploy_kernelci: enable
 
 # test
@@ -265,6 +265,7 @@ build:x86-uefi-secure-boot:
     security_test: enable
     build_swu_v2: enable
     separate_home_partition: enable
+    deploy: enable
 
 build:qemu-amd64-swupdate:
   extends:
@@ -273,7 +274,6 @@ build:qemu-amd64-swupdate:
     target: qemu-amd64
     extension: ebg-swu
     use_rt: disable
-    deploy: disable
     factory_reset: enable
 
 # bullseye images
@@ -302,7 +302,6 @@ build:qemu-amd64-secure-boot-bullseye:
     target: qemu-amd64
     extension: ebg-secure-boot-snakeoil
     use_rt: disable
-    deploy: disable
     swupdate_version: "2022.12"
 
 # buster images
@@ -331,7 +330,6 @@ build:qemu-amd64-secure-boot-buster:
     target: qemu-amd64
     extension: ebg-secure-boot-snakeoil
     use_rt: disable
-    deploy: disable
     encrypt: enable
 
 # trixie images
@@ -342,7 +340,6 @@ build:qemu-riscv64:
     target: qemu-riscv64
     release: trixie
     use_rt: disable
-    deploy: disable
 
 build:ti-am62px-sk-secure-boot:
   extends:
@@ -352,7 +349,6 @@ build:ti-am62px-sk-secure-boot:
     release: trixie
     extension: ebg-secure-boot-snakeoil
     use_rt: disable
-    deploy: disable
     encrypt: enable
 
 .test-cip-core:
diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index 4db760c1..8b02ccc1 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -13,7 +13,6 @@
 .repro-build:
   variables:
     use_rt: disable
-    deploy: disable
     base_yaml: "kas-cip.yml:kas/board/${target}.yml:kas/opt/reproducible.yml"
     release: bookworm
     # This target include base + swupdate + secureboot + security
-- 
2.51.0


