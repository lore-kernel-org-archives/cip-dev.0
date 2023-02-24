Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529C5C7EE37
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 16:28:41 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.22336.1677256118156618563
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Feb 2023 08:28:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=O5BiLda5;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20230224162836a3d32fda3931dfd41c-fpvxhr@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230224162836a3d32fda3931dfd41c
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Feb 2023 17:28:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=T/hhPSQAcdMqab9E1iWpL9Ze51OROa7Wq9z/klpU7Gw=;
 b=O5BiLda5I/YEJ0bRKE0qLBc6xmZI+QUC4J5/Xm7sWiIDxJ2MMq2YwPqWe40zPVyARAAg11
 G5fLBdwAV0Lf5u7SMPygQN9pqF9s8ati6aIB+XvtVG9GgzEZ/fvc1XaBvFgpD/mW6hUaukCJ
 1kZCgyDi3xDR5aKaRXBKlyzRzDKZg=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	christian.storm@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 7/8] .gitlabci: Add ci build
Date: Fri, 24 Feb 2023 17:28:31 +0100
Message-Id: <20230224162832.327030-8-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230224162832.327030-1-Quirin.Gylstorff@siemens.com>
References: <20230224162832.327030-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Feb 2023 16:28:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10821

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 777840b..1506252 100644
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


