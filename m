Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14CFE77179
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 09:12:09 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.33207.1733476326952992149
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Dec 2024 01:12:07 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: hHrUg1VMT2S2Zvp57Oe7EA==
X-CSE-MsgGUID: MvtO1lB9R1+9fTA2NaWxXg==
X-IronPort-AV: E=Sophos;i="6.12,212,1728918000"; 
   d="scan'208";a="227108911"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Dec 2024 18:12:06 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9F84F41F4DFE;
	Fri,  6 Dec 2024 18:11:46 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 12/16] memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
Date: Fri,  6 Dec 2024 09:11:18 +0000
Message-ID: <20241206091122.67133-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206091122.67133-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241206091122.67133-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Dec 2024 09:12:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17355

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 3d56c7364389fce14547803fef56d6f2cab5d366 upstream.

According to the datasheets, the Strobe Timing Adjustment bit (STRTIM)
setting is different on R-Car SoCs, i.e.

R-Car M3 ES1.*  : STRTIM[2:0] is set to 0x6
other R-Car Gen3: STRTIM[2:0] is set to 0x7
other R-Car Gen4: STRTIM[3:0] is set to 0xf

To fix this issue, a DT match data was added to specify the setting
for special use cases.

Signed-off-by: Cong Dang <cong.dang.xn@renesas.com>
Signed-off-by: Hai Pham  <hai.pham.ud@renesas.com>
[wsa: rebased, restructured, added Gen4 support]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230419130234.44321-1-wsa+renesas@sang-engineering.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
[PL: dropped R-Car Gen4 changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 37 ++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 0e88c49a98c6..58bfdf3bd767 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2019-2020 Cogent Embedded, Inc.
  */
 
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -162,6 +163,11 @@ static const struct regmap_access_table rpcif_volatile_table = {
 	.n_yes_ranges	= ARRAY_SIZE(rpcif_volatile_ranges),
 };
 
+struct rpcif_info {
+	enum rpcif_type type;
+	u8 strtim;
+};
+
 struct rpcif_priv {
 	struct device *dev;
 	void __iomem *base;
@@ -170,7 +176,7 @@ struct rpcif_priv {
 	struct reset_control *rstc;
 	struct platform_device *vdev;
 	size_t size;
-	enum rpcif_type type;
+	const struct rpcif_info *info;
 	enum rpcif_data_dir dir;
 	u8 bus_size;
 	u8 xfer_size;
@@ -185,6 +191,16 @@ struct rpcif_priv {
 	u32 ddr;		/* DRDRENR or SMDRENR */
 };
 
+static const struct rpcif_info rpcif_info_gen3 = {
+	.type = RPCIF_RCAR_GEN3,
+	.strtim = 7,
+};
+
+static const struct rpcif_info rpcif_info_rz_g2l = {
+	.type = RPCIF_RZ_G2L,
+	.strtim = 7,
+};
+
 /*
  * Custom accessor functions to ensure SM[RW]DR[01] are always accessed with
  * proper width.  Requires rpcif_priv.xfer_size to be correctly set before!
@@ -309,7 +325,7 @@ int rpcif_hw_init(struct rpcif *rpcif, bool hyperflash)
 	if (ret)
 		return ret;
 
-	if (rpc->type == RPCIF_RZ_G2L) {
+	if (rpc->info->type == RPCIF_RZ_G2L) {
 		ret = reset_control_reset(rpc->rstc);
 		if (ret)
 			return ret;
@@ -323,9 +339,10 @@ int rpcif_hw_init(struct rpcif *rpcif, bool hyperflash)
 	/* DMA Transfer is not supported */
 	regmap_update_bits(rpc->regmap, RPCIF_PHYCNT, RPCIF_PHYCNT_HS, 0);
 
-	if (rpc->type == RPCIF_RCAR_GEN3)
-		regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
-				   RPCIF_PHYCNT_STRTIM(7), RPCIF_PHYCNT_STRTIM(7));
+	regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
+			   /* create mask with all affected bits set */
+			   RPCIF_PHYCNT_STRTIM(BIT(fls(rpc->info->strtim)) - 1),
+			   RPCIF_PHYCNT_STRTIM(rpc->info->strtim));
 
 	regmap_update_bits(rpc->regmap, RPCIF_PHYOFFSET1, RPCIF_PHYOFFSET1_DDRTMG(3),
 			   RPCIF_PHYOFFSET1_DDRTMG(3));
@@ -336,7 +353,7 @@ int rpcif_hw_init(struct rpcif *rpcif, bool hyperflash)
 		regmap_update_bits(rpc->regmap, RPCIF_PHYINT,
 				   RPCIF_PHYINT_WPVAL, 0);
 
-	if (rpc->type == RPCIF_RCAR_GEN3)
+	if (rpc->info->type == RPCIF_RCAR_GEN3)
 		regmap_update_bits(rpc->regmap, RPCIF_CMNCR,
 				   RPCIF_CMNCR_MOIIO(3) | RPCIF_CMNCR_BSZ(3),
 				   RPCIF_CMNCR_MOIIO(3) |
@@ -725,9 +742,9 @@ static int rpcif_probe(struct platform_device *pdev)
 	rpc->dirmap = devm_ioremap_resource(dev, res);
 	if (IS_ERR(rpc->dirmap))
 		return PTR_ERR(rpc->dirmap);
-	rpc->size = resource_size(res);
 
-	rpc->type = (uintptr_t)of_device_get_match_data(dev);
+	rpc->size = resource_size(res);
+	rpc->info = of_device_get_match_data(dev);
 	rpc->rstc = devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(rpc->rstc))
 		return PTR_ERR(rpc->rstc);
@@ -760,8 +777,8 @@ static int rpcif_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id rpcif_of_match[] = {
-	{ .compatible = "renesas,rcar-gen3-rpc-if", .data = (void *)RPCIF_RCAR_GEN3 },
-	{ .compatible = "renesas,rzg2l-rpc-if", .data = (void *)RPCIF_RZ_G2L },
+	{ .compatible = "renesas,rcar-gen3-rpc-if", .data = &rpcif_info_gen3 },
+	{ .compatible = "renesas,rzg2l-rpc-if", .data = &rpcif_info_rz_g2l },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rpcif_of_match);
-- 
2.43.0


