Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880DDC71157
	for <webhook@archiver.kernel.org>; Tue, 17 Jun 2025 09:46:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.14894.1750153556687286956
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Jun 2025 02:45:57 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 55H9jrWr305938; Tue, 17 Jun 2025 18:45:54 +0900
X-Iguazu-Qid: 2rWhqikygHWJqXkZJ3
X-Iguazu-QSIG: v=2; s=0; t=1750153553; q=2rWhqikygHWJqXkZJ3; m=Fqiwt2XRqK32EpTOpg3Py5u0xiQxQ3XNzCMfkwXxh28=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 55H9jqRQ3186991
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 18:45:53 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH] .gitlab-ci.yml: Increase IEC test timeout for real hardware(M-COM).
Date: Tue, 17 Jun 2025 15:06:42 +0530
X-TSB-HOP2: ON
Message-Id: <20250617093642.1320442-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 17 Jun 2025 09:45:50.0670 (UTC) FILETIME=[9C2516E0:01DBDF6C]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Jun 2025 09:46:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19118

Sometimes the current timeout of 60 mins for IEC tests execution for M-COM
device on LAVA lab is not sufficient. The gitlab CI job fails due to timeout
issue. Increase timeout to 120 min to avoid CI job failures.

It's a temporary fix, so need to explore the reason for the longer runtime
in LAVA setup for M-COM.

[1] https://lava.ciplatform.org/scheduler/job/1281301
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index ca52a05..f7a8127 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -458,7 +458,7 @@ test:x86-uefi-IEC:
   variables:
     target: x86-uefi
     test_function: IEC
-    iec_test_timeout: 60
+    iec_test_timeout: 120
 
 test:qemu-amd64-secure-boot-unsigned-kernel:
   extends:
-- 
2.39.2



