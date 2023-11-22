Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143BFC61D99
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 07:01:36 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.13995.1700636488039514159
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Nov 2023 23:01:28 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 3AM71PFf2844676; Wed, 22 Nov 2023 16:01:25 +0900
X-Iguazu-Qid: 2yAam8fxz1CJtYUqbi
X-Iguazu-QSIG: v=2; s=0; t=1700636485; q=2yAam8fxz1CJtYUqbi; m=pk073jCR3WbqK+h94uayJV3bMo4htugf/A3mXIloMqA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 3AM71OZW850005
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 22 Nov 2023 16:01:25 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v1 1/3] .gitlab-ci.yml: Add cve-check stage in CI
Date: Wed, 22 Nov 2023 12:31:19 +0530
X-TSB-HOP2: ON
Message-Id: <20231122070121.326276-2-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231122070121.326276-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20231122070121.326276-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Nov 2023 07:01:21.0248 (UTC) FILETIME=[B2D00E00:01DA1D11]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 07:01:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13609

From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>

The cve-check uses the dpkg-status file to get the latest CVE
report using the cve_checker.py script in debian-cve-checker
container. The dpkg-status file will also be deployed to aws s3
bucket along with the targets whose deployment is enabled.

Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
---
 .gitlab-ci.yml | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 1de6570..c838a81 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -29,6 +29,7 @@ variables:
 stages:
   - build
   - test
+  - cve-check
 
 default:
   before_script:
@@ -48,6 +49,7 @@ default:
     - large
   variables:
     base_yaml: "kas-cip.yml:kas/board/${target}.yml"
+    dpkg_status: "cip-core-image-*.dpkg_status"
   script:
     - if [ "${use_rt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/rt.yml"; fi
     - if [ "${extension}" != "none" ]; then base_yaml="${base_yaml}:kas/opt/${extension}.yml"; fi
@@ -60,9 +62,17 @@ default:
     - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-partitions.yml"; fi
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
-    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
+    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} ${dpkg_status}; fi
     - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
 
+cve-checks:
+  stage: cve-check
+  image: registry.gitlab.com/cip-playground/debian-cve-checker:latest
+  script:
+    - scripts/run-cve-checks.sh
+  rules:
+    - if: $CI_PIPELINE_SOURCE == "schedule" && $CI_JOB_NAME == "cve-checks"
+
 # base image
 build:simatic-ipc227e-base:
   extends:
-- 
2.30.2



