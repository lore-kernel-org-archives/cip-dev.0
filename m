Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CD9D25B64
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 13:25:42 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12765.1769606726333152485
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 05:25:33 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: EMY+7JLmSy+VDQr6/H3YTw==
X-CSE-MsgGUID: y93YE3TFQK2Y50sHMpjgvw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Jan 2026 22:25:32 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.43])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 60C8A41728C9;
	Wed, 28 Jan 2026 22:25:31 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 04/11] PM: domains: Add RZ/V2H compatible to PM domain detach list
Date: Wed, 28 Jan 2026 13:25:13 +0000
Message-ID: <20260128132522.6902-5-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128132522.6902-1-ovidiu.panait.rb@renesas.com>
References: <20260128132522.6902-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 13:25:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21741

Add Renesas RZ/V2H compatible to the PM domain detach list in
dev_pm_domain_allow_detach_on_unbind_cleanup(). This fixes asynchronous
aborts when unbinding the TSU devices.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/base/power/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index f1fd50d0efb9..8e002aa131f0 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -245,6 +245,7 @@ bool dev_pm_domain_allow_detach_on_unbind_cleanup(void)
 		"renesas,r9a07g044", /* Renesas RZ/G2{L, LC} */
 		"renesas,r9a07g054", /* Renesas RZ/V2L */
 		"renesas,r9a08g045", /* Renesas RZ/G3S */
+		"renesas,r9a09g057", /* Renesas RZ/V2H */
 		NULL
 	};
 
-- 
2.51.0


