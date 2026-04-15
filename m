Return-Path: <Chris.Brandt@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E868F4213D
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 18:18:30 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1875.1776277100434737809
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Apr 2026 11:18:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: chris.brandt@renesas.com)
X-CSE-ConnectionGUID: aeIPQHsuSrKK/RP0adph6w==
X-CSE-MsgGUID: MrLxq2tbR06+EKtwVv4RJA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Apr 2026 03:18:25 +0900
Received: from lenovo-p330 (unknown [132.158.152.97])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A594C405BF70;
	Thu, 16 Apr 2026 03:18:24 +0900 (JST)
From: Chris Brandt <chris.brandt@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Subject: [PATCH 5.10.y-cip 09/10] clk: renesas: rzg2l: Remove DSI clock rate restrictions
Date: Wed, 15 Apr 2026 14:18:08 -0400
Message-ID: <20260415181810.4073807-10-chris.brandt@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260415181810.4073807-1-chris.brandt@renesas.com>
References: <20260415181810.4073807-1-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Apr 2026 18:18:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22729

commit 5a4326f2e3b1edfb3329c1bee59035dc9f048b59 upstream.

Convert the limited MIPI clock calculations to a full range of settings
based on math including H/W limitation validation.
Since the required DSI division setting must be specified from external
sources before calculations, expose a new API to set it.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Tested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251124131003.992554-2-chris.brandt@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 174 ++++++++++++++++++++++++++------
 include/linux/clk/renesas.h     |  12 +++
 2 files changed, 155 insertions(+), 31 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index d83755e273d9..70ddfc917a17 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -21,6 +21,7 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/iopoll.h>
+#include <linux/math64.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
@@ -73,6 +74,17 @@
 #define MSTOP_OFF(conf)		FIELD_GET(GENMASK(31, 16), (conf))
 #define MSTOP_MASK(conf)	FIELD_GET(GENMASK(15, 0), (conf))

