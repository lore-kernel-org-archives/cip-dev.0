Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0336EB64DD
	for <webhook@archiver.kernel.org>; Fri, 23 Jun 2023 14:06:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.133])
 by mx.groups.io with SMTP id smtpd.web10.42888.1687529169018135882
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Jun 2023 07:06:09 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.133, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 35NE65WJ015854; Fri, 23 Jun 2023 23:06:05 +0900
X-Iguazu-Qid: 2wHHJG9eOsx0250qAq
X-Iguazu-QSIG: v=2; s=0; t=1687529165; q=2wHHJG9eOsx0250qAq; m=9t6YBPu3fTT+F9zx4HDoRTLUI+HPMfsV/JKw1JOKDK0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1111) id 35NE6338018181
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 23 Jun 2023 23:06:04 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 3/3] repro-tests.sh: Enable html output in diffoscope
Date: Fri, 23 Jun 2023 19:35:55 +0530
X-TSB-HOP2: ON
Message-Id: <20230623140555.11428-4-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230623140555.11428-1-venkata.pyla@toshiba-tsip.com>
References: <20230623140555.11428-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Jun 2023 14:05:59.0606 (UTC) FILETIME=[D64EF560:01D9A5DB]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Jun 2023 14:06:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12147

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

diffoscope generates output in html format that will be helpful to
easily view the non-reproducible differences in the browser.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .reproducible-check-ci.yml | 3 ++-
 scripts/repro-tests.sh     | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index ede358b..1c53c77 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -64,7 +64,8 @@
     when: always
     expire_in: 1 day
     paths:
-      - "./*diffoscope_output.txt"
+      - "diffoscope_output"
+      - "./*diffoscope_output.*"
 
 
 # repro build
diff --git a/scripts/repro-tests.sh b/scripts/repro-tests.sh
index b37c15e..94de950 100755
--- a/scripts/repro-tests.sh
+++ b/scripts/repro-tests.sh
@@ -78,6 +78,8 @@ res=0
 for file in "$@"; do
 	if [ -f "${artifacts1}/${file}" ] && [ -f "${artifacts1}/${file}" ]; then
 		if $DIFFOSCOPE --text "${file}.diffoscope_output.txt" \
+			--html-dir diffoscope_output \
+			--html "${file}.diffoscope_output.html" \
 			"${artifacts1}/${file}" \
 			"${artifacts2}/${file}" > /dev/null 2>&1; then
 			echo "${file}: ${GREEN}Reproducible${NC}" | tee -a diffoscope_output.txt
-- 
2.20.1



