Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F76C04E69
	for <webhook@archiver.kernel.org>; Fri,  7 Jul 2023 14:16:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.13304.1688739361454230637
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jul 2023 07:16:01 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 367EG0Qd1354923; Fri, 7 Jul 2023 23:16:00 +0900
X-Iguazu-Qid: 2rWhc6jYwBz6gXWVZx
X-Iguazu-QSIG: v=2; s=0; t=1688739359; q=2rWhc6jYwBz6gXWVZx; m=bDZMK8NKGIc1alMYe2/+c5nz94ppiejuxxahUmgtwsI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 367EFwnS1298415
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 7 Jul 2023 23:15:59 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v3 5/8] squashfs.bbclass: Fix file timestamps are not reproducible in squashfs image
Date: Fri,  7 Jul 2023 19:45:47 +0530
X-TSB-HOP2: ON
Message-Id: <20230707141550.27805-6-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <176E5CF032D87010.7887@lists.cip-project.org>
References: <176E5CF032D87010.7887@lists.cip-project.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Jul 2023 14:15:54.0558 (UTC) FILETIME=[8AB5EDE0:01D9B0DD]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jul 2023 14:16:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12267

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

The generated squashfs image contains non-reproducible file timestamps,
so set with value in SOURCE_DATE_EPOCH variable if it is set.

Closes: #68

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 classes/squashfs.bbclass | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
index b39be0c..bf72133 100644
--- a/classes/squashfs.bbclass
+++ b/classes/squashfs.bbclass
@@ -31,6 +31,12 @@ SQUASHFS_MEMLIMIT ?= "${@int(get_free_mem() * 3/4)}"
 SQUASHFS_CREATION_LIMITS = "-mem ${SQUASHFS_MEMLIMIT} -processors ${SQUASHFS_THREADS}"
 
 python __anonymous() {
+    # Set file timestamps for reproducible builds
+    source_date_epoch = d.getVar('SOURCE_DATE_EPOCH')
+    if source_date_epoch:
+        args = " -fstime {time}".format(time=source_date_epoch)
+        d.appendVar('SQUASHFS_CREATION_ARGS', args)
+
     exclude_directories = d.getVar('SQUASHFS_EXCLUDE_DIRS').split()
     if len(exclude_directories) == 0:
         return
-- 
2.20.1



