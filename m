Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DD4C3F6B0
	for <webhook@archiver.kernel.org>; Fri, 29 Jul 2022 10:04:43 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web08.6284.1659089075535148736
 for <cip-dev@lists.cip-project.org>;
 Fri, 29 Jul 2022 03:04:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2
 header.b=UgNq+1iJ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225,
 mailfrom: fm-51332-202207291004325258a59108b44f5904-e9g_q2@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 202207291004325258a59108b44f5904
        for <cip-dev@lists.cip-project.org>;
        Fri, 29 Jul 2022 12:04:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=fFRHowR/mQQzSPUOqCdazTP8CHvjVyl6i3XvkzcfEC0=;
 b=UgNq+1iJ99PWkZ5Nw2EV0x1ysephRP2UH4p0Aa5pu6V7lbIfpRBGNvFTAxoEc5muptEHsk
 yw+sN3+JMjmhzBcr1n3Vilh4r0fAtl+bFhY5CDR4R31Gv9MgCCfZiNw3oFni2DClTvc/dkJX
 3HIxMcPCIUuZFPiZZH9Iut2PHO+Rs=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 1/4] scripts/deploy-cip-core.sh:
 Use dtb from deploy dir
Date: Fri, 29 Jul 2022 12:04:28 +0200
Message-Id: <20220729100431.453463-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20220729100431.453463-1-Quirin.Gylstorff@siemens.com>
References: <20220729100431.453463-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Jul 2022 10:04:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8980

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes the build errors after sbuild migration as the build
artifacts are no longer available after the build.

This adds the DTB file for the beagle bone black to the deploy
dir to fix the CI pipeline after using sbuild.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml             | 6 +++---
 conf/machine/bbb.conf      | 1 +
 scripts/deploy-cip-core.sh | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3d39d1f..41af3e9 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -68,7 +68,7 @@ build:hihope-rzg2m-base:
     - .build_base
   variables:
     target: hihope-rzg2m
-    dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
+    dtb: r8a774a1-hihope-rzg2m-ex.dtb
 
 build:qemu-amd64-base:
   extends:
@@ -166,7 +166,7 @@ build:hihope-rzg2m-test:
   variables:
     target: hihope-rzg2m
     extension: test
-    dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
+    dtb: r8a774a1-hihope-rzg2m-ex.dtb
 
 build:qemu-amd64-test:
   extends:
@@ -271,7 +271,7 @@ build:hihope-rzg2m-buster:
     - .build_base
   variables:
     target: hihope-rzg2m
-    dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
+    dtb: r8a774a1-hihope-rzg2m-ex.dtb
     release: buster
 
 build:qemu-amd64-secure-boot-buster:
diff --git a/conf/machine/bbb.conf b/conf/machine/bbb.conf
index b592f4d..ea87ed8 100644
--- a/conf/machine/bbb.conf
+++ b/conf/machine/bbb.conf
@@ -7,6 +7,7 @@
 #
 
 DISTRO_ARCH = "armhf"
+DTB_FILES = "am335x-boneblack.dtb"
 
 IMAGE_FSTYPES ?= "wic"
 IMAGER_INSTALL += "u-boot-omap"
diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index 203ab1d..01aa494 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -50,5 +50,5 @@ aws s3 cp --no-progress --acl public-read $KERNEL_IMAGE ${S3_TARGET}
 aws s3 cp --no-progress --acl public-read $BASE_PATH-initrd.img ${S3_TARGET}
 
 if [ "$DTB" != "none" ]; then
-	aws s3 cp --no-progress --acl public-read build/tmp/work/cip-core-*/linux-cip*/*/linux-cip-*/debian/linux-image-cip*/usr/lib/linux-image-*/$DTB ${S3_TARGET}
+	aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/$DTB ${S3_TARGET}
 fi
-- 
2.35.1


