Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FB1C48BC4
	for <webhook@archiver.kernel.org>; Wed, 14 Feb 2024 12:28:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.40413.1707913696861422578
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Feb 2024 04:28:17 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 41ECSFjH2581064; Wed, 14 Feb 2024 21:28:15 +0900
X-Iguazu-Qid: 2rWgYo6FlCT1JQcEOf
X-Iguazu-QSIG: v=2; s=0; t=1707913694; q=2rWgYo6FlCT1JQcEOf; m=Na9+tnLZHiubXK2MbbhHRUXMCvur2Q3SNxg6v2lYAaI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 41ECSCJY3286795
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 14 Feb 2024 21:28:14 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 2/2] .gitlab-ci.yml: Add v2 QEMU security targets for swupdate testing
Date: Wed, 14 Feb 2024 17:58:09 +0530
X-TSB-HOP2: ON
Message-Id: <20240214122809.3541505-3-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240214122809.3541505-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20240214122809.3541505-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Feb 2024 12:28:09.0974 (UTC) FILETIME=[45393160:01DA5F41]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Feb 2024 12:28:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14965

From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>

For LAVA swupdate testing, v2 QEMU security targets are built with a
minor change in cip-core-image-security.bb. and their .swu artifacts
are deployed to s3 buckets for using in LAVA job definitions.

Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
---
 .gitlab-ci.yml | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 4f87ec3..c7837f4 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -25,6 +25,7 @@ variables:
   dtb: none
   deploy: enable
   deploy_kernelci: disable
+  use_swu: disable
 
 stages:
   - build
@@ -63,9 +64,10 @@ default:
     - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
     - if [ "${release}" = "sid" ]; then base_yaml="${base_yaml}:kas/opt/sid.yml"; fi
     - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-partitions.yml"; fi
+    - if [ "${use_swu}" = "enable" ]; then echo "PV = \"2.0\"" >> recipes-core/images/cip-core-image-security.bb; fi
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
-    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
+    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} ${use_swu}; fi
     - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
 
 # base image
@@ -106,6 +108,18 @@ build:qemu-amd64-base:
     wic_targz: disable
     targz: enable
 
+build:qemu-amd64-base-v2:
+  extends:
+    - .build_base
+  needs: [build:qemu-amd64-base]
+  variables:
+    target: qemu-amd64
+    extension: security
+    use_rt: disable
+    wic_targz: disable
+    targz: enable
+    use_swu: enable
+
 build:qemu-amd64-base-kernelci:
   extends:
     - .build_base
@@ -128,6 +142,18 @@ build:qemu-arm64-base:
     wic_targz: disable
     targz: enable
 
+build:qemu-arm64-base-v2:
+  extends:
+    - .build_base
+  needs: [build:qemu-arm64-base]
+  variables:
+    target: qemu-arm64
+    extension: security
+    use_rt: disable
+    wic_targz: disable
+    targz: enable
+    use_swu: enable
+
 build:qemu-arm64-base-kernelci:
   extends:
     - .build_base
@@ -150,6 +176,18 @@ build:qemu-arm-base:
     wic_targz: disable
     targz: enable
 
+build:qemu-arm-base-v2:
+  extends:
+    - .build_base
+  needs: [build:qemu-arm-base]
+  variables:
+    target: qemu-arm
+    extension: security
+    use_rt: disable
+    wic_targz: disable
+    targz: enable
+    use_swu: enable
+
 build:qemu-arm-base-kernelci:
   extends:
     - .build_base
-- 
2.30.2



