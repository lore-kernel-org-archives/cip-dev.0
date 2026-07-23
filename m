Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3734DC44524
	for <webhook@archiver.kernel.org>; Thu, 23 Jul 2026 05:19:57 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17372.1784783994593958354
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2026 22:19:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 66N5Jpch3941046; Thu, 23 Jul 2026 14:19:52 +0900
X-Iguazu-Qid: 2rWh1q7vhFRlAEALo2
X-Iguazu-QSIG: v=2; s=1; t=1784783991; q=2rWh1q7vhFRlAEALo2; m=AAfiqTO3rFuqPbBbCapm+qNgQX/r1Lzec+4ns6jLB2g=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h5KF31WJRz4vys; Thu, 23 Jul 2026 14:19:50 +0900 (JST)
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        kazuhiro.hayashi.f74@mail.toshiba, kumar.dinesh.h95@mail.toshiba
Subject: [isar-cip-core][PATCH] .gitlab-ci.yml: Override default release with sid
Date: Thu, 23 Jul 2026 10:36:34 +0530
X-TSB-HOP2: ON
Message-Id: <20260723050634.2447684-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Jul 2026 05:19:48.0124 (UTC) FILETIME=[E15F9DC0:01DD1A62]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Jul 2026 05:19:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23722

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

By default, the release is set to trixie, pass release as sid to
override it for trixie based test targets.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 .gitlab-ci.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 5a20ad6..b53def4 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -740,6 +740,7 @@ test:qemu-amd64-IEC-sid:
    - .test-cip-core-sid
   variables:
     target: qemu-amd64
+    release: sid
     test_function: IEC
     iec_test_timeout: 40
 
@@ -749,6 +750,7 @@ test:qemu-arm64-IEC-sid:
   needs: ["build:qemu-arm64-base-sid"]
   variables:
     target: qemu-arm64
+    release: sid
     test_function: IEC
     iec_test_timeout: 40
 
@@ -758,6 +760,7 @@ test:qemu-arm-IEC-sid:
   needs: ["build:qemu-arm-base-sid"]
   variables:
     target: qemu-arm
+    release: sid
     test_function: IEC
     iec_test_timeout: 40
 
-- 
2.39.5



