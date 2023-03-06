Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE2AC6FD1E
	for <webhook@archiver.kernel.org>; Mon,  6 Mar 2023 12:39:34 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.32035.1678106371974482548
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Mar 2023 04:39:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=T0KHGO6M;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-202303061239309c4daeab8d93078102-wr5nds@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202303061239309c4daeab8d93078102
        for <cip-dev@lists.cip-project.org>;
        Mon, 06 Mar 2023 13:39:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=SdZkjJGfjCoHvhflmvOfbp9Gx3Tiv49EDnta8EdGaWo=;
 b=T0KHGO6MMbpI+ZPNniW3twzWBQuzjHCWjwd7/KPFfO63uW7pSUj0QcPfedFfndNcZIx0UY
 dc2ZK11gSR5HaRxwM7Fj6g8ikO260KvyBqEEOcSEUeDD0okxjQRVTuHXtp4w2iTpC9tH1k51
 HMiwkgQOmPI9qobD5WyJwgmaYvGHo=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	christian.storm@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 6/7] .gitlabci: Add ci build
Date: Mon,  6 Mar 2023 13:39:25 +0100
Message-Id: <20230306123926.243471-7-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230306123926.243471-1-Quirin.Gylstorff@siemens.com>
References: <20230306123926.243471-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Mar 2023 12:39:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10940

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


