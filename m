Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342FF105D9AE
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 09:40:02 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.102550.1775641196244975563
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Apr 2026 02:40:00 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: 9TycZjuASz2K0ChQdDAk3g==
X-CSE-MsgGUID: 5Aqk1pzDQKW1fSnBOwjImw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 08 Apr 2026 18:40:00 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4F33D40116CF;
	Wed,  8 Apr 2026 18:39:59 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 4/7] PM: domains: Add RZ/V2N compatible to PM domain detach list
Date: Wed,  8 Apr 2026 09:39:47 +0000
Message-ID: <20260408093951.66884-5-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408093951.66884-1-ovidiu.panait.rb@renesas.com>
References: <20260408093951.66884-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Apr 2026 09:40:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22640

Add Renesas RZ/V2N compatible to the PM domain detach list in
dev_pm_domain_allow_detach_on_unbind_cleanup(). This fixes asynchronous
aborts when unbinding the TSU devices.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/base/power/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 44c485f0c96b..e83ba3a5611f 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -246,6 +246,7 @@ bool dev_pm_domain_allow_detach_on_unbind_cleanup(void)
 		"renesas,r9a07g054", /* Renesas RZ/V2L */
 		"renesas,r9a08g045", /* Renesas RZ/G3S */
 		"renesas,r9a09g047", /* Renesas RZ/G3E */
+		"renesas,r9a09g056", /* Renesas RZ/V2N */
 		"renesas,r9a09g057", /* Renesas RZ/V2H */
 		NULL
 	};
-- 
2.51.0


