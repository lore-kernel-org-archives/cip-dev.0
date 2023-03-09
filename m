Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C7AC742A7
	for <webhook@archiver.kernel.org>; Thu,  9 Mar 2023 08:53:29 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.8771.1678352006644594541
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Mar 2023 00:53:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=bscTZP5m;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20230309085324412b4cacbcde2e8740-zlrfpp@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230309085324412b4cacbcde2e8740
        for <cip-dev@lists.cip-project.org>;
        Thu, 09 Mar 2023 09:53:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=SdZkjJGfjCoHvhflmvOfbp9Gx3Tiv49EDnta8EdGaWo=;
 b=bscTZP5mFfZRhsG/rVnZNYHIeqeRyqvqcUPVwLZfFgbplgpBYVUkxqOY8gRUP+3zGCpbA4
 Otz7dOfcGmKsmYESPgNF3UYqZuYa8OmYXAd6GkKWKOw2UnssvR0LjUrjP4Bfhcn6NUFwErWo
 ERTpsEK27n/k2aATi63jOnGRWgJzc=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	christian.storm@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 5/6] .gitlabci: Add ci build
Date: Thu,  9 Mar 2023 09:53:20 +0100
Message-Id: <20230309085321.17167-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230309085321.17167-1-Quirin.Gylstorff@siemens.com>
References: <20230309085321.17167-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Mar 2023 08:53:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10961

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index f51b64b..1ef13ea 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -19,6 +19,7 @@ variables:
   release: bullseye
   extension: none
   use_rt: enable
+  tpm: disable
   wic_targz: enable
   targz: disable
   dtb: none
@@ -55,6 +56,7 @@ default:
     - if [ "${release}" = "buster" ]; then base_yaml="${base_yaml}:kas/opt/buster.yml"; fi
     - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
     - if [ "${release}" = "sid-ports" ]; then base_yaml="${base_yaml}:kas/opt/sid-ports.yml"; fi
+    - if [ "${tpm}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/tpm.yml"; fi
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
     - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
@@ -224,6 +226,17 @@ build:qemu-amd64-secure-boot:
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
2.39.2


