Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FC0C369D5
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 09:11:37 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.2723.1745572277578265580
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Apr 2025 02:11:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: omRI7+4UQ5uNCL9pDoUwIw==
X-CSE-MsgGUID: DPTphp1DTc+mvtKhadhwmg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 Apr 2025 18:11:29 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4E9A841FE015;
	Fri, 25 Apr 2025 18:11:28 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 14/15] i2c: riic: Use predefined macro and simplify clock tick calculation
Date: Fri, 25 Apr 2025 10:10:56 +0100
Message-ID: <20250425091057.33752-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425091057.33752-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250425091057.33752-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Apr 2025 09:11:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18618

commit 385bb1c2678b59db201831255b524a6d7f7a25ff upstream.

Replace the hardcoded `1000000000` with the predefined `NSEC_PER_SEC`
macro for clarity. Simplify the code by introducing a `ns_per_tick`
variable to store `NSEC_PER_SEC / rate`, reducing redundancy and
improving readability.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 0dc2de0a14416..51a3faea13e0a 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -47,6 +47,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
+#include <linux/time.h>
 
 #define ICCR1_ICE	BIT(7)
 #define ICCR1_IICRST	BIT(6)
@@ -314,6 +315,7 @@ static int riic_init_hw(struct riic_dev *riic)
 {
 	int ret;
 	unsigned long rate;
+	unsigned long ns_per_tick;
 	int total_ticks, cks, brl, brh;
 	struct i2c_timings *t = &riic->i2c_t;
 	struct device *dev = riic->adapter.dev.parent;
@@ -377,8 +379,9 @@ static int riic_init_hw(struct riic_dev *riic)
 	 * Remove clock ticks for rise and fall times. Convert ns to clock
 	 * ticks.
 	 */
-	brl -= t->scl_fall_ns / (1000000000 / rate);
-	brh -= t->scl_rise_ns / (1000000000 / rate);
+	ns_per_tick = NSEC_PER_SEC / rate;
+	brl -= t->scl_fall_ns / ns_per_tick;
+	brh -= t->scl_rise_ns / ns_per_tick;
 
 	/* Adjust for min register values for when SCLE=1 and NFE=1 */
 	if (brl < 1)
@@ -388,8 +391,7 @@ static int riic_init_hw(struct riic_dev *riic)
 
 	pr_debug("i2c-riic: freq=%lu, duty=%d, fall=%lu, rise=%lu, cks=%d, brl=%d, brh=%d\n",
 		 rate / total_ticks, ((brl + 3) * 100) / (brl + brh + 6),
-		 t->scl_fall_ns / (1000000000 / rate),
-		 t->scl_rise_ns / (1000000000 / rate), cks, brl, brh);
+		 t->scl_fall_ns / ns_per_tick, t->scl_rise_ns / ns_per_tick, cks, brl, brh);
 
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret)
-- 
2.43.0


