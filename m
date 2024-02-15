Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C82C4829E
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 13:59:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.14399.1708005544642663205
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Feb 2024 05:59:05 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 41FDx28t2216325; Thu, 15 Feb 2024 22:59:02 +0900
X-Iguazu-Qid: 2rWg9o4uhiDf2qeaWn
X-Iguazu-QSIG: v=2; s=0; t=1708005541; q=2rWg9o4uhiDf2qeaWn; m=S6nmFwR1p17NoPqbr/PwlLH4HhLpDj3Cv29VBNYVq2M=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 41FDx0G11110858
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 15 Feb 2024 22:59:01 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v4 2/2] .gitlab-ci.yml: Add condition check in .build_base to build v2 image
Date: Thu, 15 Feb 2024 19:28:37 +0530
X-TSB-HOP2: ON
Message-Id: <20240215135837.3557922-3-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240215135837.3557922-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20240215135837.3557922-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 Feb 2024 13:58:37.0912 (UTC) FILETIME=[12F08D80:01DA6017]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Feb 2024 13:59:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14999

From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>

To re-use the built artifacts of v1 image, the consecutive build must
happen in the project directory of the job. So if build_swu_v2 is enabled,
then a consecutive build with a minor recipe change is done to get an .swu
artifact for swupdate testing in LAVA. deploy_file variable is default set
to wic so that after checking presence of .wic in the deploy script, all
the artifacts like wic, firmware etc. shall be deployed except .swu file.
Only .swu file will pushed when "swu" is passed to deploy script.

Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
---
 .gitlab-ci.yml | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 4f87ec3..1c6816c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -25,6 +25,8 @@ variables:
   dtb: none
   deploy: enable
   deploy_kernelci: disable
+  build_swu_v2: disable
+  deploy_file: wic
 
 stages:
   - build
@@ -65,7 +67,13 @@ default:
     - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-partitions.yml"; fi
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
-    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
+    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} ${deploy_file}; fi
+    - if [ "${build_swu_v2}" = "enable" ]; then
+          echo "PV = \"2.0\"" >> recipes-core/images/cip-core-image-security.bb;
+          kas build ${base_yaml};
+          deploy_file="swu";
+          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} ${deploy_file};
+      fi
     - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
 
 # base image
@@ -105,6 +113,7 @@ build:qemu-amd64-base:
     use_rt: disable
     wic_targz: disable
     targz: enable
+    build_swu_v2: enable
 
 build:qemu-amd64-base-kernelci:
   extends:
@@ -127,6 +136,7 @@ build:qemu-arm64-base:
     use_rt: disable
     wic_targz: disable
     targz: enable
+    build_swu_v2: enable
 
 build:qemu-arm64-base-kernelci:
   extends:
@@ -149,6 +159,7 @@ build:qemu-arm-base:
     use_rt: disable
     wic_targz: disable
     targz: enable
+    build_swu_v2: enable
 
 build:qemu-arm-base-kernelci:
   extends:
-- 
2.30.2



