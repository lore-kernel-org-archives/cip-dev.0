Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4CAC433F5
	for <webhook@archiver.kernel.org>; Mon, 31 Jan 2022 12:19:27 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.31207.1643631563602998327
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Jan 2022 04:19:27 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,330,1635174000";
   d="scan'208";a="108906310"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 31 Jan 2022 21:19:26 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DC0664347FE1;
	Mon, 31 Jan 2022 21:19:25 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 16/27] memory: renesas-rpc-if: Add support for
 RZ/G2L
Date: Mon, 31 Jan 2022 12:18:52 +0000
Message-Id: <20220131121903.8620-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Jan 2022 12:19:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7537

commit b04cc0d912eb80d3c438b11d96ca847c3e77e8ab upstream.

SPI Multi I/O Bus Controller on RZ/G2L SoC is almost identical to
the RPC-IF interface found on R-Car Gen3 SoC's.

This patch adds a new compatible string for the RZ/G2L family so
that the timing values on RZ/G2L can be adjusted.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20211025205631.21151-8-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 72 ++++++++++++++++++++++++++++-----
 drivers/mtd/hyperbus/rpc-if.c   |  4 +-
 drivers/spi/spi-rpc-if.c        |  4 +-
 include/memory/renesas-rpc-if.h |  8 +++-
 4 files changed, 75 insertions(+), 13 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 140cb4e2b789..7e20853df4a2 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
@@ -27,8 +28,8 @@
 #define RPCIF_CMNCR_MOIIO_HIZ	(RPCIF_CMNCR_MOIIO0(3) | \
 				 RPCIF_CMNCR_MOIIO1(3) | \
 				 RPCIF_CMNCR_MOIIO2(3) | RPCIF_CMNCR_MOIIO3(3))
-#define RPCIF_CMNCR_IO3FV(val)	(((val) & 0x3) << 14) /* undocumented */
-#define RPCIF_CMNCR_IO2FV(val)	(((val) & 0x3) << 12) /* undocumented */
+#define RPCIF_CMNCR_IO3FV(val)	(((val) & 0x3) << 14) /* documented for RZ/G2L */
+#define RPCIF_CMNCR_IO2FV(val)	(((val) & 0x3) << 12) /* documented for RZ/G2L */
 #define RPCIF_CMNCR_IO0FV(val)	(((val) & 0x3) << 8)
 #define RPCIF_CMNCR_IOFV_HIZ	(RPCIF_CMNCR_IO0FV(3) | RPCIF_CMNCR_IO2FV(3) | \
 				 RPCIF_CMNCR_IO3FV(3))
@@ -126,6 +127,9 @@
 #define RPCIF_SMDRENR_OPDRE	BIT(4)
 #define RPCIF_SMDRENR_SPIDRE	BIT(0)
 
+#define RPCIF_PHYADD		0x0070	/* R/W available on R-Car E3/D3/V3M and RZ/G2{E,L} */
+#define RPCIF_PHYWR		0x0074	/* R/W available on R-Car E3/D3/V3M and RZ/G2{E,L} */
+
 #define RPCIF_PHYCNT		0x007C	/* R/W */
 #define RPCIF_PHYCNT_CAL	BIT(31)
 #define RPCIF_PHYCNT_OCTA(v)	(((v) & 0x3) << 22)
@@ -133,10 +137,12 @@
 #define RPCIF_PHYCNT_OCT	BIT(20)
 #define RPCIF_PHYCNT_DDRCAL	BIT(19)
 #define RPCIF_PHYCNT_HS		BIT(18)
-#define RPCIF_PHYCNT_STRTIM(v)	(((v) & 0x7) << 15)
+#define RPCIF_PHYCNT_CKSEL(v)	(((v) & 0x3) << 16) /* valid only for RZ/G2L */
+#define RPCIF_PHYCNT_STRTIM(v)	(((v) & 0x7) << 15) /* valid for R-Car and RZ/G2{E,H,M,N} */
 #define RPCIF_PHYCNT_WBUF2	BIT(4)
 #define RPCIF_PHYCNT_WBUF	BIT(2)
 #define RPCIF_PHYCNT_PHYMEM(v)	(((v) & 0x3) << 0)