+#define PLL5_FOUTVCO_MIN	800000000
+#define PLL5_FOUTVCO_MAX	3000000000
+#define PLL5_POSTDIV_MIN	1
+#define PLL5_POSTDIV_MAX	7
+#define PLL5_REFDIV_MIN		1
+#define PLL5_REFDIV_MAX		2
+#define PLL5_INTIN_MIN		20
+#define PLL5_INTIN_MAX		320
+#define PLL5_HSCLK_MIN		10000000
+#define PLL5_HSCLK_MAX		187500000
+
 /**
  * struct clk_hw_data - clock hardware data
  * @hw: clock hw
@@ -128,6 +140,12 @@ struct rzg2l_pll5_param {
 	u8 pl5_spread;
 };

+/* PLL5 output will be used for DPI or MIPI-DSI */
+static int dsi_div_target = PLL5_TARGET_DPI;
+
+/* Required division ratio for MIPI D-PHY clock depending on number of lanes and bpp. */
+static u8 dsi_div_ab_desired;
+
 struct rzg2l_pll5_mux_dsi_div_param {
 	u8 clksrc;
 	u8 dsi_div_a;
@@ -169,6 +187,11 @@ struct rzg2l_cpg_priv {
 	struct rzg2l_pll5_mux_dsi_div_param mux_dsi_div_params;
 };

+static inline u8 rzg2l_cpg_div_ab(u8 a, u8 b)
+{
+	return (b + 1) << a;
+}
+
 static void rzg2l_cpg_del_clk_provider(void *data)
 {
 	of_clk_del_provider(data);
@@ -559,24 +582,121 @@ rzg2l_cpg_sd_mux_clk_register(const struct cpg_core_clk *core,
 	return clk_hw->clk;
 }

+/*
+ * VCO-->[POSTDIV1,2]--FOUTPOSTDIV--------------->|
+ *                          |                     |-->[1/(DSI DIV A * B)]--> MIPI_DSI_VCLK
+ *                          |-->[1/2]--FOUT1PH0-->|
+ *                          |
+ *                          |------->[1/16]--------------------------------> hsclk (MIPI-PHY)
+ */
 static unsigned long
-rzg2l_cpg_get_foutpostdiv_rate(struct rzg2l_pll5_param *params,
+rzg2l_cpg_get_foutpostdiv_rate(struct rzg2l_cpg_priv *priv,
+			       struct rzg2l_pll5_param *params,
 			       unsigned long rate)
 {
-	unsigned long foutpostdiv_rate, foutvco_rate;
+	const u32 extal_hz = EXTAL_FREQ_IN_MEGA_HZ * MEGA;
+	unsigned long foutpostdiv_rate;
+	unsigned int a, b, odd;
+	unsigned long hsclk;
+	u8 dsi_div_ab_calc;
+	u64 foutvco_rate;
+
+	if (dsi_div_target == PLL5_TARGET_DSI) {
+		/* Check hsclk */
+		hsclk = rate * dsi_div_ab_desired / 16;
+		if (hsclk < PLL5_HSCLK_MIN || hsclk > PLL5_HSCLK_MAX) {
+			dev_err(priv->dev, "hsclk out of range\n");
+			return 0;
+		}
+
+		/* Determine the correct clock source based on even/odd of the divider */
+		odd = dsi_div_ab_desired & 1;
+		if (odd) {
+			priv->mux_dsi_div_params.clksrc = 0;	/* FOUTPOSTDIV */
+			dsi_div_ab_calc = dsi_div_ab_desired;
+		} else {
+			priv->mux_dsi_div_params.clksrc = 1;	/*  FOUT1PH0 */
+			dsi_div_ab_calc = dsi_div_ab_desired / 2;
+		}
+
+		/* Calculate the DIV_DSI_A and DIV_DSI_B based on the desired divider */
+		for (a = 0; a < 4; a++) {
+			/* FOUT1PH0: Max output of DIV_DSI_A is 750MHz so at least 1/2 to be safe */
+			if (!odd && a == 0)
+				continue;
+
+			/* FOUTPOSTDIV: DIV_DSI_A must always be 1/1 */
+			if (odd && a != 0)
+				break;
+
+			for (b = 0; b < 16; b++) {
+				/* FOUTPOSTDIV: DIV_DSI_B must always be odd divider 1/(b+1) */
+				if (odd && b & 1)
+					continue;
+
+				if (rzg2l_cpg_div_ab(a, b) == dsi_div_ab_calc) {
+					priv->mux_dsi_div_params.dsi_div_a = a;
+					priv->mux_dsi_div_params.dsi_div_b = b;
+					goto calc_pll_clk;
+				}
+			}
+		}
+
+		dev_err(priv->dev, "Failed to calculate DIV_DSI_A,B\n");
+
+		return 0;
+	} else if (dsi_div_target == PLL5_TARGET_DPI) {
+		/* Fixed settings for DPI */
+		priv->mux_dsi_div_params.clksrc = 0;
+		priv->mux_dsi_div_params.dsi_div_a = 3; /* Divided by 8 */
+		priv->mux_dsi_div_params.dsi_div_b = 0; /* Divided by 1 */
+		dsi_div_ab_desired = rzg2l_cpg_div_ab(priv->mux_dsi_div_params.dsi_div_a,
+						      priv->mux_dsi_div_params.dsi_div_b);
+	}
+
+calc_pll_clk:
+	/* PLL5 (MIPI_DSI_PLLCLK) = VCO / POSTDIV1 / POSTDIV2 */
+	for (params->pl5_postdiv1 = PLL5_POSTDIV_MIN;
+	     params->pl5_postdiv1 <= PLL5_POSTDIV_MAX;
+	     params->pl5_postdiv1++) {
+		for (params->pl5_postdiv2 = PLL5_POSTDIV_MIN;
+		     params->pl5_postdiv2 <= PLL5_POSTDIV_MAX;
+		     params->pl5_postdiv2++) {
+			foutvco_rate = rate * params->pl5_postdiv1 * params->pl5_postdiv2 *
+				       dsi_div_ab_desired;
+			if (foutvco_rate <= PLL5_FOUTVCO_MIN || foutvco_rate >= PLL5_FOUTVCO_MAX)
+				continue;
+
+			for (params->pl5_refdiv = PLL5_REFDIV_MIN;
+			     params->pl5_refdiv <= PLL5_REFDIV_MAX;
+			     params->pl5_refdiv++) {
+				u32 rem;
+
+				params->pl5_intin = div_u64_rem(foutvco_rate * params->pl5_refdiv,
+								extal_hz, &rem);
+
+				if (params->pl5_intin < PLL5_INTIN_MIN ||
+				    params->pl5_intin > PLL5_INTIN_MAX)
+					continue;
+
+				params->pl5_fracin = div_u64((u64)rem << 24, extal_hz);
+
+				goto clk_valid;
+			}
+		}
+	}

-	params->pl5_intin = rate / MEGA;
-	params->pl5_fracin = div_u64(((u64)rate % MEGA) << 24, MEGA);
-	params->pl5_refdiv = 2;
-	params->pl5_postdiv1 = 1;
-	params->pl5_postdiv2 = 1;
+	dev_err(priv->dev, "Failed to calculate PLL5 settings\n");
+	return 0;
+
+clk_valid:
 	params->pl5_spread = 0x16;

 	foutvco_rate = div_u64(mul_u32_u32(EXTAL_FREQ_IN_MEGA_HZ * MEGA,
 					   (params->pl5_intin << 24) + params->pl5_fracin),
 			       params->pl5_refdiv) >> 24;
-	foutpostdiv_rate = DIV_ROUND_CLOSEST(foutvco_rate,
-					     params->pl5_postdiv1 * params->pl5_postdiv2);
+	foutpostdiv_rate = DIV_U64_ROUND_CLOSEST(foutvco_rate,
+						 params->pl5_postdiv1 * params->pl5_postdiv2);

 	return foutpostdiv_rate;
 }
@@ -610,7 +730,7 @@ static unsigned long rzg2l_cpg_get_vclk_parent_rate(struct clk_hw *hw,
 	struct rzg2l_pll5_param params;
 	unsigned long parent_rate;

-	parent_rate = rzg2l_cpg_get_foutpostdiv_rate(&params, rate);
+	parent_rate = rzg2l_cpg_get_foutpostdiv_rate(priv, &params, rate);

 	if (priv->mux_dsi_div_params.clksrc)
 		parent_rate /= 2;
@@ -626,9 +746,19 @@ static int rzg2l_cpg_dsi_div_determine_rate(struct clk_hw *hw,

 	req->best_parent_rate = rzg2l_cpg_get_vclk_parent_rate(hw, req->rate);

+	if (!req->best_parent_rate)
+		return -EINVAL;
+
 	return 0;
 }

+void rzg2l_cpg_dsi_div_set_divider(u8 divider, int target)
+{
+	dsi_div_ab_desired = divider;
+	dsi_div_target = target;
+}
+EXPORT_SYMBOL_GPL(rzg2l_cpg_dsi_div_set_divider);
+
 static int rzg2l_cpg_dsi_div_set_rate(struct clk_hw *hw,
 				      unsigned long rate,
 				      unsigned long parent_rate)
@@ -800,22 +930,6 @@ struct sipll5 {

 #define to_sipll5(_hw)	container_of(_hw, struct sipll5, hw)

-static unsigned long rzg2l_cpg_get_vclk_rate(struct clk_hw *hw,
-					     unsigned long rate)
-{
-	struct sipll5 *sipll5 = to_sipll5(hw);
-	struct rzg2l_cpg_priv *priv = sipll5->priv;
-	unsigned long vclk;
-
-	vclk = rate / ((1 << priv->mux_dsi_div_params.dsi_div_a) *
-		       (priv->mux_dsi_div_params.dsi_div_b + 1));
-
-	if (priv->mux_dsi_div_params.clksrc)
-		vclk /= 2;
-
-	return vclk;
-}
-
 static unsigned long rzg2l_cpg_sipll5_recalc_rate(struct clk_hw *hw,
 						  unsigned long parent_rate)
 {
@@ -861,9 +975,9 @@ static int rzg2l_cpg_sipll5_set_rate(struct clk_hw *hw,
 	if (!rate)
 		return -EINVAL;

-	vclk_rate = rzg2l_cpg_get_vclk_rate(hw, rate);
+	vclk_rate = rate / dsi_div_ab_desired;
 	sipll5->foutpostdiv_rate =
-		rzg2l_cpg_get_foutpostdiv_rate(&params, vclk_rate);
+		rzg2l_cpg_get_foutpostdiv_rate(priv, &params, vclk_rate);

 	/* Put PLL5 into standby mode */
 	writel(CPG_SIPLL5_STBY_RESETB_WEN, priv->base + CPG_SIPLL5_STBY);
@@ -951,9 +1065,7 @@ rzg2l_cpg_sipll5_register(const struct cpg_core_clk *core,
 	if (ret)
 		return ERR_PTR(ret);

-	priv->mux_dsi_div_params.clksrc = 1; /* Use clk src 1 for DSI */
-	priv->mux_dsi_div_params.dsi_div_a = 1; /* Divided by 2 */
-	priv->mux_dsi_div_params.dsi_div_b = 2; /* Divided by 3 */
+	rzg2l_cpg_dsi_div_set_divider(8, PLL5_TARGET_DPI);

 	return clk_hw->clk;
 }
diff --git a/include/linux/clk/renesas.h b/include/linux/clk/renesas.h
index 0ebbe2f0b45e..96f54becfa4b 100644
--- a/include/linux/clk/renesas.h
+++ b/include/linux/clk/renesas.h
@@ -32,4 +32,16 @@ void cpg_mssr_detach_dev(struct generic_pm_domain *unused, struct device *dev);
 #define cpg_mssr_attach_dev	NULL
 #define cpg_mssr_detach_dev	NULL
 #endif
+
+enum {
+	PLL5_TARGET_DPI,
+	PLL5_TARGET_DSI
+};
+
+#ifdef CONFIG_CLK_RZG2L
+void rzg2l_cpg_dsi_div_set_divider(u8 divider, int target);
+#else
+static inline void rzg2l_cpg_dsi_div_set_divider(u8 divider, int target) { }
+#endif
+
 #endif
--
2.52.0


