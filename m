Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA83C48BEB
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 12:17:06 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.12622.1707999422853780723
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Feb 2024 04:17:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=e/FovIY7;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-2024021512170029078e20812e48776f-5mhfaw@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2024021512170029078e20812e48776f
        for <cip-dev@lists.cip-project.org>;
        Thu, 15 Feb 2024 13:17:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=dHCj/UKeO8MUO/F8Tt0OU806qoW/XP9ErTwLErgwV+Q=;
 b=e/FovIY7zvqlqXLpOUFdiTv69mDdwcFECXLwlZ2N8RGzUkRupm4OEBlhZWkLq3c3yn/awS
 9V4TUch789FbrhQnw6acmIIkszVjSTQOegIFasfEYMvoIQ6d6EXqCqiXf/uh/FBsa3AVRcE5
 ug0M3TH/c8v8GlVTgKMOXt6Yr9+7I=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 3/3] build swupdate 2022.12 for qemu-amd64-secure-boot-bullseye
Date: Thu, 15 Feb 2024 13:14:07 +0100
Message-ID: <20240215121659.315309-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240215121659.315309-1-Quirin.Gylstorff@siemens.com>
References: <20240215121659.315309-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Feb 2024 12:17:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14993

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This ensure minimal build testing for SWUpdate 2022.12

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9c3ee0f..d39ecb3 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -25,7 +25,7 @@ variables:
   dtb: none
   deploy: enable
   deploy_kernelci: disable
-
+  swupdate_version: default
 stages:
   - build
   - test
@@ -63,6 +63,7 @@ default:
     - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
     - if [ "${release}" = "sid" ]; then base_yaml="${base_yaml}:kas/opt/sid.yml"; fi
     - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-partitions.yml"; fi
+    - if [ "${swupdate_version}" = "2022.12" ]; then base_yaml="${base_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
     - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
@@ -303,6 +304,7 @@ build:qemu-amd64-secure-boot-bullseye:
     use_rt: disable
     wic_targz: disable
     deploy: disable
+    swupdate_version: "2022.12"
 
 # buster images
 build:iwg20m-buster:
-- 
2.43.0


