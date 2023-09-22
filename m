Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915CCE7D0B1
	for <webhook@archiver.kernel.org>; Fri, 22 Sep 2023 12:23:32 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.19766.1695385407791112331
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Sep 2023 05:23:28 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 38MCNO6Y1684833; Fri, 22 Sep 2023 21:23:25 +0900
X-Iguazu-Qid: 2rWgbWvS0QnePb19Tk
X-Iguazu-QSIG: v=2; s=0; t=1695385404; q=2rWgbWvS0QnePb19Tk; m=lZa5ToYRKf3wNidmC59Cl6Zck5gGAhzNKfnbU7NzvqI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 38MCNMhA334830
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 22 Sep 2023 21:23:23 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] kas-cip.yml: Update Isar revision
Date: Fri, 22 Sep 2023 17:53:22 +0530
X-TSB-HOP2: ON
Message-Id: <20230922122322.3657-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Sep 2023 12:23:21.0582 (UTC) FILETIME=[936E50E0:01D9ED4F]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Sep 2023 12:23:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13208

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Brings following reproducible fixes
 - Remove core files generated in rootfs
 - clean blkid cache files

and some minor fixes.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 59d7ac2..a9f3897 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 478f3c324f50eca0d082cd1c8f23ef50e28071fb
+    commit: bf9c9fdd99bf26dca25fdf9e63b7eb5b053d962f
     layers:
       meta:
 
-- 
2.20.1



