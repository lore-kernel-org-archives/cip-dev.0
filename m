Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9B8C5CFC1
	for <webhook@archiver.kernel.org>; Tue, 11 Aug 2026 09:18:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50806.1786439880928860713
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Aug 2026 02:18:01 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 67B9Hx841690055; Tue, 11 Aug 2026 18:17:59 +0900
X-Iguazu-Qid: 2rWh1q7vhm1HZLcE9R
X-Iguazu-QSIG: v=2; s=1; t=1786439878; q=2rWh1q7vhm1HZLcE9R; m=IMF+sT6iUsQsPgEQX6Y2tvC24gUKCEj9HtRheQGasGk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hK5d25GHcz1xnf; Tue, 11 Aug 2026 18:17:58 +0900 (JST)
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        kumar.dinesh.h95@mail.toshiba, kazuhiro.hayashi.f74@mail.toshiba
Subject: [isar-cip-core][PATCH v3 3/3] Enable CI image build and test support for forky
Date: Tue, 11 Aug 2026 14:34:21 +0530
X-TSB-HOP2: ON
Message-Id: <20260811090421.3547180-4-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260811090421.3547180-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20260811090421.3547180-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Aug 2026 09:17:53.0833 (UTC) FILETIME=[4A2B1190:01DD2972]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Aug 2026 09:18:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23894

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

Keep these jobs as scheduled and can be scheduled to run every week
just to monitor and fix if there are any issues.
Also set allow_failure:true for these jobs as forky is not officially
released and there will always be some build & test issues.

It includes SWUpdate, secure boot & RB tests.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 .gitlab-ci.yml             | 148 +++++++++++++++++++++++++++++++++++++
 .reproducible-check-ci.yml |  72 ++++++++++++++++++
 2 files changed, 220 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 480ad3d..d46a9ef 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -8,6 +8,7 @@
 #  Jan Kiszka <jan.kiszka@siemens.com>
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
 #  Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+#  Shivanand Kunijadar <shivanand.kunijadar@toshiba-tsip.com>
 #
 # SPDX-License-Identifier: MIT
 #
@@ -63,6 +64,7 @@ default:
     - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
     - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
     - if [ "${release}" = "trixie" ]; then base_yaml="${base_yaml}:kas/opt/trixie.yml"; fi
