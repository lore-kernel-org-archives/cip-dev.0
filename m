Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8B2C77B7E
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 07:35:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.25684.1685604904677012426
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 00:35:05 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.157, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 3517Z2Pw025360; Thu, 1 Jun 2023 16:35:02 +0900
X-Iguazu-Qid: 2wHHOP40h78BN95Toh
X-Iguazu-QSIG: v=2; s=0; t=1685604902; q=2wHHOP40h78BN95Toh; m=OOObus/4F0DNVhLssi8Q8Xq50WeUWZ6Mhn5srr1QgrU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1111) id 3517Z0qY029833
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 1 Jun 2023 16:35:01 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 3/3] scripts/repro-tests.sh: enable html output in diffoscope
Date: Thu,  1 Jun 2023 13:04:54 +0530
X-TSB-HOP2: ON
Message-Id: <20230601073454.1896-4-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230601073454.1896-1-venkata.pyla@toshiba-tsip.com>
References: <20230601073454.1896-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Jun 2023 07:34:55.0774 (UTC) FILETIME=[8FAFD3E0:01D9945B]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 07:35:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11719

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

html output is easy to watch the differences in the browser.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .reproducible-check-ci.yml | 2 +-
 scripts/repro-tests.sh     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index 98f76d1..3fb0c71 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -60,7 +60,7 @@
     when: always
     expire_in: 1 day
     paths:
-      - "./*diffoscope_output.txt"
+      - "./*diffoscope_output.*"
 
 
 # repro build
diff --git a/scripts/repro-tests.sh b/scripts/repro-tests.sh
index 7c44567..a5efe62 100755
--- a/scripts/repro-tests.sh
+++ b/scripts/repro-tests.sh
@@ -79,6 +79,7 @@ res=0
 for file in "$@"; do
 	if [ -f "${artifacts1}/${file}" ] && [ -f "${artifacts1}/${file}" ]; then
 		if $DIFFOSCOPE --text "${file}.diffoscope_output.txt" \
+			--html "${file}.diffoscope_output.html" \
 			"${artifacts1}/${file}" \
 			"${artifacts2}/${file}" > /dev/null 2>&1; then
 			echo "${file}: ${GREEN}Reproducible${NC}" | tee -a diffoscope_output.txt
-- 
2.20.1



