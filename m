Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5377C27C4F
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 16:10:44 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.90715.1718727043928441092
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jun 2024 09:10:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 45IGAfCi2526398; Wed, 19 Jun 2024 01:10:42 +0900
X-Iguazu-Qid: 2rWhNMNedRGMflekgC
X-Iguazu-QSIG: v=2; s=0; t=1718727041; q=2rWhNMNedRGMflekgC; m=9FvucWW0izBIGX1bJs+uWhaOBLGsYD7foRmV+hxuku4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 45IGAen0963220
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 01:10:41 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v1 1/3] templates/swupdate_template.yml: Fail the job immediately after unexpected outcome
Date: Tue, 18 Jun 2024 21:40:33 +0530
X-TSB-HOP2: ON
Message-Id: <20240618161035.1810237-2-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240618161035.1810237-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20240618161035.1810237-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 18 Jun 2024 16:10:34.0115 (UTC) FILETIME=[0C964530:01DAC19A]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jun 2024 16:10:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16285

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

Previously to make the job incomplete, a sleep command is added in the test job under
the intention that it will cause a timeout error and make the job incomplete. Sometimes
due to unknown circumstances the error cannot be caught using this method. This also
increases the job time. To avoid this, "lava-test-raise <message>" can be used to
immediately fail the job as soon as unexpected outcome occurs.

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 tests/templates/swupdate_template.yml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/templates/swupdate_template.yml b/tests/templates/swupdate_template.yml
index bf6777c..119a5d3 100644
--- a/tests/templates/swupdate_template.yml
+++ b/tests/templates/swupdate_template.yml
@@ -58,7 +58,7 @@ actions:
       password: "CIPsecurity@123"
 
 # TEST_BLOCK
-# Sleep 200s is added to make the job incomplete with a timeout if software update application failed
+# Fail the job if software update application failed
 - test:
     timeout:
       minutes: 15
@@ -70,7 +70,7 @@ actions:
           description: "Test software update"
         run:
           steps:
-            - if swupdate -d "-u #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.swu"; then echo software update is successful!!; else sleep 200s; fi
+            - if swupdate -d "-u #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.swu"; then echo software update is successful!!; else lava-test-raise "Fail job"; fi
       from: inline
       name: sample-test-1
       path: inline/sample-test.yaml
@@ -102,7 +102,7 @@ actions:
     parameters:
        kernel-start-message: "kernel: C:BOOT1:linux.efi"
 
-# sleep 180s is added to make the job incomplete if ustate is not 2 in the updated partition
+# Fail the job if ustate is not #updatestate# after reboot
 - test:
     timeout:
       minutes: 5
@@ -114,7 +114,7 @@ actions:
           description: "check boot loader environment variables"
         run:
           steps:
-            - if [ $(bg_printenv | grep ustate | awk 'FNR == 2{print $2}') = 2 ]; then bg_setenv -c; else sleep 180s; fi
+            - if [ $(bg_printenv | grep ustate | awk 'FNR == 2{print $2}') = 2 ]; then bg_setenv -c; else lava-test-raise "Fail job"; fi
       from: inline
       name: sample-test-2
       path: inline/sample-test.yaml
-- 
2.30.2



