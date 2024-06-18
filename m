Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A4DC41513
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 16:10:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.90720.1718727051457984860
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jun 2024 09:10:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 45IGAm2l2986366; Wed, 19 Jun 2024 01:10:48 +0900
X-Iguazu-Qid: 2rWhyQ028tnf8mw3Ga
X-Iguazu-QSIG: v=2; s=0; t=1718727048; q=2rWhyQ028tnf8mw3Ga; m=uX8D6AqPe14RevAIt8R5KOB8rtvBUSTPIVlcmSz/m5c=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 45IGAlc2454227
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 01:10:48 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v1 3/3] .gitlab-ci.yml: Add relevant qemu target in 'needs' for test targets
Date: Tue, 18 Jun 2024 21:40:35 +0530
X-TSB-HOP2: ON
Message-Id: <20240618161035.1810237-4-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240618161035.1810237-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20240618161035.1810237-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 18 Jun 2024 16:10:34.0271 (UTC) FILETIME=[0CAE12F0:01DAC19A]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jun 2024 16:10:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16287

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 .gitlab-ci.yml | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b567556..a283429 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -352,7 +352,6 @@ build:qemu-riscv64:
     - if: $CI_PIPELINE_SOURCE == "schedule"
       when: never
     - if: $CI_COMMIT_BRANCH != "master"
-  needs: ["build:qemu-amd64-base","build:qemu-arm64-base","build:qemu-arm-base"]
   tags:
     - small
   allow_failure: true
@@ -370,6 +369,7 @@ build:qemu-riscv64:
 test:qemu-amd64-secure-boot:
   extends:
     - .test-cip-core
+  needs: ["build:qemu-amd64-base"]
   variables:
     target: qemu-amd64
     test_function: secure-boot
@@ -377,6 +377,7 @@ test:qemu-amd64-secure-boot:
 test:qemu-arm64-secure-boot:
   extends:
     - .test-cip-core
+  needs: ["build:qemu-arm64-base"]
   variables:
     target: qemu-arm64
     test_function: secure-boot
@@ -384,6 +385,7 @@ test:qemu-arm64-secure-boot:
 test:qemu-arm-secure-boot:
   extends:
     - .test-cip-core
+  needs: ["build:qemu-arm-base"]
   variables:
     target: qemu-arm
     test_function: secure-boot
@@ -391,6 +393,7 @@ test:qemu-arm-secure-boot:
 test:qemu-amd64-swupdate:
   extends:
     - .test-cip-core
+  needs: ["build:qemu-amd64-base"]
   variables:
     target: qemu-amd64
     test_function: swupdate
@@ -398,6 +401,7 @@ test:qemu-amd64-swupdate:
 test:qemu-arm64-swupdate:
   extends:
     - .test-cip-core
+  needs: ["build:qemu-arm64-base"]
   variables:
     target: qemu-arm64
     test_function: swupdate
@@ -405,6 +409,7 @@ test:qemu-arm64-swupdate:
 test:qemu-arm-swupdate:
   extends:
     - .test-cip-core
+  needs: ["build:qemu-arm-base"]
   variables:
     target: qemu-arm
     test_function: swupdate
@@ -412,6 +417,7 @@ test:qemu-arm-swupdate:
 test:qemu-amd64-swupdate-kernel-panic:
   extends:
     - .test-cip-core
+  needs: ["build:qemu-amd64-base"]
   variables:
     target: qemu-amd64
     test_function: kernel-panic
@@ -419,6 +425,7 @@ test:qemu-amd64-swupdate-kernel-panic:
 test:qemu-amd64-swupdate-initramfs-crash:
   extends:
     - .test-cip-core
+  needs: ["build:qemu-amd64-base"]
   variables:
     target: qemu-amd64
     test_function: initramfs-crash
@@ -426,6 +433,7 @@ test:qemu-amd64-swupdate-initramfs-crash:
 test:qemu-amd64-IEC:
   extends:
    - .test-cip-core
+  needs: ["build:qemu-amd64-base"]
   variables:
     target: qemu-amd64
     test_function: IEC
@@ -433,6 +441,7 @@ test:qemu-amd64-IEC:
 test:qemu-arm64-IEC:
   extends:
    - .test-cip-core
+  needs: ["build:qemu-arm64-base"]
   variables:
     target: qemu-arm64
     test_function: IEC
@@ -440,6 +449,7 @@ test:qemu-arm64-IEC:
 test:qemu-arm-IEC:
   extends:
    - .test-cip-core
+  needs: ["build:qemu-arm-base"]
   variables:
     target: qemu-arm
     test_function: IEC
-- 
2.30.2



