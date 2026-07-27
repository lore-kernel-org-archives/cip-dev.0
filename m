Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEC2C531D0
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 14:25:03 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32462.1785162299826348074
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 07:25:00 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 66REOwH42103455; Mon, 27 Jul 2026 23:24:58 +0900
X-Iguazu-Qid: 2rWh7sv8E0TBI3Wtaz
X-Iguazu-QSIG: v=2; s=1; t=1785162297; q=2rWh7sv8E0TBI3Wtaz; m=J+q0x/mBVaSNbjPs6OqXsNhEXWYGkjzLOEyRyKdWJz0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h81895kVLz4vyn; Mon, 27 Jul 2026 23:24:57 +0900 (JST)
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        kumar.dinesh.h95@mail.toshiba, kazuhiro.hayashi.f74@mail.toshiba
Subject: [isar-cip-core][PATCH v1 2/2] Enable CI image build and test support for forky
Date: Mon, 27 Jul 2026 19:41:36 +0530
X-TSB-HOP2: ON
Message-Id: <20260727141136.1773671-3-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260727141136.1773671-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20260727141136.1773671-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 27 Jul 2026 14:24:54.0237 (UTC) FILETIME=[B16368D0:01DD1DD3]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 14:25:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23775

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

Keep these jobs as scheduled and can be scheduled to run every week
just to monitor and fix if there are any issues.
Also set allow_failure:true for these jobs as forky is not officially
released and there will always be some build & test issues.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 .gitlab-ci.yml | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b53def4..977ae01 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -64,6 +64,7 @@ default:
     - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
     - if [ "${release}" = "trixie" ]; then base_yaml="${base_yaml}:kas/opt/trixie.yml"; fi
     - if [ "${release}" = "sid" ]; then base_yaml="${base_yaml}:kas/opt/sid.yml"; fi
+    - if [ "${release}" = "forky" ]; then base_yaml="${base_yaml}:kas/opt/forky.yml"; fi
     - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-data.yml"; fi
     - if [ "${factory_reset}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/factory-reset.yml"; fi
     - if [ "${watchdog}" = "disable" ]; then base_yaml="${base_yaml}:kas/opt/disable-watchdog.yml"; fi
@@ -399,6 +400,57 @@ build:qemu-arm-base-sid:
     separate_home_partition: enable
     deploy: enable
 
+# forky image builds
+.build_base_forky:
+  extends:
+    - .build_base
+  rules:
+    - if: $CI_COMMIT_TAG
+      when: never
+    - if: '$CI_PIPELINE_SOURCE == "schedule" && $CI_RUN_UNSTABLE_FORKY'
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
@@ -764,6 +816,47 @@ test:qemu-arm-IEC-sid:
     test_function: IEC
     iec_test_timeout: 40
 
+# Tests for forky images
+.test-cip-core-forky:
+  extends:
+    - .test-cip-core
+  rules:
+    - if: $CI_COMMIT_TAG
+      when: never
+    - if: '$CI_PIPELINE_SOURCE == "schedule" && $CI_RUN_UNSTABLE_FORKY'
+    - if: $CI_COMMIT_BRANCH != "master"
+      when: never
+  allow_failure: true
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
-- 
2.39.5



