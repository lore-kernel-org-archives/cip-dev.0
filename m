Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB72C001DF
	for <webhook@archiver.kernel.org>; Fri,  7 Jul 2023 14:16:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.13565.1688739360968936443
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jul 2023 07:16:01 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 367EFvKj1368931; Fri, 7 Jul 2023 23:15:58 +0900
X-Iguazu-Qid: 2rWhQ1EpXpMK0x3Onh
X-Iguazu-QSIG: v=2; s=0; t=1688739357; q=2rWhQ1EpXpMK0x3Onh; m=i8LC+jntaBN0K4OxxPTNJpBpgWQo5m/1/hDIhUy5mOA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 367EFuUT1303710
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 7 Jul 2023 23:15:57 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v3 1/8] .reproducible-check-ci.yml: Include swupdate artifacts in reproducible check
Date: Fri,  7 Jul 2023 19:45:43 +0530
X-TSB-HOP2: ON
Message-Id: <20230707141550.27805-2-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <176E5CF032D87010.7887@lists.cip-project.org>
References: <176E5CF032D87010.7887@lists.cip-project.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Jul 2023 14:15:54.0230 (UTC) FILETIME=[8A83E160:01D9B0DD]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jul 2023 14:16:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12265

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Till now minimal images are verified against the reproducible build checks,
now extend the verification to swupdate feature.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .reproducible-check-ci.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index d8bfb40..f4250ce 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -69,18 +69,24 @@ build:qemu-amd64-base-repro-build:
     - .repro-build
   variables:
     target: qemu-amd64
+    extension: ebg-swu
+    wic_targz: enable
 
 build:qemu-arm64-base-repro-build:
   extends:
     - .repro-build
   variables:
     target: qemu-arm64
+    extension: ebg-swu
+    wic_targz: enable
 
 build:qemu-arm-base-repro-build:
   extends:
     - .repro-build
   variables:
     target: qemu-arm
+    extension: ebg-swu
+    wic_targz: enable
 
 # repro build test
 test:qemu-amd64-base-repro-test:
-- 
2.20.1



