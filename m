Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96071C04E69
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 09:17:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.103793.1692004639309584896
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Aug 2023 02:17:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 37E9HHtR785136; Mon, 14 Aug 2023 18:17:17 +0900
X-Iguazu-Qid: 2yAb9zVTgIo6Z2OCgb
X-Iguazu-QSIG: v=2; s=0; t=1692004637; q=2yAb9zVTgIo6Z2OCgb; m=b2WijRDShT/Ya1ojVwLQTCaiy/MWXPIaqZqxMC7PkRE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 37E9HGVP610542
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 14 Aug 2023 18:17:17 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 2/4] .reproducible-check-ci: Include individual file system images
Date: Mon, 14 Aug 2023 14:47:12 +0530
X-TSB-HOP2: ON
Message-Id: <20230814091714.9400-3-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230814091714.9400-1-venkata.pyla@toshiba-tsip.com>
References: <20230814091714.9400-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Aug 2023 09:17:14.0005 (UTC) FILETIME=[1CED0C50:01D9CE90]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 09:17:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12627

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Now include individual file system images instead of their contents in
reproducible check CI.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .reproducible-check-ci.yml |  7 +------
 scripts/repro-tests.sh     | 14 +++++++-------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index 6782eea..5628b1b 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -40,12 +40,7 @@
     expire_in: 1 day
     paths:
       - scripts/repro-tests.sh
-      - image*/*initrd.img
-      - image*/*-vmlinu*
-      - image*/*.tar.gz
-      - image*/*.squashfs
-      - image*/*.swu
-      - image*/linux.efi
+      - image*/*.wic.p*
 
 .repro-test:
   image:
diff --git a/scripts/repro-tests.sh b/scripts/repro-tests.sh
index 94de950..ec3b1e4 100755
--- a/scripts/repro-tests.sh
+++ b/scripts/repro-tests.sh
@@ -65,13 +65,13 @@ fi
 
 # Define files in the artifacts for checking the reproducibility
 set -- \
-	"${IMAGE_BASE}-${RELEASE}-${TARGET}-vmlinuz" \
-	"${IMAGE_BASE}-${RELEASE}-${TARGET}-vmlinux" \
-	"${IMAGE_BASE}-${RELEASE}-${TARGET}-initrd.img" \
-	"${IMAGE_BASE}-${RELEASE}-${TARGET}.tar.gz" \
-	"linux.efi" \
-	"${IMAGE_BASE}-${RELEASE}-${TARGET}.swu" \
-	"${IMAGE_BASE}-${RELEASE}-${TARGET}.squashfs" \
+	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p1" \
+	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p2" \
+	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p3" \
+	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p4" \
+	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p5" \
+	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p6" \
+	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p7"
 
 # compare artifacts
 res=0
-- 
2.20.1



