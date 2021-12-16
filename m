Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34A0C433F5
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 12:55:08 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.10105.1639659291122281966
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 04:55:08 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,211,1635174000";
   d="scan'208";a="103722229"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Dec 2021 21:55:07 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 721544010737;
	Thu, 16 Dec 2021 21:55:06 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 14/24] dt-bindings: clock: r9a07g044-cpg: Update
 clock/reset definitions
Date: Thu, 16 Dec 2021 12:54:36 +0000
Message-Id: <20211216125446.15451-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 12:55:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7137

From: Biju Das <biju.das.jz@bp.renesas.com>

commit c3e67ad6f5a2c698a055fb297c6f9962f5145edd upstream.

Update clock and reset definitions as per RZ/G2L_clock_list_r02_02.xlsx
and RZ/G2L HW(Rev.0.50) manual.

Update {GIC,IA55,SCIF} clock and reset entries in the CPG driver, and
separate reset from module clocks in order to handle them efficiently.

Update the SCIF0 clock and reset index in the SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20210626081344.5783-6-biju.das.jz@bp.renesas.com
Link: https://lore.kernel.org/r/20210626081344.5783-7-biju.das.jz@bp.renesas.com
Link: https://lore.kernel.org/r/20210626081344.5783-8-biju.das.jz@bp.renesas.com
[geert: Squashed 3 commits]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi |   4 +-
 drivers/clk/renesas/r9a07g044-cpg.c        |  62 +++---
 drivers/clk/renesas/renesas-rzg2l-cpg.c    |  59 +++---
 drivers/clk/renesas/renesas-rzg2l-cpg.h    |  36 +++-
 include/dt-bindings/clock/r9a07g044-cpg.h  | 236 ++++++++++++++++-----
 5 files changed, 278 insertions(+), 119 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 734c8adeceba..01482d227506 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -82,10 +82,10 @@
 				     <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "eri", "rxi", "txi",
 					  "bri", "dri", "tei";
-			clocks = <&cpg CPG_MOD R9A07G044_CLK_SCIF0>;
+			clocks = <&cpg CPG_MOD R9A07G044_SCIF0_CLK_PCK>;
 			clock-names = "fck";
 			power-domains = <&cpg>;
-			resets = <&cpg R9A07G044_CLK_SCIF0>;
+			resets = <&cpg R9A07G044_SCIF0_RST_SYSTEM_N>;
 			status = "disabled";
 		};
 
diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index 70df4feda417..ae24e0397d3c 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -84,34 +84,40 @@ static const struct cpg_core_clk r9a07g044_core_clks[] __initconst = {
 };
 
 static struct rzg2l_mod_clk r9a07g044_mod_clks[] = {
-	DEF_MOD("gic",		R9A07G044_CLK_GIC600,
-				R9A07G044_CLK_P1,
-				0x514, BIT(0), (BIT(0) | BIT(1))),
-	DEF_MOD("ia55",		R9A07G044_CLK_IA55,
-				R9A07G044_CLK_P1,
-				0x518, (BIT(0) | BIT(1)), BIT(0)),
-	DEF_MOD("scif0",	R9A07G044_CLK_SCIF0,
-				R9A07G044_CLK_P0,
-				0x584, BIT(0), BIT(0)),
-	DEF_MOD("scif1",	R9A07G044_CLK_SCIF1,
-				R9A07G044_CLK_P0,
-				0x584, BIT(1), BIT(1)),
-	DEF_MOD("scif2",	R9A07G044_CLK_SCIF2,
-				R9A07G044_CLK_P0,
-				0x584, BIT(2), BIT(2)),
-	DEF_MOD("scif3",	R9A07G044_CLK_SCIF3,
-				R9A07G044_CLK_P0,
-				0x584, BIT(3), BIT(3)),
-	DEF_MOD("scif4",	R9A07G044_CLK_SCIF4,
-				R9A07G044_CLK_P0,
-				0x584, BIT(4), BIT(4)),
-	DEF_MOD("sci0",		R9A07G044_CLK_SCI0,
-				R9A07G044_CLK_P0,
-				0x588, BIT(0), BIT(0)),
+	DEF_MOD("gic",		R9A07G044_GIC600_GICCLK, R9A07G044_CLK_P1,
+				0x514, 0),
+	DEF_MOD("ia55_pclk",	R9A07G044_IA55_PCLK, R9A07G044_CLK_P2,
+				0x518, 0),
+	DEF_MOD("ia55_clk",	R9A07G044_IA55_CLK, R9A07G044_CLK_P1,
+				0x518, 1),
+	DEF_MOD("scif0",	R9A07G044_SCIF0_CLK_PCK, R9A07G044_CLK_P0,
+				0x584, 0),
+	DEF_MOD("scif1",	R9A07G044_SCIF1_CLK_PCK, R9A07G044_CLK_P0,
+				0x584, 1),
+	DEF_MOD("scif2",	R9A07G044_SCIF2_CLK_PCK, R9A07G044_CLK_P0,
+				0x584, 2),
+	DEF_MOD("scif3",	R9A07G044_SCIF3_CLK_PCK, R9A07G044_CLK_P0,
+				0x584, 3),
+	DEF_MOD("scif4",	R9A07G044_SCIF4_CLK_PCK, R9A07G044_CLK_P0,
+				0x584, 4),
+	DEF_MOD("sci0",		R9A07G044_SCI0_CLKP, R9A07G044_CLK_P0,
+				0x588, 0),
+};
+
+static struct rzg2l_reset r9a07g044_resets[] = {
+	DEF_RST(R9A07G044_GIC600_GICRESET_N, 0x814, 0),
+	DEF_RST(R9A07G044_GIC600_DBG_GICRESET_N, 0x814, 1),
+	DEF_RST(R9A07G044_IA55_RESETN, 0x818, 0),
+	DEF_RST(R9A07G044_SCIF0_RST_SYSTEM_N, 0x884, 0),
+	DEF_RST(R9A07G044_SCIF1_RST_SYSTEM_N, 0x884, 1),
+	DEF_RST(R9A07G044_SCIF2_RST_SYSTEM_N, 0x884, 2),
+	DEF_RST(R9A07G044_SCIF3_RST_SYSTEM_N, 0x884, 3),
+	DEF_RST(R9A07G044_SCIF4_RST_SYSTEM_N, 0x884, 4),
+	DEF_RST(R9A07G044_SCI0_RST, 0x888, 0),
 };
 
 static const unsigned int r9a07g044_crit_mod_clks[] __initconst = {
-	MOD_CLK_BASE + R9A07G044_CLK_GIC600,
+	MOD_CLK_BASE + R9A07G044_GIC600_GICCLK,
 };
 
 const struct rzg2l_cpg_info r9a07g044_cpg_info = {
@@ -128,5 +134,9 @@ const struct rzg2l_cpg_info r9a07g044_cpg_info = {
 	/* Module Clocks */
 	.mod_clks = r9a07g044_mod_clks,
 	.num_mod_clks = ARRAY_SIZE(r9a07g044_mod_clks),
-	.num_hw_mod_clks = R9A07G044_CLK_MIPI_DSI_PIN + 1,
+	.num_hw_mod_clks = R9A07G044_TSU_PCLK + 1,
+
+	/* Resets */
+	.resets = r9a07g044_resets,
+	.num_resets = ARRAY_SIZE(r9a07g044_resets),
 };
diff --git a/drivers/clk/renesas/renesas-rzg2l-cpg.c b/drivers/clk/renesas/renesas-rzg2l-cpg.c
index 1941f13bd922..e7c59af2a1d8 100644
--- a/drivers/clk/renesas/renesas-rzg2l-cpg.c
+++ b/drivers/clk/renesas/renesas-rzg2l-cpg.c
@@ -47,9 +47,9 @@
 #define SDIV(val)		DIV_RSMASK(val, 0, 0x7)
 
 #define CLK_ON_R(reg)		(reg)
-#define CLK_MON_R(reg)		(0x680 - 0x500 + (reg))
-#define CLK_RST_R(reg)		(0x800 - 0x500 + (reg))
-#define CLK_MRST_R(reg)		(0x980 - 0x500 + (reg))
+#define CLK_MON_R(reg)		(0x180 + (reg))
+#define CLK_RST_R(reg)		(reg)
+#define CLK_MRST_R(reg)		(0x180 + (reg))
 
 #define GET_REG_OFFSET(val)		((val >> 20) & 0xfff)
 #define GET_REG_SAMPLL_CLK1(val)	((val >> 22) & 0xfff)
@@ -78,6 +78,7 @@ struct rzg2l_cpg_priv {
 	struct clk **clks;
 	unsigned int num_core_clks;
 	unsigned int num_mod_clks;
+	unsigned int num_resets;
 	unsigned int last_dt_core_clk;
 
 	struct raw_notifier_head notifiers;
@@ -315,15 +316,13 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
  *
  * @hw: handle between common and hardware-specific interfaces
  * @off: register offset
- * @onoff: ON/MON bits
- * @reset: reset bits
+ * @bit: ON/MON bit
  * @priv: CPG/MSTP private data
  */
 struct mstp_clock {
 	struct clk_hw hw;
 	u16 off;
-	u8 onoff;
-	u8 reset;
+	u8 bit;
 	struct rzg2l_cpg_priv *priv;
 };
 
@@ -337,6 +336,7 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 	struct device *dev = priv->dev;
 	unsigned long flags;
 	unsigned int i;
+	u32 bitmask = BIT(clock->bit);
 	u32 value;
 
 	if (!clock->off) {
@@ -349,9 +349,9 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 	spin_lock_irqsave(&priv->rmw_lock, flags);
 
 	if (enable)
-		value = (clock->onoff << 16) | clock->onoff;
+		value = (bitmask << 16) | bitmask;
 	else
-		value = clock->onoff << 16;
+		value = bitmask << 16;
 	writel(value, priv->base + CLK_ON_R(reg));
 
 	spin_unlock_irqrestore(&priv->rmw_lock, flags);
@@ -360,7 +360,7 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 		return 0;
 
 	for (i = 1000; i > 0; --i) {
-		if (((readl(priv->base + CLK_MON_R(reg))) & clock->onoff))
+		if (((readl(priv->base + CLK_MON_R(reg))) & bitmask))
 			break;
 		cpu_relax();
 	}
@@ -388,6 +388,7 @@ static int rzg2l_mod_clock_is_enabled(struct clk_hw *hw)
 {
 	struct mstp_clock *clock = to_mod_clock(hw);
 	struct rzg2l_cpg_priv *priv = clock->priv;
+	u32 bitmask = BIT(clock->bit);
 	u32 value;
 
 	if (!clock->off) {
@@ -397,7 +398,7 @@ static int rzg2l_mod_clock_is_enabled(struct clk_hw *hw)
 
 	value = readl(priv->base + CLK_MON_R(clock->off));
 
-	return !(value & clock->onoff);
+	return !(value & bitmask);
 }
 
 static const struct clk_ops rzg2l_mod_clock_ops = {
@@ -457,8 +458,7 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 	init.num_parents = 1;
 
 	clock->off = mod->off;
-	clock->onoff = mod->onoff;
-	clock->reset = mod->reset;
+	clock->bit = mod->bit;
 	clock->priv = priv;
 	clock->hw.init = &init;
 
@@ -483,12 +483,11 @@ static int rzg2l_cpg_reset(struct reset_controller_dev *rcdev,
 {
 	struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
 	const struct rzg2l_cpg_info *info = priv->info;
-	unsigned int reg = info->mod_clks[id].off;
-	u32 dis = info->mod_clks[id].reset;
+	unsigned int reg = info->resets[id].off;
+	u32 dis = BIT(info->resets[id].bit);
 	u32 we = dis << 16;
 
-	dev_dbg(rcdev->dev, "reset name:%s id:%ld offset:0x%x\n",
-		info->mod_clks[id].name, id, CLK_RST_R(reg));
+	dev_dbg(rcdev->dev, "reset id:%ld offset:0x%x\n", id, CLK_RST_R(reg));
 
 	/* Reset module */
 	writel(we, priv->base + CLK_RST_R(reg));
@@ -507,11 +506,10 @@ static int rzg2l_cpg_assert(struct reset_controller_dev *rcdev,
 {
 	struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
 	const struct rzg2l_cpg_info *info = priv->info;
-	unsigned int reg = info->mod_clks[id].off;
-	u32 value = info->mod_clks[id].reset << 16;
+	unsigned int reg = info->resets[id].off;
+	u32 value = BIT(info->resets[id].bit) << 16;
 
-	dev_dbg(rcdev->dev, "assert name:%s id:%ld offset:0x%x\n",
-		info->mod_clks[id].name, id, CLK_RST_R(reg));
+	dev_dbg(rcdev->dev, "assert id:%ld offset:0x%x\n", id, CLK_RST_R(reg));
 
 	writel(value, priv->base + CLK_RST_R(reg));
 	return 0;
@@ -522,12 +520,12 @@ static int rzg2l_cpg_deassert(struct reset_controller_dev *rcdev,
 {
 	struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
 	const struct rzg2l_cpg_info *info = priv->info;
-	unsigned int reg = info->mod_clks[id].off;
-	u32 dis = info->mod_clks[id].reset;
+	unsigned int reg = info->resets[id].off;
+	u32 dis = BIT(info->resets[id].bit);
 	u32 value = (dis << 16) | dis;
 
-	dev_dbg(rcdev->dev, "deassert name:%s id:%ld offset:0x%x\n",
-		info->mod_clks[id].name, id, CLK_RST_R(reg));
+	dev_dbg(rcdev->dev, "deassert id:%ld offset:0x%x\n", id,
+		CLK_RST_R(reg));
 
 	writel(value, priv->base + CLK_RST_R(reg));
 	return 0;
@@ -538,8 +536,8 @@ static int rzg2l_cpg_status(struct reset_controller_dev *rcdev,
 {
 	struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
 	const struct rzg2l_cpg_info *info = priv->info;
-	unsigned int reg = info->mod_clks[id].off;
-	u32 bitmask = info->mod_clks[id].reset;
+	unsigned int reg = info->resets[id].off;
+	u32 bitmask = BIT(info->resets[id].bit);
 
 	return !(readl(priv->base + CLK_MRST_R(reg)) & bitmask);
 }
@@ -554,9 +552,11 @@ static const struct reset_control_ops rzg2l_cpg_reset_ops = {
 static int rzg2l_cpg_reset_xlate(struct reset_controller_dev *rcdev,
 				 const struct of_phandle_args *reset_spec)
 {
+	struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
+	const struct rzg2l_cpg_info *info = priv->info;
 	unsigned int id = reset_spec->args[0];
 
-	if (id >= rcdev->nr_resets) {
+	if (id >= rcdev->nr_resets || !info->resets[id].off) {
 		dev_err(rcdev->dev, "Invalid reset index %u\n", id);
 		return -EINVAL;
 	}
@@ -571,7 +571,7 @@ static int rzg2l_cpg_reset_controller_register(struct rzg2l_cpg_priv *priv)
 	priv->rcdev.dev = priv->dev;
 	priv->rcdev.of_reset_n_cells = 1;
 	priv->rcdev.of_xlate = rzg2l_cpg_reset_xlate;
-	priv->rcdev.nr_resets = priv->num_mod_clks;
+	priv->rcdev.nr_resets = priv->num_resets;
 
 	return devm_reset_controller_register(priv->dev, &priv->rcdev);
 }
@@ -699,6 +699,7 @@ static int __init rzg2l_cpg_probe(struct platform_device *pdev)
 	priv->clks = clks;
 	priv->num_core_clks = info->num_total_core_clks;
 	priv->num_mod_clks = info->num_hw_mod_clks;
+	priv->num_resets = info->num_resets;
 	priv->last_dt_core_clk = info->last_dt_core_clk;
 
 	for (i = 0; i < nclks; i++)
diff --git a/drivers/clk/renesas/renesas-rzg2l-cpg.h b/drivers/clk/renesas/renesas-rzg2l-cpg.h
index a6a3bade1985..63695280ce8b 100644
--- a/drivers/clk/renesas/renesas-rzg2l-cpg.h
+++ b/drivers/clk/renesas/renesas-rzg2l-cpg.h
@@ -77,26 +77,40 @@ enum clk_types {
  * @id: clock index in array containing all Core and Module Clocks
  * @parent: id of parent clock
  * @off: register offset
- * @onoff: ON/MON bits
- * @reset: reset bits
+ * @bit: ON/MON bit
  */
 struct rzg2l_mod_clk {
 	const char *name;
 	unsigned int id;
 	unsigned int parent;
 	u16 off;
-	u8 onoff;
-	u8 reset;
+	u8 bit;
 };
 
-#define DEF_MOD(_name, _id, _parent, _off, _onoff, _reset)	\
-	[_id] = { \
+#define DEF_MOD(_name, _id, _parent, _off, _bit)	\
+	{ \
 		.name = _name, \
-		.id = MOD_CLK_BASE + _id, \
+		.id = MOD_CLK_BASE + (_id), \
 		.parent = (_parent), \
 		.off = (_off), \
-		.onoff = (_onoff), \
-		.reset = (_reset) \
+		.bit = (_bit), \
+	}
+
+/**
+ * struct rzg2l_reset - Reset definitions
+ *
+ * @off: register offset
+ * @bit: reset bit
+ */
+struct rzg2l_reset {
+	u16 off;
+	u8 bit;
+};
+
+#define DEF_RST(_id, _off, _bit)	\
+	[_id] = { \
+		.off = (_off), \
+		.bit = (_bit) \
 	}
 
 /**
@@ -127,6 +141,10 @@ struct rzg2l_cpg_info {
 	unsigned int num_mod_clks;
 	unsigned int num_hw_mod_clks;
 
+	/* Resets */
+	const struct rzg2l_reset *resets;
+	unsigned int num_resets;
+
 	/* Critical Module Clocks that should not be disabled */
 	const unsigned int *crit_mod_clks;
 	unsigned int num_crit_mod_clks;
diff --git a/include/dt-bindings/clock/r9a07g044-cpg.h b/include/dt-bindings/clock/r9a07g044-cpg.h
index 1d8986563fc5..0728ad07ff7a 100644
--- a/include/dt-bindings/clock/r9a07g044-cpg.h
+++ b/include/dt-bindings/clock/r9a07g044-cpg.h
@@ -32,58 +32,188 @@
 #define R9A07G044_OSCCLK		21
 
 /* R9A07G044 Module Clocks */
-#define R9A07G044_CLK_GIC600		0
-#define R9A07G044_CLK_IA55		1
-#define R9A07G044_CLK_SYC		2
-#define R9A07G044_CLK_DMAC		3
-#define R9A07G044_CLK_SYSC		4
-#define R9A07G044_CLK_MTU		5
-#define R9A07G044_CLK_GPT		6
-#define R9A07G044_CLK_ETH0		7
-#define R9A07G044_CLK_ETH1		8
-#define R9A07G044_CLK_I2C0		9
-#define R9A07G044_CLK_I2C1		10
-#define R9A07G044_CLK_I2C2		11
-#define R9A07G044_CLK_I2C3		12
-#define R9A07G044_CLK_SCIF0		13
-#define R9A07G044_CLK_SCIF1		14
-#define R9A07G044_CLK_SCIF2		15
-#define R9A07G044_CLK_SCIF3		16
-#define R9A07G044_CLK_SCIF4		17
-#define R9A07G044_CLK_SCI0		18
-#define R9A07G044_CLK_SCI1		19
-#define R9A07G044_CLK_GPIO		20
-#define R9A07G044_CLK_SDHI0		21
-#define R9A07G044_CLK_SDHI1		22
-#define R9A07G044_CLK_USB0		23
-#define R9A07G044_CLK_USB1		24
-#define R9A07G044_CLK_CANFD		25
-#define R9A07G044_CLK_SSI0		26
-#define R9A07G044_CLK_SSI1		27
-#define R9A07G044_CLK_SSI2		28
-#define R9A07G044_CLK_SSI3		29
-#define R9A07G044_CLK_MHU		30
-#define R9A07G044_CLK_OSTM0		31
-#define R9A07G044_CLK_OSTM1		32
-#define R9A07G044_CLK_OSTM2		33
-#define R9A07G044_CLK_WDT0		34
-#define R9A07G044_CLK_WDT1		35
-#define R9A07G044_CLK_WDT2		36
-#define R9A07G044_CLK_WDT_PON		37
-#define R9A07G044_CLK_GPU		38
-#define R9A07G044_CLK_ISU		39
-#define R9A07G044_CLK_H264		40
-#define R9A07G044_CLK_CRU		41
-#define R9A07G044_CLK_MIPI_DSI		42
-#define R9A07G044_CLK_LCDC		43
-#define R9A07G044_CLK_SRC		44
-#define R9A07G044_CLK_RSPI0		45
-#define R9A07G044_CLK_RSPI1		46
-#define R9A07G044_CLK_RSPI2		47
-#define R9A07G044_CLK_ADC		48
-#define R9A07G044_CLK_TSU_PCLK		49
-#define R9A07G044_CLK_SPI		50
-#define R9A07G044_CLK_MIPI_DSI_V	51
-#define R9A07G044_CLK_MIPI_DSI_PIN	52
+#define R9A07G044_CA55_SCLK		0
+#define R9A07G044_CA55_PCLK		1
+#define R9A07G044_CA55_ATCLK		2
+#define R9A07G044_CA55_GICCLK		3
+#define R9A07G044_CA55_PERICLK		4
+#define R9A07G044_CA55_ACLK		5
+#define R9A07G044_CA55_TSCLK		6
+#define R9A07G044_GIC600_GICCLK		7
+#define R9A07G044_IA55_CLK		8
+#define R9A07G044_IA55_PCLK		9
+#define R9A07G044_MHU_PCLK		10
+#define R9A07G044_SYC_CNT_CLK		11
+#define R9A07G044_DMAC_ACLK		12
+#define R9A07G044_DMAC_PCLK		13
+#define R9A07G044_OSTM0_PCLK		14
+#define R9A07G044_OSTM1_PCLK		15
+#define R9A07G044_OSTM2_PCLK		16
+#define R9A07G044_MTU_X_MCK_MTU3	17
+#define R9A07G044_POE3_CLKM_POE		18
+#define R9A07G044_GPT_PCLK		19
+#define R9A07G044_POEG_A_CLKP		20
+#define R9A07G044_POEG_B_CLKP		21
+#define R9A07G044_POEG_C_CLKP		22
+#define R9A07G044_POEG_D_CLKP		23
+#define R9A07G044_WDT0_PCLK		24
+#define R9A07G044_WDT0_CLK		25
+#define R9A07G044_WDT1_PCLK		26
+#define R9A07G044_WDT1_CLK		27
+#define R9A07G044_WDT2_PCLK		28
+#define R9A07G044_WDT2_CLK		29
+#define R9A07G044_SPI_CLK2		30
+#define R9A07G044_SPI_CLK		31
+#define R9A07G044_SDHI0_IMCLK		32
+#define R9A07G044_SDHI0_IMCLK2		33
+#define R9A07G044_SDHI0_CLK_HS		34
+#define R9A07G044_SDHI0_ACLK		35
+#define R9A07G044_SDHI1_IMCLK		36
+#define R9A07G044_SDHI1_IMCLK2		37
+#define R9A07G044_SDHI1_CLK_HS		38
+#define R9A07G044_SDHI1_ACLK		39
+#define R9A07G044_GPU_CLK		40
+#define R9A07G044_GPU_AXI_CLK		41
+#define R9A07G044_GPU_ACE_CLK		42
+#define R9A07G044_ISU_ACLK		43
+#define R9A07G044_ISU_PCLK		44
+#define R9A07G044_H264_CLK_A		45
+#define R9A07G044_H264_CLK_P		46
+#define R9A07G044_CRU_SYSCLK		47
+#define R9A07G044_CRU_VCLK		48
+#define R9A07G044_CRU_PCLK		49
+#define R9A07G044_CRU_ACLK		50
+#define R9A07G044_MIPI_DSI_PLLCLK	51
+#define R9A07G044_MIPI_DSI_SYSCLK	52
+#define R9A07G044_MIPI_DSI_ACLK		53
+#define R9A07G044_MIPI_DSI_PCLK		54
+#define R9A07G044_MIPI_DSI_VCLK		55
+#define R9A07G044_MIPI_DSI_LPCLK	56
+#define R9A07G044_LCDC_CLK_A		57
+#define R9A07G044_LCDC_CLK_P		58
+#define R9A07G044_LCDC_CLK_D		59
+#define R9A07G044_SSI0_PCLK2		60
+#define R9A07G044_SSI0_PCLK_SFR		61
+#define R9A07G044_SSI1_PCLK2		62
+#define R9A07G044_SSI1_PCLK_SFR		63
+#define R9A07G044_SSI2_PCLK2		64
+#define R9A07G044_SSI2_PCLK_SFR		65
+#define R9A07G044_SSI3_PCLK2		66
+#define R9A07G044_SSI3_PCLK_SFR		67
+#define R9A07G044_SRC_CLKP		68
+#define R9A07G044_USB_U2H0_HCLK		69
+#define R9A07G044_USB_U2H1_HCLK		70
+#define R9A07G044_USB_U2P_EXR_CPUCLK	71
+#define R9A07G044_USB_PCLK		72
+#define R9A07G044_ETH0_CLK_AXI		73
+#define R9A07G044_ETH0_CLK_CHI		74
+#define R9A07G044_ETH1_CLK_AXI		75
+#define R9A07G044_ETH1_CLK_CHI		76
+#define R9A07G044_I2C0_PCLK		77
+#define R9A07G044_I2C1_PCLK		78
+#define R9A07G044_I2C2_PCLK		79
+#define R9A07G044_I2C3_PCLK		80
+#define R9A07G044_SCIF0_CLK_PCK		81
+#define R9A07G044_SCIF1_CLK_PCK		82
+#define R9A07G044_SCIF2_CLK_PCK		83
+#define R9A07G044_SCIF3_CLK_PCK		84
+#define R9A07G044_SCIF4_CLK_PCK		85
+#define R9A07G044_SCI0_CLKP		86
+#define R9A07G044_SCI1_CLKP		87
+#define R9A07G044_IRDA_CLKP		88
+#define R9A07G044_RSPI0_CLKB		89
+#define R9A07G044_RSPI1_CLKB		90
+#define R9A07G044_RSPI2_CLKB		91
+#define R9A07G044_CANFD_PCLK		92
+#define R9A07G044_GPIO_HCLK		93
+#define R9A07G044_ADC_ADCLK		94
+#define R9A07G044_ADC_PCLK		95
+#define R9A07G044_TSU_PCLK		96
+
+/* R9A07G044 Resets */
+#define R9A07G044_CA55_RST_1_0		0
+#define R9A07G044_CA55_RST_1_1		1
+#define R9A07G044_CA55_RST_3_0		2
+#define R9A07G044_CA55_RST_3_1		3
+#define R9A07G044_CA55_RST_4		4
+#define R9A07G044_CA55_RST_5		5
+#define R9A07G044_CA55_RST_6		6
+#define R9A07G044_CA55_RST_7		7
+#define R9A07G044_CA55_RST_8		8
+#define R9A07G044_CA55_RST_9		9
+#define R9A07G044_CA55_RST_10		10
+#define R9A07G044_CA55_RST_11		11
+#define R9A07G044_CA55_RST_12		12
+#define R9A07G044_GIC600_GICRESET_N	13
+#define R9A07G044_GIC600_DBG_GICRESET_N	14
+#define R9A07G044_IA55_RESETN		15
+#define R9A07G044_MHU_RESETN		16
+#define R9A07G044_DMAC_ARESETN		17
+#define R9A07G044_DMAC_RST_ASYNC	18
+#define R9A07G044_SYC_RESETN		19
+#define R9A07G044_OSTM0_PRESETZ		20
+#define R9A07G044_OSTM1_PRESETZ		21
+#define R9A07G044_OSTM2_PRESETZ		22
+#define R9A07G044_MTU_X_PRESET_MTU3	23
+#define R9A07G044_POE3_RST_M_REG	24
+#define R9A07G044_GPT_RST_C		25
+#define R9A07G044_POEG_A_RST		26
+#define R9A07G044_POEG_B_RST		27
+#define R9A07G044_POEG_C_RST		28
+#define R9A07G044_POEG_D_RST		29
+#define R9A07G044_WDT0_PRESETN		30
+#define R9A07G044_WDT1_PRESETN		31
+#define R9A07G044_WDT2_PRESETN		32
+#define R9A07G044_SPI_RST		33
+#define R9A07G044_SDHI0_IXRST		34
+#define R9A07G044_SDHI1_IXRST		35
+#define R9A07G044_GPU_RESETN		36
+#define R9A07G044_GPU_AXI_RESETN	37
+#define R9A07G044_GPU_ACE_RESETN	38
+#define R9A07G044_ISU_ARESETN		39
+#define R9A07G044_ISU_PRESETN		40
+#define R9A07G044_H264_X_RESET_VCP	41
+#define R9A07G044_H264_CP_PRESET_P	42
+#define R9A07G044_CRU_CMN_RSTB		43
+#define R9A07G044_CRU_PRESETN		44
+#define R9A07G044_CRU_ARESETN		45
+#define R9A07G044_MIPI_DSI_CMN_RSTB	46
+#define R9A07G044_MIPI_DSI_ARESET_N	47
+#define R9A07G044_MIPI_DSI_PRESET_N	48
+#define R9A07G044_LCDC_RESET_N		49
+#define R9A07G044_SSI0_RST_M2_REG	50
+#define R9A07G044_SSI1_RST_M2_REG	51
+#define R9A07G044_SSI2_RST_M2_REG	52
+#define R9A07G044_SSI3_RST_M2_REG	53
+#define R9A07G044_SRC_RST		54
+#define R9A07G044_USB_U2H0_HRESETN	55
+#define R9A07G044_USB_U2H1_HRESETN	56
+#define R9A07G044_USB_U2P_EXL_SYSRST	57
+#define R9A07G044_USB_PRESETN		58
+#define R9A07G044_ETH0_RST_HW_N		59
+#define R9A07G044_ETH1_RST_HW_N		60
+#define R9A07G044_I2C0_MRST		61
+#define R9A07G044_I2C1_MRST		62
+#define R9A07G044_I2C2_MRST		63
+#define R9A07G044_I2C3_MRST		64
+#define R9A07G044_SCIF0_RST_SYSTEM_N	65
+#define R9A07G044_SCIF1_RST_SYSTEM_N	66
+#define R9A07G044_SCIF2_RST_SYSTEM_N	67
+#define R9A07G044_SCIF3_RST_SYSTEM_N	68
+#define R9A07G044_SCIF4_RST_SYSTEM_N	69
+#define R9A07G044_SCI0_RST		70
+#define R9A07G044_SCI1_RST		71
+#define R9A07G044_IRDA_RST		72
+#define R9A07G044_RSPI0_RST		73
+#define R9A07G044_RSPI1_RST		74
+#define R9A07G044_RSPI2_RST		75
+#define R9A07G044_CANFD_RSTP_N		76
+#define R9A07G044_CANFD_RSTC_N		77
+#define R9A07G044_GPIO_RSTN		78
+#define R9A07G044_GPIO_PORT_RESETN	79
+#define R9A07G044_GPIO_SPARE_RESETN	80
+#define R9A07G044_ADC_PRESETN		81
+#define R9A07G044_ADC_ADRST_N		82
+#define R9A07G044_TSU_PRESETN		83
 
 #endif /* __DT_BINDINGS_CLOCK_R9A07G044_CPG_H__ */
-- 
2.17.1


