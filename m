Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE1DC10F1D
	for <webhook@archiver.kernel.org>; Tue, 13 Dec 2022 17:23:38 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.79731.1670952204464812552
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Dec 2022 09:23:30 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.96,241,1665414000"; 
   d="scan'208";a="143214816"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Dec 2022 02:23:30 +0900
Received: from localhost.localdomain (unknown [10.226.93.72])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6C0684053D07;
	Wed, 14 Dec 2022 02:23:28 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 4/7] can: rcar_canfd: rcar_canfd_probe: Add struct rcar_canfd_hw_info to driver data
Date: Tue, 13 Dec 2022 17:23:13 +0000
Message-Id: <20221213172316.1848032-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221213172316.1848032-1-biju.das.jz@bp.renesas.com>
References: <20221213172316.1848032-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Dec 2022 17:23:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10225

commit ce7c5382758b13dd4dfa2eb2f4989f9a27c58ffe upstream.

The CAN FD IP found on RZ/G2L SoC has some HW features different to that
of R-Car. For example, it has multiple resets and multiple IRQs for global
and channel interrupts. Also, it does not have ECC error flag registers
and clk post divider present on R-Car. Similarly, R-Car V3U has 8 channels
whereas other SoCs has only 2 channels.

This patch adds the struct rcar_canfd_hw_info to take care of the
HW feature differences and driver data present on both IPs. It also
replaces the driver data chip type with struct rcar_canfd_hw_info by
moving chip type to it.

Whilst started using driver data instead of chip_id for detecting
R-Car V3U SoCs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20221027082158.95895-2-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
[biju: Removed V3U SoC related changes]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 35 +++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index e485efc00b49..5727189094d6 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -494,6 +494,10 @@ enum rcar_canfd_fcanclk {
 
 struct rcar_canfd_global;
 
+struct rcar_canfd_hw_info {
+	enum rcanfd_chip_id chip_id;
+};
+
 /* Channel priv data */
 struct rcar_canfd_channel {
 	struct can_priv can;			/* Must be the first member */
@@ -520,7 +524,7 @@ struct rcar_canfd_global {
 	bool fdmode;			/* CAN FD or Classical CAN only mode */
 	struct reset_control *rstc1;
 	struct reset_control *rstc2;
-	enum rcanfd_chip_id chip_id;
+	const struct rcar_canfd_hw_info *info;
 };
 
 /* CAN FD mode nominal rate constants */
@@ -562,6 +566,14 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
 	.brp_inc = 1,
 };
 
+static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
+	.chip_id = RENESAS_RCAR_GEN3,
+};
+
+static const struct rcar_canfd_hw_info rzg2l_hw_info = {
+	.chip_id = RENESAS_RZG2L,
+};
+
 /* Helper functions */
 static inline void rcar_canfd_update(u32 mask, u32 val, u32 __iomem *reg)
 {
@@ -1625,6 +1637,7 @@ static const struct net_device_ops rcar_canfd_netdev_ops = {
 static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 				    u32 fcan_freq)
 {
+	const struct rcar_canfd_hw_info *info = gpriv->info;
 	struct platform_device *pdev = gpriv->pdev;
 	struct rcar_canfd_channel *priv;
 	struct net_device *ndev;
@@ -1646,7 +1659,7 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 	priv->can.clock.freq = fcan_freq;
 	dev_info(&pdev->dev, "can_clk rate is %u\n", priv->can.clock.freq);
 
-	if (gpriv->chip_id == RENESAS_RZG2L) {
+	if (info->chip_id == RENESAS_RZG2L) {
 		char *irq_name;
 		int err_irq;
 		int tx_irq;
@@ -1745,6 +1758,7 @@ static void rcar_canfd_channel_remove(struct rcar_canfd_global *gpriv, u32 ch)
 
 static int rcar_canfd_probe(struct platform_device *pdev)
 {
+	const struct rcar_canfd_hw_info *info;
 	void __iomem *addr;
 	u32 sts, ch, fcan_freq;
 	struct rcar_canfd_global *gpriv;
@@ -1753,9 +1767,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	int err, ch_irq, g_irq;
 	int g_err_irq, g_recc_irq;
 	bool fdmode = true;			/* CAN FD only mode - default */
-	enum rcanfd_chip_id chip_id;
 
-	chip_id = (uintptr_t)of_device_get_match_data(&pdev->dev);
+	info = of_device_get_match_data(&pdev->dev);
 
 	if (of_property_read_bool(pdev->dev.of_node, "renesas,no-can-fd"))
 		fdmode = false;			/* Classical CAN only mode */
@@ -1768,7 +1781,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	if (of_child && of_device_is_available(of_child))
 		channels_mask |= BIT(1);	/* Channel 1 */
 
-	if (chip_id == RENESAS_RCAR_GEN3) {
+	if (info->chip_id == RENESAS_RCAR_GEN3) {
 		ch_irq = platform_get_irq_byname_optional(pdev, "ch_int");
 		if (ch_irq < 0) {
 			/* For backward compatibility get irq by index */
@@ -1803,7 +1816,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	gpriv->pdev = pdev;
 	gpriv->channels_mask = channels_mask;
 	gpriv->fdmode = fdmode;
-	gpriv->chip_id = chip_id;
+	gpriv->info = info;
 
 	gpriv->rstc1 = devm_reset_control_get_optional_exclusive(&pdev->dev,
 								 "rstp_n");
@@ -1845,7 +1858,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	}
 	fcan_freq = clk_get_rate(gpriv->can_clk);
 
-	if (gpriv->fcan == RCANFD_CANFDCLK && gpriv->chip_id == RENESAS_RCAR_GEN3)
+	if (gpriv->fcan == RCANFD_CANFDCLK && info->chip_id == RENESAS_RCAR_GEN3)
 		/* CANFD clock is further divided by (1/2) within the IP */
 		fcan_freq /= 2;
 
@@ -1857,7 +1870,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	gpriv->base = addr;
 
 	/* Request IRQ that's common for both channels */
-	if (gpriv->chip_id == RENESAS_RCAR_GEN3) {
+	if (info->chip_id == RENESAS_RCAR_GEN3) {
 		err = devm_request_irq(&pdev->dev, ch_irq,
 				       rcar_canfd_channel_interrupt, 0,
 				       "canfd.ch_int", gpriv);
@@ -2009,9 +2022,9 @@ static int __maybe_unused rcar_canfd_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
 			 rcar_canfd_resume);
 
-static const struct of_device_id rcar_canfd_of_table[] = {
-	{ .compatible = "renesas,rcar-gen3-canfd", .data = (void *)RENESAS_RCAR_GEN3 },
-	{ .compatible = "renesas,rzg2l-canfd", .data = (void *)RENESAS_RZG2L },
+static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
+	{ .compatible = "renesas,rcar-gen3-canfd", .data = &rcar_gen3_hw_info },
+	{ .compatible = "renesas,rzg2l-canfd", .data = &rzg2l_hw_info },
 	{ }
 };
 
-- 
2.25.1


