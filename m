Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A6FD48985
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 11:49:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4374.1768564148281785583
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Jan 2026 03:49:08 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 60GBn5rx016065; Fri, 16 Jan 2026 20:49:05 +0900
X-Iguazu-Qid: 2rWhoMOwv9IoVw9cpM
X-Iguazu-QSIG: v=2; s=0; t=1768564145; q=2rWhoMOwv9IoVw9cpM; m=ma+63Ze1Y6GhRwXaXLTi9GygrVp1cLucz432XdL4WDY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dsymx09PXz1xnf; Fri, 16 Jan 2026 20:49:04 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        akunuri.sahithi@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
        michael.adler@siemens.com
Subject: [isar-cip-core][PATCH v5 2/4] Kconfig: Add option to set WFX_URL
Date: Fri, 16 Jan 2026 07:03:45 -0500
X-TSB-HOP2: ON
Message-Id: <20260116120347.1733494-3-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260116120347.1733494-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20260116120347.1733494-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Jan 2026 11:49:00.0746 (UTC) FILETIME=[1AF5F2A0:01DC86DE]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Jan 2026 11:49:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21634

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Kconfig b/Kconfig
index 30abb84..3665269 100644
--- a/Kconfig
+++ b/Kconfig
@@ -279,6 +279,13 @@ config IMAGE_SWUPDATE
 
 if IMAGE_SWUPDATE
 
+config WFX_URL
+	string "WFX backend URL"
+	default ""
+	help
+	  URL of the wfx backend for software updates. See ./doc/README.swupdate.md for
+	  more about wfx support for updates.
+
 choice
 	prompt "Update type"
 
-- 
2.39.5



