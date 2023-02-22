Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8ADC636D6
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 11:44:26 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.6617.1677066262065786771
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Feb 2023 03:44:22 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 31MBiKDc009199; Wed, 22 Feb 2023 20:44:20 +0900
X-Iguazu-Qid: 34ts1GHAbi4g3O5DQ8
X-Iguazu-QSIG: v=2; s=0; t=1677066259; q=34ts1GHAbi4g3O5DQ8; m=2CL63nh9edDZBj9UeemvwUv75UCnTNB/sB/KRMBOxrw=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1511) id 31MBiJM7016932
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 22 Feb 2023 20:44:19 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v3 2/2] .reproducible-check-ci.yml: Add ci for reproducible build checks
Date: Wed, 22 Feb 2023 17:14:08 +0530
X-TSB-HOP2: ON
Message-Id: <20230222114408.32155-3-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <2e6c36f78e3873f0627fa5c3912108fe1283438e.camel@siemens.com>
References: <2e6c36f78e3873f0627fa5c3912108fe1283438e.camel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Feb 2023 11:43:31.0981 (UTC) FILETIME=[E38B23D0:01D946B2]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Feb 2023 11:44:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10780

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

The reproducible check is added only for scheduled CI's in order to reduce
burden on regular commit pushes and monitor only reproducible checks on
specified intervals like bi-weekly or monthly.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .gitlab-ci.yml             |  5 +++
 .reproducible-check-ci.yml | 91 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100644 .reproducible-check-ci.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index f7c8c88..3642661 100644
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
@@ -281,3 +284,5 @@ build:qemu-amd64-secure-boot-buster:
     use_rt: disable
     wic_targz: disable
     deploy: disable
+
+include: '.reproducible-check-ci.yml'
diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
new file mode 100644
index 0000000..a50d683
--- /dev/null
+++ b/.reproducible-check-ci.yml
@@ -0,0 +1,91 @@
+# extension to gitlab-ci for reproducible checks
+
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
-- 
2.20.1



