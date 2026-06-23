Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF466CDB47C
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 11:05:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18214.1782212745637266237
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Jun 2026 04:05:46 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 65NB5isU4017711; Tue, 23 Jun 2026 20:05:44 +0900
X-Iguazu-Qid: 2yAbcyMlSl3p7lqtUm
X-Iguazu-QSIG: v=2; s=0; t=1782212743; q=2yAbcyMlSl3p7lqtUm; m=Ql5HTM9dXdn8y1YjFP+tgGIeX0bXLS/XWs/sPVyqqPc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gl2Kz5Fm0z1xnZ; Tue, 23 Jun 2026 20:05:43 +0900 (JST)
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, Adithya.Balakumar@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v4 3/3] Enable CI image build and test support for Sid
Date: Tue, 23 Jun 2026 16:22:34 +0530
X-TSB-HOP2: ON
Message-Id: <20260623105234.972121-4-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260623105234.972121-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20260623105234.972121-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Jun 2026 11:05:39.0052 (UTC) FILETIME=[397F72C0:01DD0300]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Jun 2026 11:05:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23268

Keep these jobs as scheduled and can be scheduled to run every week
just to monitor and fix if there are any issues.
Also set allow_failure:true for these jobs as sid is unstable.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 .gitlab-ci.yml | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 485c3c3..5a20ad6 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -63,6 +63,7 @@ default:
     - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
     - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
     - if [ "${release}" = "trixie" ]; then base_yaml="${base_yaml}:kas/opt/trixie.yml"; fi
+    - if [ "${release}" = "sid" ]; then base_yaml="${base_yaml}:kas/opt/sid.yml"; fi
     - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-data.yml"; fi
     - if [ "${factory_reset}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/factory-reset.yml"; fi
     - if [ "${watchdog}" = "disable" ]; then base_yaml="${base_yaml}:kas/opt/disable-watchdog.yml"; fi
@@ -347,6 +348,57 @@ build:qemu-amd64-secure-boot-buster:
     use_rt: disable
     encrypt: enable
 
+# sid image builds
+.build_base_sid:
+  extends:
+    - .build_base
+  rules:
+    - if: $CI_COMMIT_TAG
+      when: never
+    - if: '$CI_PIPELINE_SOURCE == "schedule" && $CI_RUN_UNSTABLE_SID'
+    - if: $CI_COMMIT_BRANCH != "master"
+      when: never
+  allow_failure: true
+
+build:qemu-amd64-base-sid:
+  extends:
+    - .build_base_sid
+  variables:
+    target: qemu-amd64
+    use_rt: disable
+    release: sid
+    extension: security
+    security_test: enable
+    build_updates: enable
+    separate_home_partition: enable
+    deploy: enable
+
+build:qemu-arm64-base-sid:
+  extends:
+    - .build_base_sid
+  variables:
+    target: qemu-arm64
+    use_rt: disable
+    release: sid
+    extension: security
+    security_test: enable
+    build_updates: enable
+    separate_home_partition: enable
+    deploy: enable
+
+build:qemu-arm-base-sid:
+  extends:
+    - .build_base_sid
+  variables:
+    target: qemu-arm
+    extension: security
+    security_test: enable
+    use_rt: disable
+    release: sid
+    build_updates: enable
+    separate_home_partition: enable
+    deploy: enable
+
 .test-cip-core:
   stage: test
   image: $CI_REGISTRY_IMAGE/lavacli
@@ -671,6 +723,44 @@ test:qemu-arm-swupdate-apply-same-image-swu:
     target: qemu-arm
     test_function: swupdate-apply-same-image-swu
 
+# Tests for unstable(sid) images
+.test-cip-core-sid:
+  extends:
+    - .test-cip-core
+  rules:
+    - if: $CI_COMMIT_TAG
+      when: never
+    - if: '$CI_PIPELINE_SOURCE == "schedule" && $CI_RUN_UNSTABLE_SID'
+    - if: $CI_COMMIT_BRANCH != "master"
+      when: never
+  allow_failure: true
+
+test:qemu-amd64-IEC-sid:
+  extends:
+   - .test-cip-core-sid
+  variables:
+    target: qemu-amd64
+    test_function: IEC
+    iec_test_timeout: 40
+
+test:qemu-arm64-IEC-sid:
+  extends:
+   - .test-cip-core-sid
+  needs: ["build:qemu-arm64-base-sid"]
+  variables:
+    target: qemu-arm64
+    test_function: IEC
+    iec_test_timeout: 40
+
+test:qemu-arm-IEC-sid:
+  extends:
+   - .test-cip-core-sid
+  needs: ["build:qemu-arm-base-sid"]
+  variables:
+    target: qemu-arm
+    test_function: IEC
+    iec_test_timeout: 40
+
 cve-checks:
   stage: cve-check
   needs: []
-- 
2.39.5



