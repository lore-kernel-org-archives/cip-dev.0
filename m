Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52622FCC04D
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 17:18:53 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.74548.1772817507868725562
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Mar 2026 09:18:46 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: xXzI/eYuR5iI+YwH2Zo4dw==
X-CSE-MsgGUID: JetMEJo0Tma6tfoCa/hzEA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Mar 2026 02:18:46 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.180])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D88E84031C01;
	Sat,  7 Mar 2026 02:18:44 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip v2 12/17] spi: rzv2h-rspi: add support for variable transfer clock
Date: Fri,  6 Mar 2026 19:17:30 +0200
Message-ID: <20260306171735.226034-13-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306171735.226034-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260306171735.226034-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Mar 2026 17:18:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22137

commit 9c9bf4fdc5e5d09d5f4280ed2c582df6e1f837d9 upstream.

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have a more
complicated clocking setup for the SPI transfer clock than RZ/V2H, as
the clock from which it is generated supports multiple dividers.

To prepare for adding support for these SoCs, do the following changes.

Use the minimum frequency of SPI clock to calculate the SPI
controller's min_speed_hz, and the maximum frequency to calculate
max_speed_hz.

Apply the clock rate found by the .find_tclk_rate() to the found clock.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251119161434.595677-9-cosmin-gabriel.tanislav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * remove internal Reviewed-by tags

 drivers/spi/spi-rzv2h-rspi.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index e9d8ee919261..be45269e8853 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -308,6 +308,7 @@ static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_priv *rspi, u32 hz)
 	struct rzv2h_rspi_best_clock best_clock = {
 		.error = ULONG_MAX,
 	};
+	int ret;
 
 	rspi->info->find_tclk_rate(rspi->tclk, hz, RSPI_SPBR_SPR_MIN,
 				   RSPI_SPBR_SPR_MAX, &best_clock);
@@ -323,6 +324,10 @@ static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_priv *rspi, u32 hz)
 	if (!best_clock.clk_rate)
 		return -EINVAL;
 
+	ret = clk_set_rate(best_clock.clk, best_clock.clk_rate);
+	if (ret)
+		return 0;
+
 	rspi->use_pclk = best_clock.clk == rspi->pclk;
 	rspi->spr = best_clock.spr;
 	rspi->brdv = best_clock.brdv;
@@ -426,8 +431,8 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rzv2h_rspi_priv *rspi;
 	struct clk_bulk_data *clks;
-	unsigned long tclk_rate;
 	int irq_rx, ret, i;
+	long tclk_rate;
 
 	controller = devm_spi_alloc_host(dev, sizeof(*rspi));
 	if (!controller)
@@ -460,8 +465,6 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 	if (!rspi->tclk)
 		return dev_err_probe(dev, -EINVAL, "Failed to get tclk\n");
 
-	tclk_rate = clk_get_rate(rspi->tclk);
-
 	rspi->resets[0].id = "presetn";
 	rspi->resets[1].id = "tresetn";
 	ret = devm_reset_control_bulk_get_optional_exclusive(dev, RSPI_RESET_NUM,
@@ -493,9 +496,23 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 	controller->unprepare_message = rzv2h_rspi_unprepare_message;
 	controller->num_chipselect = 4;
 	controller->transfer_one = rzv2h_rspi_transfer_one;
+
+	tclk_rate = clk_round_rate(rspi->tclk, 0);
+	if (tclk_rate < 0) {
+		ret = tclk_rate;
+		goto quit_resets;
+	}
+
 	controller->min_speed_hz = rzv2h_rspi_calc_bitrate(tclk_rate,
 							   RSPI_SPBR_SPR_MAX,
 							   RSPI_SPCMD_BRDV_MAX);
+
+	tclk_rate = clk_round_rate(rspi->tclk, ULONG_MAX);
+	if (tclk_rate < 0) {
+		ret = tclk_rate;
+		goto quit_resets;
+	}
+
 	controller->max_speed_hz = rzv2h_rspi_calc_bitrate(tclk_rate,
 							   RSPI_SPBR_SPR_MIN,
 							   RSPI_SPCMD_BRDV_MIN);
-- 
2.53.0

