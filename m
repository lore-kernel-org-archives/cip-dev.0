Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DB4C7618E
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 07:18:20 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.6169.1682061470715228262
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 00:18:18 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.99,214,1677510000"; 
   d="scan'208";a="156786990"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Apr 2023 16:18:17 +0900
Received: from localhost.localdomain (unknown [10.226.93.14])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B492241AA65A;
	Fri, 21 Apr 2023 16:18:15 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 18/33] clk: renesas: Add RZ/V2M support using the rzg2l driver
Date: Fri, 21 Apr 2023 08:17:14 +0100
Message-Id: <20230421071729.130347-19-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
References: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 07:18:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11291

From: Phil Edworthy <phil.edworthy@renesas.com>

commit 1dd65bb08604ad2906d839c243e1bede2b0efe53 upstream.

The Renesas RZ/V2M SoC is very similar to RZ/G2L, though it doesn't have
any CLK_MON registers.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220503115557.53370-11-phil.edworthy@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/Kconfig         |   5 +
 drivers/clk/renesas/Makefile        |   1 +
 drivers/clk/renesas/r9a09g011-cpg.c | 168 ++++++++++++++++++++++++++++
 drivers/clk/renesas/rzg2l-cpg.c     |   6 +
 drivers/clk/renesas/rzg2l-cpg.h     |   1 +
 5 files changed, 181 insertions(+)
 create mode 100644 drivers/clk/renesas/r9a09g011-cpg.c

diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 1430ef677a1b..591c961979eb 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -35,6 +35,7 @@ config CLK_RENESAS
 	select CLK_R9A07G043 if ARCH_R9A07G043
 	select CLK_R9A07G044 if ARCH_R9A07G044
 	select CLK_R9A07G054 if ARCH_R9A07G054
+	select CLK_R9A09G011 if ARCH_R9A09G011
 	select CLK_SH73A0 if ARCH_SH73A0
 
 if CLK_RENESAS
@@ -170,6 +171,10 @@ config CLK_R9A07G054
 	bool "RZ/V2L clock support" if COMPILE_TEST
 	select CLK_RZG2L
 
+config CLK_R9A09G011
+	bool "RZ/V2M clock support" if COMPILE_TEST
+	select CLK_RZG2L
+
 config CLK_SH73A0
 	bool "SH-Mobile AG5 clock support" if COMPILE_TEST
 	select CLK_RENESAS_CPG_MSTP
diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefile
index f7b6bfff2dc5..2e57c7047dc3 100644
--- a/drivers/clk/renesas/Makefile
+++ b/drivers/clk/renesas/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_CLK_R9A06G032)		+= r9a06g032-clocks.o
 obj-$(CONFIG_CLK_R9A07G043)		+= r9a07g043-cpg.o
 obj-$(CONFIG_CLK_R9A07G044)		+= r9a07g044-cpg.o
 obj-$(CONFIG_CLK_R9A07G054)		+= r9a07g044-cpg.o
+obj-$(CONFIG_CLK_R9A09G011)		+= r9a09g011-cpg.o
 obj-$(CONFIG_CLK_SH73A0)		+= clk-sh73a0.o
 
 # Family
