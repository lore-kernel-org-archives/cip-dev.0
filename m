Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8297FD32D60
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 14:15:51 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6646.1764944146013151365
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Dec 2025 06:15:46 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 5B5EFgj32215509; Fri, 5 Dec 2025 23:15:42 +0900
X-Iguazu-Qid: 2rWgRWki9S6KMTl3p3
X-Iguazu-QSIG: v=2; s=0; t=1764944142; q=2rWgRWki9S6KMTl3p3; m=hcxqEsB0vQ1kSwvmjcDw4+4w8xBS7qTTHSvPoh75pps=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dND1V3ftKz1xnZ; Fri,  5 Dec 2025 23:15:42 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
Subject: [isar-cip-core][PATCH v1 3/3] scripts/repro-tests.sh: Remove return value from run_diffoscope function
Date: Fri,  5 Dec 2025 09:29:27 -0500
X-TSB-HOP2: ON
Message-Id: <20251205142927.4087770-4-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251205142927.4087770-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20251205142927.4087770-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Dec 2025 14:15:38.0017 (UTC) FILETIME=[A1317910:01DC65F1]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Dec 2025 14:15:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20913

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Currently when diffoscope runs against partitions for identifying the diffs,
the script exits as soon as a partition is detected as "not reproducible"

But it should run against the remaining partitons too in order to give a
more comprehensive comparison for all the partitions.

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 scripts/repro-tests.sh | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/scripts/repro-tests.sh b/scripts/repro-tests.sh
index b717a20..4f30c41 100755
--- a/scripts/repro-tests.sh
+++ b/scripts/repro-tests.sh
@@ -80,7 +80,6 @@ run_diffoscope() {
     artifacts2_dir="$3"
     label=""
     fstype=""
-    res=0
 
     # Get partition label and filesystem type
     label=$(blkid -s LABEL -o value "${artifacts1_dir}"/"${file}" || true)
@@ -95,10 +94,7 @@ run_diffoscope() {
         echo "${file}($label,$fstype): ${GREEN}Reproducible${NC}" | tee -a diffoscope_output.txt
     else
         echo "${file}($label,$fstype): ${RED}Not-Reproducible${NC}" | tee -a diffoscope_output.txt
-        res=1
     fi
-
-    return $res
 }
 
 # compare swu file
@@ -108,9 +104,8 @@ if [ -f "${artifacts1}/${swu_file}" ] && [ -f "${artifacts2}/${swu_file}" ]; the
 	swu1_sha256sum=$(sha256sum "${artifacts1}/${IMAGE_BASE}-${RELEASE}-${TARGET}.swu" | awk '{ print $1 }')
 	swu2_sha256sum=$(sha256sum "${artifacts2}/${IMAGE_BASE}-${RELEASE}-${TARGET}.swu" | awk '{ print $1 }')
 	if [ "$swu1_sha256sum" != "$swu2_sha256sum" ]; then
-		if ! run_diffoscope "$swu_file" "$artifacts1" "$artifacts2"; then
-			res_swu=1
-		fi
+		run_diffoscope "$swu_file" "$artifacts1" "$artifacts2"
+		res_swu=1
 	else
 		echo "${IMAGE_BASE}-${RELEASE}-${TARGET}.swu: ${GREEN}Reproducible${NC}" | tee -a diffoscope_output.txt
 	fi
-- 
2.39.5



