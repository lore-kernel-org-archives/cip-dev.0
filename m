Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132E3F417F7
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 15:07:20 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16933.1773068839276120535
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 08:07:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: cU+R5nIfTJiWm7l7m1ELkQ==
X-CSE-MsgGUID: X1/qTZOiQGqQ41X8Ye4yrg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 10 Mar 2026 00:07:18 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.213])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8A99A400720E;
	Tue, 10 Mar 2026 00:07:17 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip v3 06/17] spi: rzv2h-rspi: make FIFO size chip-specific
Date: Mon,  9 Mar 2026 17:06:08 +0200
Message-ID: <20260309150619.761962-7-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309150619.761962-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260309150619.761962-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 15:07:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22204

commit 8e89ee6cd2b928a8431bef61e8b851ce5df1ecb0 upstream.

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have a
different FIFO size compared to RZ/V2H. Add a chip-specific structure,
and set the FIFO size inside it, to prepare for adding support for them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251119161434.595677-3-cosmin-gabriel.tanislav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V3:
 * no changes

V2:
 * remove internal Reviewed-by tags

 drivers/spi/spi-rzv2h-rspi.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 09b9362e9b1f..7a7a576c17dd 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -58,7 +58,6 @@
 /* Register SPDCR2 */
 #define RSPI_SPDCR2_TTRG	GENMASK(11, 8)
 #define RSPI_SPDCR2_RTRG	GENMASK(3, 0)
-#define RSPI_FIFO_SIZE		16
 
 /* Register SPSR */
 #define RSPI_SPSR_SPRF		BIT(15)
@@ -69,9 +68,14 @@
 #define RSPI_RESET_NUM		2
 #define RSPI_CLK_NUM		3
 
+struct rzv2h_rspi_info {
+	unsigned int fifo_size;
+};
+
 struct rzv2h_rspi_priv {
 	struct reset_control_bulk_data resets[RSPI_RESET_NUM];
 	struct spi_controller *controller;
+	const struct rzv2h_rspi_info *info;
 	void __iomem *base;
 	struct clk *tclk;
 	wait_queue_head_t wait;
@@ -305,7 +309,7 @@ static int rzv2h_rspi_prepare_message(struct spi_controller *ctlr,
 		writeb(0, rspi->base + RSPI_SSLP);
 
 	/* Setup FIFO thresholds */
-	conf16 = FIELD_PREP(RSPI_SPDCR2_TTRG, RSPI_FIFO_SIZE - 1);
+	conf16 = FIELD_PREP(RSPI_SPDCR2_TTRG, rspi->info->fifo_size - 1);
 	conf16 |= FIELD_PREP(RSPI_SPDCR2_RTRG, 0);
 	writew(conf16, rspi->base + RSPI_SPDCR2);
 
@@ -362,6 +366,8 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 
 	rspi->controller = controller;
 
+	rspi->info = device_get_match_data(dev);
+
 	rspi->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rspi->base))
 		return PTR_ERR(rspi->base);
@@ -445,8 +451,12 @@ static void rzv2h_rspi_remove(struct platform_device *pdev)
 	reset_control_bulk_assert(RSPI_RESET_NUM, rspi->resets);
 }
 
+static const struct rzv2h_rspi_info rzv2h_info = {
+	.fifo_size = 16,
+};
+
 static const struct of_device_id rzv2h_rspi_match[] = {
-	{ .compatible = "renesas,r9a09g057-rspi" },
+	{ .compatible = "renesas,r9a09g057-rspi", &rzv2h_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzv2h_rspi_match);
-- 
2.53.0

