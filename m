Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301DAD29FFE
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 12:10:44 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8553.1768392634613809779
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Jan 2026 04:10:35 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 60ECAWsV2399173; Wed, 14 Jan 2026 21:10:32 +0900
X-Iguazu-Qid: 2yAbS7rJl2lFQw5C1Q
X-Iguazu-QSIG: v=2; s=0; t=1768392632; q=2yAbS7rJl2lFQw5C1Q; m=/ThvpBAMfTBgqypCe7HR55tga7QtXsDhyTLr0D5yXP0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4drlLc2Kj7zyPZ; Wed, 14 Jan 2026 21:10:32 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        akunuri.sahithi@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v4 2/4] Kconfig: Add option to set WFX_URL
Date: Wed, 14 Jan 2026 07:25:14 -0500
X-TSB-HOP2: ON
Message-Id: <20260114122517.1716929-3-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260114122517.1716929-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20260114122517.1716929-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Jan 2026 12:10:29.0203 (UTC) FILETIME=[C61D6230:01DC854E]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jan 2026 12:10:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21544

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



