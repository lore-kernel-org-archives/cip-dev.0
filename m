Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63098C3600B
	for <webhook@archiver.kernel.org>; Thu, 27 Mar 2025 09:37:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.45848.1743068234590664950
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Mar 2025 02:37:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 52R9bB5K2961781; Thu, 27 Mar 2025 18:37:12 +0900
X-Iguazu-Qid: 2yAbaKzOh4Va650ggU
X-Iguazu-QSIG: v=2; s=0; t=1743068231; q=2yAbaKzOh4Va650ggU; m=G48hi9h7M7PU7HBLG6rqZOYLgGwVnchWwM4oSJ0Yr0Y=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 52R9bAIX1364158
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 18:37:11 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] IEC_template.yml: Update IEC tests to latest revision
Date: Thu, 27 Mar 2025 15:03:58 +0530
X-TSB-HOP2: ON
Message-Id: <20250327093358.3419546-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 27 Mar 2025 09:37:08.0952 (UTC) FILETIME=[CF4DBD80:01DB9EFB]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Mar 2025 09:37:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18374

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

Major changes in this revision update:

1. Skip TC_CR2.7_1 until it is redesigned to remove dependencies on static time delays.
2. Improve tests to include testing of new IEC-62443-4-2 sub-requirements.
3. Fail the job if any failed test cases are found in final summary.

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 tests/templates/IEC_template.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
index 3c33773..92944da 100644
--- a/tests/templates/IEC_template.yml
+++ b/tests/templates/IEC_template.yml
@@ -64,7 +64,7 @@ actions:
      definitions:
      - repository: https://gitlab.com/cip-project/cip-testing/cip-security-tests.git
        from: git
-       revision: 064a92b98127b0001ca527a83b175521bea4b626
+       revision: 5dbc47f55d4a43449dcbde4363e5d23d6e96344f
        path: iec-security-tests/Singlenode-TestDefinition.yaml
        name: Security-Testcases
 
-- 
2.30.2



