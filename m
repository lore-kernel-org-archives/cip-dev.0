Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDBCEE7FF4
	for <webhook@archiver.kernel.org>; Mon, 11 Sep 2023 13:32:01 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.58501.1694439112881168397
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Sep 2023 06:31:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 38BDVpSh4004664; Mon, 11 Sep 2023 22:31:51 +0900
X-Iguazu-Qid: 2rWgJRkMW8EkpEctgf
X-Iguazu-QSIG: v=2; s=0; t=1694439110; q=2rWgJRkMW8EkpEctgf; m=X5+txn9rNfzQI0yWoWXZsGYaML3MfANSXB0qbRCzSDA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 38BDVopO3610357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 11 Sep 2023 22:31:50 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 3/5] reproducible-check: Add option to pass extensions of the image
Date: Mon, 11 Sep 2023 19:01:45 +0530
X-TSB-HOP2: ON
Message-Id: <20230911133147.3164-4-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230911133147.3164-1-venkata.pyla@toshiba-tsip.com>
References: <20230911133147.3164-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Sep 2023 13:31:46.0832 (UTC) FILETIME=[4FCE8100:01D9E4B4]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Sep 2023 13:32:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13019

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Images build with extentions like `security` have different name than
base image, so prepare filename based on the extension passed to the
script.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .reproducible-check-ci.yml | 3 ++-
 scripts/repro-tests.sh     | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index 35acb01..dec28e2 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -55,10 +55,11 @@
   variables:
     GIT_STRATEGY: none
     release: bookworm
+    extension: security
   before_script:
     - apt update && DEBIAN_FRONTEND=noninteractive apt install -y diffoscope
   script:
-    - ./scripts/repro-tests.sh --release ${release} --target ${target} image1 image2
+    - ./scripts/repro-tests.sh --release ${release} --target ${target} --extension ${extension} image1 image2
   artifacts:
     when: always
     expire_in: 1 day
diff --git a/scripts/repro-tests.sh b/scripts/repro-tests.sh
index ab3dbce..2143058 100755
--- a/scripts/repro-tests.sh
+++ b/scripts/repro-tests.sh
@@ -31,6 +31,7 @@ GREEN='\033[0;32m'
 IMAGE_BASE="cip-core-image-cip-core"
 RELEASE="bullseye"
 TARGET="qemu-amd64"
+EXTENSION=""
 DIFFOSCOPE="diffoscope"
 
 while [ "$1" != "" ]; do
@@ -43,6 +44,10 @@ while [ "$1" != "" ]; do
 			TARGET="$2"
 			shift 2
 			;;
+		-e | --extension )
+			EXTENSION="$2"
+			shift 2
+			;;
 		-h | --help )
 			usage
 			exit
@@ -63,6 +68,10 @@ if [ -z "$artifacts1" ] || [ -z "$artifacts2" ]; then
 	exit 1
 fi
 
+if [ "${EXTENSION}" = "security" ]; then
+	IMAGE_BASE="cip-core-image-security-cip-core"
+fi
+
 # Define files in the artifacts for checking the reproducibility
 set -- \
 	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p1" \
-- 
2.20.1



