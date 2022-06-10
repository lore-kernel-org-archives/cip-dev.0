Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC795CCA47B
	for <webhook@archiver.kernel.org>; Fri, 10 Jun 2022 07:25:37 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.24145.1654845929332913386
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Jun 2022 00:25:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1
 header.b=RlQqK0qA;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226,
 mailfrom: fm-51332-202206100725266912fb77806b61adbb-hty7dx@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 202206100725266912fb77806b61adbb
        for <cip-dev@lists.cip-project.org>;
        Fri, 10 Jun 2022 09:25:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=wFiA1fABIR4yHlQiM8xzlhbVC2AaBm5kdVVIcrVK41M=;
 b=RlQqK0qAamybAY4RyDMklEtIBgAPqJTp0JfNUuOV70JBCkYpkx8dc9MXk9rSogkoHWoee8
 1hGFnC50B23dw6jPMN4gR/pgpsT+mzir3A8ETHfjt6jr5ya9rRTa+MiDuWSst1aufuBUt9Tu
 OgdI697a03FAtpjGVbyKBSc1nqqcI=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 2/2] .gitlabci: switch to bullseye
Date: Fri, 10 Jun 2022 09:25:24 +0200
Message-Id: <20220610072524.910925-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20220610072524.910925-1-Quirin.Gylstorff@siemens.com>
References: <20220610072524.910925-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Jun 2022 07:25:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8525

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 23ab1cb..7c28ea1 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -2,7 +2,7 @@ image: ghcr.io/siemens/kas/kas-isar:3.0.2
 
 variables:
   GIT_STRATEGY: clone
-  release: buster
+  release: bullseye
   extension: base
   use_rt: enable
   wic_targz: enable
@@ -241,34 +241,34 @@ build:qemu-arm64-swupdate:
     targz: disable
     deploy: disable
 
-# bullseye images
-build:simatic-ipc227e-bullseye:
+# buster images
+build:simatic-ipc227e-buster:
   extends:
     - .build_base
   variables:
     target: simatic-ipc227e
-    release: bullseye
+    release: buster
 
-build:bbb-bullseye:
+build:bbb-buster:
   extends:
     - .build_base
   variables:
     target: bbb
     dtb: am335x-boneblack.dtb
-    release: bullseye
+    release: buster
 
-build:iwg20m-bullseye:
+build:iwg20m-buster:
   extends:
     - .build_base
   variables:
     target: iwg20m
     dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
-    release: bullseye
+    release: buster
 
-build:hihope-rzg2m-bullseye:
+build:hihope-rzg2m-buster:
   extends:
     - .build_base
   variables:
     target: hihope-rzg2m
     dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
-    release: bullseye
+    release: buster
-- 
2.35.1


