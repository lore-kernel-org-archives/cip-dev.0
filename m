Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA72C48BED
	for <webhook@archiver.kernel.org>; Wed, 14 Feb 2024 15:34:12 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.43783.1707924849050248233
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Feb 2024 07:34:09 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 41EFY7953103210; Thu, 15 Feb 2024 00:34:07 +0900
X-Iguazu-Qid: 2rWgHjhWrUGS0bhc1q
X-Iguazu-QSIG: v=2; s=0; t=1707924846; q=2rWgHjhWrUGS0bhc1q; m=pEyQ3/mTqkHxkq8vDZFTc0I8jHlmz+nyNZVbPerf8a8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 41EFY5U93368585
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 15 Feb 2024 00:34:06 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 2/2] .gitlab-ci.yml: Add condition check in .build_base to build v2 image
Date: Wed, 14 Feb 2024 21:03:41 +0530
X-TSB-HOP2: ON
Message-Id: <20240214153341.3543690-3-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240214153341.3543690-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20240214153341.3543690-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Feb 2024 15:33:41.0358 (UTC) FILETIME=[300B98E0:01DA5F5B]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Feb 2024 15:34:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14977

From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>

To re-use the built artifacts of v1 image, the consecutive build must
happen in the project directory of the job. So if use_swu is enabled, then
a consecutive build with a minor recipe change is done to get an .swu
artifact for swupdate testing in LAVA.

Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
---
 .gitlab-ci.yml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 4f87ec3..8ce7118 100644
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
-- 
2.30.2



