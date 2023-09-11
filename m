Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825E2EEB58C
	for <webhook@archiver.kernel.org>; Mon, 11 Sep 2023 13:32:01 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.58427.1694439114247851976
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Sep 2023 06:31:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 38BDVq2a3930803; Mon, 11 Sep 2023 22:31:52 +0900
X-Iguazu-Qid: 2rWgLYQMf54wBpwWOm
X-Iguazu-QSIG: v=2; s=0; t=1694439111; q=2rWgLYQMf54wBpwWOm; m=PTsNzoNUQeeBTY1SaakZQOX/vpBK2Z86lb9iLGDw6ZY=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 38BDVoI53612988
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 11 Sep 2023 22:31:51 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 4/5] .reproducible-check-ci.yml: Add BBB target
Date: Mon, 11 Sep 2023 19:01:46 +0530
X-TSB-HOP2: ON
Message-Id: <20230911133147.3164-5-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230911133147.3164-1-venkata.pyla@toshiba-tsip.com>
References: <20230911133147.3164-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Sep 2023 13:31:46.0989 (UTC) FILETIME=[4FE675D0:01D9E4B4]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Sep 2023 13:32:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13022

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .reproducible-check-ci.yml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index dec28e2..6bcc215 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -87,6 +87,13 @@ build:qemu-arm-repro-build:
   variables:
     target: qemu-arm
 
+build:bbb-repro-build:
+  extends:
+    - .repro-build
+  variables:
+    target: bbb
+    extension: "none"
+
 # repro build test
 test:qemu-amd64-repro-test:
   extends:
@@ -111,3 +118,12 @@ test:qemu-arm-repro-test:
     target: qemu-arm
   dependencies:
     - build:qemu-arm-repro-build
+
+test:bbb-repro-test:
+  extends:
+    - .repro-test
+  variables:
+    target: bbb
+    extension: "none"
+  dependencies:
+    - build:bbb-repro-build
-- 
2.20.1



