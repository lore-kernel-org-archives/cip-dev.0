Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23301C54E69
	for <webhook@archiver.kernel.org>; Thu, 14 Mar 2024 19:30:02 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.1808.1710444597208809443
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Mar 2024 12:29:57 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.07,126,1708354800"; 
   d="scan'208";a="197762395"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 Mar 2024 04:29:56 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.128])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4688A4001B5F;
	Fri, 15 Mar 2024 04:29:55 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 4.19.y-cip 2/9] memory: renesas-rpc-if: Correct QSPI data transfer in Manual mode
Date: Thu, 14 Mar 2024 19:29:43 +0000
Message-Id: <20240314192950.27343-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240314192950.27343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240314192950.27343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Mar 2024 19:30:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15310

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit fff53a551db50f5edecaa0b29a64056ab8d2bbca upstream.

This patch fixes 2 problems:
[1] The output warning logs and data loss when performing
mount/umount then remount the device with jffs2 format.
[2] The access width of SMWDR[0:1]/SMRDR[0:1] register is wrong.

This is the sample warning logs when performing mount/umount then
remount the device with jffs2 format:
jffs2: jffs2_scan_inode_node(): CRC failed on node at 0x031c51d4:
Read 0x00034e00, calculated 0xadb272a7

The reason for issue [1] is that the writing data seems to
get messed up.
Data is only completed when the number of bytes is divisible by 4.
If you only have 3 bytes of data left to write, 1 garbage byte
is inserted after the end of the write stream.
If you only have 2 bytes of data left to write, 2 bytes of '00'
are added into the write stream.
If you only have 1 byte of data left to write, 2 bytes of '00'
are added into the write stream. 1 garbage byte is inserted after
the end of the write stream.

To solve problem [1], data must be written continuously in serial
and the write stream ends when data is out.

Following HW manual 62.2.15, access to SMWDR0 register should be
in the same size as the transfer size specified in the SPIDE[3:0]
bits in the manual mode enable setting register (SMENR).
Be sure to access from address 0.

So, in 16-bit transfer (SPIDE[3:0]=b'1100), SMWDR0 should be
accessed by 16-bit width.
Similar to SMWDR1, SMDDR0/1 registers.
In current code, SMWDR0 register is accessed by regmap_write()
that only set up to do 32-bit width.

To solve problem [2], data must be written 16-bit or 8-bit when
transferring 1-byte or 2-byte.

Fixes: ca7d8b980b67 ("memory: add Renesas RPC-IF driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Duc Nguyen <duc.nguyen.ub@renesas.com>
[wsa: refactored to use regmap only via reg_read/reg_write]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20210922091007.5516-1-wsa+renesas@sang-engineering.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 113 ++++++++++++++++++++++----------
 include/memory/renesas-rpc-if.h |   1 +
 2 files changed, 79 insertions(+), 35 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 15bed5be96e3..4a9fd90b1a79 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -160,10 +160,62 @@ static const struct regmap_access_table rpcif_volatile_table = {
 	.n_yes_ranges	= ARRAY_SIZE(rpcif_volatile_ranges),
 };
 
+
+/*
+ * Custom accessor functions to ensure SMRDR0 and SMWDR0 are always accessed
+ * with proper width. Requires SMENR_SPIDE to be correctly set before!
+ */
+static int rpcif_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct rpcif *rpc = context;
+
+	if (reg == RPCIF_SMRDR0 || reg == RPCIF_SMWDR0) {
+		u32 spide = readl(rpc->base + RPCIF_SMENR) & RPCIF_SMENR_SPIDE(0xF);
+
+		if (spide == 0x8) {
+			*val = readb(rpc->base + reg);
+			return 0;
+		} else if (spide == 0xC) {
+			*val = readw(rpc->base + reg);
+			return 0;
+		} else if (spide != 0xF) {
+			return -EILSEQ;
+		}
+	}
+
+	*val = readl(rpc->base + reg);
+	return 0;
+
+}
+
+static int rpcif_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct rpcif *rpc = context;
+
+	if (reg == RPCIF_SMRDR0 || reg == RPCIF_SMWDR0) {
+		u32 spide = readl(rpc->base + RPCIF_SMENR) & RPCIF_SMENR_SPIDE(0xF);
+
+		if (spide == 0x8) {
+			writeb(val, rpc->base + reg);
+			return 0;
+		} else if (spide == 0xC) {
+			writew(val, rpc->base + reg);
+			return 0;
+		} else if (spide != 0xF) {
+			return -EILSEQ;
+		}
+	}
+
+	writel(val, rpc->base + reg);
+	return 0;
+}
+
 static const struct regmap_config rpcif_regmap_config = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
 	.reg_stride	= 4,
+	.reg_read	= rpcif_reg_read,
+	.reg_write	= rpcif_reg_write,
 	.fast_io	= true,
 	.max_register	= RPCIF_PHYINT,
 	.volatile_table	= &rpcif_volatile_table,
@@ -173,17 +225,15 @@ int rpcif_sw_init(struct rpcif *rpc, struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *res;
-	void __iomem *base;
 
 	rpc->dev = dev;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
-	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	rpc->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(rpc->base))
+		return PTR_ERR(rpc->base);
 
