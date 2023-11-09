Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F050C4167B
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 10:06:04 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.118068.1699524360839032226
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Nov 2023 02:06:01 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 3A9A5xV03577669; Thu, 9 Nov 2023 19:05:59 +0900
X-Iguazu-Qid: 2yAaQ5iWIW7GWRKeeZ
X-Iguazu-QSIG: v=2; s=0; t=1699524358; q=2yAaQ5iWIW7GWRKeeZ; m=mitmNc9rBbYzL89wrE9K4A4MXFPQB8raYM8sZf/SJkk=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 3A9A5uS21482469
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 9 Nov 2023 19:05:58 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] .reproducible-check-ci.yml: Stop running in jobs all schedules
Date: Thu,  9 Nov 2023 15:35:56 +0530
X-TSB-HOP2: ON
Message-Id: <20231109100557.16431-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 09 Nov 2023 10:05:55.0341 (UTC) FILETIME=[541DCBD0:01DA12F4]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Nov 2023 10:06:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13545

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Currently the reproducible build check jobs are running for any type
of schedule, so created a variable and allowed to run only when the
variable is set along with the schedule.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .reproducible-check-ci.yml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index 1a2b4c8..2bef312 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -25,8 +25,8 @@
   stage: build
   tags:
     - large
-  only:
-    - schedules
+  rules:
+    - if: $CI_PIPELINE_SOURCE == "schedule" && $REPRODUCIBLE_BUILDS
   script:
     - if [ -f kas/opt/reproducible.yml ]; then base_yaml="${base_yaml}:kas/opt/reproducible.yml"; fi
     # Build 1st time
@@ -55,8 +55,8 @@
   tags:
     - large
   stage: test
-  only:
-    - schedules
+  rules:
+    - if: $CI_PIPELINE_SOURCE == "schedule" && $REPRODUCIBLE_BUILDS
   variables:
     GIT_STRATEGY: none
     release: bookworm
-- 
2.20.1



