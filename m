Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A81AF45A07
	for <webhook@archiver.kernel.org>; Fri, 10 Apr 2026 17:03:18 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.161295.1775840591878637041
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Apr 2026 10:03:14 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: f2cgyxxpTQKu9DZFfcW8+g==
X-CSE-MsgGUID: st0pVolqShCk8qi7dD5g7A==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 11 Apr 2026 02:03:14 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.85])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4FBE8402F558;
	Sat, 11 Apr 2026 02:03:13 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 07/11] PM: domains: Add RZ/T2H and RZ/N2H compatibles to PM domain detach list
Date: Fri, 10 Apr 2026 20:02:11 +0300
Message-ID: <20260410170215.393698-8-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410170215.393698-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260410170215.393698-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Apr 2026 17:03:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22670

Add Renesas RZ/T2H and RZ/N2H compatibles to the PM domain detach list
in dev_pm_domain_allow_detach_on_unbind_cleanup(). This fixes
asynchronous aborts when unbinding the TSU devices.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/base/power/common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index b1fb615af2929..2871d27dcbda0 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -453,6 +453,8 @@ bool dev_pm_domain_allow_detach_on_unbind_cleanup(void)
 		"renesas,r9a09g047", /* Renesas RZ/G3E */
 		"renesas,r9a09g056", /* Renesas RZ/V2N */
 		"renesas,r9a09g057", /* Renesas RZ/V2H */
+		"renesas,r9a09g077", /* Renesas RZ/T2H */
+		"renesas,r9a09g087", /* Renesas RZ/N2H */
 		NULL
 	};
 
-- 
2.53.0


