Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B61C48BC4
	for <webhook@archiver.kernel.org>; Wed, 14 Feb 2024 15:48:32 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.44216.1707925706273328948
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Feb 2024 07:48:26 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 41EFmOMx2046333; Thu, 15 Feb 2024 00:48:25 +0900
X-Iguazu-Qid: 2yAaCKdk3pid79EtXc
X-Iguazu-QSIG: v=2; s=0; t=1707925704; q=2yAaCKdk3pid79EtXc; m=4gao8lRW6Fc8vohdJ5BAed6cGH3NJE2+QmnKm37uS3s=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 41EFmNdi2903719
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 15 Feb 2024 00:48:24 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v3 2/2] .gitlab-ci.yml: Add condition check in .build_base to build v2 image
Date: Wed, 14 Feb 2024 21:18:20 +0530
X-TSB-HOP2: ON
Message-Id: <20240214154820.3544080-3-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240214154820.3544080-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20240214154820.3544080-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Feb 2024 15:48:20.0446 (UTC) FILETIME=[3C05C7E0:01DA5F5D]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Feb 2024 15:48:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14981

From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>

To re-use the built artifacts of v1 image, the consecutive build must
happen in the project directory of the job. So if use_swu is enabled, then
a consecutive build with a minor recipe change is done to get an .swu
artifact for swupdate testing in LAVA.

Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
---
 .gitlab-ci.yml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 4f87ec3..bbd534e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -25,6 +25,7 @@ variables:
   dtb: none
   deploy: enable
   deploy_kernelci: disable
+  use_swu: disable
 
 stages:
   - build
@@ -66,6 +67,12 @@ default:
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
     - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
+    - >
+      if [ "${use_swu}" = "enable" ]; then
+          echo "PV = \"2.0\"" >> recipes-core/images/cip-core-image-security.bb
+          kas build ${base_yaml}
+          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} ${use_swu}
+      fi
     - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
 
 # base image
@@ -105,6 +112,7 @@ build:qemu-amd64-base:
     use_rt: disable
     wic_targz: disable
     targz: enable
+    use_swu: enable
 
 build:qemu-amd64-base-kernelci:
   extends:
@@ -127,6 +135,7 @@ build:qemu-arm64-base:
     use_rt: disable
     wic_targz: disable
     targz: enable
+    use_swu: enable
 
 build:qemu-arm64-base-kernelci:
   extends:
@@ -149,6 +158,7 @@ build:qemu-arm-base:
     use_rt: disable
     wic_targz: disable
     targz: enable
+    use_swu: enable
 
 build:qemu-arm-base-kernelci:
   extends:
-- 
2.30.2



