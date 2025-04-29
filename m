Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773E9C3ABA5
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 04:29:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.7904.1745900988390637364
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Apr 2025 21:29:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 53T4TkpP4064245; Tue, 29 Apr 2025 13:29:46 +0900
X-Iguazu-Qid: 2rWhyCKR6sL2LpG0Wm
X-Iguazu-QSIG: v=2; s=0; t=1745900985; q=2rWhyCKR6sL2LpG0Wm; m=PKDkz5Y5onmsXPiiY6NbE192WwTphuEUIiUPfZfFjmQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 53T4ThfW1137375
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 13:29:45 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai.sathujoda@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1 3/3] .gitlab-ci.yml: Add job to verify amd64 secure boot keys mismatch case
Date: Tue, 29 Apr 2025 09:50:28 +0530
X-TSB-HOP2: ON
Message-Id: <20250429042028.3579304-4-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250429042028.3579304-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20250429042028.3579304-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 29 Apr 2025 04:29:40.0193 (UTC) FILETIME=[529E4510:01DBB8BF]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 04:29:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18706

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 .gitlab-ci.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2c1deaa..ca52a05 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -508,6 +508,14 @@ test:qemu-arm-secure-boot-unsigned-bootloader:
     target: qemu-arm
     test_function: secure-boot-unsigned-bootloader
 
+test:qemu-amd64-secure-boot-mismatch-keys:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-amd64-base"]
+  variables:
+    target: qemu-amd64
+    test_function: secure-boot-mismatch-keys
+
 test:qemu-amd64-swupdate-corrupt-swu:
   extends:
     - .test-cip-core
-- 
2.39.2



