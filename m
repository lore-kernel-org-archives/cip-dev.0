Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87808C41513
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:10 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web10.18446.1713526749484512049
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=hTvOLPn7;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e69a51a33so1990629a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526748; x=1714131548; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gjdaqdis9ydlWE6O/FdqxLuU1DDpeBGoBQiuBjchjmE=;
        b=hTvOLPn77mxs4qpmA/ahUBQB89yXP5lM3tYokeF5cAZyiVMyjZ1hkCX+IK1MSnZwlT
         tK2byVh5S3+hIVjsf9Hz20wzoR4iRjiV8ACAb85gwQut2oiXG1ysJ6uuvWnZsToU66CW
         s0gHJzde3EQymy2vYz3Wn0JJqVHu80n3CC4oOJrplruUgsZ89fsy+710nT/yr0pXvqXW
         V8emqV/MJWaLIglfz5GTEOUTCfi7dGkzr31HwjqB9smUVlruy4G9IDEgiaZ+LH9EC9D2
         nxLrsdTpKlejFsFa8ACsOtC0pMPjsEWf85LoRgAl9EDROLbCkUilKrf14Iv5I4BB+F9q
         093A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526748; x=1714131548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gjdaqdis9ydlWE6O/FdqxLuU1DDpeBGoBQiuBjchjmE=;
        b=A68lLYZIyFkQJXhTnpG7LYqDlhuvlwAKGdocDH8NBq8tpHO0IBscz6exHNc1je/L4j
         6XY7Q9yV/nqt0ifMX3M/7IURE8+jYIrhjq/ADLCbisbQLIBZflNz7+phO+mq3YUg8onk
         QINFz3+EFiIv3ubE7KDL4giQqmW6nU6/qAHHHCT3ab3ObUagCNRsTEPvlRUgl4KNxvGd
         XPL63b71lVOTmvfQayiCjLQmVXqXPJ8cKzwoH8JNo9G9wXqB3jrevvan/77atz+8GxOH
         iTNVb8c861bI4DIcldEHFkbWTcEl3SJ8wIbgN/irknEWTPeNI74GSgRwBJwFyDdIJJ0R
         3nPA==
X-Gm-Message-State: AOJu0YyYg6zDOGkxqEiiU3IzReSGA5+mrISCTGq4YUgN4xVVi+7bu5qQ
	4IkTUZ1QeQSr0Iyj0oR1/QzydPxPgHBscGIM4oim+bZESjEm8c1EZLDqW7DKZm8=
X-Google-Smtp-Source: AGHT+IF4GYFkLev778cUDT0kZD81HgpAIiuGmJKb8qppe3FfxSPV3/gOyQacFNy7Zxlfsyefdf2bDg==
X-Received: by 2002:a50:a69a:0:b0:56e:2daf:1ed9 with SMTP id e26-20020a50a69a000000b0056e2daf1ed9mr1390848edc.23.1713526747660;
        Fri, 19 Apr 2024 04:39:07 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:06 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 16/44] clk: renesas: Add minimal boot support for RZ/G3S SoC
Date: Fri, 19 Apr 2024 14:38:14 +0300
Message-Id: <20240419113842.3675543-17-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15667

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit de60a3ebe410670ffdbbc95faa25a820da44ab11 upstream.

Add minimal clock and reset support for the RZ/G3S SoC to be able to
boot Linux from SD Card/eMMC.  This includes necessary core clocks for
booting and GIC, SCIF, GPIO, and SD0 module clocks and resets.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231006103959.197485-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/Kconfig         |   7 +-
 drivers/clk/renesas/Makefile        |   1 +
 drivers/clk/renesas/r9a08g045-cpg.c | 214 ++++++++++++++++++++++++++++
 drivers/clk/renesas/rzg2l-cpg.c     |   6 +
 drivers/clk/renesas/rzg2l-cpg.h     |   1 +
 5 files changed, 228 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/renesas/r9a08g045-cpg.c

diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 37632a0659d8..69396e197959 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -37,6 +37,7 @@ config CLK_RENESAS
 	select CLK_R9A07G043 if ARCH_R9A07G043
 	select CLK_R9A07G044 if ARCH_R9A07G044
 	select CLK_R9A07G054 if ARCH_R9A07G054
