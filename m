Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFD7C64ED9
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 13:05:53 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.5825.1676639146750862895
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Feb 2023 05:05:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=LG9a1TJG;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-2023021713054443a86c4d3029b4a986-nbqi0w@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2023021713054443a86c4d3029b4a986
        for <cip-dev@lists.cip-project.org>;
        Fri, 17 Feb 2023 14:05:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=T7Pvtg8e1clM1yrOXfPA5a/T6lQjmCbOdUGY9YMuNMw=;
 b=LG9a1TJGELkV0PODcaOLhgUzbiPCaErdHqKJiT1nphcYP712WSTw0Ea+kzkztM9o+62B/m
 2uB88UPpPshjr4oUQCCgJqe/Dp8rhjwNLnrOacSBFnvgLfz0w3VgtGYoFeFBaOEgSKr6zId6
 0kXQPJrhBId8Goqy4x9gU5L+Ly/1w=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	christian.storm@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v2 7/7] .gitlabci: Add ci build
Date: Fri, 17 Feb 2023 14:05:40 +0100
Message-Id: <20230217130540.509910-8-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230217130540.509910-1-Quirin.Gylstorff@siemens.com>
References: <20230217130540.509910-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Feb 2023 13:05:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10719

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index f7c8c88..c6dcab6 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -5,6 +5,7 @@ variables:
   release: bullseye
   extension: none
   use_rt: enable
+  tpm: disable
   wic_targz: enable
   targz: disable
   dtb: none
@@ -37,6 +38,7 @@ default:
     - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi
     - if [ "${release}" = "buster" ]; then base_yaml="${base_yaml}:kas/opt/buster.yml"; fi
     - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
+    - if [ "${tpm}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/tpm.yml"; fi
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
     - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
@@ -206,6 +208,17 @@ build:qemu-amd64-secure-boot:
     wic_targz: disable
     deploy: disable
 
+build:qemu-amd64-secure-boot-tpm:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-amd64
+    extension: ebg-secure-boot-snakeoil
+    use_rt: disable
+    wic_targz: disable
+    deploy: disable
+    tpm: enable
+
 build:qemu-amd64-swupdate:
   extends:
     - .build_base
-- 
2.39.1


