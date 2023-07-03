Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CA9C001DE
	for <webhook@archiver.kernel.org>; Mon,  3 Jul 2023 06:22:40 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.21485.1688365357306510086
 for <cip-dev@lists.cip-project.org>;
 Sun, 02 Jul 2023 23:22:38 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 3636MZd43084634; Mon, 3 Jul 2023 15:22:35 +0900
X-Iguazu-Qid: 2rWhDvohsD3xND92jp
X-Iguazu-QSIG: v=2; s=0; t=1688365355; q=2rWhDvohsD3xND92jp; m=VlK4GtRhjefWUsZcKoNFNRmxymIwYpJX25j1JP9dx2A=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 3636MYBX1114363
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 3 Jul 2023 15:22:34 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 1/6] .reproducible-check-ci.yml: Include swupdate artifacts in reproducible check
Date: Mon,  3 Jul 2023 11:52:26 +0530
X-TSB-HOP2: ON
Message-Id: <20230703062231.18183-2-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <176C1D7D866704FB.6977@lists.cip-project.org>
References: <176C1D7D866704FB.6977@lists.cip-project.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 03 Jul 2023 06:22:31.0546 (UTC) FILETIME=[BF8B3DA0:01D9AD76]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jul 2023 06:22:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12174

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Till now minimal images are verified against the reproducible build checks,
now extend the verification to swupdate feature.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .reproducible-check-ci.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index 6eb82ea..021d4ef 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -71,18 +71,24 @@ build:qemu-amd64-base-repro-build:
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



