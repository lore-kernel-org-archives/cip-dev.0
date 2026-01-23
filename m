Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1C5D74EE7
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 15:30:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.737.1769182225761051423
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Jan 2026 07:30:26 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 60NFUOZv347670; Sat, 24 Jan 2026 00:30:24 +0900
X-Iguazu-Qid: 2yAbG2P4DheWCk5nCT
X-Iguazu-QSIG: v=2; s=0; t=1769182224; q=2yAbG2P4DheWCk5nCT; m=F+8bW8lb/0VDT8RrBSQ3rlfe1pFlzP0mnb6cFUmtAdU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dyMM36XGZz1xnZ; Sat, 24 Jan 2026 00:30:23 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        akunuri.sahithi@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v6 2/4] Kconfig: Add option to set WFX_URL
Date: Fri, 23 Jan 2026 10:44:55 -0500
X-TSB-HOP2: ON
Message-Id: <20260123154458.2479542-3-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260123154458.2479542-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20260123154458.2479542-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Jan 2026 15:30:18.0690 (UTC) FILETIME=[2E1FAA20:01DC8C7D]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Jan 2026 15:30:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21704

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Kconfig b/Kconfig
index 30abb84..bb27f94 100644
--- a/Kconfig
+++ b/Kconfig
@@ -279,6 +279,13 @@ config IMAGE_SWUPDATE
 
 if IMAGE_SWUPDATE
 
+config WFX_URL
+	string "WFX backend URL"
+	default ""
+	help
+	  URL of the wfx backend for software updates. An empty string here implies wfx support is disabled.
+	  See ./doc/README.swupdate.md for more about wfx support for updates.
+
 choice
 	prompt "Update type"
 
-- 
2.39.5



