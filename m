Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F651C30658
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 07:41:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.12326.1720165263683745387
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 00:41:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 4657f18q680740; Fri, 5 Jul 2024 16:41:01 +0900
X-Iguazu-Qid: 2rWg5LUt5WbI8fC5Fc
X-Iguazu-QSIG: v=2; s=0; t=1720165260; q=2rWg5LUt5WbI8fC5Fc; m=aUR56/S92JdJFXtK3T/dSaC7rd0AHHFW8ZhIrAntjW0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 4657ex7w115446
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 5 Jul 2024 16:41:00 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2] Kconfig: Select secure boot as default for security image
Date: Fri,  5 Jul 2024 13:05:41 +0530
X-TSB-HOP2: ON
Message-Id: <20240705073541.1376479-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Jul 2024 07:40:58.0068 (UTC) FILETIME=[ACDD8140:01DACEAE]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 07:41:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16387

In Kconfig, only SWUpdate is selected as default for security image.
so, add secure boot also as default.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Kconfig b/Kconfig
index 96f590a..b86305e 100644
--- a/Kconfig
+++ b/Kconfig
@@ -163,6 +163,7 @@ if !KERNEL_4_4 && !KERNEL_4_19
 config IMAGE_SECURITY
 	bool "Security extensions"
 	select IMAGE_SWUPDATE
+	select IMAGE_SECURE_BOOT
 	select IMAGE_DATA_ENCRYPTION
 	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI
 	help
-- 
2.39.2



