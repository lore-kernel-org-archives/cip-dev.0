Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D31AC3DA4A
	for <webhook@archiver.kernel.org>; Wed, 23 Apr 2025 21:05:19 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.494.1745442306767471673
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Apr 2025 14:05:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: nJfM8hkGQ9KtjvhW7Yb52w==
X-CSE-MsgGUID: yrsnW0PcSsq0g5TEbW/PfQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Apr 2025 06:05:17 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 66BC9401C946;
	Thu, 24 Apr 2025 06:05:16 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.12.y-cip 8/8] i2c: riic: Add `riic_bus_barrier()` to check bus availability
Date: Wed, 23 Apr 2025 22:04:58 +0100
Message-ID: <20250423210458.14698-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423210458.14698-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250423210458.14698-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Apr 2025 21:05:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18591

commit b31addf2a08bc5c16dfd6eae8785546f3eea92b8 upstream.

Introduce a new `riic_bus_barrier()` function to verify bus availability
before initiating an I2C transfer. This function enhances the bus
arbitration check by ensuring that the SDA and SCL lines are not held low,
in addition to checking the BBSY flag using `readb_poll_timeout()`.

Previously, only the BBSY flag was checked to determine bus availability.
However, it is possible for the SDA line to remain low even when BBSY = 0.
This new implementation performs an additional check on the SDA and SCL
lines to avoid potential bus contention issues.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 506b21423e75..79540179fbd8 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -41,6 +41,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -51,6 +52,8 @@
 #define ICCR1_ICE	BIT(7)
 #define ICCR1_IICRST	BIT(6)
 #define ICCR1_SOWP	BIT(4)
+#define ICCR1_SCLI	BIT(1)
+#define ICCR1_SDAI	BIT(0)
 
 #define ICCR2_BBSY	BIT(7)
 #define ICCR2_SP	BIT(3)
@@ -136,6 +139,27 @@ static inline void riic_clear_set_bit(struct riic_dev *riic, u8 clear, u8 set, u
 	riic_writeb(riic, (riic_readb(riic, reg) & ~clear) | set, reg);
 }
 
+static int riic_bus_barrier(struct riic_dev *riic)
+{
+	int ret;
+	u8 val;
+
+	/*
+	 * The SDA line can still be low even when BBSY = 0. Therefore, after checking
+	 * the BBSY flag, also verify that the SDA and SCL lines are not being held low.
+	 */
+	ret = readb_poll_timeout(riic->base + riic->info->regs[RIIC_ICCR2], val,
+				 !(val & ICCR2_BBSY), 10, riic->adapter.timeout);
+	if (ret)
+		return ret;
+
+	if ((riic_readb(riic, RIIC_ICCR1) & (ICCR1_SDAI | ICCR1_SCLI)) !=
+	     (ICCR1_SDAI | ICCR1_SCLI))
+		return -EBUSY;
+
+	return 0;
+}
+
 static int riic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 {
 	struct riic_dev *riic = i2c_get_adapdata(adap);
@@ -148,13 +172,11 @@ static int riic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	if (ret)
 		return ret;
 
-	if (riic_readb(riic, RIIC_ICCR2) & ICCR2_BBSY) {
-		riic->err = -EBUSY;
+	riic->err = riic_bus_barrier(riic);
+	if (riic->err)
 		goto out;
-	}
 
 	reinit_completion(&riic->msg_done);
-	riic->err = 0;
 
 	riic_writeb(riic, 0, RIIC_ICSR2);
 
-- 
2.43.0


