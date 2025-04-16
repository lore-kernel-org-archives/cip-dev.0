Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47ED2C369BD
	for <webhook@archiver.kernel.org>; Wed, 16 Apr 2025 14:55:55 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.21580.1744815353772363308
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Apr 2025 07:55:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 53GEtpeG1738453; Wed, 16 Apr 2025 23:55:51 +0900
X-Iguazu-Qid: 2yAbuzQy2XU0LHKUe8
X-Iguazu-QSIG: v=2; s=0; t=1744815351; q=2yAbuzQy2XU0LHKUe8; m=XKGroCfhjSO6Z1RkXxPIciWXpi5nfkkcC+sB/L4rngY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 53GEtndw3041711
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 23:55:50 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v3 2/2] IEC_template.yml: Update IEC layer tests revision
Date: Wed, 16 Apr 2025 20:21:41 +0530
X-TSB-HOP2: ON
Message-Id: <20250416145141.2678093-2-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250416145141.2678093-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20250416145141.2678093-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Apr 2025 14:55:46.0467 (UTC) FILETIME=[A27E0730:01DBAEDF]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Apr 2025 14:55:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18512

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

Major changes in this update:

1. Fixed instability of TC_CR2.7_1 (Concurrent session termination)
2. Added TC_CR1.10_1 (Authenticator feedback)

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 tests/templates/IEC_template.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
index c8efe40..b93ed4b 100644
--- a/tests/templates/IEC_template.yml
+++ b/tests/templates/IEC_template.yml
@@ -64,7 +64,7 @@ actions:
      definitions:
      - repository: https://gitlab.com/cip-project/cip-testing/cip-security-tests.git
        from: git
-       revision: 5dbc47f55d4a43449dcbde4363e5d23d6e96344f
+       revision: bb19990c2b29ea96eea309e54124c74ea3246f18
        path: iec-security-tests/Singlenode-TestDefinition.yaml
        name: Security-Testcases
 
-- 
2.30.2



