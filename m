Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B284FCC04D
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 17:18:43 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.74548.1772817507868725562
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Mar 2026 09:18:42 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: ifcouXA0TmqnQgDtoOnhsg==
X-CSE-MsgGUID: YyFQ3Et6TN254/za6epnxQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Mar 2026 02:18:42 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.180])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 57D674031FE8;
	Sat,  7 Mar 2026 02:18:41 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip v2 10/17] spi: rzv2h-rspi: make transfer clock rate finding chip-specific
Date: Fri,  6 Mar 2026 19:17:28 +0200
Message-ID: <20260306171735.226034-11-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306171735.226034-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260306171735.226034-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Mar 2026 17:18:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22135

commit 77d931584dd38916b66c65320c80a65cbef4b122 upstream.

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have a more
complicated clocking setup for the SPI transfer clock than RZ/V2H, as
the clock from which it is generated supports multiple dividers.

To prepare for adding support for these SoCs, split out the logic for
finding the SPR and BRDV for a fixed clock into
rzv2h_rspi_find_rate_fixed(), and add and use a .find_tclk_rate()
callback into the chip-specific structure.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251119161434.595677-7-cosmin-gabriel.tanislav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * remove internal Reviewed-by tags

 drivers/spi/spi-rzv2h-rspi.c | 62 ++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index d7719f3c7b13..f59bcadf5e38 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -67,7 +67,18 @@
 
 #define RSPI_RESET_NUM		2
 
+struct rzv2h_rspi_best_clock {
+	struct clk *clk;
+	unsigned long clk_rate;
+	unsigned long error;
+	u32 actual_hz;
+	u8 brdv;
+	u8 spr;
+};
+
 struct rzv2h_rspi_info {
+	void (*find_tclk_rate)(struct clk *clk, u32 hz, u8 spr_min, u8 spr_max,
+			       struct rzv2h_rspi_best_clock *best_clk);
 	const char *tclk_name;
 	unsigned int fifo_size;
 	unsigned int num_clks;
@@ -240,9 +251,13 @@ static inline u32 rzv2h_rspi_calc_bitrate(unsigned long tclk_rate, u8 spr,
 	return DIV_ROUND_UP(tclk_rate, (2 * (spr + 1) * (1 << brdv)));
 }
 
-static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_priv *rspi, u32 hz)
+static void rzv2h_rspi_find_rate_fixed(struct clk *clk, u32 hz,
+				       u8 spr_min, u8 spr_max,
+				       struct rzv2h_rspi_best_clock *best)
 {
-	unsigned long tclk_rate;
+	unsigned long clk_rate;
+	unsigned long error;
+	u32 actual_hz;
 	int spr;
 	u8 brdv;
 
@@ -255,21 +270,49 @@ static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_priv *rspi, u32 hz)
 	 * * n = SPR - is RSPI_SPBR.SPR (from 0 to 255)
 	 * * N = BRDV - is RSPI_SPCMD.BRDV (from 0 to 3)
 	 */
-	tclk_rate = clk_get_rate(rspi->tclk);
+	clk_rate = clk_get_rate(clk);
 	for (brdv = RSPI_SPCMD_BRDV_MIN; brdv <= RSPI_SPCMD_BRDV_MAX; brdv++) {
-		spr = DIV_ROUND_UP(tclk_rate, hz * (1 << (brdv + 1)));
+		spr = DIV_ROUND_UP(clk_rate, hz * (1 << (brdv + 1)));
 		spr--;
-		if (spr >= RSPI_SPBR_SPR_MIN && spr <= RSPI_SPBR_SPR_MAX)
+		if (spr >= spr_min && spr <= spr_max)
 			goto clock_found;
 	}
 
-	return 0;
+	return;
 
 clock_found:
-	rspi->spr = spr;
-	rspi->brdv = brdv;
+	actual_hz = rzv2h_rspi_calc_bitrate(clk_rate, spr, brdv);
+	error = abs((long)hz - (long)actual_hz);
 
-	return rzv2h_rspi_calc_bitrate(tclk_rate, spr, brdv);
+	if (error >= best->error)
+		return;
+
+	*best = (struct rzv2h_rspi_best_clock) {
+		.clk = clk,
+		.clk_rate = clk_rate,
+		.error = error,
+		.actual_hz = actual_hz,
+		.brdv = brdv,
+		.spr = spr,
+	};
+}
+
+static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_priv *rspi, u32 hz)
+{
+	struct rzv2h_rspi_best_clock best_clock = {
+		.error = ULONG_MAX,
+	};
+
+	rspi->info->find_tclk_rate(rspi->tclk, hz, RSPI_SPBR_SPR_MIN,
+				   RSPI_SPBR_SPR_MAX, &best_clock);
+
+	if (!best_clock.clk_rate)
+		return -EINVAL;
+
+	rspi->spr = best_clock.spr;
+	rspi->brdv = best_clock.brdv;
+
+	return best_clock.actual_hz;
 }
 
 static int rzv2h_rspi_prepare_message(struct spi_controller *ctlr,
@@ -463,6 +506,7 @@ static void rzv2h_rspi_remove(struct platform_device *pdev)
 }
 
 static const struct rzv2h_rspi_info rzv2h_info = {
+	.find_tclk_rate = rzv2h_rspi_find_rate_fixed,
 	.tclk_name = "tclk",
 	.fifo_size = 16,
 	.num_clks = 3,
-- 
2.53.0

