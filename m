Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B6DC54ED1
	for <webhook@archiver.kernel.org>; Tue, 27 May 2025 07:13:17 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.45640.1748329986002499747
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 May 2025 00:13:06 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 54R7D3k82396047; Tue, 27 May 2025 16:13:04 +0900
X-Iguazu-Qid: 2rWhg4sy3ZsbUB00WI
X-Iguazu-QSIG: v=2; s=0; t=1748329983; q=2rWhg4sy3ZsbUB00WI; m=FBSfBXzKglSflu27EMYAEpxpE13bMcaB2TufG5B7EP4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 54R7D2ae1616642
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 16:13:03 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH] IEC_template.yml: Update IEC layer tests revision
Date: Tue, 27 May 2025 12:34:13 +0530
X-TSB-HOP2: ON
Message-Id: <20250527070413.2285223-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 27 May 2025 07:13:00.0284 (UTC) FILETIME=[C77E7BC0:01DBCED6]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 May 2025 07:13:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18950

Major changes are as below,

1. Fix the rules for aide tool to support for symlink case
2. Update to tests to print the summary of IEC layer tests and
   time taken to execute each test case.
3. Check /var is CRYPTO_LUKS instead of /home as it is moved under /var

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 tests/templates/IEC_template.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
index b93ed4b..fe4132d 100644
--- a/tests/templates/IEC_template.yml
+++ b/tests/templates/IEC_template.yml
@@ -64,7 +64,7 @@ actions:
      definitions:
      - repository: https://gitlab.com/cip-project/cip-testing/cip-security-tests.git
        from: git
-       revision: bb19990c2b29ea96eea309e54124c74ea3246f18
+       revision: dee76c8b6612439ac648fd18709088ec8fea7e40
        path: iec-security-tests/Singlenode-TestDefinition.yaml
        name: Security-Testcases
 
-- 
2.39.2



