Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467AB106B51D
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 12:26:33 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20931.1774441588690739275
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Mar 2026 05:26:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=HyPJgWQc;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20260325122624dce645d797000207c7-vgy5uc@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260325122624dce645d797000207c7
        for <cip-dev@lists.cip-project.org>;
        Wed, 25 Mar 2026 13:26:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=GyaWvULGDuC6bGsR2uxbHIim9Y3yUQlpq2ie326bVVs=;
 b=HyPJgWQc2/EdpJ3s9mHaOywsECgKo7C/AzQSibE7IUFwZmWMHeYRJV6J/5PSGxh/DIxKuZ
 EnNzeeokL2BMjikeEkRJlJlHnhCg7V+odxJPbFbT9b1iWNPWih9wjcpfDh+DSgN/VahYQj3s
 EZt05+8xBmdnJVI0Bbp0W+BeWKaRbVJTwMQOp0fvQkhnlXP5yfrmfCM56Is2lvG48rxZ7D8n
 yIPJ/ba+JsnL4Pp3N/ngA0lRmLt2bSG2jHFv+rPUNkukP7amwJbKRHnW+XG3i/ve0wF8srNO
 pGUX+oudUXwFqDlJhjWS1xRt0wQtyb7x2cBZYLDwDRcAjrXnjGGjAa3A==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	chris.paterson2@renesas.com
Subject: [RFC cip-dev][isar-cip-core][PATCH] Use pipeline id instead of CI_COMMIT_REF_SLUG
Date: Wed, 25 Mar 2026 13:25:04 +0100
Message-ID: <20260325122615.424136-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Mar 2026 12:26:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22565

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This avoids errors due to overwrites from followup jobs.

This change requires a clean up in the storage backend(e.g. S3) to avoid
storing outdated build artifacts.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 602c503..75f0502 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -71,7 +71,7 @@ default:
     - if [ "${no_kernel}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/no_kernel.yml:kas/opt/targz.yml"; fi
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
-    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi
+    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_PIPELINE_ID} wic; fi
     - if [ "${build_updates}" = "enable" ]; then
           mkdir build/previous-image;
           if [ "${extension}" = "security" ] || [ "${extension}" = "ebg-secure-boot-snakeoil" ]; then
@@ -90,7 +90,7 @@ default:
           for swu in build/previous-image/*-broken.swu; do
               mv "$swu" build/tmp/deploy/images/${target};
           done;
-          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} swus;
+          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_PIPELINE_ID} swus;
       fi
 
 # base image
@@ -359,7 +359,7 @@ build:qemu-amd64-secure-boot-buster:
   tags:
     - small
   script:
-    - scripts/submit_lava.sh ${test_function} ${target} ${CI_COMMIT_SHORT_SHA} ${release} ${CI_COMMIT_REF_SLUG} ${iec_test_timeout}
+    - scripts/submit_lava.sh ${test_function} ${target} ${CI_COMMIT_SHORT_SHA} ${release} ${CI_PIPELINE_ID} ${iec_test_timeout}
   artifacts:
     name: "$CI_JOB_NAME"
     when: always
-- 
2.53.0


