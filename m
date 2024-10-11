Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D15D24464
	for <webhook@archiver.kernel.org>; Fri, 11 Oct 2024 01:55:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.1949.1728611699528994214
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Oct 2024 18:54:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=Kvry1rQA;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=
	1728611697;x=1729821297;bh=3OJHhyecU98K4+1jRwv/3IeqIbH38GlSh2ol7Y+TqSo=;b=Kvr
	y1rQACrNVidPnXInA+9ykVkj0FAuF/7wJBSI70r+5VexYGJ9upRaz5Kw1CLwPxQTTn9ssVALrgpif
	QietHa8k4A7S2QKhmenPViiqtw6KSCUrpR1RQ60EL/o7g/aHjgWDcL6sLvFGGz9QudXGadS1v4KRT
	Lg5QfXBEdRWiqAmpxnBqrKipKxXGfqmyXX1xKYVCXJs1GKEud6q5FYTaxUAMps+ChsczllibEn6dR
	lvZGe11NeUu5iP/pNh1Py87MBaehg/fGFlCSW1w0O3oi98nvi4TrH/Q5o6vvV9mggtlaEFU/IFviK
	gA1Esu/kF3bad3HFoJaXBGqa/I/1iBw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 49B1svJb2376816; Fri, 11 Oct 2024 10:54:57 +0900
X-Iguazu-Qid: 2rWg67yesp5IQlflmz
X-Iguazu-QSIG: v=2; s=0; t=1728611697; q=2rWg67yesp5IQlflmz; m=teFCF+5ncu4+7R+HbCMG56fDlOVCkWtZDVDLyTNgrkc=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 49B1suUn2631720
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 10:54:56 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [isar-cip-core][PATCH] recipes-core: ltp: Update to 20240930
Date: Fri, 11 Oct 2024 10:54:48 +0900
X-TSB-HOP2: ON
Message-Id: <1728611688-13663-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Oct 2024 01:55:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17027

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 recipes-core/ltp/{ltp-full_20240524.bb => ltp-full_20240930.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-core/ltp/{ltp-full_20240524.bb => ltp-full_20240930.bb} (69%)

diff --git a/recipes-core/ltp/ltp-full_20240524.bb b/recipes-core/ltp/ltp-full_20240930.bb
similarity index 69%
rename from recipes-core/ltp/ltp-full_20240524.bb
rename to recipes-core/ltp/ltp-full_20240930.bb
index 1ec0974..95828ee 100644
--- a/recipes-core/ltp/ltp-full_20240524.bb
+++ b/recipes-core/ltp/ltp-full_20240930.bb
@@ -11,4 +11,4 @@
 
 require recipes-core/ltp/ltp.inc
 
-SRC_URI[sha256sum] = "2b7c07bb281b7ec49981eeb06c4b66f147b103977254632678d384034f6e9663"
+SRC_URI[sha256sum] = "3e9e806405aa602e2d21d221d885fd4914ff2da23eb8bba3d0f0f468bdf60238"
-- 
2.45.2



