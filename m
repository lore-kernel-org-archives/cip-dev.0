Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF873C61DA4
	for <webhook@archiver.kernel.org>; Mon,  6 Feb 2023 11:51:13 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.133])
 by mx.groups.io with SMTP id smtpd.web11.51481.1675684269349634581
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Feb 2023 03:51:10 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.133, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 316Bp6w4002652; Mon, 6 Feb 2023 20:51:06 +0900
X-Iguazu-Qid: 2wGr5g72R0aDuyJQbz
X-Iguazu-QSIG: v=2; s=0; t=1675684265; q=2wGr5g72R0aDuyJQbz; m=S8k2rOlfn2XiSnXd4T1GPVTElTT/msIu0Mkko6wWGGw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1113) id 316Bp4Vw016619
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 6 Feb 2023 20:51:05 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] Update ISAR revision
Date: Mon,  6 Feb 2023 17:21:16 +0530
X-TSB-HOP2: ON
Message-Id: <20230206115118.930-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 06 Feb 2023 11:51:03.0527 (UTC) FILETIME=[4A139770:01D93A21]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Feb 2023 11:51:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10595

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index b970f39..049eca8 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: fc4f004eb67237d9d09b1ffad0de1a19217fa94a
+    refspec: 73f0cc16ca50f1102084851b1bc0f2d59925c9ad
     layers:
       meta:
 
-- 
2.20.1



