Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8116BC41513
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 09:17:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.103547.1692004640875576011
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Aug 2023 02:17:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 37E9HIuN377201; Mon, 14 Aug 2023 18:17:19 +0900
X-Iguazu-Qid: 2rWhi9UHd5oQ2Ug8bT
X-Iguazu-QSIG: v=2; s=0; t=1692004638; q=2rWhi9UHd5oQ2Ug8bT; m=8NarHVZDcGkcBxdUtV16+KSfpNthyyyEm6j7hJ1cbvk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 37E9HHZi2531146
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 14 Aug 2023 18:17:18 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 3/4] scripts/repro-tests.sh: Fix condition check for artifact folder
Date: Mon, 14 Aug 2023 14:47:13 +0530
X-TSB-HOP2: ON
Message-Id: <20230814091714.9400-4-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230814091714.9400-1-venkata.pyla@toshiba-tsip.com>
References: <20230814091714.9400-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Aug 2023 09:17:14.0126 (UTC) FILETIME=[1CFF82E0:01D9CE90]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 09:17:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12630

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 scripts/repro-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/repro-tests.sh b/scripts/repro-tests.sh
index ec3b1e4..41357b2 100755
--- a/scripts/repro-tests.sh
+++ b/scripts/repro-tests.sh
@@ -76,7 +76,7 @@ set -- \
 # compare artifacts
 res=0
 for file in "$@"; do
-	if [ -f "${artifacts1}/${file}" ] && [ -f "${artifacts1}/${file}" ]; then
+	if [ -f "${artifacts1}/${file}" ] && [ -f "${artifacts2}/${file}" ]; then
 		if $DIFFOSCOPE --text "${file}.diffoscope_output.txt" \
 			--html-dir diffoscope_output \
 			--html "${file}.diffoscope_output.html" \
-- 
2.20.1



