Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F24C04A6A
	for <webhook@archiver.kernel.org>; Fri,  7 Jul 2023 14:16:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.13566.1688739361013637516
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jul 2023 07:16:01 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 367EFxJT1368958; Fri, 7 Jul 2023 23:15:59 +0900
X-Iguazu-Qid: 2rWhDvohsKQ5nijhmy
X-Iguazu-QSIG: v=2; s=0; t=1688739358; q=2rWhDvohsKQ5nijhmy; m=sWqtZ0O8Y9SmFxzS7rbJOkgukWjgGbf84vm6VJCEqq0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 367EFv6b1727332
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 7 Jul 2023 23:15:58 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v3 3/8] .reproducible-check-ci.yml: Include only files required for RB check
Date: Fri,  7 Jul 2023 19:45:45 +0530
X-TSB-HOP2: ON
Message-Id: <20230707141550.27805-4-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <176E5CF032D87010.7887@lists.cip-project.org>
References: <176E5CF032D87010.7887@lists.cip-project.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Jul 2023 14:15:54.0387 (UTC) FILETIME=[8A9BD630:01D9B0DD]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jul 2023 14:16:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12266

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

artifacts folder contains many other files like dpkg_status, manifest,
etc, which are not verified in reproducible check, so include only the
files are used in reproducible check.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .reproducible-check-ci.yml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index a9e3996..079b53d 100644
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



