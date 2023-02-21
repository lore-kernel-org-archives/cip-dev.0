Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C15C64ED6
	for <webhook@archiver.kernel.org>; Tue, 21 Feb 2023 15:41:17 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.45106.1676994069503266359
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Feb 2023 07:41:09 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 31LFf7Ia021870; Wed, 22 Feb 2023 00:41:07 +0900
X-Iguazu-Qid: 34ts1GHAbgedEWqpea
X-Iguazu-QSIG: v=2; s=0; t=1676994067; q=34ts1GHAbgedEWqpea; m=x41eYNCGKwdB+b8ye2N8zAKcosgM0RUePTfawhsdUYA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1511) id 31LFf6ZK037416
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 22 Feb 2023 00:41:06 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 2/2] .gitlab-ci.yml: Add ci for reproducible build checks
Date: Tue, 21 Feb 2023 21:11:38 +0530
X-TSB-HOP2: ON
Message-Id: <20230221154138.15146-3-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230221154138.15146-1-venkata.pyla@toshiba-tsip.com>
References: <20230221154138.15146-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 21 Feb 2023 15:41:01.0926 (UTC) FILETIME=[E6C27060:01D9460A]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Feb 2023 15:41:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10760

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .gitlab-ci.yml | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index f7c8c88..3458a2f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -13,6 +13,7 @@ variables:
 
 stages:
   - build
+  - test
 
 default:
   before_script:
@@ -26,6 +27,8 @@ default:
 
 .build_base:
   stage: build
+  except:
+    - schedules
   tags:
     - large
   variables:
@@ -42,6 +45,57 @@ default:
     - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
     - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
 
+.repro-build:
+  variables:
+    use_rt: disable
+    wic_targz: disable
+    targz: enable
+    deploy: disable
+    deploy_kernelci: disable
+    artifact_suffix: ".tar.gz"
+    base_yaml: "kas-cip.yml:kas/board/${target}.yml"
+  stage: build
+  tags:
+    - large
+  only:
+    - schedules
+  script:
+    - if [ -f kas/opt/reproducible.yml ]; then base_yaml="${base_yaml}:kas/opt/reproducible.yml"; fi
+    # Build 1st time
+    - !reference [.build_base, script]
+    - mv build/tmp/deploy/images/${target}/cip-core-image-cip-core-${release}-${target}${artifact_suffix} image1
+    # clean
+    - sudo rm -rf build/tmp
+    - sudo rm -rf build/sstate-cache
+    # Build 2nd time
+    - !reference [.build_base, script]
+    - mv build/tmp/deploy/images/${target}/cip-core-image-cip-core-${release}-${target}${artifact_suffix} image2
+  artifacts:
+    expire_in: 1 day
+    paths:
+      - image1
+      - image2
+
+.repro-test:
+  image:
+    name: debian:bullseye
+  tags:
+    - large
+  stage: test
+  only:
+    - schedules
+  variables:
+    GIT_STRATEGY: none
+  before_script:
+    - apt update && DEBIAN_FRONTEND=noninteractive apt install -y diffoscope
+  script:
+    - diffoscope --text diffoscope_output.txt image1 image2
+  artifacts:
+    when: always
+    expire_in: 1 day
+    paths:
+      - diffoscope_output.txt
+
 # base image
 build:simatic-ipc227e-base:
   extends:
@@ -281,3 +335,42 @@ build:qemu-amd64-secure-boot-buster:
     use_rt: disable
     wic_targz: disable
     deploy: disable
+
+# repro build
+build:qemu-amd64-base-repro-build:
+  extends:
+    - .repro-build
+  variables:
+    target: qemu-amd64
+
+build:qemu-arm64-base-repro-build:
+  extends:
+    - .repro-build
+  variables:
+    target: qemu-arm64
+
+build:qemu-arm-base-repro-build:
+  extends:
+    - .repro-build
+  variables:
+    target: qemu-arm
+
+# repro build test
+test:qemu-amd64-base-repro-test:
+  extends:
+    - .repro-test
+  dependencies:
+    - build:qemu-amd64-base-repro-build
+
+test:qemu-arm64-base-repro-test:
+  extends:
+    - .repro-test
+  dependencies:
+    - build:qemu-arm64-base-repro-build
+
+test:qemu-arm-base-repro-test:
+  extends:
+    - .repro-test
+  dependencies:
+    - build:qemu-arm-base-repro-build
+
-- 
2.20.1



