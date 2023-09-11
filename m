Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644FCEEB580
	for <webhook@archiver.kernel.org>; Mon, 11 Sep 2023 13:32:01 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.58502.1694439113272338093
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Sep 2023 06:31:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 38BDVo1d4004639; Mon, 11 Sep 2023 22:31:50 +0900
X-Iguazu-Qid: 2rWgSWj5NCjynch5AP
X-Iguazu-QSIG: v=2; s=0; t=1694439109; q=2rWgSWj5NCjynch5AP; m=3YWGVQHNIZjj1T13myVdMxgS5esq33bJuKwX6326FQo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 38BDVmg64133164
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 11 Sep 2023 22:31:49 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 1/5] .reproducible-check-ci.yml: Set default values in base job
Date: Mon, 11 Sep 2023 19:01:43 +0530
X-TSB-HOP2: ON
Message-Id: <20230911133147.3164-2-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230911133147.3164-1-venkata.pyla@toshiba-tsip.com>
References: <20230911133147.3164-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Sep 2023 13:31:46.0754 (UTC) FILETIME=[4FC29A20:01D9E4B4]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Sep 2023 13:32:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13020

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

The 'wic_targz' and 'extension' values will be same for all repro-build
targets so define them in the base job `report-build`

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .reproducible-check-ci.yml | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index 5628b1b..75c8cef 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -13,13 +13,14 @@
 .repro-build:
   variables:
     use_rt: disable
-    wic_targz: disable
-    targz: enable
+    wic_targz: enable
+    targz: disable
     deploy: disable
     deploy_kernelci: disable
     artifact_suffix: ".tar.gz"
     base_yaml: "kas-cip.yml:kas/board/${target}.yml"
     release: bookworm
+    extension: ebg-swu
   stage: build
   tags:
     - large
@@ -71,24 +72,18 @@ build:qemu-amd64-repro-build:
     - .repro-build
   variables:
     target: qemu-amd64
-    extension: ebg-swu
-    wic_targz: enable
 
 build:qemu-arm64-repro-build:
   extends:
     - .repro-build
   variables:
     target: qemu-arm64
-    extension: ebg-swu
-    wic_targz: enable
 
 build:qemu-arm-repro-build:
   extends:
     - .repro-build
   variables:
     target: qemu-arm
-    extension: ebg-swu
-    wic_targz: enable
 
 # repro build test
 test:qemu-amd64-repro-test:
-- 
2.20.1