+	select CLK_R9A08G045 if ARCH_R9A08G045
 	select CLK_R9A09G011 if ARCH_R9A09G011
 	select CLK_SH73A0 if ARCH_SH73A0
 
@@ -179,6 +180,10 @@ config CLK_R9A07G054
 	bool "RZ/V2L clock support" if COMPILE_TEST
 	select CLK_RZG2L
 
+config CLK_R9A08G045
+	bool "RZ/G3S clock support" if COMPILE_TEST
+	select CLK_RZG2L
+
 config CLK_R9A09G011
 	bool "RZ/V2M clock support" if COMPILE_TEST
 	select CLK_RZG2L
@@ -215,7 +220,7 @@ config CLK_RCAR_USB2_CLOCK_SEL
 	  This is a driver for R-Car USB2 clock selector
 
 config CLK_RZG2L
-	bool "Renesas RZ/{G2L,G2UL,V2L} family clock support" if COMPILE_TEST
+	bool "Renesas RZ/{G2L,G2UL,G3S,V2L} family clock support" if COMPILE_TEST
 	select RESET_CONTROLLER
 
 # Generic
diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefile
index de907623fe3f..879a07d445f9 100644
--- a/drivers/clk/renesas/Makefile
+++ b/drivers/clk/renesas/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_CLK_R9A06G032)		+= r9a06g032-clocks.o
 obj-$(CONFIG_CLK_R9A07G043)		+= r9a07g043-cpg.o
 obj-$(CONFIG_CLK_R9A07G044)		+= r9a07g044-cpg.o
 obj-$(CONFIG_CLK_R9A07G054)		+= r9a07g044-cpg.o
+obj-$(CONFIG_CLK_R9A08G045)		+= r9a08g045-cpg.o
 obj-$(CONFIG_CLK_R9A09G011)		+= r9a09g011-cpg.o
 obj-$(CONFIG_CLK_SH73A0)		+= clk-sh73a0.o
 
diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
new file mode 100644
index 000000000000..389d32b32168
--- /dev/null
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RZ/G3S CPG driver
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+#include <dt-bindings/clock/r9a08g045-cpg.h>
+
+#include "rzg2l-cpg.h"
+
+/* RZ/G3S Specific registers. */
+#define G3S_CPG_PL2_DDIV		(0x204)
+#define G3S_CPG_SDHI_DDIV		(0x218)
+#define G3S_CPG_PLL_DSEL		(0x240)
+#define G3S_CPG_SDHI_DSEL		(0x244)
+#define G3S_CLKDIVSTATUS		(0x280)
+#define G3S_CLKSELSTATUS		(0x284)
+
+/* RZ/G3S Specific division configuration.  */
+#define G3S_DIVPL2B		DDIV_PACK(G3S_CPG_PL2_DDIV, 4, 3)
+#define G3S_DIV_SDHI0		DDIV_PACK(G3S_CPG_SDHI_DDIV, 0, 1)
+
+/* RZ/G3S Clock status configuration. */
+#define G3S_DIVPL1A_STS		DDIV_PACK(G3S_CLKDIVSTATUS, 0, 1)
+#define G3S_DIVPL2B_STS		DDIV_PACK(G3S_CLKDIVSTATUS, 5, 1)
+#define G3S_DIVPL3A_STS		DDIV_PACK(G3S_CLKDIVSTATUS, 8, 1)
+#define G3S_DIVPL3B_STS		DDIV_PACK(G3S_CLKDIVSTATUS, 9, 1)
+#define G3S_DIVPL3C_STS		DDIV_PACK(G3S_CLKDIVSTATUS, 10, 1)
+#define G3S_DIV_SDHI0_STS	DDIV_PACK(G3S_CLKDIVSTATUS, 24, 1)
+
+#define G3S_SEL_PLL4_STS	SEL_PLL_PACK(G3S_CLKSELSTATUS, 6, 1)
+#define G3S_SEL_SDHI0_STS	SEL_PLL_PACK(G3S_CLKSELSTATUS, 16, 1)
+
+/* RZ/G3S Specific clocks select. */
+#define G3S_SEL_PLL4		SEL_PLL_PACK(G3S_CPG_PLL_DSEL, 6, 1)
+#define G3S_SEL_SDHI0		SEL_PLL_PACK(G3S_CPG_SDHI_DSEL, 0, 2)
+
+/* PLL 1/4/6 configuration registers macro. */
+#define G3S_PLL146_CONF(clk1, clk2)	((clk1) << 22 | (clk2) << 12)
+
+#define DEF_G3S_MUX(_name, _id, _conf, _parent_names, _mux_flags, _clk_flags) \
+	DEF_TYPE(_name, _id, CLK_TYPE_MUX, .conf = (_conf), \
+		 .parent_names = (_parent_names), \
+		 .num_parents = ARRAY_SIZE((_parent_names)), \
+		 .mux_flags = CLK_MUX_HIWORD_MASK | (_mux_flags), \
+		 .flag = (_clk_flags))
+
+enum clk_ids {
+	/* Core Clock Outputs exported to DT */
+	LAST_DT_CORE_CLK = R9A08G045_SWD,
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
+	CLK_PLL2_DIV6,
+	CLK_PLL3,
+	CLK_PLL3_DIV2,
+	CLK_PLL3_DIV2_4,
+	CLK_PLL3_DIV2_8,
+	CLK_PLL3_DIV6,
+	CLK_PLL4,
+	CLK_PLL6,
+	CLK_PLL6_DIV2,
+	CLK_SEL_SDHI0,
+	CLK_SEL_PLL4,
+	CLK_P1_DIV2,
+	CLK_P3_DIV2,
+	CLK_SD0_DIV4,
+
+	/* Module Clocks */
+	MOD_CLK_BASE,
+};
+
+/* Divider tables */
+static const struct clk_div_table dtable_1_2[] = {
+	{ 0, 1 },
+	{ 1, 2 },
+	{ 0, 0 },
+};
+
+static const struct clk_div_table dtable_1_8[] = {
+	{ 0, 1 },
+	{ 1, 2 },
+	{ 2, 4 },
+	{ 3, 8 },
+	{ 0, 0 },
+};
+
+static const struct clk_div_table dtable_1_32[] = {
+	{ 0, 1 },
+	{ 1, 2 },
+	{ 2, 4 },
+	{ 3, 8 },
+	{ 4, 32 },
+	{ 0, 0 },
+};
+
+/* Mux clock names tables. */
+static const char * const sel_sdhi[] = { ".pll2_div2", ".pll6", ".pll2_div6" };
+static const char * const sel_pll4[] = { ".osc_div1000", ".pll4" };
+
+/* Mux clock indices tables. */
+static const u32 mtable_sd[] = { 0, 2, 3 };
+static const u32 mtable_pll4[] = { 0, 1 };
+
+static const struct cpg_core_clk r9a08g045_core_clks[] __initconst = {
+	/* External Clock Inputs */
+	DEF_INPUT("extal", CLK_EXTAL),
+
+	/* Internal Core Clocks */
+	DEF_FIXED(".osc_div1000", CLK_OSC_DIV1000, CLK_EXTAL, 1, 1000),
+	DEF_G3S_PLL(".pll1", CLK_PLL1, CLK_EXTAL, G3S_PLL146_CONF(0x4, 0x8)),
+	DEF_FIXED(".pll2", CLK_PLL2, CLK_EXTAL, 200, 3),
+	DEF_FIXED(".pll3", CLK_PLL3, CLK_EXTAL, 200, 3),
+	DEF_FIXED(".pll4", CLK_PLL4, CLK_EXTAL, 100, 3),
+	DEF_FIXED(".pll6", CLK_PLL6, CLK_EXTAL, 125, 6),
+	DEF_FIXED(".pll2_div2", CLK_PLL2_DIV2, CLK_PLL2, 1, 2),
+	DEF_FIXED(".pll2_div2_8", CLK_PLL2_DIV2_8, CLK_PLL2_DIV2, 1, 8),
+	DEF_FIXED(".pll2_div6", CLK_PLL2_DIV6, CLK_PLL2, 1, 6),
+	DEF_FIXED(".pll3_div2", CLK_PLL3_DIV2, CLK_PLL3, 1, 2),
+	DEF_FIXED(".pll3_div2_4", CLK_PLL3_DIV2_4, CLK_PLL3_DIV2, 1, 4),
+	DEF_FIXED(".pll3_div2_8", CLK_PLL3_DIV2_8, CLK_PLL3_DIV2, 1, 8),
+	DEF_FIXED(".pll3_div6", CLK_PLL3_DIV6, CLK_PLL3, 1, 6),
+	DEF_FIXED(".pll6_div2", CLK_PLL6_DIV2, CLK_PLL6, 1, 2),
+	DEF_SD_MUX(".sel_sd0", CLK_SEL_SDHI0, G3S_SEL_SDHI0, G3S_SEL_SDHI0_STS, sel_sdhi,
+		   mtable_sd, 0, NULL),
+	DEF_SD_MUX(".sel_pll4", CLK_SEL_PLL4, G3S_SEL_PLL4, G3S_SEL_PLL4_STS, sel_pll4,
+		   mtable_pll4, CLK_SET_PARENT_GATE, NULL),
+
+	/* Core output clk */
+	DEF_G3S_DIV("I", R9A08G045_CLK_I, CLK_PLL1, DIVPL1A, G3S_DIVPL1A_STS, dtable_1_8,
+		    0, 0, 0, NULL),
+	DEF_G3S_DIV("P0", R9A08G045_CLK_P0, CLK_PLL2_DIV2_8, G3S_DIVPL2B, G3S_DIVPL2B_STS,
+		    dtable_1_32, 0, 0, 0, NULL),
+	DEF_G3S_DIV("SD0", R9A08G045_CLK_SD0, CLK_SEL_SDHI0, G3S_DIV_SDHI0, G3S_DIV_SDHI0_STS,
+		    dtable_1_2, 800000000UL, 500000000UL, CLK_SET_RATE_PARENT,
+		    rzg3s_cpg_div_clk_notifier),
+	DEF_FIXED(".sd0_div4", CLK_SD0_DIV4, R9A08G045_CLK_SD0, 1, 4),
+	DEF_FIXED("M0", R9A08G045_CLK_M0, CLK_PLL3_DIV2_4, 1, 1),
+	DEF_G3S_DIV("P1", R9A08G045_CLK_P1, CLK_PLL3_DIV2_4, DIVPL3A, G3S_DIVPL3A_STS,
+		    dtable_1_32, 0, 0, 0, NULL),
+	DEF_FIXED("P1_DIV2", CLK_P1_DIV2, R9A08G045_CLK_P1, 1, 2),
+	DEF_G3S_DIV("P2", R9A08G045_CLK_P2, CLK_PLL3_DIV2_8, DIVPL3B, G3S_DIVPL3B_STS,
+		    dtable_1_32, 0, 0, 0, NULL),
+	DEF_G3S_DIV("P3", R9A08G045_CLK_P3, CLK_PLL3_DIV2_4, DIVPL3C, G3S_DIVPL3C_STS,
+		    dtable_1_32, 0, 0, 0, NULL),
+	DEF_FIXED("P3_DIV2", CLK_P3_DIV2, R9A08G045_CLK_P3, 1, 2),
+	DEF_FIXED("S0", R9A08G045_CLK_S0, CLK_SEL_PLL4, 1, 2),
+	DEF_FIXED("OSC", R9A08G045_OSCCLK, CLK_EXTAL, 1, 1),
+	DEF_FIXED("OSC2", R9A08G045_OSCCLK2, CLK_EXTAL, 1, 3),
+};
+
+static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
+	DEF_MOD("gic_gicclk",		R9A08G045_GIC600_GICCLK, R9A08G045_CLK_P1, 0x514, 0),
+	DEF_MOD("ia55_clk",		R9A08G045_IA55_CLK, R9A08G045_CLK_P1, 0x518, 1),
+	DEF_MOD("dmac_aclk",		R9A08G045_DMAC_ACLK, R9A08G045_CLK_P3, 0x52c, 0),
+	DEF_MOD("sdhi0_imclk",		R9A08G045_SDHI0_IMCLK, CLK_SD0_DIV4, 0x554, 0),
+	DEF_MOD("sdhi0_imclk2",		R9A08G045_SDHI0_IMCLK2, CLK_SD0_DIV4, 0x554, 1),
+	DEF_MOD("sdhi0_clk_hs",		R9A08G045_SDHI0_CLK_HS, R9A08G045_CLK_SD0, 0x554, 2),
+	DEF_MOD("sdhi0_aclk",		R9A08G045_SDHI0_ACLK, R9A08G045_CLK_P1, 0x554, 3),
+	DEF_MOD("scif0_clk_pck",	R9A08G045_SCIF0_CLK_PCK, R9A08G045_CLK_P0, 0x584, 0),
+	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0),
+};
+
+static const struct rzg2l_reset r9a08g045_resets[] = {
+	DEF_RST(R9A08G045_GIC600_GICRESET_N, 0x814, 0),
+	DEF_RST(R9A08G045_GIC600_DBG_GICRESET_N, 0x814, 1),
+	DEF_RST(R9A08G045_SDHI0_IXRST, 0x854, 0),
+	DEF_RST(R9A08G045_SCIF0_RST_SYSTEM_N, 0x884, 0),
+	DEF_RST(R9A08G045_GPIO_RSTN, 0x898, 0),
+	DEF_RST(R9A08G045_GPIO_PORT_RESETN, 0x898, 1),
+	DEF_RST(R9A08G045_GPIO_SPARE_RESETN, 0x898, 2),
+};
+
+static const unsigned int r9a08g045_crit_mod_clks[] __initconst = {
+	MOD_CLK_BASE + R9A08G045_GIC600_GICCLK,
+	MOD_CLK_BASE + R9A08G045_IA55_CLK,
+	MOD_CLK_BASE + R9A08G045_DMAC_ACLK,
+};
+
+const struct rzg2l_cpg_info r9a08g045_cpg_info = {
+	/* Core Clocks */
+	.core_clks = r9a08g045_core_clks,
+	.num_core_clks = ARRAY_SIZE(r9a08g045_core_clks),
+	.last_dt_core_clk = LAST_DT_CORE_CLK,
+	.num_total_core_clks = MOD_CLK_BASE,
+
+	/* Critical Module Clocks */
+	.crit_mod_clks = r9a08g045_crit_mod_clks,
+	.num_crit_mod_clks = ARRAY_SIZE(r9a08g045_crit_mod_clks),
+
+	/* Module Clocks */
+	.mod_clks = r9a08g045_mod_clks,
+	.num_mod_clks = ARRAY_SIZE(r9a08g045_mod_clks),
+	.num_hw_mod_clks = R9A08G045_VBAT_BCLK + 1,
+
+	/* Resets */
+	.resets = r9a08g045_resets,
+	.num_resets = R9A08G045_VBAT_BRESETN + 1, /* Last reset ID + 1 */
+
+	.has_clk_mon_regs = true,
+};
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 3b691445bf52..e05471a6ca8d 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1728,6 +1728,12 @@ static const struct of_device_id rzg2l_cpg_match[] = {
 		.data = &r9a07g054_cpg_info,
 	},
 #endif
+#ifdef CONFIG_CLK_R9A08G045
+	{
+		.compatible = "renesas,r9a08g045-cpg",
+		.data = &r9a08g045_cpg_info,
+	},
+#endif
 #ifdef CONFIG_CLK_R9A09G011
 	{
 		.compatible = "renesas,r9a09g011-cpg",
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 4755befaf38e..6e38c8fc888c 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -284,6 +284,7 @@ struct rzg2l_cpg_info {
 extern const struct rzg2l_cpg_info r9a07g043_cpg_info;
 extern const struct rzg2l_cpg_info r9a07g044_cpg_info;
 extern const struct rzg2l_cpg_info r9a07g054_cpg_info;
+extern const struct rzg2l_cpg_info r9a08g045_cpg_info;
 extern const struct rzg2l_cpg_info r9a09g011_cpg_info;
 
 int rzg2l_cpg_sd_clk_mux_notifier(struct notifier_block *nb, unsigned long event, void *data);
-- 
2.39.2


