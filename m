Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED105E6BF0D
	for <webhook@archiver.kernel.org>; Fri, 30 Jan 2026 12:44:49 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9293.1769777087355174688
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Jan 2026 04:44:48 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 60UCiiIU3524627; Fri, 30 Jan 2026 21:44:44 +0900
X-Iguazu-Qid: 2rWh8deQP3OIWxAXdg
X-Iguazu-QSIG: v=2; s=0; t=1769777083; q=2rWh8deQP3OIWxAXdg; m=dBlZScPN1sWqBKE3lO/+MZRMP8w1m9lm8py/98WSh28=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4f2bLg5sS8z4vyh; Fri, 30 Jan 2026 21:44:43 +0900 (JST)
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH] IEC_template.yml: Update IEC layer tests revision
Date: Fri, 30 Jan 2026 18:03:05 +0530
X-TSB-HOP2: ON
Message-Id: <20260130123306.638831-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 30 Jan 2026 12:44:41.0622 (UTC) FILETIME=[340FAB60:01DC91E6]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 Jan 2026 12:44:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21790

This revision include below improvements for IEC tests,

TC_CR4.1_2: Refactor LUKS partition check to handle /var and / partitions
TC_CR2.12.1 TC_CR2.8_1 TC_CR2.9_1: improve ausearch date parsing reliability
TC_CR1.9_5: ensure correct permissions for SSH principal file
TC_CR6.1-RE1_1: prevent auditd restart failure from blocking remaining test cases
TC_CR1.9_6: support both pubkeyacceptedkeytypes and pubkeyacceptedalgorithms

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 tests/templates/IEC_template.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
index fba7544..f8558cd 100644
--- a/tests/templates/IEC_template.yml
+++ b/tests/templates/IEC_template.yml
@@ -64,7 +64,7 @@ actions:
      definitions:
      - repository: https://gitlab.com/cip-project/cip-testing/cip-security-tests.git
        from: git
-       revision: deec0428624e827a9d762eccc99b55ee05b440fd
+       revision: 88134a939f06c456d4978db9c050f9afc74c5d3b
        path: iec-security-tests/Singlenode-TestDefinition.yaml
        name: Security-Testcases
 
-- 
2.39.5



