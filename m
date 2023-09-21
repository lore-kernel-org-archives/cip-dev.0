Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD8EE7070F
	for <webhook@archiver.kernel.org>; Thu, 21 Sep 2023 10:23:40 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.12716.1695291815935455746
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Sep 2023 03:23:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=a5DoA23r;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-294854-20230921102333e8cd2329d738a36501-eoduyt@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230921102333e8cd2329d738a36501
        for <cip-dev@lists.cip-project.org>;
        Thu, 21 Sep 2023 12:23:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=6QAQqPHxy42VeBH/Nw8vfbCXag91+5mywI0Sjj5JyZg=;
 b=a5DoA23rLKFOg+RQ4VenuBpq2ddM0gz1C6ObtkNUdSSod4DK9tGXRe17HfjMxuNABpUJA0
 m+ucoFIOyzWDK+fkeCCxsKockWAq4oBCrPorEkrsv38V7gf6mU2ufGeGId6hjPdpym5QPQ+o
 clUnEol5rCuu4cUe5GSpUZSEcTrXA=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 5/5] ci: Reduce number of build tests, focus on bookworm
Date: Thu, 21 Sep 2023 12:23:31 +0200
Message-Id: <e2a5394de5915a3e1a5d7610111ce6cc52b5e37c.1695291811.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1695291811.git.jan.kiszka@siemens.com>
References: <cover.1695291811.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Sep 2023 10:23:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13193

From: Jan Kiszka <jan.kiszka@siemens.com>

Flip the default to bookworm and only have one target for
arm/arm64/amd64 for the old bullseye and buster releases. Helps to focus
on the main development area and shortens our pipeline.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 76 +++++++++++++++-----------------------------------
 1 file changed, 23 insertions(+), 53 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 8ccd6171..1de6570b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -16,7 +16,7 @@ image: ghcr.io/siemens/kas/kas-isar:4.0
 
 variables:
   GIT_STRATEGY: clone
-  release: bullseye
+  release: bookworm
   extension: none
   use_rt: enable
   encrypt: disable
@@ -270,22 +270,36 @@ build:qemu-arm-secure-boot:
     wic_targz: disable
     deploy: disable
 
-# buster images
-build:simatic-ipc227e-buster:
+# bullseye images
+build:iwg20m-bullseye:
   extends:
     - .build_base
   variables:
-    target: simatic-ipc227e
-    release: buster
+    target: iwg20m
+    dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
+    release: bullseye
 
-build:bbb-buster:
+build:hihope-rzg2m-bullseye:
   extends:
     - .build_base
   variables:
-    target: bbb
-    dtb: am335x-boneblack.dtb
-    release: buster
+    target: hihope-rzg2m
+    dtb: r8a774a1-hihope-rzg2m-ex.dtb
+    release: bullseye
 
+build:qemu-amd64-secure-boot-bullseye:
+  extends:
+    - .build_base
+  variables:
+    base_yaml: "kas-cip.yml:kas/board/${target}.yml"
+    release: bullseye
+    target: qemu-amd64
+    extension: ebg-secure-boot-snakeoil
+    use_rt: disable
+    wic_targz: disable
+    deploy: disable
+
+# buster images
 build:iwg20m-buster:
   extends:
     - .build_base
@@ -328,47 +342,3 @@ build:qemu-riscv64:
   allow_failure: true
 
 include: '.reproducible-check-ci.yml'
-
-# bookworm images
-build:simatic-ipc227e-bookworm:
-  extends:
-    - .build_base
-  variables:
-    target: simatic-ipc227e
-    release: bookworm
-
-build:bbb-bookworm:
-  extends:
-    - .build_base
-  variables:
-    target: bbb
-    dtb: am335x-boneblack.dtb
-    release: bookworm
-
-build:iwg20m-bookworm:
-  extends:
-    - .build_base
-  variables:
-    target: iwg20m
-    dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
-    release: bookworm
-
-build:hihope-rzg2m-bookworm:
-  extends:
-    - .build_base
-  variables:
-    target: hihope-rzg2m
-    dtb: r8a774a1-hihope-rzg2m-ex.dtb
-    release: bookworm
-
-build:qemu-amd64-secure-boot-bookworm:
-  extends:
-    - .build_base
-  variables:
-    base_yaml: "kas-cip.yml:kas/board/${target}.yml"
-    release: bookworm
-    target: qemu-amd64
-    extension: ebg-secure-boot-snakeoil
-    use_rt: disable
-    wic_targz: disable
-    deploy: disable
-- 
2.35.3


