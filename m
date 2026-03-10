Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F57CFCC9BE
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 04:30:43 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33059.1773117034108164746
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 21:30:34 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 62A4UWQY3654780; Tue, 10 Mar 2026 13:30:32 +0900
X-Iguazu-Qid: 2rWgTdetUH3Px7xjgg
X-Iguazu-QSIG: v=2; s=0; t=1773117032; q=2rWgTdetUH3Px7xjgg; m=dZDrJVOMA4yZH1CwanyPkpQZ83aOEyyp44oCRRDpbSk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fVLXS2MFQz1xnf; Tue, 10 Mar 2026 13:30:32 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        koshiro.onuki.h55@mail.toshiba, kazuhiro3.hayashi@toshiba.co.jp,
        michael.adler@siemens.com, christian.storm@siemens.com
Subject: [isar-cip-core][RFC v1 5/7] Kconfig: Add kas menu options for wfx based onboarding
Date: Tue, 10 Mar 2026 00:45:52 -0400
X-TSB-HOP2: ON
Message-Id: <20260310044554.990348-6-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260310044554.990348-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20260310044554.990348-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Mar 2026 04:30:24.0296 (UTC) FILETIME=[9D071A80:01DCB046]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Mar 2026 04:30:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22221

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 Kconfig | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Kconfig b/Kconfig
index 772b8cd..43709e7 100644
--- a/Kconfig
+++ b/Kconfig
@@ -285,6 +285,13 @@ config IMAGE_SWUPDATE
 
 if IMAGE_SWUPDATE
 
+config WFX_SUPPORT
+	bool "Enable WFX support"
+	help
+	  Enable WFX support for device updates.
+
+if WFX_SUPPORT
+
 config WFX_URL
 	string "WFX backend URL"
 	default ""
@@ -292,6 +299,21 @@ config WFX_URL
 	  URL of the wfx backend for software updates. An empty string here implies wfx support is disabled.
 	  See ./doc/README.swupdate.md for more about wfx support for updates.
 
+config INCLUDE_WFX_BASED_ONBOARDING
+	bool "WFX based device onboarding"
+	help
+	  Enable wfx based device onboarding capability. See ./doc/README.swupdate.md for more.
+
+config WFX_BASED_ONBOARDING
+	int
+	default 1 if INCLUDE_WFX_BASED_ONBOARDING
+
+config KAS_INCLUDE_WFX
+	string
+	default "kas/opt/wfx.yml"
+
+endif
+
 choice
 	prompt "Update type"
 
-- 
2.39.5