+#define RPCIF_PHYCNT_PHYMEM_MASK GENMASK(1, 0)
 
 #define RPCIF_PHYOFFSET1	0x0080	/* R/W */
 #define RPCIF_PHYOFFSET1_DDRTMG(v) (((v) & 0x3) << 28)
@@ -245,18 +251,46 @@ int rpcif_sw_init(struct rpcif *rpc, struct device *dev)
 		return PTR_ERR(rpc->dirmap);
 	rpc->size = resource_size(res);
 
+	rpc->type = (enum rpcif_type)of_device_get_match_data(dev);
 	rpc->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 
 	return PTR_ERR_OR_ZERO(rpc->rstc);
 }
 EXPORT_SYMBOL(rpcif_sw_init);
 
-void rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
+static void rpcif_rzg2l_timing_adjust_sdr(struct rpcif *rpc)
+{
+	u32 data;
+
+	regmap_write(rpc->regmap, RPCIF_PHYWR, 0xa5390000);
+	regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000000);
+	regmap_write(rpc->regmap, RPCIF_PHYWR, 0x00008080);
+	regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000022);
+	regmap_write(rpc->regmap, RPCIF_PHYWR, 0x00008080);
+	regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000024);
+
+	regmap_read(rpc->regmap, RPCIF_PHYCNT, &data);
+	regmap_write(rpc->regmap, RPCIF_PHYCNT, data | RPCIF_PHYCNT_CKSEL(3));
+	regmap_write(rpc->regmap, RPCIF_PHYWR, 0x00000030);
+	regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000032);
+}
+
+int rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
 {
 	u32 dummy;
 
 	pm_runtime_get_sync(rpc->dev);
 
+	if (rpc->type == RPCIF_RZ_G2L) {
+		int ret;
+
+		ret = reset_control_reset(rpc->rstc);
+		if (ret)
+			return ret;
+		usleep_range(200, 300);
+		rpcif_rzg2l_timing_adjust_sdr(rpc);
+	}
+
 	/*
 	 * NOTE: The 0x260 are undocumented bits, but they must be set.
 	 *	 RPCIF_PHYCNT_STRTIM is strobe timing adjustment bits,
@@ -265,8 +299,15 @@ void rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
 	 *	 On H3 ES1.x, the value should be 0, while on others,
 	 *	 the value should be 7.
 	 */
-	regmap_write(rpc->regmap, RPCIF_PHYCNT, RPCIF_PHYCNT_STRTIM(7) |
-		     RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260);
+	if (rpc->type == RPCIF_RCAR_GEN3) {
+		regmap_write(rpc->regmap, RPCIF_PHYCNT, RPCIF_PHYCNT_STRTIM(7) |
+			     RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260);
+	} else {
+		regmap_read(rpc->regmap, RPCIF_PHYCNT, &dummy);
+		dummy &= ~RPCIF_PHYCNT_PHYMEM_MASK;
+		dummy |= RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260;
+		regmap_write(rpc->regmap, RPCIF_PHYCNT, dummy);
+	}
 
 	/*
 	 * NOTE: The 0x1511144 are undocumented bits, but they must be set
@@ -283,9 +324,17 @@ void rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
 		regmap_update_bits(rpc->regmap, RPCIF_PHYINT,
 				   RPCIF_PHYINT_WPVAL, 0);
 
-	regmap_write(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_SFDE |
-		     RPCIF_CMNCR_MOIIO_HIZ | RPCIF_CMNCR_IOFV_HIZ |
-		     RPCIF_CMNCR_BSZ(hyperflash ? 1 : 0));
+	if (rpc->type == RPCIF_RCAR_GEN3)
+		regmap_write(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_SFDE |
+			     RPCIF_CMNCR_MOIIO_HIZ | RPCIF_CMNCR_IOFV_HIZ |
+			     RPCIF_CMNCR_BSZ(hyperflash ? 1 : 0));
+	else
+		regmap_write(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_SFDE |
+			     RPCIF_CMNCR_MOIIO3(1) | RPCIF_CMNCR_MOIIO2(1) |
+			     RPCIF_CMNCR_MOIIO1(1) | RPCIF_CMNCR_MOIIO0(1) |
+			     RPCIF_CMNCR_IO3FV(2) | RPCIF_CMNCR_IO2FV(2) |
+			     RPCIF_CMNCR_IO0FV(2) | RPCIF_CMNCR_BSZ(hyperflash ? 1 : 0));
+
 	/* Set RCF after BSZ update */
 	regmap_write(rpc->regmap, RPCIF_DRCR, RPCIF_DRCR_RCF);
 	/* Dummy read according to spec */
@@ -296,6 +345,8 @@ void rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
 	pm_runtime_put(rpc->dev);
 
 	rpc->bus_size = hyperflash ? 2 : 1;
+
+	return 0;
 }
 EXPORT_SYMBOL(rpcif_hw_init);
 
