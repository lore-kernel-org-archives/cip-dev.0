Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F54C02194
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 15:08:03 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.71482.1738940881345571532
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Feb 2025 07:08:01 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 517F7x1L3279646; Sat, 8 Feb 2025 00:07:59 +0900
X-Iguazu-Qid: 2yAbuzQy0fvUKlC3Bw
X-Iguazu-QSIG: v=2; s=0; t=1738940879; q=2yAbuzQy0fvUKlC3Bw; m=bxdCF7j4Gh5DKST1UH8GlGc8563sbM9IqjqiQIyQEkw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 517F7wAi1816199
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 8 Feb 2025 00:07:58 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v1 5/5] .gitlab-ci.yml: Add test targets for M-COM x86
Date: Fri,  7 Feb 2025 20:34:39 +0530
X-TSB-HOP2: ON
Message-Id: <20250207150439.392479-6-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250207150439.392479-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20250207150439.392479-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Feb 2025 15:07:53.0110 (UTC) FILETIME=[0F83F360:01DB7972]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Feb 2025 15:08:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17776

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 .gitlab-ci.yml | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2e3054c..4df521b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -359,6 +359,14 @@ test:qemu-arm-secure-boot:
     target: qemu-arm
     test_function: secure-boot
 
+test:x86-uefi-secure-boot:
+  extends:
+    - .test-cip-core
+  needs: ["build:x86-uefi-secure-boot"]
+  variables:
+    target: x86-uefi
+    test_function: secure-boot
+
 test:qemu-amd64-swupdate:
   extends:
     - .test-cip-core
@@ -383,6 +391,14 @@ test:qemu-arm-swupdate:
     target: qemu-arm
     test_function: swupdate
 
+test:x86-uefi-swupdate:
+  extends:
+    - .test-cip-core
+  needs: ["build:x86-uefi-secure-boot"]
+  variables:
+    target: x86-uefi
+    test_function: swupdate
+
 test:qemu-amd64-swupdate-kernel-panic:
   extends:
     - .test-cip-core
@@ -423,6 +439,14 @@ test:qemu-arm-IEC:
     target: qemu-arm
     test_function: IEC
 
+test:x86-uefi-IEC:
+  extends:
+   - .test-cip-core
+  needs: ["build:x86-uefi-secure-boot"]
+  variables:
+    target: x86-uefi
+    test_function: IEC
+
 cve-checks:
   stage: cve-check
   needs: []
-- 
2.30.2



