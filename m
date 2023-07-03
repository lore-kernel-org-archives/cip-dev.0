Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE83C001B0
	for <webhook@archiver.kernel.org>; Mon,  3 Jul 2023 06:22:40 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.21486.1688365357439331981
 for <cip-dev@lists.cip-project.org>;
 Sun, 02 Jul 2023 23:22:38 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 3636MZCM525454; Mon, 3 Jul 2023 15:22:36 +0900
X-Iguazu-Qid: 2yAbS7mhcmrI1NkNS6
X-Iguazu-QSIG: v=2; s=0; t=1688365355; q=2yAbS7mhcmrI1NkNS6; m=fHJEKdfx/KdiYpEQgp0O65fBYaNif2vSDo88qlcRcac=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 3636MYr11122212
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 3 Jul 2023 15:22:35 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 3/6] .reproducible-check-ci.yml: Include only files required for RB check
Date: Mon,  3 Jul 2023 11:52:28 +0530
X-TSB-HOP2: ON
Message-Id: <20230703062231.18183-4-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <176C1D7D866704FB.6977@lists.cip-project.org>
References: <176C1D7D866704FB.6977@lists.cip-project.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 03 Jul 2023 06:22:31.0671 (UTC) FILETIME=[BF9E5070:01D9AD76]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jul 2023 06:22:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12172

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

artifacts folder contains many other files like dpkg_status, manifest,
etc, which are not verified in reproducible check, so include only the
files are used in reproducible check.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .reproducible-check-ci.yml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index f19bd2c..88644a7 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -40,8 +40,12 @@
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