@@ -613,7 +664,8 @@ static int rpcif_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id rpcif_of_match[] = {
-	{ .compatible = "renesas,rcar-gen3-rpc-if", },
+	{ .compatible = "renesas,rcar-gen3-rpc-if", .data = (void *)RPCIF_RCAR_GEN3 },
+	{ .compatible = "renesas,rzg2l-rpc-if", .data = (void *)RPCIF_RZ_G2L },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rpcif_of_match);
diff --git a/drivers/mtd/hyperbus/rpc-if.c b/drivers/mtd/hyperbus/rpc-if.c
index 367b0d72bf62..40bca89268c3 100644
--- a/drivers/mtd/hyperbus/rpc-if.c
+++ b/drivers/mtd/hyperbus/rpc-if.c
@@ -132,7 +132,9 @@ static int rpcif_hb_probe(struct platform_device *pdev)
 
 	rpcif_enable_rpm(&hyperbus->rpc);
 
-	rpcif_hw_init(&hyperbus->rpc, true);
+	error = rpcif_hw_init(&hyperbus->rpc, true);
+	if (error)
+		return error;
 
 	hyperbus->hbdev.map.size = hyperbus->rpc.size;
 	hyperbus->hbdev.map.virt = hyperbus->rpc.dirmap;
diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index 727d7cf0a6ad..651d92028306 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -156,7 +156,9 @@ static int rpcif_spi_probe(struct platform_device *pdev)
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_QUAD | SPI_RX_QUAD;
 	ctlr->flags = SPI_CONTROLLER_HALF_DUPLEX;
 
-	rpcif_hw_init(rpc, false);
+	error = rpcif_hw_init(rpc, false);
+	if (error)
+		return error;
 
 	error = spi_register_controller(ctlr);
 	if (error) {
diff --git a/include/memory/renesas-rpc-if.h b/include/memory/renesas-rpc-if.h
index 77c694a19149..7c93f5177532 100644
--- a/include/memory/renesas-rpc-if.h
+++ b/include/memory/renesas-rpc-if.h
@@ -57,6 +57,11 @@ struct rpcif_op {
 	} data;
 };
 
+enum rpcif_type {
+	RPCIF_RCAR_GEN3,
+	RPCIF_RZ_G2L,
+};
+
 struct rpcif {
 	struct device *dev;
 	void __iomem *base;
@@ -64,6 +69,7 @@ struct rpcif {
 	struct regmap *regmap;
 	struct reset_control *rstc;
 	size_t size;
+	enum rpcif_type type;
 	enum rpcif_data_dir dir;
 	u8 bus_size;
 	void *buffer;
@@ -78,7 +84,7 @@ struct rpcif {
 };
 
 int rpcif_sw_init(struct rpcif *rpc, struct device *dev);
-void rpcif_hw_init(struct rpcif *rpc, bool hyperflash);
+int rpcif_hw_init(struct rpcif *rpc, bool hyperflash);
 void rpcif_prepare(struct rpcif *rpc, const struct rpcif_op *op, u64 *offs,
 		   size_t *len);
 int rpcif_manual_xfer(struct rpcif *rpc);
-- 
2.17.1


