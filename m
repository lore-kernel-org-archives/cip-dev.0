Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DE81073C81
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 09:42:03 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.102301.1775641316705973846
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Apr 2026 02:42:00 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: JkeW9UC5SVyQpkciG+1oAQ==
X-CSE-MsgGUID: nrSNZAcXTcyIFQwFpvOHgw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 08 Apr 2026 18:41:59 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 622C240116C8;
	Wed,  8 Apr 2026 18:41:58 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 4/7] PM: domains: Add RZ/V2N compatible to PM domain detach list
Date: Wed,  8 Apr 2026 09:41:47 +0000
Message-ID: <20260408094150.66941-5-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408094150.66941-1-ovidiu.panait.rb@renesas.com>
References: <20260408094150.66941-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Apr 2026 09:42:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22648

Add Renesas RZ/V2N compatible to the PM domain detach list in
dev_pm_domain_allow_detach_on_unbind_cleanup(). This fixes asynchronous
aborts when unbinding the TSU devices.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/base/power/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 536ce9be7395..b1fb615af292 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -451,6 +451,7 @@ bool dev_pm_domain_allow_detach_on_unbind_cleanup(void)
 		"renesas,r9a07g054", /* Renesas RZ/V2L */
 		"renesas,r9a08g045", /* Renesas RZ/G3S */
 		"renesas,r9a09g047", /* Renesas RZ/G3E */
+		"renesas,r9a09g056", /* Renesas RZ/V2N */
 		"renesas,r9a09g057", /* Renesas RZ/V2H */
 		NULL
 	};
-- 
2.51.0


