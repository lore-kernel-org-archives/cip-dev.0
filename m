Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A676CC54EE9
	for <webhook@archiver.kernel.org>; Thu,  1 Sep 2022 13:49:23 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web12.12329.1662040156295639267
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Sep 2022 06:49:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=Kl4iyT69;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226,
 mailfrom: fm-294854-20220901134912a44e41c7e61bf4fe8c-qa_d_c@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 20220901134912a44e41c7e61bf4fe8c
        for <cip-dev@lists.cip-project.org>;
        Thu, 01 Sep 2022 15:49:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=hsGvZpaZiq4UwP1IaLvwrqWKGUIvmvBuwq9/P+RD44E=;
 b=Kl4iyT69fiICRCxA1byOaKt6x40bUKAMhFpB9vHYH0q1WsRwu0DBRurTltGVrVvHVGEB+o
 o8Qv4HL1KkMRIpLppKuIu8uKu5mc7oKzsIzKau2QbGqb9bdvoyDPX73teaynVvq8tYIZmTtm
 CwjMzzpIzWvpl7uS4dTgJsGv8GDII=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 2/3] ci: Clean up redundant statements
Date: Thu,  1 Sep 2022 15:49:11 +0200
Message-Id: 
 <be104913799b65fd4159d3e4ff1922d24f265790.1662040151.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1662040151.git.jan.kiszka@siemens.com>
References: <cover.1662040151.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Sep 2022 13:49:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9420

From: Jan Kiszka <jan.kiszka@siemens.com>

We neither need to delete build/tmp anymore (since 3510f8a66f80), nor do
we need to set variables to the same value as their default.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 477ec63..593aee7 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -30,7 +30,6 @@ default:
   variables:
     base_yaml: "kas-cip.yml:kas/board/${target}.yml"
   script:
-    - sudo rm -rf build/tmp
     - if [ "${use_rt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/rt.yml"; fi
     - if [ "${extension}" != "base" ]; then base_yaml="${base_yaml}:kas/opt/${extension}.yml"; fi
     - if [ "${wic_targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/wic-targz-img.yml"; fi
@@ -204,7 +203,6 @@ build:qemu-amd64-secure-boot:
     extension: ebg-secure-boot-snakeoil
     use_rt: disable
     wic_targz: disable
-    targz: disable
     deploy: disable
 
 build:qemu-amd64-swupdate:
@@ -215,7 +213,6 @@ build:qemu-amd64-swupdate:
     extension: ebg-swu
     use_rt: disable
     wic_targz: disable
-    targz: disable
     deploy: disable
 
 # secure boot images arm64
@@ -227,7 +224,6 @@ build:qemu-arm64-secure-boot:
     extension: ebg-secure-boot-snakeoil
     use_rt: disable
     wic_targz: disable
-    targz: disable
     deploy: disable
 
 # secure boot images arm
@@ -239,7 +235,6 @@ build:qemu-arm-secure-boot:
     extension: ebg-secure-boot-snakeoil
     use_rt: disable
     wic_targz: disable
-    targz: disable
     deploy: disable
 
 # buster images
@@ -284,5 +279,4 @@ build:qemu-amd64-secure-boot-buster:
     extension: ebg-secure-boot-snakeoil
     use_rt: disable
     wic_targz: disable
-    targz: disable
     deploy: disable
-- 
2.35.3


