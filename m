Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB86C3DA63
	for <webhook@archiver.kernel.org>; Tue, 23 Jul 2024 17:51:27 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.1678.1721757079571350405
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Jul 2024 10:51:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 46NHpHOh1296327; Wed, 24 Jul 2024 02:51:17 +0900
X-Iguazu-Qid: 2yAbQ60VQtsZBsCm3d
X-Iguazu-QSIG: v=2; s=0; t=1721757076; q=2yAbQ60VQtsZBsCm3d; m=qSxdvXbaCbHHZiSFTlU9bSQ/wfBf7/MnDlQk9oFb0Os=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 46NHpGUa156821
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 02:51:16 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] IEC_template.yml: Update revision of cip-security-tests
Date: Tue, 23 Jul 2024 23:21:17 +0530
X-TSB-HOP2: ON
Message-Id: <20240723175117.2471090-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Jul 2024 17:51:13.0673 (UTC) FILETIME=[E8E6EF90:01DADD28]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Jul 2024 17:51:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16598

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

It is expected for all the test cases to pass with the revision
mentioned in this commit.

Below mentioned test cases are fixed with the updated revision.

a) TC_CR1.11_2
b) TC_CR2.10_1
c) TC_CR2.9-RE1_1
d) TC_CR2.9_2
e) TC_CR3.4-RE2_1,
f) TC_CR6.2_1
g) TC_CR7.1_1

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 tests/templates/IEC_template.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
index 1d46791..a196bb5 100644
--- a/tests/templates/IEC_template.yml
+++ b/tests/templates/IEC_template.yml
@@ -64,7 +64,7 @@ actions:
      definitions:
      - repository: https://gitlab.com/cip-project/cip-testing/cip-security-tests.git
        from: git
-       revision: 07021c3b7455ed354a00f4de0f1a7267788c414a
+       revision: 064a92b98127b0001ca527a83b175521bea4b626
        path: iec-security-tests/Singlenode-TestDefinition.yaml
        name: Security-Testcases
 
-- 
2.30.2