+    - if [ "${release}" = "forky" ]; then base_yaml="${base_yaml}:kas/opt/forky.yml"; fi
     - if [ "${release}" = "sid" ]; then base_yaml="${base_yaml}:kas/opt/sid.yml"; fi
     - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-data.yml"; fi
     - if [ "${factory_reset}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/factory-reset.yml"; fi
@@ -399,6 +401,57 @@ build:qemu-arm-base-sid:
     separate_home_partition: enable
     deploy: enable
 
+# forky image builds
+.build_base_forky:
+  extends:
+    - .build_base
+  rules:
+    - if: $CI_COMMIT_TAG
+      when: never
+    - if: '$CI_PIPELINE_SOURCE == "schedule" && $CI_RUN_UNSTABLE'
+    - if: $CI_COMMIT_BRANCH != "master"
+      when: never
+  allow_failure: true
+
+build:qemu-amd64-base-forky:
+  extends:
+    - .build_base_forky
+  variables:
+    target: qemu-amd64
+    use_rt: disable
+    release: forky
+    extension: security
+    security_test: enable
+    build_updates: enable
+    separate_home_partition: enable
+    deploy: enable
+
+build:qemu-arm64-base-forky:
+  extends:
+    - .build_base_forky
+  variables:
+    target: qemu-arm64
+    use_rt: disable
+    release: forky
+    extension: security
+    security_test: enable
+    build_updates: enable
+    separate_home_partition: enable
+    deploy: enable
+
+build:qemu-arm-base-forky:
+  extends:
+    - .build_base_forky
+  variables:
+    target: qemu-arm
+    extension: security
+    security_test: enable
+    use_rt: disable
+    release: forky
+    build_updates: enable
+    separate_home_partition: enable
+    deploy: enable
+
 .test-cip-core:
   stage: test
   image: $CI_REGISTRY_IMAGE/lavacli
@@ -764,6 +817,101 @@ test:qemu-arm-IEC-sid:
     test_function: IEC
     iec_test_timeout: 40
 
+# Tests for forky images
+.test-cip-core-forky:
+  extends:
+    - .test-cip-core
+  rules:
+    - if: $CI_COMMIT_TAG
+      when: never
+    - if: '$CI_PIPELINE_SOURCE == "schedule" && $CI_RUN_UNSTABLE'
+    - if: $CI_COMMIT_BRANCH != "master"
+      when: never
+  allow_failure: true
+
+test:qemu-amd64-swupdate-forky:
+  extends:
+    - .test-cip-core-forky
+  needs: ["build:qemu-amd64-base-forky"]
+  variables:
+    target: qemu-amd64
+    release: forky
+    test_function: swupdate
+
+test:qemu-arm64-swupdate-forky:
+  extends:
+    - .test-cip-core-forky
+  needs: ["build:qemu-arm64-base-forky"]
+  variables:
+    target: qemu-arm64
+    release: forky
+    test_function: swupdate
+
+test:qemu-arm-swupdate-forky:
+  extends:
+    - .test-cip-core-forky
+  needs: ["build:qemu-arm-base-forky"]
+  variables:
+    target: qemu-arm
+    release: forky
+    test_function: swupdate
+
+test:qemu-amd64-secure-boot-forky:
+  extends:
+    - .test-cip-core-forky
+  needs: ["build:qemu-amd64-base-forky"]
+  variables:
+    target: qemu-amd64
+    release: forky
+    test_function: secure-boot
+
+test:qemu-arm64-secure-boot-forky:
+  extends:
+    - .test-cip-core-forky
+  needs: ["build:qemu-arm64-base-forky"]
+  variables:
+    target: qemu-arm64
+    release: forky
+    test_function: secure-boot
+
+test:qemu-arm-secure-boot-forky:
+  extends:
+    - .test-cip-core-forky
+  needs: ["build:qemu-arm-base-forky"]
+  variables:
+    target: qemu-arm
+    release: forky
+    test_function: secure-boot
+
+test:qemu-amd64-IEC-forky:
+  extends:
+   - .test-cip-core-forky
+  variables:
+    target: qemu-amd64
+    release: forky
+    test_function: IEC
+    iec_test_timeout: 40
+
+test:qemu-arm64-IEC-forky:
+  extends:
+   - .test-cip-core-forky
+  needs: ["build:qemu-arm64-base-forky"]
+  variables:
+    target: qemu-arm64
+    release: forky
+    test_function: IEC
+    iec_test_timeout: 40
+
+test:qemu-arm-IEC-forky:
+  extends:
+   - .test-cip-core-forky
+  needs: ["build:qemu-arm-base-forky"]
+  variables:
+    target: qemu-arm
+    release: forky
+    test_function: IEC
+    iec_test_timeout: 40
+
 cve-checks:
   stage: cve-check
   needs: []
diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index fb24188..1246a64 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -5,6 +5,8 @@
 #
 # Authors:
 #  Venkata Pyla <venkata.pyla@toshiba-tsip.com>
+#  Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
+#  Shivanand Kunijadar <shivanand.kunijadar@toshiba-tsip.com>
 #
 # SPDX-License-Identifier: MIT
 #
@@ -130,6 +132,39 @@ build:x86-uefi-repro-build:
   variables:
     target: x86-uefi
 
+# repro build for debian forky
+build:qemu-amd64-repro-build-forky:
+  extends:
+    - .repro-build
+  variables:
+    target: qemu-amd64
+    release: forky
+  allow_failure: true
+
+build:qemu-arm64-repro-build-forky:
+  extends:
+    - .repro-build
+  variables:
+    target: qemu-arm64
+    release: forky
+  allow_failure: true
+
+build:qemu-arm-repro-build-forky:
+  extends:
+    - .repro-build
+  variables:
+    target: qemu-arm
+    release: forky
+  allow_failure: true
+
+build:x86-uefi-repro-build-forky:
+  extends:
+    - .repro-build
+  variables:
+    target: x86-uefi
+    release: forky
+  allow_failure: true
+
 # repro build test
 test:qemu-amd64-repro-test:
   extends:
@@ -166,3 +201,40 @@ test:x86-uefi-repro-test:
   variables:
     target: x86-uefi
   needs: ["build:x86-uefi-repro-build"]
+
+# repro build test for debian forky
+test:qemu-amd64-repro-test-forky:
+  extends:
+    - .repro-test
+  variables:
+    target: qemu-amd64
+    release: forky
+  allow_failure: true
+  needs: ["build:qemu-amd64-repro-build-forky"]
+
+test:qemu-arm64-repro-test-forky:
+  extends:
+    - .repro-test
+  variables:
+    target: qemu-arm64
+    release: forky
+  allow_failure: true
+  needs: ["build:qemu-arm64-repro-build-forky"]
+
+test:qemu-arm-repro-test-forky:
+  extends:
+    - .repro-test
+  variables:
+    target: qemu-arm
+    release: forky
+  allow_failure: true
+  needs: ["build:qemu-arm-repro-build-forky"]
+
+test:x86-uefi-repro-test-forky:
+  extends:
+    - .repro-test
+  variables:
+    target: x86-uefi
+    release: forky
+  allow_failure: true
+  needs: ["build:x86-uefi-repro-build-forky"]
-- 
2.39.5



