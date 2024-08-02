Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6E8C3DA7F
	for <webhook@archiver.kernel.org>; Fri,  2 Aug 2024 06:23:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.87277.1722579798519664014
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Aug 2024 23:23:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 4726NGf5108261; Fri, 2 Aug 2024 15:23:17 +0900
X-Iguazu-Qid: 2yAb5mQqVWSiuhfJQ7
X-Iguazu-QSIG: v=2; s=0; t=1722579796; q=2yAb5mQqVWSiuhfJQ7; m=3gbIuPeukzw51UdnHeZHSoC1OyENvpxl+kZpqJn9h1c=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 4726NFgX1709862
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 2 Aug 2024 15:23:16 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] submit_lava.sh: Modify environment slug in SQUAD
Date: Fri,  2 Aug 2024 11:53:17 +0530
X-TSB-HOP2: ON
Message-Id: <20240802062317.3333603-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 02 Aug 2024 06:23:13.0789 (UTC) FILETIME=[744E02D0:01DAE4A4]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Aug 2024 06:23:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16708

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

This commit modifies environment slug for test results hosted in SQUAD.
Currently the slug includes device name which keeps varying as that depends
on assigned device in LAVA Lab. Ex: "qemu-cip-siemens-muc", "qemu-renesas-01"
etc.

Environment slug should denote the test suite as well as the target on which
tests are executed. So it needs target information as part of it instead of
device allocated. This also helps in fetching the results from SQUAD using
squad-client while generating test reports.

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 scripts/submit_lava.sh | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index b9015f3..1f55c3b 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -104,19 +104,18 @@ submit_squad_watch_job(){
 	fi
 
 	if [ "$TEST" = "swupdate" ] || [ "$TEST" = "kernel-panic" ] || [ "$TEST" = "initramfs-crash" ]; then
-		squad_project="swupdate-testing"
+		SQUAD_PROJECT="swupdate-testing"
 	elif [ "$TEST" = "secure-boot" ]; then
-		squad_project="secure-boot-testing"
+		SQUAD_PROJECT="secure-boot-testing"
 	elif [ "$TEST" = "IEC" ]; then
-		squad_project="iec-layer-testing"
+		SQUAD_PROJECT="iec-layer-testing"
 	else
 		echo "Unable to host results in available CIP Core SQUAD projects"
 		return 1
 	fi
 
-	local DEVICE=$2
-	local ENV="${DEVICE}_${squad_project}"
-	local squad_url="$SQUAD_WATCH_JOBS_URL/${SQUAD_GROUP}/${squad_project}/${COMMIT_REF}/${ENV}"
+	local ENV="${SQUAD_PROJECT}_${TARGET}"
+	local squad_url="$SQUAD_WATCH_JOBS_URL/${SQUAD_GROUP}/${SQUAD_PROJECT}/${COMMIT_REF}/${ENV}"
 	ret=$(curl -s \
 		--header "Authorization: token $CIP_SQUAD_LAB_TOKEN" \
 		--form backend="$SQUAD_LAVA_BACKEND" \
@@ -165,7 +164,7 @@ submit_job() {
 				| cut -d ":" -f 2 \
 				| awk '{$1=$1};1')
 
-			submit_squad_watch_job "${ret}" "${DEVICE}"
+			submit_squad_watch_job "${ret}"
 
 			lavacli $LAVACLI_ARGS jobs logs "${ret}"
 			lavacli $LAVACLI_ARGS results "${ret}"
-- 
2.30.2



