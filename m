Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6B5EB64D7
	for <webhook@archiver.kernel.org>; Fri, 23 Jun 2023 14:06:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web11.42921.1687529167251418082
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Jun 2023 07:06:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.153, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 35NE64Wi025736; Fri, 23 Jun 2023 23:06:05 +0900
X-Iguazu-Qid: 34trEg1Q9Jc7UnDFbc
X-Iguazu-QSIG: v=2; s=0; t=1687529164; q=34trEg1Q9Jc7UnDFbc; m=VxFR0P+vZjqYl90WqwV5XLBzZkyScooFDOQjd8rBCLU=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1511) id 35NE632g032528
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 23 Jun 2023 23:06:04 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 2/3] .reproducible-check-ci.yml: Include only files required for RB check
Date: Fri, 23 Jun 2023 19:35:54 +0530
X-TSB-HOP2: ON
Message-Id: <20230623140555.11428-3-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230623140555.11428-1-venkata.pyla@toshiba-tsip.com>
References: <20230623140555.11428-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Jun 2023 14:05:59.0535 (UTC) FILETIME=[D6441FF0:01D9A5DB]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Jun 2023 14:06:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12146

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

artifacts folder contains many other files like dpkg_status, manifest,
etc, which are not verified in reproducible check, so include only the
files are used in reproducible check.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .reproducible-check-ci.yml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index 5ea7857..ede358b 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -39,8 +39,12 @@
     expire_in: 1 day
     paths:
       - scripts/repro-tests.sh
-      - image1
-      - image2
+      - image*/*initrd.img
+      - image*/*-vmlinu*
+      - image*/*.tar.gz
+      - image*/*.squashfs
+      - image*/*.swu
+      - image*/linux.efi
 
 .repro-test:
   image:
-- 
2.20.1



