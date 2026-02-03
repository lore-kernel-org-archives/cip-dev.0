Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CF0E83070
	for <webhook@archiver.kernel.org>; Tue,  3 Feb 2026 09:13:53 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12666.1770110026120335150
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Feb 2026 01:13:46 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: john.madieu.xa@bp.renesas.com)
X-CSE-ConnectionGUID: X2ByLuZfQqmZ8KxBy0sCxw==
X-CSE-MsgGUID: OXO5rjvCQKGsf566F74rhQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 03 Feb 2026 18:13:45 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.13])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 95ED9416D941;
	Tue,  3 Feb 2026 18:13:43 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	john.madieu@gmail.com
Subject: [PATCH 6.12.y-cip 1/2] PM: domains: Add RZ/G3E compatible to PM domain detach list
Date: Tue,  3 Feb 2026 10:13:30 +0100
Message-ID: <20260203091332.98580-2-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203091332.98580-1-john.madieu.xa@bp.renesas.com>
References: <20260203091332.98580-1-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Feb 2026 09:13:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21820

Add Renesas RZ/G3E compatible string to the PM domain detach list in
dev_pm_domain_allow_detach_on_unbind_cleanup(). This avoid asynchronous
aborts when unbinding the TSU device.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/base/power/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 5d6b6cd86579..536ce9be7395 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -450,6 +450,7 @@ bool dev_pm_domain_allow_detach_on_unbind_cleanup(void)
 		"renesas,r9a07g044", /* Renesas RZ/G2{L, LC} */
 		"renesas,r9a07g054", /* Renesas RZ/V2L */
 		"renesas,r9a08g045", /* Renesas RZ/G3S */
+		"renesas,r9a09g047", /* Renesas RZ/G3E */
 		"renesas,r9a09g057", /* Renesas RZ/V2H */
 		NULL
 	};
-- 
2.25.1


