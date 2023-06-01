Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFA9C7EE2F
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 07:35:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.25351.1685604903233015160
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 00:35:03 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.153, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 3517Z1sj024433; Thu, 1 Jun 2023 16:35:01 +0900
X-Iguazu-Qid: 34trKxHUsml51TzDof
X-Iguazu-QSIG: v=2; s=0; t=1685604901; q=34trKxHUsml51TzDof; m=VMEn5ws5X2j867a22zcFY422k2X5Xqx7uvleFfNpxPg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1513) id 3517Z0Mk011997
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 1 Jun 2023 16:35:00 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 2/3] .reproducible-check-ci.yml: use ext4 images in reproducible build checks
Date: Thu,  1 Jun 2023 13:04:53 +0530
X-TSB-HOP2: ON
Message-Id: <20230601073454.1896-3-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230601073454.1896-1-venkata.pyla@toshiba-tsip.com>
References: <20230601073454.1896-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Jun 2023 07:34:55.0696 (UTC) FILETIME=[8FA3ED00:01D9945B]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 07:35:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11718

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Till now we are using tarball images in reproducible checks and with
this commit we are also verifying ext4 file system images in
reproducible check CI.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .reproducible-check-ci.yml | 7 +++++++
 scripts/repro-tests.sh     | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index d8bfb40..98f76d1 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -69,18 +69,24 @@ build:qemu-amd64-base-repro-build:
     - .repro-build
   variables:
     target: qemu-amd64
+    targz: disable
+    extension: ext4-targz-img
 
 build:qemu-arm64-base-repro-build:
   extends:
     - .repro-build
   variables:
     target: qemu-arm64
+    targz: disable
+    extension: ext4-targz-img
 
 build:qemu-arm-base-repro-build:
   extends:
     - .repro-build
   variables:
     target: qemu-arm
+    targz: disable
+    extension: ext4-targz-img
 
 # repro build test
 test:qemu-amd64-base-repro-test:
@@ -106,3 +112,4 @@ test:qemu-arm-base-repro-test:
     target: qemu-arm
   dependencies:
     - build:qemu-arm-base-repro-build
+
diff --git a/scripts/repro-tests.sh b/scripts/repro-tests.sh
index f767839..7c44567 100755
--- a/scripts/repro-tests.sh
+++ b/scripts/repro-tests.sh
@@ -69,6 +69,7 @@ set -- \
 	"${IMAGE_BASE}-${RELEASE}-${TARGET}-vmlinux" \
 	"${IMAGE_BASE}-${RELEASE}-${TARGET}-initrd.img" \
 	"${IMAGE_BASE}-${RELEASE}-${TARGET}.tar.gz" \
+	"${IMAGE_BASE}-${RELEASE}-${TARGET}.ext4" \
 	"linux.efi" \
 	"${IMAGE_BASE}-${RELEASE}-${TARGET}.swu" \
 	"${IMAGE_BASE}-${RELEASE}-${TARGET}.squashfs" \
@@ -88,4 +89,4 @@ for file in "$@"; do
 	fi
 done
 
-exit $res
\ No newline at end of file
+exit $res
-- 
2.20.1



