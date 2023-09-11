Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653D3EEB581
	for <webhook@archiver.kernel.org>; Mon, 11 Sep 2023 13:32:01 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.58503.1694439113635634268
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Sep 2023 06:31:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 38BDVpC32060801; Mon, 11 Sep 2023 22:31:51 +0900
X-Iguazu-Qid: 2yAamNv3HFGkklX1t2
X-Iguazu-QSIG: v=2; s=0; t=1694439110; q=2yAamNv3HFGkklX1t2; m=QkPJsjM94RfbhAnbWe/w2875x9Hi87H4Tx/JU22MR44=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 38BDVnDA2379201
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 11 Sep 2023 22:31:50 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 2/5] .reproducible-check-ci.yml: Enable security target
Date: Mon, 11 Sep 2023 19:01:44 +0530
X-TSB-HOP2: ON
Message-Id: <20230911133147.3164-3-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230911133147.3164-1-venkata.pyla@toshiba-tsip.com>
References: <20230911133147.3164-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Sep 2023 13:31:46.0832 (UTC) FILETIME=[4FCE8100:01D9E4B4]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Sep 2023 13:32:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13021

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

This security extension image includes the following features
 * security customizations
 * swupdate
 * secure boot

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .reproducible-check-ci.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index 75c8cef..35acb01 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -20,7 +20,8 @@
     artifact_suffix: ".tar.gz"
     base_yaml: "kas-cip.yml:kas/board/${target}.yml"
     release: bookworm
-    extension: ebg-swu
+    # This target include base + swupdate + secureboot + security
+    extension: security
   stage: build
   tags:
     - large
-- 
2.20.1



