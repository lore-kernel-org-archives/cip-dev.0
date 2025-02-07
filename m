Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C421C0219D
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 15:08:03 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.71479.1738940879235516793
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Feb 2025 07:07:59 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 517F7uMc3476447; Sat, 8 Feb 2025 00:07:56 +0900
X-Iguazu-Qid: 2rWhyCKR4fQTUVtttT
X-Iguazu-QSIG: v=2; s=0; t=1738940875; q=2rWhyCKR4fQTUVtttT; m=7yirw2nF/9QKq0Nl9SkIE1qg/J35iTFfLNwmWjTq1aU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 517F7sxF986128
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 8 Feb 2025 00:07:55 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v1 1/5] swupdate_template.yml: Give different names to test actions
Date: Fri,  7 Feb 2025 20:34:35 +0530
X-TSB-HOP2: ON
Message-Id: <20250207150439.392479-2-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250207150439.392479-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20250207150439.392479-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Feb 2025 15:07:52.0797 (UTC) FILETIME=[0F5430D0:01DB7972]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Feb 2025 15:08:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17773

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

Second test action in swupdate_template file can be re-used as it is
in M-COM swupdate job. To grep the second test action from the template
a different name has been assigned to it.

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 tests/templates/swupdate_template.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/templates/swupdate_template.yml b/tests/templates/swupdate_template.yml
index 119a5d3..e12fb32 100644
--- a/tests/templates/swupdate_template.yml
+++ b/tests/templates/swupdate_template.yml
@@ -57,7 +57,7 @@ actions:
       password_prompt: "Password:"
       password: "CIPsecurity@123"
 
-# TEST_BLOCK
+# TEST_BLOCK 1
 # Fail the job if software update application failed
 - test:
     timeout:
@@ -102,6 +102,7 @@ actions:
     parameters:
        kernel-start-message: "kernel: C:BOOT1:linux.efi"
 
+# TEST BLOCK 2
 # Fail the job if ustate is not #updatestate# after reboot
 - test:
     timeout:
-- 
2.30.2



