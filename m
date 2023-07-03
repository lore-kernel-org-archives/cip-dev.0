Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CBCEB64DC
	for <webhook@archiver.kernel.org>; Mon,  3 Jul 2023 06:22:40 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.21487.1688365358222209384
 for <cip-dev@lists.cip-project.org>;
 Sun, 02 Jul 2023 23:22:38 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 3636MaRM904142; Mon, 3 Jul 2023 15:22:36 +0900
X-Iguazu-Qid: 2yAbM4uBPv1XQg1nk0
X-Iguazu-QSIG: v=2; s=0; t=1688365356; q=2yAbM4uBPv1XQg1nk0; m=qMMc2QOD+wPdlyp+u7CgxTjl5DcYoTL4ZOM2R7zLZsU=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 3636MZ8d1117315
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 3 Jul 2023 15:22:35 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 4/6] repro-tests.sh: Enable html output in diffoscope
Date: Mon,  3 Jul 2023 11:52:29 +0530
X-TSB-HOP2: ON
Message-Id: <20230703062231.18183-5-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <176C1D7D866704FB.6977@lists.cip-project.org>
References: <176C1D7D866704FB.6977@lists.cip-project.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 03 Jul 2023 06:22:31.0734 (UTC) FILETIME=[BFA7ED60:01D9AD76]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jul 2023 06:22:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12175

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

diffoscope generates output in html format that will be helpful to
easily view the non-reproducible differences in the browser.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .reproducible-check-ci.yml | 3 ++-
 scripts/repro-tests.sh     | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index 88644a7..1f59eba 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -66,7 +66,8 @@
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



