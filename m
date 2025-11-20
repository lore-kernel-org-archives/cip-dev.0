Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CC9CF64B4
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 04:50:13 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27561.1763614206349533155
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Nov 2025 20:50:07 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 5AK4o3YH1784739; Thu, 20 Nov 2025 13:50:04 +0900
X-Iguazu-Qid: 2rWgZy3EX4Vtb4fFLN
X-Iguazu-QSIG: v=2; s=0; t=1763614203; q=2rWgZy3EX4Vtb4fFLN; m=CqiIwpFUmFLDv3F9eX1462aYAAKr1rWclUneRE3Xw6U=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dBm9l1WkBz4vyk; Thu, 20 Nov 2025 13:50:02 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1] IEC_template.yml: Update IEC layer tests revision
Date: Thu, 20 Nov 2025 00:03:13 -0500
X-TSB-HOP2: ON
Message-Id: <20251120050313.973859-1-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Nov 2025 04:50:00.0098 (UTC) FILETIME=[206BC020:01DC59D9]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Nov 2025 04:50:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20630

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

This revision update fixes the inconsistency with the IEC CR 7.1 test.

Currently the rate limit using nftables is set to 3 requests/second and
the ping flood transmits a packet every 0.3 seconds i.e 3.3 packets / second

Although this is theoretically over the rate limit and should drop packets,
but the rate limit set and the ping requests interval is too close and some
iterations can lead to no packets being dropped and thereby the test failing.

The fix increase the frequency in the ping flood attack which would lead to
more packets being dropped by the kernel.

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 tests/templates/IEC_template.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
index fe4132d..fba7544 100644
--- a/tests/templates/IEC_template.yml
+++ b/tests/templates/IEC_template.yml
@@ -64,7 +64,7 @@ actions:
      definitions:
      - repository: https://gitlab.com/cip-project/cip-testing/cip-security-tests.git
        from: git
-       revision: dee76c8b6612439ac648fd18709088ec8fea7e40
+       revision: deec0428624e827a9d762eccc99b55ee05b440fd
        path: iec-security-tests/Singlenode-TestDefinition.yaml
        name: Security-Testcases
 
-- 
2.39.5