diff --git a/drivers/clk/renesas/r9a09g011-cpg.c b/drivers/clk/renesas/r9a09g011-cpg.c
new file mode 100644
index 000000000000..b9f80c531869
--- /dev/null
+++ b/drivers/clk/renesas/r9a09g011-cpg.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RZ/V2M Clock Pulse Generator / Module Standby and Software Reset
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ *
+ * Based on r9a07g044-cpg.c
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+#include <dt-bindings/clock/r9a09g011-cpg.h>
+
+#include "rzg2l-cpg.h"
+
+#define RZV2M_SAMPLL4_CLK1	0x104
+#define RZV2M_SAMPLL4_CLK2	0x108
+
+#define PLL4_CONF	(RZV2M_SAMPLL4_CLK1 << 22 | RZV2M_SAMPLL4_CLK2 << 12)
+
+#define DIV_A		DDIV_PACK(0x200, 0, 3)
+#define DIV_B		DDIV_PACK(0x204, 0, 2)
+#define DIV_E		DDIV_PACK(0x204, 8, 1)
+#define DIV_W		DDIV_PACK(0x328, 0, 3)
+
+#define SEL_B		SEL_PLL_PACK(0x214, 0, 1)
+#define SEL_E		SEL_PLL_PACK(0x214, 2, 1)
+#define SEL_W0		SEL_PLL_PACK(0x32C, 0, 1)
+
+enum clk_ids {
+	/* Core Clock Outputs exported to DT */
+	LAST_DT_CORE_CLK = 0,
+
+	/* External Input Clocks */
+	CLK_EXTAL,
+
+	/* Internal Core Clocks */
+	CLK_MAIN,
+	CLK_MAIN_24,
+	CLK_MAIN_2,
+	CLK_PLL1,
+	CLK_PLL2,
+	CLK_PLL2_800,
+	CLK_PLL2_400,
+	CLK_PLL2_200,
+	CLK_PLL2_100,
+	CLK_PLL4,
+	CLK_DIV_A,
+	CLK_DIV_B,
+	CLK_DIV_E,
+	CLK_DIV_W,
+	CLK_SEL_B,
+	CLK_SEL_B_D2,
+	CLK_SEL_E,
+	CLK_SEL_W0,
+
+	/* Module Clocks */
+	MOD_CLK_BASE
+};
+
+/* Divider tables */
+static const struct clk_div_table dtable_diva[] = {
+	{0, 1},
+	{1, 2},
+	{2, 3},
+	{3, 4},
+	{4, 6},
+	{5, 12},
+	{6, 24},
+	{0, 0},
+};
+
+static const struct clk_div_table dtable_divb[] = {
+	{0, 1},
+	{1, 2},
+	{2, 4},
+	{3, 8},
+	{0, 0},
+};
+
+static const struct clk_div_table dtable_divw[] = {
+	{0, 6},
+	{1, 7},
+	{2, 8},
+	{3, 9},
+	{4, 10},
+	{5, 11},
+	{6, 12},
+	{0, 0},
+};
+
+/* Mux clock tables */
+static const char * const sel_b[] = { ".main", ".divb" };
+static const char * const sel_e[] = { ".main", ".dive" };
+static const char * const sel_w[] = { ".main", ".divw" };
+
+static const struct cpg_core_clk r9a09g011_core_clks[] __initconst = {
+	/* External Clock Inputs */
+	DEF_INPUT("extal",	CLK_EXTAL),
+
+	/* Internal Core Clocks */
+	DEF_FIXED(".main",	CLK_MAIN,	CLK_EXTAL,	1,	1),
+	DEF_FIXED(".main_24",	CLK_MAIN_24,	CLK_MAIN,	1,	2),
+	DEF_FIXED(".main_2",	CLK_MAIN_2,	CLK_MAIN,	1,	24),
+	DEF_FIXED(".pll1",	CLK_PLL1,	CLK_MAIN_2,	498,	1),
+	DEF_FIXED(".pll2",	CLK_PLL2,	CLK_MAIN_2,	800,	1),
+	DEF_FIXED(".pll2_800",	CLK_PLL2_800,	CLK_PLL2,	1,	2),
+	DEF_FIXED(".pll2_400",	CLK_PLL2_400,	CLK_PLL2_800,	1,	2),
+	DEF_FIXED(".pll2_200",	CLK_PLL2_200,	CLK_PLL2_800,	1,	4),
+	DEF_FIXED(".pll2_100",	CLK_PLL2_100,	CLK_PLL2_800,	1,	8),
+	DEF_SAMPLL(".pll4",	CLK_PLL4,	CLK_MAIN_2,	PLL4_CONF),
+
+	DEF_DIV_RO(".diva",	CLK_DIV_A,	CLK_PLL1,	DIV_A,	dtable_diva),
+	DEF_DIV_RO(".divb",	CLK_DIV_B,	CLK_PLL2_400,	DIV_B,	dtable_divb),
+	DEF_DIV_RO(".dive",	CLK_DIV_E,	CLK_PLL2_100,	DIV_E,	NULL),
+	DEF_DIV_RO(".divw",	CLK_DIV_W,	CLK_PLL4,	DIV_W,	dtable_divw),
+
+	DEF_MUX_RO(".selb",	CLK_SEL_B,	SEL_B,		sel_b),
+	DEF_MUX_RO(".sele",	CLK_SEL_E,	SEL_E,		sel_e),
+	DEF_MUX(".selw0",	CLK_SEL_W0,	SEL_W0,		sel_w),
+
+	DEF_FIXED(".selb_d2",	CLK_SEL_B_D2,	CLK_SEL_B,	1,	2),
+};
+
+static const struct rzg2l_mod_clk r9a09g011_mod_clks[] __initconst = {
+	DEF_MOD("gic",		R9A09G011_GIC_CLK,	CLK_SEL_B_D2, 0x400, 5),
+	DEF_MOD("syc_cnt_clk",	R9A09G011_SYC_CNT_CLK,	CLK_MAIN_24,  0x41c, 12),
+	DEF_MOD("urt_pclk",	R9A09G011_URT_PCLK,	CLK_SEL_E,    0x438, 4),
+	DEF_MOD("urt0_clk",	R9A09G011_URT0_CLK,	CLK_SEL_W0,   0x438, 5),
+	DEF_MOD("ca53",		R9A09G011_CA53_CLK,	CLK_DIV_A,    0x448, 0),
+};
+
+static const struct rzg2l_reset r9a09g011_resets[] = {
+	DEF_RST_MON(R9A09G011_SYC_RST_N,	0x610, 9,  13),
+};
+
+static const unsigned int r9a09g011_crit_mod_clks[] __initconst = {
+	MOD_CLK_BASE + R9A09G011_CA53_CLK,
+	MOD_CLK_BASE + R9A09G011_GIC_CLK,
+	MOD_CLK_BASE + R9A09G011_SYC_CNT_CLK,
+	MOD_CLK_BASE + R9A09G011_URT_PCLK,
+};
+
+const struct rzg2l_cpg_info r9a09g011_cpg_info = {
+	/* Core Clocks */
+	.core_clks = r9a09g011_core_clks,
+	.num_core_clks = ARRAY_SIZE(r9a09g011_core_clks),
+	.last_dt_core_clk = LAST_DT_CORE_CLK,
+	.num_total_core_clks = MOD_CLK_BASE,
+
+	/* Critical Module Clocks */
+	.crit_mod_clks = r9a09g011_crit_mod_clks,
+	.num_crit_mod_clks = ARRAY_SIZE(r9a09g011_crit_mod_clks),
+
+	/* Module Clocks */
+	.mod_clks = r9a09g011_mod_clks,
+	.num_mod_clks = ARRAY_SIZE(r9a09g011_mod_clks),
+	.num_hw_mod_clks = R9A09G011_CA53_CLK + 1,
+
+	/* Resets */
+	.resets = r9a09g011_resets,
+	.num_resets = ARRAY_SIZE(r9a09g011_resets),
+
+	.has_clk_mon_regs = false,
+};
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 7b8a373f6ebc..1f9cbee97df1 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -976,6 +976,12 @@ static const struct of_device_id rzg2l_cpg_match[] = {
 		.compatible = "renesas,r9a07g054-cpg",
 		.data = &r9a07g054_cpg_info,
 	},
+#endif
+#ifdef CONFIG_CLK_R9A09G011
+	{
+		.compatible = "renesas,r9a09g011-cpg",
+		.data = &r9a09g011_cpg_info,
+	},
 #endif
 	{ /* sentinel */ }
 };
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index f05b2b775cd5..4d7f7a102f36 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -225,5 +225,6 @@ struct rzg2l_cpg_info {
 extern const struct rzg2l_cpg_info r9a07g043_cpg_info;
 extern const struct rzg2l_cpg_info r9a07g044_cpg_info;
 extern const struct rzg2l_cpg_info r9a07g054_cpg_info;
+extern const struct rzg2l_cpg_info r9a09g011_cpg_info;
 
 #endif
-- 
2.25.1


