Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0B7EB64DB
	for <webhook@archiver.kernel.org>; Tue, 20 Jun 2023 13:57:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.10924.1687269426044712120
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Jun 2023 06:57:06 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.157, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 35KDv3Dx014522; Tue, 20 Jun 2023 22:57:03 +0900
X-Iguazu-Qid: 2wHHJG9eOnqDYrQpFI
X-Iguazu-QSIG: v=2; s=0; t=1687269423; q=2wHHJG9eOnqDYrQpFI; m=w9RePoh48+1mSxsLICYIt9rrEAkNG3HsPfyAe1PxIJo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1113) id 35KDv2pj035061
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 20 Jun 2023 22:57:02 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] kas-cip.yml: Update isar reference
Date: Tue, 20 Jun 2023 19:26:57 +0530
X-TSB-HOP2: ON
Message-Id: <20230620135657.4585-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Jun 2023 13:57:00.0729 (UTC) FILETIME=[15DF9A90:01D9A37F]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 Jun 2023 13:57:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12085

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

To bring the reproducible build issue fixes from the upstream
 e.g.: vmlinux files are not reproducible in case of arm architectures

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index b6a3ded..454fe04 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: f95f69d3b83cc28976ef81eeefb5ec5dd17e544f
+    refspec: d2b961746be788f0f35f8297ed3a8d2292704a4c
     layers:
       meta:
 
-- 
2.20.1



