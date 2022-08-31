Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F69FC0502A
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 16:47:07 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.1223.1661964417858439900
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 09:47:01 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,278,1654527600";
   d="scan'208";a="133251648"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Sep 2022 01:47:00 +0900
Received: from localhost.localdomain (unknown [10.226.92.133])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id CF89D40457CD;
	Thu,  1 Sep 2022 01:46:57 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 03/26] clk: renesas: Add support for RZ/G2UL SoC
Date: Wed, 31 Aug 2022 17:46:22 +0100
Message-Id: <20220831164645.2134258-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
References: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 16:47:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9363

commit c8b088224c25ef4f5270f9de6a3516181b63f38c upstream.

The clock structure for RZ/G2UL is almost identical to RZ/G2L SoC with
fewer IP blocks. The IP blocks such as WDT1, GPT, H264, GPU and POEG are
not present on RZ/G2UL.

This patch adds minimal clock and reset entries required to boot the
system on Renesas RZ/G2UL SMARC EVK and binds it with the RZ/G2L CPG core
driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220412161314.13800-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/Kconfig         |   7 +-
 drivers/clk/renesas/Makefile        |   1 +
 drivers/clk/renesas/r9a07g043-cpg.c | 157 ++++++++++++++++++++++++++++
 drivers/clk/renesas/rzg2l-cpg.c     |   6 ++
 drivers/clk/renesas/rzg2l-cpg.h     |   1 +
 5 files changed, 171 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/renesas/r9a07g043-cpg.c

diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 162ea716b9a5..1430ef677a1b 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -32,6 +32,7 @@ config CLK_RENESAS
 	select CLK_R8A77995 if ARCH_R8A77995
 	select CLK_R8A779A0 if ARCH_R8A779A0
 	select CLK_R9A06G032 if ARCH_R9A06G032
+	select CLK_R9A07G043 if ARCH_R9A07G043
 	select CLK_R9A07G044 if ARCH_R9A07G044
 	select CLK_R9A07G054 if ARCH_R9A07G054
 	select CLK_SH73A0 if ARCH_SH73A0
@@ -157,6 +158,10 @@ config CLK_R9A06G032
 	help
 	  This is a driver for R9A06G032 clocks
 
+config CLK_R9A07G043
+	bool "RZ/G2UL clock support" if COMPILE_TEST
+	select CLK_RZG2L
+
 config CLK_R9A07G044
 	bool "RZ/G2L clock support" if COMPILE_TEST
 	select CLK_RZG2L
@@ -188,7 +193,7 @@ config CLK_RCAR_USB2_CLOCK_SEL
 	  This is a driver for R-Car USB2 clock selector
 
 config CLK_RZG2L
-	bool "Renesas RZ/{G2L,V2L} family clock support" if COMPILE_TEST
+	bool "Renesas RZ/{G2L,G2UL,V2L} family clock support" if COMPILE_TEST
 	select RESET_CONTROLLER
 
 # Generic
diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefile
index 7cb90ed1e1db..f7b6bfff2dc5 100644
--- a/drivers/clk/renesas/Makefile
+++ b/drivers/clk/renesas/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_CLK_R8A77990)		+= r8a77990-cpg-mssr.o
 obj-$(CONFIG_CLK_R8A77995)		+= r8a77995-cpg-mssr.o
 obj-$(CONFIG_CLK_R8A779A0)		+= r8a779a0-cpg-mssr.o
 obj-$(CONFIG_CLK_R9A06G032)		+= r9a06g032-clocks.o
+obj-$(CONFIG_CLK_R9A07G043)		+= r9a07g043-cpg.o
 obj-$(CONFIG_CLK_R9A07G044)		+= r9a07g044-cpg.o
 obj-$(CONFIG_CLK_R9A07G054)		+= r9a07g044-cpg.o
 obj-$(CONFIG_CLK_SH73A0)		+= clk-sh73a0.o
diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
new file mode 100644
index 000000000000..81409ff37e2e
--- /dev/null
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RZ/G2UL CPG driver
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+#include <dt-bindings/clock/r9a07g043-cpg.h>
+
+#include "rzg2l-cpg.h"
+
+enum clk_ids {
+	/* Core Clock Outputs exported to DT */
+	LAST_DT_CORE_CLK = R9A07G043_CLK_P0_DIV2,
+
+	/* External Input Clocks */
+	CLK_EXTAL,
+
+	/* Internal Core Clocks */
+	CLK_OSC_DIV1000,
+	CLK_PLL1,
+	CLK_PLL2,
+	CLK_PLL2_DIV2,
+	CLK_PLL2_DIV2_8,
+	CLK_PLL3,
+	CLK_PLL3_DIV2,
+	CLK_PLL3_DIV2_4,
+	CLK_PLL3_DIV2_4_2,
+	CLK_PLL5,
+	CLK_PLL6,
+	CLK_P1_DIV2,
+
+	/* Module Clocks */
+	MOD_CLK_BASE,
+};
+
+/* Divider tables */
+static const struct clk_div_table dtable_1_8[] = {
+	{0, 1},
+	{1, 2},
+	{2, 4},
+	{3, 8},
+	{0, 0},
+};
+
+static const struct clk_div_table dtable_1_32[] = {
+	{0, 1},
+	{1, 2},
+	{2, 4},
+	{3, 8},
+	{4, 32},
+	{0, 0},
+};
+
+static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
+	/* External Clock Inputs */
+	DEF_INPUT("extal", CLK_EXTAL),
+
+	/* Internal Core Clocks */
+	DEF_FIXED(".osc", R9A07G043_OSCCLK, CLK_EXTAL, 1, 1),
+	DEF_FIXED(".osc_div1000", CLK_OSC_DIV1000, CLK_EXTAL, 1, 1000),
+	DEF_SAMPLL(".pll1", CLK_PLL1, CLK_EXTAL, PLL146_CONF(0)),
+	DEF_FIXED(".pll2", CLK_PLL2, CLK_EXTAL, 200, 3),
+	DEF_FIXED(".pll2_div2", CLK_PLL2_DIV2, CLK_PLL2, 1, 2),
+	DEF_FIXED(".pll2_div2_8", CLK_PLL2_DIV2_8, CLK_PLL2_DIV2, 1, 8),
+	DEF_FIXED(".pll3", CLK_PLL3, CLK_EXTAL, 200, 3),
+	DEF_FIXED(".pll3_div2", CLK_PLL3_DIV2, CLK_PLL3, 1, 2),
+	DEF_FIXED(".pll3_div2_4", CLK_PLL3_DIV2_4, CLK_PLL3_DIV2, 1, 4),
+	DEF_FIXED(".pll3_div2_4_2", CLK_PLL3_DIV2_4_2, CLK_PLL3_DIV2_4, 1, 2),
+	DEF_FIXED(".pll5", CLK_PLL5, CLK_EXTAL, 125, 1),
+	DEF_FIXED(".pll6", CLK_PLL6, CLK_EXTAL, 125, 6),
+
+	/* Core output clk */
+	DEF_DIV("I", R9A07G043_CLK_I, CLK_PLL1, DIVPL1A, dtable_1_8,
+		CLK_DIVIDER_HIWORD_MASK),
+	DEF_DIV("P0", R9A07G043_CLK_P0, CLK_PLL2_DIV2_8, DIVPL2A,
+		dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
+	DEF_DIV("P1", R9A07G043_CLK_P1, CLK_PLL3_DIV2_4,
+		DIVPL3B, dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
+	DEF_FIXED("P1_DIV2", CLK_P1_DIV2, R9A07G043_CLK_P1, 1, 2),
+	DEF_DIV("P2", R9A07G043_CLK_P2, CLK_PLL3_DIV2_4_2,
+		DIVPL3A, dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
+};
+
+static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
+	DEF_MOD("gic",		R9A07G043_GIC600_GICCLK, R9A07G043_CLK_P1,
+				0x514, 0),
+	DEF_MOD("ia55_pclk",	R9A07G043_IA55_PCLK, R9A07G043_CLK_P2,
+				0x518, 0),
+	DEF_MOD("ia55_clk",	R9A07G043_IA55_CLK, R9A07G043_CLK_P1,
+				0x518, 1),
+	DEF_MOD("dmac_aclk",	R9A07G043_DMAC_ACLK, R9A07G043_CLK_P1,
+				0x52c, 0),
+	DEF_MOD("dmac_pclk",	R9A07G043_DMAC_PCLK, CLK_P1_DIV2,
+				0x52c, 1),
+	DEF_MOD("scif0",	R9A07G043_SCIF0_CLK_PCK, R9A07G043_CLK_P0,
+				0x584, 0),
+	DEF_MOD("scif1",	R9A07G043_SCIF1_CLK_PCK, R9A07G043_CLK_P0,
+				0x584, 1),
+	DEF_MOD("scif2",	R9A07G043_SCIF2_CLK_PCK, R9A07G043_CLK_P0,
+				0x584, 2),
+	DEF_MOD("scif3",	R9A07G043_SCIF3_CLK_PCK, R9A07G043_CLK_P0,
+				0x584, 3),
+	DEF_MOD("scif4",	R9A07G043_SCIF4_CLK_PCK, R9A07G043_CLK_P0,
+				0x584, 4),
+	DEF_MOD("sci0",		R9A07G043_SCI0_CLKP, R9A07G043_CLK_P0,
+				0x588, 0),
+	DEF_MOD("sci1",		R9A07G043_SCI1_CLKP, R9A07G043_CLK_P0,
+				0x588, 1),
+};
+
+static struct rzg2l_reset r9a07g043_resets[] = {
+	DEF_RST(R9A07G043_GIC600_GICRESET_N, 0x814, 0),
+	DEF_RST(R9A07G043_GIC600_DBG_GICRESET_N, 0x814, 1),
+	DEF_RST(R9A07G043_IA55_RESETN, 0x818, 0),
+	DEF_RST(R9A07G043_DMAC_ARESETN, 0x82c, 0),
+	DEF_RST(R9A07G043_DMAC_RST_ASYNC, 0x82c, 1),
+	DEF_RST(R9A07G043_SCIF0_RST_SYSTEM_N, 0x884, 0),
+	DEF_RST(R9A07G043_SCIF1_RST_SYSTEM_N, 0x884, 1),
+	DEF_RST(R9A07G043_SCIF2_RST_SYSTEM_N, 0x884, 2),
+	DEF_RST(R9A07G043_SCIF3_RST_SYSTEM_N, 0x884, 3),
+	DEF_RST(R9A07G043_SCIF4_RST_SYSTEM_N, 0x884, 4),
+	DEF_RST(R9A07G043_SCI0_RST, 0x888, 0),
+	DEF_RST(R9A07G043_SCI1_RST, 0x888, 1),
+};
+
+static const unsigned int r9a07g043_crit_mod_clks[] __initconst = {
+	MOD_CLK_BASE + R9A07G043_GIC600_GICCLK,
+	MOD_CLK_BASE + R9A07G043_IA55_CLK,
+	MOD_CLK_BASE + R9A07G043_DMAC_ACLK,
+};
+
+const struct rzg2l_cpg_info r9a07g043_cpg_info = {
+	/* Core Clocks */
+	.core_clks = r9a07g043_core_clks,
+	.num_core_clks = ARRAY_SIZE(r9a07g043_core_clks),
+	.last_dt_core_clk = LAST_DT_CORE_CLK,
+	.num_total_core_clks = MOD_CLK_BASE,
+
+	/* Critical Module Clocks */
+	.crit_mod_clks = r9a07g043_crit_mod_clks,
+	.num_crit_mod_clks = ARRAY_SIZE(r9a07g043_crit_mod_clks),
+
+	/* Module Clocks */
+	.mod_clks = r9a07g043_mod_clks,
+	.num_mod_clks = ARRAY_SIZE(r9a07g043_mod_clks),
+	.num_hw_mod_clks = R9A07G043_TSU_PCLK + 1,
+
+	/* Resets */
+	.resets = r9a07g043_resets,
+	.num_resets = R9A07G043_TSU_PRESETN + 1, /* Last reset ID + 1 */
+};
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index a03bc9cbbd4b..4d056057f28e 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -945,6 +945,12 @@ static int __init rzg2l_cpg_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id rzg2l_cpg_match[] = {
+#ifdef CONFIG_CLK_R9A07G043
+	{
+		.compatible = "renesas,r9a07g043-cpg",
+		.data = &r9a07g043_cpg_info,
+	},
+#endif
 #ifdef CONFIG_CLK_R9A07G044
 	{
 		.compatible = "renesas,r9a07g044-cpg",
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index ce657beaf160..92c88f42ca7f 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -202,6 +202,7 @@ struct rzg2l_cpg_info {
 	unsigned int num_crit_mod_clks;
 };
 
+extern const struct rzg2l_cpg_info r9a07g043_cpg_info;
 extern const struct rzg2l_cpg_info r9a07g044_cpg_info;
 extern const struct rzg2l_cpg_info r9a07g054_cpg_info;
 
-- 
2.25.1


