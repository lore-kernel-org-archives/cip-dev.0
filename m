Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6715C0502C
	for <webhook@archiver.kernel.org>; Thu,  1 Sep 2022 13:49:23 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web09.12414.1662040155653482062
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Sep 2022 06:49:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=YgA0GtxA;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225,
 mailfrom: fm-294854-20220901134913b844e582fb908e38cc-rnbp4f@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 20220901134913b844e582fb908e38cc
        for <cip-dev@lists.cip-project.org>;
        Thu, 01 Sep 2022 15:49:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=wvsike9cS7sXkCbkKYw+6tyRfPGWY043DQu993+iJX8=;
 b=YgA0GtxAic0lzjxdc6DueZDXs/FYq4H3upYw7bYLryhrPOeBbOlx2KQUbvEGSU6hg/EuAn
 YjgLLrP3jX5b0IBSUY3z+ozsE5qRLx1Cg6WDDRkgs6yopJdC1WYuF3TSc092ovMUT38jFNlh
 xNd+R81hZbhpnCUHTzQL2rcWQYtsc=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 3/3] ci: Rename empty extension case
Date: Thu,  1 Sep 2022 15:49:12 +0200
Message-Id: 
 <4259a1fd031036e3f9f075044984565c319d6588.1662040151.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9419

From: Jan Kiszka <jan.kiszka@siemens.com>

"none" is clearer than "base".

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml             | 4 ++--
 scripts/deploy-cip-core.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 593aee7..81301e5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -3,7 +3,7 @@ image: ghcr.io/siemens/kas/kas-isar:3.0.2
 variables:
   GIT_STRATEGY: clone
   release: bullseye
-  extension: base
+  extension: none
   use_rt: enable
   wic_targz: enable
   targz: disable
@@ -31,7 +31,7 @@ default:
     base_yaml: "kas-cip.yml:kas/board/${target}.yml"
   script:
     - if [ "${use_rt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/rt.yml"; fi
-    - if [ "${extension}" != "base" ]; then base_yaml="${base_yaml}:kas/opt/${extension}.yml"; fi
+    - if [ "${extension}" != "none" ]; then base_yaml="${base_yaml}:kas/opt/${extension}.yml"; fi
     - if [ "${wic_targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/wic-targz-img.yml"; fi
     - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi
     - if [ "${release}" = "buster" ]; then base_yaml="${base_yaml}:kas/opt/buster.yml"; fi
diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index 01aa494..1eb93d5 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -17,7 +17,7 @@ DTB=$4
 REF=$5
 
 BASE_FILENAME=cip-core-image-cip-core-$RELEASE-$TARGET
-if [ "${EXTENSION}" != "base" ] ; then
+if [ "${EXTENSION}" != "none" ] ; then
 	if [ "${EXTENSION}" = "security" ] ; then
 		BASE_FILENAME=cip-core-image-$EXTENSION-cip-core-$RELEASE-$TARGET
 	else
-- 
2.35.3


