Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95274C04A94
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 09:17:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.103794.1692004640330213049
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Aug 2023 02:17:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 37E9HIWC3671841; Mon, 14 Aug 2023 18:17:18 +0900
X-Iguazu-Qid: 2yAbM4uBR4c0rFNFsO
X-Iguazu-QSIG: v=2; s=0; t=1692004638; q=2yAbM4uBR4c0rFNFsO; m=qmhXVtaDeFVYb7O6yf7+3U208l0lXEQeh6HbXrkVomA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 37E9HHBq117924
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 14 Aug 2023 18:17:18 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 4/4] scripts/repro-tests.sh: Print partition label and fstype in the output
Date: Mon, 14 Aug 2023 14:47:14 +0530
X-TSB-HOP2: ON
Message-Id: <20230814091714.9400-5-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230814091714.9400-1-venkata.pyla@toshiba-tsip.com>
References: <20230814091714.9400-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Aug 2023 09:17:14.0189 (UTC) FILETIME=[1D091FD0:01D9CE90]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 09:17:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12628

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

An additional information to the user to know which partition and its
type is compared for reproducible check.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 scripts/repro-tests.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/repro-tests.sh b/scripts/repro-tests.sh
index 41357b2..ab3dbce 100755
--- a/scripts/repro-tests.sh
+++ b/scripts/repro-tests.sh
@@ -77,14 +77,16 @@ set -- \
 res=0
 for file in "$@"; do
 	if [ -f "${artifacts1}/${file}" ] && [ -f "${artifacts2}/${file}" ]; then
+		label=$(blkid -s LABEL -o value ${artifacts1}/${file})
+		fstype=$(blkid -s TYPE -o value ${artifacts1}/${file})
 		if $DIFFOSCOPE --text "${file}.diffoscope_output.txt" \
 			--html-dir diffoscope_output \
 			--html "${file}.diffoscope_output.html" \
 			"${artifacts1}/${file}" \
 			"${artifacts2}/${file}" > /dev/null 2>&1; then
-			echo "${file}: ${GREEN}Reproducible${NC}" | tee -a diffoscope_output.txt
+			echo "${file}($label,$fstype): ${GREEN}Reproducible${NC}" | tee -a diffoscope_output.txt
 		else
-			echo "${file}: ${RED}Not-Reproducible${NC}" | tee -a diffoscope_output.txt
+			echo "${file}($label,$fstype): ${RED}Not-Reproducible${NC}" | tee -a diffoscope_output.txt
 			res=1
 		fi
 	fi
-- 
2.20.1