-	rpc->regmap = devm_regmap_init_mmio(&pdev->dev, base,
-					    &rpcif_regmap_config);
+	rpc->regmap = devm_regmap_init(&pdev->dev, NULL, rpc, &rpcif_regmap_config);
 	if (IS_ERR(rpc->regmap)) {
 		dev_err(&pdev->dev,
 			"failed to init regmap for rpcif, error %ld\n",
@@ -356,20 +406,16 @@ void rpcif_prepare(struct rpcif *rpc, const struct rpcif_op *op, u64 *offs,
 			nbytes = op->data.nbytes;
 		rpc->xferlen = nbytes;
 
-		rpc->enable |= RPCIF_SMENR_SPIDE(rpcif_bits_set(rpc, nbytes)) |
-			RPCIF_SMENR_SPIDB(rpcif_bit_size(op->data.buswidth));
+		rpc->enable |= RPCIF_SMENR_SPIDB(rpcif_bit_size(op->data.buswidth));
 	}
 }
 EXPORT_SYMBOL(rpcif_prepare);
 
 int rpcif_manual_xfer(struct rpcif *rpc)
 {
-	u32 smenr, smcr, pos = 0, max = 4;
+	u32 smenr, smcr, pos = 0, max = rpc->bus_size == 2 ? 8 : 4;
 	int ret = 0;
 
-	if (rpc->bus_size == 2)
-		max = 8;
-
 	pm_runtime_get_sync(rpc->dev);
 
 	regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
@@ -380,37 +426,36 @@ int rpcif_manual_xfer(struct rpcif *rpc)
 	regmap_write(rpc->regmap, RPCIF_SMOPR, rpc->option);
 	regmap_write(rpc->regmap, RPCIF_SMDMCR, rpc->dummy);
 	regmap_write(rpc->regmap, RPCIF_SMDRENR, rpc->ddr);
+	regmap_write(rpc->regmap, RPCIF_SMADR, rpc->smadr);
 	smenr = rpc->enable;
 
 	switch (rpc->dir) {
 	case RPCIF_DATA_OUT:
 		while (pos < rpc->xferlen) {
-			u32 nbytes = rpc->xferlen - pos;
-			u32 data[2];
+			u32 bytes_left = rpc->xferlen - pos;
+			u32 nbytes, data[2];
 
 			smcr = rpc->smcr | RPCIF_SMCR_SPIE;
-			if (nbytes > max) {
-				nbytes = max;
+
+			/* nbytes may only be 1, 2, 4, or 8 */
+			nbytes = bytes_left >= max ? max : (1 << ilog2(bytes_left));
+			if (bytes_left > nbytes)
 				smcr |= RPCIF_SMCR_SSLKP;
-			}
+
+			smenr |= RPCIF_SMENR_SPIDE(rpcif_bits_set(rpc, nbytes));
+			regmap_write(rpc->regmap, RPCIF_SMENR, smenr);
 
 			memcpy(data, rpc->buffer + pos, nbytes);
-			if (nbytes > 4) {
+			if (nbytes == 8) {
 				regmap_write(rpc->regmap, RPCIF_SMWDR1,
 					     data[0]);
 				regmap_write(rpc->regmap, RPCIF_SMWDR0,
 					     data[1]);
-			} else if (nbytes > 2) {
+			} else {
 				regmap_write(rpc->regmap, RPCIF_SMWDR0,
 					     data[0]);
-			} else	{
-				regmap_write(rpc->regmap, RPCIF_SMWDR0,
-					     data[0] << 16);
 			}
 
-			regmap_write(rpc->regmap, RPCIF_SMADR,
-				     rpc->smadr + pos);
-			regmap_write(rpc->regmap, RPCIF_SMENR, smenr);
 			regmap_write(rpc->regmap, RPCIF_SMCR, smcr);
 			ret = wait_msg_xfer_end(rpc);
 			if (ret)
@@ -450,14 +495,16 @@ int rpcif_manual_xfer(struct rpcif *rpc)
 			break;
 		}
 		while (pos < rpc->xferlen) {
-			u32 nbytes = rpc->xferlen - pos;
-			u32 data[2];
+			u32 bytes_left = rpc->xferlen - pos;
+			u32 nbytes, data[2];
 
-			if (nbytes > max)
-				nbytes = max;
+			/* nbytes may only be 1, 2, 4, or 8 */
+			nbytes = bytes_left >= max ? max : (1 << ilog2(bytes_left));
 
 			regmap_write(rpc->regmap, RPCIF_SMADR,
 				     rpc->smadr + pos);
+			smenr &= ~RPCIF_SMENR_SPIDE(0xF);
+			smenr |= RPCIF_SMENR_SPIDE(rpcif_bits_set(rpc, nbytes));
 			regmap_write(rpc->regmap, RPCIF_SMENR, smenr);
 			regmap_write(rpc->regmap, RPCIF_SMCR,
 				     rpc->smcr | RPCIF_SMCR_SPIE);
@@ -465,18 +512,14 @@ int rpcif_manual_xfer(struct rpcif *rpc)
 			if (ret)
 				goto err_out;
 
-			if (nbytes > 4) {
+			if (nbytes == 8) {
 				regmap_read(rpc->regmap, RPCIF_SMRDR1,
 					    &data[0]);
 				regmap_read(rpc->regmap, RPCIF_SMRDR0,
 					    &data[1]);
-			} else if (nbytes > 2) {
-				regmap_read(rpc->regmap, RPCIF_SMRDR0,
-					    &data[0]);
-			} else	{
+			} else {
 				regmap_read(rpc->regmap, RPCIF_SMRDR0,
 					    &data[0]);
-				data[0] >>= 16;
 			}
 			memcpy(rpc->buffer + pos, data, nbytes);
 
diff --git a/include/memory/renesas-rpc-if.h b/include/memory/renesas-rpc-if.h
index 14cfd036268a..2df18b7a35fa 100644
--- a/include/memory/renesas-rpc-if.h
+++ b/include/memory/renesas-rpc-if.h
@@ -59,6 +59,7 @@ struct	rpcif_op {
 
 struct	rpcif {
 	struct device *dev;
+	void __iomem *base;
 	void __iomem *dirmap;
 	struct regmap *regmap;
 	struct reset_control *rstc;
-- 
2.34.1


