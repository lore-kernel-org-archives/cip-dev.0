Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A723DE92FEA
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 22:39:25 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.53287.1767047956505708700
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 14:39:21 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: 5V6WxRhzQOapY3MoCPGjkQ==
X-CSE-MsgGUID: bgfqr97HScexAGedAslBUw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 30 Dec 2025 07:39:21 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B0ABA400D4DC;
	Tue, 30 Dec 2025 07:39:19 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 04/17] clk: renesas: cpg-mssr: Add module reset support for RZ/T2H
Date: Mon, 29 Dec 2025 22:38:58 +0000
Message-ID: <20251229223911.8663-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 22:39:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21262

commit 3b37979dcbef0dc3fc1aaba75b21ff9a21799055 upstream.

Add support for module reset handling on the RZ/T2H SoC. Unlike earlier
CPG/MSSR variants, RZ/T2H uses a unified set of Module Reset Control
Registers (MRCR) where both reset and deassert actions are done via
read-modify-write (RMW) to the same register.

Introduce a new MRCR offset table (mrcr_for_rzt2h) for RZ/T2H and assign
it to reset_regs. For this SoC, the number of resets is based on the
number of MRCR registers rather than the number of module clocks. Also
add cpg_mrcr_reset_ops to implement reset, assert, and deassert using RMW
while holding the spinlock. This follows the RZ/T2H requirements, where
processing after releasing a module reset must be secured by performing
seven dummy reads of the same register, and where a module that is reset
and released again must ensure the target bit in the Module Reset Control
Register is set to 1.

Update the reset controller registration to select cpg_mrcr_reset_ops for
RZ/T2H, while keeping the existing cpg_mssr_reset_ops for other SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Link: https://patch.msgid.link/20250929112324.3622148-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 110 ++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 9ea544d00634b..4d2d945b3f5e2 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -40,6 +40,7 @@
 #define WARN_DEBUG(x)	do { } while (0)
 #endif
 
+#define RZT2H_RESET_REG_READ_COUNT	7
 
 /*
  * Module Standby and Software Reset register offets.
@@ -138,6 +139,22 @@ static const u16 srcr_for_gen4[] = {
 	0x2C60, 0x2C64, 0x2C68, 0x2C6C, 0x2C70, 0x2C74,
 };
 
+static const u16 mrcr_for_rzt2h[] = {
+	0x240,	/* MRCTLA */
+	0x244,	/* Reserved */
+	0x248,	/* Reserved */
+	0x24C,	/* Reserved */
+	0x250,	/* MRCTLE */
+	0x254,	/* Reserved */
+	0x258,	/* Reserved */
+	0x25C,	/* Reserved */
+	0x260,	/* MRCTLI */
+	0x264,	/* Reserved */
+	0x268,	/* Reserved */
+	0x26C,	/* Reserved */
+	0x270,	/* MRCTLM */
+};
+
 /*
  * Software Reset Clearing Register offsets
  */
@@ -742,6 +759,72 @@ static int cpg_mssr_status(struct reset_controller_dev *rcdev,
 	return !!(readl(priv->pub.base0 + priv->reset_regs[reg]) & bitmask);
 }
 
