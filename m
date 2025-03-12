Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910D2C28B28
	for <webhook@archiver.kernel.org>; Wed, 12 Mar 2025 13:22:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.36743.1741785754839949212
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 06:22:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 52CDMXpX965272; Wed, 12 Mar 2025 22:22:33 +0900
X-Iguazu-Qid: 2rWh5b6vFSGofrQF3i
X-Iguazu-QSIG: v=2; s=0; t=1741785752; q=2rWh5b6vFSGofrQF3i; m=SCcbKnlvJNBWzx04sbV1bXTQoD8lHTo+A0dk3WCr2Gw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 52CDMWQs3354932
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 22:22:32 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1 3/4] .gitlab-ci.yml: Update CI to add additional jobs
Date: Wed, 12 Mar 2025 18:44:02 +0530
X-TSB-HOP2: ON
Message-Id: <20250312131403.1360421-4-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250312131403.1360421-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20250312131403.1360421-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Mar 2025 13:22:28.0841 (UTC) FILETIME=[CD96D590:01DB9351]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Mar 2025 13:22:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18087

Add separate CI jobs for SWUpdate and secure boot additional test cases
including negative scenarios.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 .gitlab-ci.yml | 144 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 72d3af8..d44b164 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -450,6 +450,150 @@ test:x86-uefi-IEC:
     target: x86-uefi
     test_function: IEC
 
+test:qemu-amd64-secure-boot-unsigned-kernel:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-amd64-base"]
+  variables:
+    target: qemu-amd64
+    test_function: secure-boot-unsigned-kernel
+
+test:qemu-arm64-secure-boot-unsigned-kernel:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-arm64-base"]
+  variables:
+    target: qemu-arm64
+    test_function: secure-boot-unsigned-kernel
+
+test:qemu-arm-secure-boot-unsigned-kernel:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-arm-base"]
+  variables:
+    target: qemu-arm
+    test_function: secure-boot-unsigned-kernel
+
+test:qemu-amd64-secure-boot-unsigned-bootloader:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-amd64-base"]
+  variables:
+    target: qemu-amd64
+    test_function: secure-boot-unsigned-bootloader
+
+test:qemu-arm64-secure-boot-unsigned-bootloader:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-arm64-base"]
+  variables:
+    target: qemu-arm64
+    test_function: secure-boot-unsigned-bootloader
+
+test:qemu-arm-secure-boot-unsigned-bootloader:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-arm-base"]
+  variables:
+    target: qemu-arm
+    test_function: secure-boot-unsigned-bootloader
+
+test:qemu-amd64-swupdate-corrupt-swu:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-amd64-base"]
+  variables:
+    target: qemu-amd64
+    test_function: swupdate-corrupt-swu
+
+test:qemu-arm64-swupdate-corrupt-swu:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-arm64-base"]
+  variables:
+    target: qemu-arm64
+    test_function: swupdate-corrupt-swu
+
+test:qemu-arm-swupdate-corrupt-swu:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-arm-base"]
+  variables:
+    target: qemu-arm
+    test_function: swupdate-corrupt-swu
+
+test:qemu-amd64-swupdate-corrupt-swu-artifact:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-amd64-base"]
+  variables:
+    target: qemu-amd64
+    test_function: swupdate-corrupt-swu-artifact
+
+test:qemu-arm64-swupdate-corrupt-swu-artifact:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-arm64-base"]
+  variables:
+    target: qemu-arm64
+    test_function: swupdate-corrupt-swu-artifact
+
+test:qemu-arm-swupdate-corrupt-swu-artifact:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-arm-base"]
+  variables:
+    target: qemu-arm
+    test_function: swupdate-corrupt-swu-artifact
+
+test:qemu-amd64-swupdate-reboot-without-confirm:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-amd64-base"]
+  variables:
+    target: qemu-amd64
+    test_function: swupdate-reboot-without-confirm
+
+test:qemu-arm64-swupdate-reboot-without-confirm:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-arm64-base"]
+  variables:
+    target: qemu-arm64
+    test_function: swupdate-reboot-without-confirm
+
+test:qemu-arm-swupdate-reboot-without-confirm:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-arm-base"]
+  variables:
+    target: qemu-arm
+    test_function: swupdate-reboot-without-confirm
+
+test:qemu-amd64-swupdate-apply-same-image-swu:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-amd64-base"]
+  variables:
+    target: qemu-amd64
+    test_function: swupdate-apply-same-image-swu
+
+test:qemu-arm64-swupdate-apply-same-image-swu:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-arm64-base"]
+  variables:
+    target: qemu-arm64
+    test_function: swupdate-apply-same-image-swu
+
+test:qemu-arm-swupdate-apply-same-image-swu:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-arm-base"]
+  variables:
+    target: qemu-arm
+    test_function: swupdate-apply-same-image-swu
+
 cve-checks:
   stage: cve-check
   needs: []
-- 
2.39.2



