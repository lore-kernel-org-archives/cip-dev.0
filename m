Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C59FEB64DA
	for <webhook@archiver.kernel.org>; Fri,  7 Jul 2023 14:16:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.13572.1688739364379396865
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jul 2023 07:16:04 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 367EG3gA1369033; Fri, 7 Jul 2023 23:16:03 +0900
X-Iguazu-Qid: 2rWhuF4KgeSZyVshaV
X-Iguazu-QSIG: v=2; s=0; t=1688739362; q=2rWhuF4KgeSZyVshaV; m=x7OR3ZD9mSxdg9W5ASz+Ku53wpGAn7hWhiG5OXKnfq0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 367EG1mE1727357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 7 Jul 2023 23:16:02 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v3 8/8] kas-cip.yml: Update isar reference
Date: Fri,  7 Jul 2023 19:45:50 +0530
X-TSB-HOP2: ON
Message-Id: <20230707141550.27805-9-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <176E5CF032D87010.7887@lists.cip-project.org>
References: <176E5CF032D87010.7887@lists.cip-project.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Jul 2023 14:15:54.0730 (UTC) FILETIME=[8AD02CA0:01D9B0DD]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jul 2023 14:16:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12272

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

It brings the fix for arm linux files are not build reproducibly

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index b6a3ded..ffaf04a 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: f95f69d3b83cc28976ef81eeefb5ec5dd17e544f
+    refspec: 478f3c324f50eca0d082cd1c8f23ef50e28071fb
     layers:
       meta:
 
-- 
2.20.1