+static int cpg_mrcr_set_reset_state(struct reset_controller_dev *rcdev,
+				    unsigned long id, bool set)
+{
+	struct cpg_mssr_priv *priv = rcdev_to_priv(rcdev);
+	unsigned int reg = id / 32;
+	unsigned int bit = id % 32;
+	u32 bitmask = BIT(bit);
+	void __iomem *reg_addr;
+	unsigned long flags;
+	unsigned int i;
+	u32 val;
+
+	dev_dbg(priv->dev, "%s %u%02u\n", set ? "assert" : "deassert", reg, bit);
+
+	spin_lock_irqsave(&priv->pub.rmw_lock, flags);
+
+	reg_addr = priv->pub.base0 + priv->reset_regs[reg];
+	/* Read current value and modify */
+	val = readl(reg_addr);
+	if (set)
+		val |= bitmask;
+	else
+		val &= ~bitmask;
+	writel(val, reg_addr);
+
+	/*
+	 * For secure processing after release from a module reset, one must
+	 * perform multiple dummy reads of the same register.
+	 */
+	for (i = 0; !set && i < RZT2H_RESET_REG_READ_COUNT; i++)
+		readl(reg_addr);
+
+	/* Verify the operation */
+	val = readl(reg_addr);
+	if (set == !(bitmask & val)) {
+		dev_err(priv->dev, "Reset register %u%02u operation failed\n", reg, bit);
+		spin_unlock_irqrestore(&priv->pub.rmw_lock, flags);
+		return -EIO;
+	}
+
+	spin_unlock_irqrestore(&priv->pub.rmw_lock, flags);
+
+	return 0;
+}
+
+static int cpg_mrcr_reset(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	int ret;
+
+	ret = cpg_mrcr_set_reset_state(rcdev, id, true);
+	if (ret)
+		return ret;
+
+	return cpg_mrcr_set_reset_state(rcdev, id, false);
+}
+
+static int cpg_mrcr_assert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	return cpg_mrcr_set_reset_state(rcdev, id, true);
+}
+
+static int cpg_mrcr_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	return cpg_mrcr_set_reset_state(rcdev, id, false);
+}
+
 static const struct reset_control_ops cpg_mssr_reset_ops = {
 	.reset = cpg_mssr_reset,
 	.assert = cpg_mssr_assert,
@@ -749,6 +832,13 @@ static const struct reset_control_ops cpg_mssr_reset_ops = {
 	.status = cpg_mssr_status,
 };
 
+static const struct reset_control_ops cpg_mrcr_reset_ops = {
+	.reset = cpg_mrcr_reset,
+	.assert = cpg_mrcr_assert,
+	.deassert = cpg_mrcr_deassert,
+	.status = cpg_mssr_status,
+};
+
 static int cpg_mssr_reset_xlate(struct reset_controller_dev *rcdev,
 				const struct of_phandle_args *reset_spec)
 {
@@ -766,11 +856,23 @@ static int cpg_mssr_reset_xlate(struct reset_controller_dev *rcdev,
 
 static int cpg_mssr_reset_controller_register(struct cpg_mssr_priv *priv)
 {
-	priv->rcdev.ops = &cpg_mssr_reset_ops;
+	/*
+	 * RZ/T2H (and family) has the Module Reset Control Registers
+	 * which allows control resets of certain modules.
+	 * The number of resets is not equal to the number of module clocks.
+	 */
+	if (priv->reg_layout == CLK_REG_LAYOUT_RZ_T2H) {
+		priv->rcdev.ops = &cpg_mrcr_reset_ops;
+		priv->rcdev.nr_resets = ARRAY_SIZE(mrcr_for_rzt2h) * 32;
+	} else {
+		priv->rcdev.ops = &cpg_mssr_reset_ops;
+		priv->rcdev.nr_resets = priv->num_mod_clks;
+	}
+
 	priv->rcdev.of_node = priv->dev->of_node;
 	priv->rcdev.of_reset_n_cells = 1;
 	priv->rcdev.of_xlate = cpg_mssr_reset_xlate;
-	priv->rcdev.nr_resets = priv->num_mod_clks;
+
 	return devm_reset_controller_register(priv->dev, &priv->rcdev);
 }
 
@@ -1176,6 +1278,7 @@ static int __init cpg_mssr_common_init(struct device *dev,
 		priv->control_regs = stbcr;
 	} else if (priv->reg_layout == CLK_REG_LAYOUT_RZ_T2H) {
 		priv->control_regs = mstpcr_for_rzt2h;
+		priv->reset_regs = mrcr_for_rzt2h;
 	} else if (priv->reg_layout == CLK_REG_LAYOUT_RCAR_GEN4) {
 		priv->status_regs = mstpsr_for_gen4;
 		priv->control_regs = mstpcr_for_gen4;
@@ -1272,8 +1375,7 @@ static int __init cpg_mssr_probe(struct platform_device *pdev)
 		goto reserve_exit;
 
 	/* Reset Controller not supported for Standby Control SoCs */
-	if (priv->reg_layout == CLK_REG_LAYOUT_RZ_A ||
-	    priv->reg_layout == CLK_REG_LAYOUT_RZ_T2H)
+	if (priv->reg_layout == CLK_REG_LAYOUT_RZ_A)
 		goto reserve_exit;
 
 	error = cpg_mssr_reset_controller_register(priv);
-- 
2.43.0


