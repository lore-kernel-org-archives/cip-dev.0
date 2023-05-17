Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE82BC77B7A
	for <webhook@archiver.kernel.org>; Wed, 17 May 2023 12:55:29 +0000 (UTC)
Received: from esa1.mentor.iphmx.com (esa1.mentor.iphmx.com [68.232.129.153])
 by mx.groups.io with SMTP id smtpd.web10.48571.1684328120902923162
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 May 2023 05:55:21 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.129.153, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="6321888"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa1.mentor.iphmx.com with ESMTP; 17 May 2023 04:55:20 -0800
IronPort-SDR: 0UsWvlXlSnwUBBBXtNZWBOzWO0b7EWZBitGFPijc3NxsG+syLNTdUnaMP9maAf2L4Mq9Qibd+X
 5pcfJ/aYscLMVotRHf+24NqHTbWNVAXpGbem9e4GyrtVTbN9z3mUGMFQdGWYeoQyM3fAwt+pL8
 2qfOcDKsEmn0L2bfoFfPAK7fmtWN8YitnbTxJ58G7/KxsxpgDfBEcTwPy5eQSAkRjwtrJoTfdI
 ZocrlqB+ba2xnRoDU3Wan4ntTcQSxCCG0dZh6wL99ojne82sxQSrEQKdWEAA4hsaPgMs7rCIpg
 jtE=
From: Srinuvasan Arjunan <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] Kconfig: disable RT selection for 6.1 mainline kernel
Date: Wed, 17 May 2023 18:25:02 +0530
Message-ID: <20230517125502.1516580-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-14.mgc.mentorg.com (147.34.90.214) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 12:55:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11492

From: Srinuvasan A <srinuvasan.a@siemens.com>

Till now we have support for 6.1 LTS not RT kernel, hence disable this
RT selection option.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Kconfig b/Kconfig
index d590cbf..a96ac17 100644
--- a/Kconfig
+++ b/Kconfig
@@ -112,6 +112,7 @@ config KAS_INCLUDE_KERNEL
 config KERNEL_RT
 	bool "Real-time CIP kernel"
 	depends on !ARCH_RISCV64
+        depends on !KERNEL_6_1_MAINLINE
 
 config KAS_INCLUDE_KERNEL_RT
 	string
-- 
2.34.1


