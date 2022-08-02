Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE31C19F2C
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 11:09:21 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.4832.1659438534534175527
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Aug 2022 04:09:17 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,210,1654527600";
   d="scan'208";a="130054350"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Aug 2022 20:09:15 +0900
Received: from localhost.localdomain (unknown [10.226.92.246])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id EF361400D4DE;
	Tue,  2 Aug 2022 20:09:13 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 10/24] clk: renesas: rzg2l-cpg: Add support for
 RZ/V2L SoC
Date: Tue,  2 Aug 2022 12:08:36 +0100
Message-Id: <20220802110850.1496057-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
References: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Aug 2022 11:09:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9007

commit a1bcf50a99dd1e40f0c6a963bd4f12547a89d4cd upstream.

The clock structure for RZ/V2L is almost identical to the RZ/G2L SoC.
The only difference being that RZ/V2L has additional registers to
control clocks and resets for the DRP-AI block.

Reuse r9a07g044-cpg.c, as the clock IDs and reset IDs are the same
between RZ/G2L and RZ/V2L, and add a separate r9a07g054_cpg_info to take
care of the DRP-AI clocks/resets.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220205084006.7142-1-biju.das.jz@bp.renesas.com
Link: https://lore.kernel.org/r/20220209203411.22332-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/Kconfig         |   7 +-
 drivers/clk/renesas/Makefile        |   1 +
 drivers/clk/renesas/r9a07g044-cpg.c | 426 +++++++++++++++-------------
 drivers/clk/renesas/rzg2l-cpg.c     |   6 +
 drivers/clk/renesas/rzg2l-cpg.h     |   1 +
 5 files changed, 250 insertions(+), 191 deletions(-)

diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 4d8de55bc6f4..162ea716b9a5 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -33,6 +33,7 @@ config CLK_RENESAS
 	select CLK_R8A779A0 if ARCH_R8A779A0
 	select CLK_R9A06G032 if ARCH_R9A06G032
 	select CLK_R9A07G044 if ARCH_R9A07G044
+	select CLK_R9A07G054 if ARCH_R9A07G054
 	select CLK_SH73A0 if ARCH_SH73A0
 
 if CLK_RENESAS
@@ -160,6 +161,10 @@ config CLK_R9A07G044
 	bool "RZ/G2L clock support" if COMPILE_TEST
 	select CLK_RZG2L
 
+config CLK_R9A07G054
+	bool "RZ/V2L clock support" if COMPILE_TEST
+	select CLK_RZG2L
+
 config CLK_SH73A0
 	bool "SH-Mobile AG5 clock support" if COMPILE_TEST
 	select CLK_RENESAS_CPG_MSTP
@@ -183,7 +188,7 @@ config CLK_RCAR_USB2_CLOCK_SEL
 	  This is a driver for R-Car USB2 clock selector
 
 config CLK_RZG2L
-	bool "Renesas RZ/G2L family clock support" if COMPILE_TEST
+	bool "Renesas RZ/{G2L,V2L} family clock support" if COMPILE_TEST
 	select RESET_CONTROLLER
 
 # Generic
diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefile
index cd104e75dab6..7cb90ed1e1db 100644
--- a/drivers/clk/renesas/Makefile
+++ b/drivers/clk/renesas/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_CLK_R8A77995)		+= r8a77995-cpg-mssr.o
 obj-$(CONFIG_CLK_R8A779A0)		+= r8a779a0-cpg-mssr.o
 obj-$(CONFIG_CLK_R9A06G032)		+= r9a06g032-clocks.o
 obj-$(CONFIG_CLK_R9A07G044)		+= r9a07g044-cpg.o
+obj-$(CONFIG_CLK_R9A07G054)		+= r9a07g044-cpg.o
 obj-$(CONFIG_CLK_SH73A0)		+= clk-sh73a0.o
 
 # Family
diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index 46359afef0d4..bdfabb992a20 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -11,12 +11,13 @@
 #include <linux/kernel.h>
 
 #include <dt-bindings/clock/r9a07g044-cpg.h>
+#include <dt-bindings/clock/r9a07g054-cpg.h>
 
 #include "rzg2l-cpg.h"
 
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
-	LAST_DT_CORE_CLK = R9A07G044_CLK_P0_DIV2,
+	LAST_DT_CORE_CLK = R9A07G054_CLK_DRP_A,
 
 	/* External Input Clocks */
 	CLK_EXTAL,
@@ -80,200 +81,222 @@ static const char * const sel_pll6_2[]	= { ".pll6_250", ".pll5_250" };
 static const char * const sel_shdi[] = { ".clk_533", ".clk_400", ".clk_266" };
 static const char * const sel_gpu2[] = { ".pll6", ".pll3_div2_2" };
 
-static const struct cpg_core_clk r9a07g044_core_clks[] __initconst = {
-	/* External Clock Inputs */
-	DEF_INPUT("extal", CLK_EXTAL),
+static const struct {
+	struct cpg_core_clk common[44];
+#ifdef CONFIG_CLK_R9A07G054
+	struct cpg_core_clk drp[0];
+#endif
+} core_clks __initconst = {
+	.common = {
+		/* External Clock Inputs */
+		DEF_INPUT("extal", CLK_EXTAL),
 
-	/* Internal Core Clocks */
-	DEF_FIXED(".osc", R9A07G044_OSCCLK, CLK_EXTAL, 1, 1),
-	DEF_FIXED(".osc_div1000", CLK_OSC_DIV1000, CLK_EXTAL, 1, 1000),
-	DEF_SAMPLL(".pll1", CLK_PLL1, CLK_EXTAL, PLL146_CONF(0)),
-	DEF_FIXED(".pll2", CLK_PLL2, CLK_EXTAL, 200, 3),
-	DEF_FIXED(".pll3", CLK_PLL3, CLK_EXTAL, 200, 3),
-	DEF_FIXED(".pll3_400", CLK_PLL3_400, CLK_PLL3, 1, 4),
-	DEF_FIXED(".pll3_533", CLK_PLL3_533, CLK_PLL3, 1, 3),
+		/* Internal Core Clocks */
+		DEF_FIXED(".osc", R9A07G044_OSCCLK, CLK_EXTAL, 1, 1),
+		DEF_FIXED(".osc_div1000", CLK_OSC_DIV1000, CLK_EXTAL, 1, 1000),
+		DEF_SAMPLL(".pll1", CLK_PLL1, CLK_EXTAL, PLL146_CONF(0)),
+		DEF_FIXED(".pll2", CLK_PLL2, CLK_EXTAL, 200, 3),
+		DEF_FIXED(".pll3", CLK_PLL3, CLK_EXTAL, 200, 3),
+		DEF_FIXED(".pll3_400", CLK_PLL3_400, CLK_PLL3, 1, 4),
+		DEF_FIXED(".pll3_533", CLK_PLL3_533, CLK_PLL3, 1, 3),
 
-	DEF_FIXED(".pll5", CLK_PLL5, CLK_EXTAL, 125, 1),
-	DEF_FIXED(".pll5_fout3", CLK_PLL5_FOUT3, CLK_PLL5, 1, 6),
+		DEF_FIXED(".pll5", CLK_PLL5, CLK_EXTAL, 125, 1),
+		DEF_FIXED(".pll5_fout3", CLK_PLL5_FOUT3, CLK_PLL5, 1, 6),
 
-	DEF_FIXED(".pll6", CLK_PLL6, CLK_EXTAL, 125, 6),
+		DEF_FIXED(".pll6", CLK_PLL6, CLK_EXTAL, 125, 6),
 
-	DEF_FIXED(".pll2_div2", CLK_PLL2_DIV2, CLK_PLL2, 1, 2),
-	DEF_FIXED(".clk_800", CLK_PLL2_800, CLK_PLL2, 1, 2),
-	DEF_FIXED(".clk_533", CLK_PLL2_SDHI_533, CLK_PLL2, 1, 3),
-	DEF_FIXED(".clk_400", CLK_PLL2_SDHI_400, CLK_PLL2_800, 1, 2),
-	DEF_FIXED(".clk_266", CLK_PLL2_SDHI_266, CLK_PLL2_SDHI_533, 1, 2),
+		DEF_FIXED(".pll2_div2", CLK_PLL2_DIV2, CLK_PLL2, 1, 2),
+		DEF_FIXED(".clk_800", CLK_PLL2_800, CLK_PLL2, 1, 2),
+		DEF_FIXED(".clk_533", CLK_PLL2_SDHI_533, CLK_PLL2, 1, 3),
+		DEF_FIXED(".clk_400", CLK_PLL2_SDHI_400, CLK_PLL2_800, 1, 2),
+		DEF_FIXED(".clk_266", CLK_PLL2_SDHI_266, CLK_PLL2_SDHI_533, 1, 2),
 
-	DEF_FIXED(".pll2_div2_8", CLK_PLL2_DIV2_8, CLK_PLL2_DIV2, 1, 8),
-	DEF_FIXED(".pll2_div2_10", CLK_PLL2_DIV2_10, CLK_PLL2_DIV2, 1, 10),
+		DEF_FIXED(".pll2_div2_8", CLK_PLL2_DIV2_8, CLK_PLL2_DIV2, 1, 8),
+		DEF_FIXED(".pll2_div2_10", CLK_PLL2_DIV2_10, CLK_PLL2_DIV2, 1, 10),
 
-	DEF_FIXED(".pll3_div2", CLK_PLL3_DIV2, CLK_PLL3, 1, 2),
-	DEF_FIXED(".pll3_div2_2", CLK_PLL3_DIV2_2, CLK_PLL3_DIV2, 1, 2),
-	DEF_FIXED(".pll3_div2_4", CLK_PLL3_DIV2_4, CLK_PLL3_DIV2, 1, 4),
-	DEF_FIXED(".pll3_div2_4_2", CLK_PLL3_DIV2_4_2, CLK_PLL3_DIV2_4, 1, 2),
-	DEF_MUX(".sel_pll3_3", CLK_SEL_PLL3_3, SEL_PLL3_3,
-		sel_pll3_3, ARRAY_SIZE(sel_pll3_3), 0, CLK_MUX_READ_ONLY),
-	DEF_DIV("divpl3c", CLK_DIV_PLL3_C, CLK_SEL_PLL3_3,
-		DIVPL3C, dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
+		DEF_FIXED(".pll3_div2", CLK_PLL3_DIV2, CLK_PLL3, 1, 2),
+		DEF_FIXED(".pll3_div2_2", CLK_PLL3_DIV2_2, CLK_PLL3_DIV2, 1, 2),
+		DEF_FIXED(".pll3_div2_4", CLK_PLL3_DIV2_4, CLK_PLL3_DIV2, 1, 4),
+		DEF_FIXED(".pll3_div2_4_2", CLK_PLL3_DIV2_4_2, CLK_PLL3_DIV2_4, 1, 2),
+		DEF_MUX(".sel_pll3_3", CLK_SEL_PLL3_3, SEL_PLL3_3,
+			sel_pll3_3, ARRAY_SIZE(sel_pll3_3), 0, CLK_MUX_READ_ONLY),
+		DEF_DIV("divpl3c", CLK_DIV_PLL3_C, CLK_SEL_PLL3_3,
+			DIVPL3C, dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
 
-	DEF_FIXED(".pll5_250", CLK_PLL5_250, CLK_PLL5_FOUT3, 1, 2),
-	DEF_FIXED(".pll6_250", CLK_PLL6_250, CLK_PLL6, 1, 2),
-	DEF_MUX(".sel_gpu2", CLK_SEL_GPU2, SEL_GPU2,
-		sel_gpu2, ARRAY_SIZE(sel_gpu2), 0, CLK_MUX_READ_ONLY),
+		DEF_FIXED(".pll5_250", CLK_PLL5_250, CLK_PLL5_FOUT3, 1, 2),
+		DEF_FIXED(".pll6_250", CLK_PLL6_250, CLK_PLL6, 1, 2),
+		DEF_MUX(".sel_gpu2", CLK_SEL_GPU2, SEL_GPU2,
+			sel_gpu2, ARRAY_SIZE(sel_gpu2), 0, CLK_MUX_READ_ONLY),
 
-	/* Core output clk */
-	DEF_DIV("I", R9A07G044_CLK_I, CLK_PLL1, DIVPL1A, dtable_1_8,
-		CLK_DIVIDER_HIWORD_MASK),
-	DEF_DIV("P0", R9A07G044_CLK_P0, CLK_PLL2_DIV2_8, DIVPL2A,
-		dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
-	DEF_FIXED("P0_DIV2", R9A07G044_CLK_P0_DIV2, R9A07G044_CLK_P0, 1, 2),
-	DEF_FIXED("TSU", R9A07G044_CLK_TSU, CLK_PLL2_DIV2_10, 1, 1),
-	DEF_DIV("P1", R9A07G044_CLK_P1, CLK_PLL3_DIV2_4,
-		DIVPL3B, dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
-	DEF_FIXED("P1_DIV2", CLK_P1_DIV2, R9A07G044_CLK_P1, 1, 2),
-	DEF_DIV("P2", R9A07G044_CLK_P2, CLK_PLL3_DIV2_4_2,
-		DIVPL3A, dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
-	DEF_FIXED("M0", R9A07G044_CLK_M0, CLK_PLL3_DIV2_4, 1, 1),
-	DEF_FIXED("ZT", R9A07G044_CLK_ZT, CLK_PLL3_DIV2_4_2, 1, 1),
-	DEF_MUX("HP", R9A07G044_CLK_HP, SEL_PLL6_2,
-		sel_pll6_2, ARRAY_SIZE(sel_pll6_2), 0, CLK_MUX_HIWORD_MASK),
-	DEF_FIXED("SPI0", R9A07G044_CLK_SPI0, CLK_DIV_PLL3_C, 1, 2),
-	DEF_FIXED("SPI1", R9A07G044_CLK_SPI1, CLK_DIV_PLL3_C, 1, 4),
-	DEF_SD_MUX("SD0", R9A07G044_CLK_SD0, SEL_SDHI0,
-		   sel_shdi, ARRAY_SIZE(sel_shdi)),
-	DEF_SD_MUX("SD1", R9A07G044_CLK_SD1, SEL_SDHI1,
-		   sel_shdi, ARRAY_SIZE(sel_shdi)),
-	DEF_FIXED("SD0_DIV4", CLK_SD0_DIV4, R9A07G044_CLK_SD0, 1, 4),
-	DEF_FIXED("SD1_DIV4", CLK_SD1_DIV4, R9A07G044_CLK_SD1, 1, 4),
-	DEF_DIV("G", R9A07G044_CLK_G, CLK_SEL_GPU2, DIVGPU, dtable_1_8,
-		CLK_DIVIDER_HIWORD_MASK),
+		/* Core output clk */
+		DEF_DIV("I", R9A07G044_CLK_I, CLK_PLL1, DIVPL1A, dtable_1_8,
+			CLK_DIVIDER_HIWORD_MASK),
+		DEF_DIV("P0", R9A07G044_CLK_P0, CLK_PLL2_DIV2_8, DIVPL2A,
+			dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
+		DEF_FIXED("P0_DIV2", R9A07G044_CLK_P0_DIV2, R9A07G044_CLK_P0, 1, 2),
+		DEF_FIXED("TSU", R9A07G044_CLK_TSU, CLK_PLL2_DIV2_10, 1, 1),
+		DEF_DIV("P1", R9A07G044_CLK_P1, CLK_PLL3_DIV2_4,
+			DIVPL3B, dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
+		DEF_FIXED("P1_DIV2", CLK_P1_DIV2, R9A07G044_CLK_P1, 1, 2),
+		DEF_DIV("P2", R9A07G044_CLK_P2, CLK_PLL3_DIV2_4_2,
+			DIVPL3A, dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
+		DEF_FIXED("M0", R9A07G044_CLK_M0, CLK_PLL3_DIV2_4, 1, 1),
+		DEF_FIXED("ZT", R9A07G044_CLK_ZT, CLK_PLL3_DIV2_4_2, 1, 1),
+		DEF_MUX("HP", R9A07G044_CLK_HP, SEL_PLL6_2,
+			sel_pll6_2, ARRAY_SIZE(sel_pll6_2), 0, CLK_MUX_HIWORD_MASK),
+		DEF_FIXED("SPI0", R9A07G044_CLK_SPI0, CLK_DIV_PLL3_C, 1, 2),
+		DEF_FIXED("SPI1", R9A07G044_CLK_SPI1, CLK_DIV_PLL3_C, 1, 4),
+		DEF_SD_MUX("SD0", R9A07G044_CLK_SD0, SEL_SDHI0,
+			   sel_shdi, ARRAY_SIZE(sel_shdi)),
+		DEF_SD_MUX("SD1", R9A07G044_CLK_SD1, SEL_SDHI1,
+			   sel_shdi, ARRAY_SIZE(sel_shdi)),
+		DEF_FIXED("SD0_DIV4", CLK_SD0_DIV4, R9A07G044_CLK_SD0, 1, 4),
+		DEF_FIXED("SD1_DIV4", CLK_SD1_DIV4, R9A07G044_CLK_SD1, 1, 4),
+		DEF_DIV("G", R9A07G044_CLK_G, CLK_SEL_GPU2, DIVGPU, dtable_1_8,
+			CLK_DIVIDER_HIWORD_MASK),
+	},
+#ifdef CONFIG_CLK_R9A07G054
+	.drp = {
+	},
+#endif
 };
 
-static struct rzg2l_mod_clk r9a07g044_mod_clks[] = {
-	DEF_MOD("gic",		R9A07G044_GIC600_GICCLK, R9A07G044_CLK_P1,
-				0x514, 0),
-	DEF_MOD("ia55_pclk",	R9A07G044_IA55_PCLK, R9A07G044_CLK_P2,
-				0x518, 0),
-	DEF_MOD("ia55_clk",	R9A07G044_IA55_CLK, R9A07G044_CLK_P1,
-				0x518, 1),
-	DEF_MOD("dmac_aclk",	R9A07G044_DMAC_ACLK, R9A07G044_CLK_P1,
-				0x52c, 0),
-	DEF_MOD("dmac_pclk",	R9A07G044_DMAC_PCLK, CLK_P1_DIV2,
-				0x52c, 1),
-	DEF_MOD("ostm0_pclk",	R9A07G044_OSTM0_PCLK, R9A07G044_CLK_P0,
-				0x534, 0),
-	DEF_MOD("ostm1_clk",	R9A07G044_OSTM1_PCLK, R9A07G044_CLK_P0,
-				0x534, 1),
-	DEF_MOD("ostm2_pclk",	R9A07G044_OSTM2_PCLK, R9A07G044_CLK_P0,
-				0x534, 2),
-	DEF_MOD("wdt0_pclk",	R9A07G044_WDT0_PCLK, R9A07G044_CLK_P0,
-				0x548, 0),
-	DEF_MOD("wdt0_clk",	R9A07G044_WDT0_CLK, R9A07G044_OSCCLK,
-				0x548, 1),
-	DEF_MOD("wdt1_pclk",	R9A07G044_WDT1_PCLK, R9A07G044_CLK_P0,
-				0x548, 2),
-	DEF_MOD("wdt1_clk",	R9A07G044_WDT1_CLK, R9A07G044_OSCCLK,
-				0x548, 3),
-	DEF_MOD("wdt2_pclk",	R9A07G044_WDT2_PCLK, R9A07G044_CLK_P0,
-				0x548, 4),
-	DEF_MOD("wdt2_clk",	R9A07G044_WDT2_CLK, R9A07G044_OSCCLK,
-				0x548, 5),
-	DEF_MOD("spi_clk2",	R9A07G044_SPI_CLK2, R9A07G044_CLK_SPI1,
-				0x550, 0),
-	DEF_MOD("spi_clk",	R9A07G044_SPI_CLK, R9A07G044_CLK_SPI0,
-				0x550, 1),
-	DEF_MOD("sdhi0_imclk",	R9A07G044_SDHI0_IMCLK, CLK_SD0_DIV4,
-				0x554, 0),
-	DEF_MOD("sdhi0_imclk2",	R9A07G044_SDHI0_IMCLK2, CLK_SD0_DIV4,
-				0x554, 1),
-	DEF_MOD("sdhi0_clk_hs",	R9A07G044_SDHI0_CLK_HS, R9A07G044_CLK_SD0,
-				0x554, 2),
-	DEF_MOD("sdhi0_aclk",	R9A07G044_SDHI0_ACLK, R9A07G044_CLK_P1,
-				0x554, 3),
-	DEF_MOD("sdhi1_imclk",	R9A07G044_SDHI1_IMCLK, CLK_SD1_DIV4,
-				0x554, 4),
-	DEF_MOD("sdhi1_imclk2",	R9A07G044_SDHI1_IMCLK2, CLK_SD1_DIV4,
-				0x554, 5),
-	DEF_MOD("sdhi1_clk_hs",	R9A07G044_SDHI1_CLK_HS, R9A07G044_CLK_SD1,
-				0x554, 6),
-	DEF_MOD("sdhi1_aclk",	R9A07G044_SDHI1_ACLK, R9A07G044_CLK_P1,
-				0x554, 7),
-	DEF_MOD("gpu_clk",	R9A07G044_GPU_CLK, R9A07G044_CLK_G,
-				0x558, 0),
-	DEF_MOD("gpu_axi_clk",	R9A07G044_GPU_AXI_CLK, R9A07G044_CLK_P1,
-				0x558, 1),
-	DEF_MOD("gpu_ace_clk",	R9A07G044_GPU_ACE_CLK, R9A07G044_CLK_P1,
-				0x558, 2),
-	DEF_MOD("ssi0_pclk",	R9A07G044_SSI0_PCLK2, R9A07G044_CLK_P0,
-				0x570, 0),
-	DEF_MOD("ssi0_sfr",	R9A07G044_SSI0_PCLK_SFR, R9A07G044_CLK_P0,
-				0x570, 1),
-	DEF_MOD("ssi1_pclk",	R9A07G044_SSI1_PCLK2, R9A07G044_CLK_P0,
-				0x570, 2),
-	DEF_MOD("ssi1_sfr",	R9A07G044_SSI1_PCLK_SFR, R9A07G044_CLK_P0,
-				0x570, 3),
-	DEF_MOD("ssi2_pclk",	R9A07G044_SSI2_PCLK2, R9A07G044_CLK_P0,
-				0x570, 4),
-	DEF_MOD("ssi2_sfr",	R9A07G044_SSI2_PCLK_SFR, R9A07G044_CLK_P0,
-				0x570, 5),
-	DEF_MOD("ssi3_pclk",	R9A07G044_SSI3_PCLK2, R9A07G044_CLK_P0,
-				0x570, 6),
-	DEF_MOD("ssi3_sfr",	R9A07G044_SSI3_PCLK_SFR, R9A07G044_CLK_P0,
-				0x570, 7),
-	DEF_MOD("usb0_host",	R9A07G044_USB_U2H0_HCLK, R9A07G044_CLK_P1,
-				0x578, 0),
-	DEF_MOD("usb1_host",	R9A07G044_USB_U2H1_HCLK, R9A07G044_CLK_P1,
-				0x578, 1),
-	DEF_MOD("usb0_func",	R9A07G044_USB_U2P_EXR_CPUCLK, R9A07G044_CLK_P1,
-				0x578, 2),
-	DEF_MOD("usb_pclk",	R9A07G044_USB_PCLK, R9A07G044_CLK_P1,
-				0x578, 3),
-	DEF_COUPLED("eth0_axi",	R9A07G044_ETH0_CLK_AXI, R9A07G044_CLK_M0,
-				0x57c, 0),
-	DEF_COUPLED("eth0_chi",	R9A07G044_ETH0_CLK_CHI, R9A07G044_CLK_ZT,
-				0x57c, 0),
-	DEF_COUPLED("eth1_axi",	R9A07G044_ETH1_CLK_AXI, R9A07G044_CLK_M0,
-				0x57c, 1),
-	DEF_COUPLED("eth1_chi",	R9A07G044_ETH1_CLK_CHI, R9A07G044_CLK_ZT,
-				0x57c, 1),
-	DEF_MOD("i2c0",		R9A07G044_I2C0_PCLK, R9A07G044_CLK_P0,
-				0x580, 0),
-	DEF_MOD("i2c1",		R9A07G044_I2C1_PCLK, R9A07G044_CLK_P0,
-				0x580, 1),
-	DEF_MOD("i2c2",		R9A07G044_I2C2_PCLK, R9A07G044_CLK_P0,
-				0x580, 2),
-	DEF_MOD("i2c3",		R9A07G044_I2C3_PCLK, R9A07G044_CLK_P0,
-				0x580, 3),
-	DEF_MOD("scif0",	R9A07G044_SCIF0_CLK_PCK, R9A07G044_CLK_P0,
-				0x584, 0),
-	DEF_MOD("scif1",	R9A07G044_SCIF1_CLK_PCK, R9A07G044_CLK_P0,
-				0x584, 1),
-	DEF_MOD("scif2",	R9A07G044_SCIF2_CLK_PCK, R9A07G044_CLK_P0,
-				0x584, 2),
-	DEF_MOD("scif3",	R9A07G044_SCIF3_CLK_PCK, R9A07G044_CLK_P0,
-				0x584, 3),
-	DEF_MOD("scif4",	R9A07G044_SCIF4_CLK_PCK, R9A07G044_CLK_P0,
-				0x584, 4),
-	DEF_MOD("sci0",		R9A07G044_SCI0_CLKP, R9A07G044_CLK_P0,
-				0x588, 0),
-	DEF_MOD("sci1",		R9A07G044_SCI1_CLKP, R9A07G044_CLK_P0,
-				0x588, 1),
-	DEF_MOD("rspi0",	R9A07G044_RSPI0_CLKB, R9A07G044_CLK_P0,
-				0x590, 0),
-	DEF_MOD("rspi1",	R9A07G044_RSPI1_CLKB, R9A07G044_CLK_P0,
-				0x590, 1),
-	DEF_MOD("rspi2",	R9A07G044_RSPI2_CLKB, R9A07G044_CLK_P0,
-				0x590, 2),
-	DEF_MOD("canfd",	R9A07G044_CANFD_PCLK, R9A07G044_CLK_P0,
-				0x594, 0),
-	DEF_MOD("gpio",		R9A07G044_GPIO_HCLK, R9A07G044_OSCCLK,
-				0x598, 0),
-	DEF_MOD("adc_adclk",	R9A07G044_ADC_ADCLK, R9A07G044_CLK_TSU,
-				0x5a8, 0),
-	DEF_MOD("adc_pclk",	R9A07G044_ADC_PCLK, R9A07G044_CLK_P0,
-				0x5a8, 1),
-	DEF_MOD("tsu_pclk",	R9A07G044_TSU_PCLK, R9A07G044_CLK_TSU,
-				0x5ac, 0),
+static const struct {
+	struct rzg2l_mod_clk common[62];
+#ifdef CONFIG_CLK_R9A07G054
+	struct rzg2l_mod_clk drp[0];
+#endif
+} mod_clks = {
+	.common = {
+		DEF_MOD("gic",		R9A07G044_GIC600_GICCLK, R9A07G044_CLK_P1,
+					0x514, 0),
+		DEF_MOD("ia55_pclk",	R9A07G044_IA55_PCLK, R9A07G044_CLK_P2,
+					0x518, 0),
+		DEF_MOD("ia55_clk",	R9A07G044_IA55_CLK, R9A07G044_CLK_P1,
+					0x518, 1),
+		DEF_MOD("dmac_aclk",	R9A07G044_DMAC_ACLK, R9A07G044_CLK_P1,
+					0x52c, 0),
+		DEF_MOD("dmac_pclk",	R9A07G044_DMAC_PCLK, CLK_P1_DIV2,
+					0x52c, 1),
+		DEF_MOD("ostm0_pclk",	R9A07G044_OSTM0_PCLK, R9A07G044_CLK_P0,
+					0x534, 0),
+		DEF_MOD("ostm1_clk",	R9A07G044_OSTM1_PCLK, R9A07G044_CLK_P0,
+					0x534, 1),
+		DEF_MOD("ostm2_pclk",	R9A07G044_OSTM2_PCLK, R9A07G044_CLK_P0,
+					0x534, 2),
+		DEF_MOD("wdt0_pclk",	R9A07G044_WDT0_PCLK, R9A07G044_CLK_P0,
+					0x548, 0),
+		DEF_MOD("wdt0_clk",	R9A07G044_WDT0_CLK, R9A07G044_OSCCLK,
+					0x548, 1),
+		DEF_MOD("wdt1_pclk",	R9A07G044_WDT1_PCLK, R9A07G044_CLK_P0,
+					0x548, 2),
+		DEF_MOD("wdt1_clk",	R9A07G044_WDT1_CLK, R9A07G044_OSCCLK,
+					0x548, 3),
+		DEF_MOD("wdt2_pclk",	R9A07G044_WDT2_PCLK, R9A07G044_CLK_P0,
+					0x548, 4),
+		DEF_MOD("wdt2_clk",	R9A07G044_WDT2_CLK, R9A07G044_OSCCLK,
+					0x548, 5),
+		DEF_MOD("spi_clk2",	R9A07G044_SPI_CLK2, R9A07G044_CLK_SPI1,
+					0x550, 0),
+		DEF_MOD("spi_clk",	R9A07G044_SPI_CLK, R9A07G044_CLK_SPI0,
+					0x550, 1),
+		DEF_MOD("sdhi0_imclk",	R9A07G044_SDHI0_IMCLK, CLK_SD0_DIV4,
+					0x554, 0),
+		DEF_MOD("sdhi0_imclk2",	R9A07G044_SDHI0_IMCLK2, CLK_SD0_DIV4,
+					0x554, 1),
+		DEF_MOD("sdhi0_clk_hs",	R9A07G044_SDHI0_CLK_HS, R9A07G044_CLK_SD0,
+					0x554, 2),
+		DEF_MOD("sdhi0_aclk",	R9A07G044_SDHI0_ACLK, R9A07G044_CLK_P1,
+					0x554, 3),
+		DEF_MOD("sdhi1_imclk",	R9A07G044_SDHI1_IMCLK, CLK_SD1_DIV4,
+					0x554, 4),
+		DEF_MOD("sdhi1_imclk2",	R9A07G044_SDHI1_IMCLK2, CLK_SD1_DIV4,
+					0x554, 5),
+		DEF_MOD("sdhi1_clk_hs",	R9A07G044_SDHI1_CLK_HS, R9A07G044_CLK_SD1,
+					0x554, 6),
+		DEF_MOD("sdhi1_aclk",	R9A07G044_SDHI1_ACLK, R9A07G044_CLK_P1,
+					0x554, 7),
+		DEF_MOD("gpu_clk",	R9A07G044_GPU_CLK, R9A07G044_CLK_G,
+					0x558, 0),
+		DEF_MOD("gpu_axi_clk",	R9A07G044_GPU_AXI_CLK, R9A07G044_CLK_P1,
+					0x558, 1),
+		DEF_MOD("gpu_ace_clk",	R9A07G044_GPU_ACE_CLK, R9A07G044_CLK_P1,
+					0x558, 2),
+		DEF_MOD("ssi0_pclk",	R9A07G044_SSI0_PCLK2, R9A07G044_CLK_P0,
+					0x570, 0),
+		DEF_MOD("ssi0_sfr",	R9A07G044_SSI0_PCLK_SFR, R9A07G044_CLK_P0,
+					0x570, 1),
+		DEF_MOD("ssi1_pclk",	R9A07G044_SSI1_PCLK2, R9A07G044_CLK_P0,
+					0x570, 2),
+		DEF_MOD("ssi1_sfr",	R9A07G044_SSI1_PCLK_SFR, R9A07G044_CLK_P0,
+					0x570, 3),
+		DEF_MOD("ssi2_pclk",	R9A07G044_SSI2_PCLK2, R9A07G044_CLK_P0,
+					0x570, 4),
+		DEF_MOD("ssi2_sfr",	R9A07G044_SSI2_PCLK_SFR, R9A07G044_CLK_P0,
+					0x570, 5),
+		DEF_MOD("ssi3_pclk",	R9A07G044_SSI3_PCLK2, R9A07G044_CLK_P0,
+					0x570, 6),
+		DEF_MOD("ssi3_sfr",	R9A07G044_SSI3_PCLK_SFR, R9A07G044_CLK_P0,
+					0x570, 7),
+		DEF_MOD("usb0_host",	R9A07G044_USB_U2H0_HCLK, R9A07G044_CLK_P1,
+					0x578, 0),
+		DEF_MOD("usb1_host",	R9A07G044_USB_U2H1_HCLK, R9A07G044_CLK_P1,
+					0x578, 1),
+		DEF_MOD("usb0_func",	R9A07G044_USB_U2P_EXR_CPUCLK, R9A07G044_CLK_P1,
+					0x578, 2),
+		DEF_MOD("usb_pclk",	R9A07G044_USB_PCLK, R9A07G044_CLK_P1,
+					0x578, 3),
+		DEF_COUPLED("eth0_axi",	R9A07G044_ETH0_CLK_AXI, R9A07G044_CLK_M0,
+					0x57c, 0),
+		DEF_COUPLED("eth0_chi",	R9A07G044_ETH0_CLK_CHI, R9A07G044_CLK_ZT,
+					0x57c, 0),
+		DEF_COUPLED("eth1_axi",	R9A07G044_ETH1_CLK_AXI, R9A07G044_CLK_M0,
+					0x57c, 1),
+		DEF_COUPLED("eth1_chi",	R9A07G044_ETH1_CLK_CHI, R9A07G044_CLK_ZT,
+					0x57c, 1),
+		DEF_MOD("i2c0",		R9A07G044_I2C0_PCLK, R9A07G044_CLK_P0,
+					0x580, 0),
+		DEF_MOD("i2c1",		R9A07G044_I2C1_PCLK, R9A07G044_CLK_P0,
+					0x580, 1),
+		DEF_MOD("i2c2",		R9A07G044_I2C2_PCLK, R9A07G044_CLK_P0,
+					0x580, 2),
+		DEF_MOD("i2c3",		R9A07G044_I2C3_PCLK, R9A07G044_CLK_P0,
+					0x580, 3),
+		DEF_MOD("scif0",	R9A07G044_SCIF0_CLK_PCK, R9A07G044_CLK_P0,
+					0x584, 0),
+		DEF_MOD("scif1",	R9A07G044_SCIF1_CLK_PCK, R9A07G044_CLK_P0,
+					0x584, 1),
+		DEF_MOD("scif2",	R9A07G044_SCIF2_CLK_PCK, R9A07G044_CLK_P0,
+					0x584, 2),
+		DEF_MOD("scif3",	R9A07G044_SCIF3_CLK_PCK, R9A07G044_CLK_P0,
+					0x584, 3),
+		DEF_MOD("scif4",	R9A07G044_SCIF4_CLK_PCK, R9A07G044_CLK_P0,
+					0x584, 4),
+		DEF_MOD("sci0",		R9A07G044_SCI0_CLKP, R9A07G044_CLK_P0,
+					0x588, 0),
+		DEF_MOD("sci1",		R9A07G044_SCI1_CLKP, R9A07G044_CLK_P0,
+					0x588, 1),
+		DEF_MOD("rspi0",	R9A07G044_RSPI0_CLKB, R9A07G044_CLK_P0,
+					0x590, 0),
+		DEF_MOD("rspi1",	R9A07G044_RSPI1_CLKB, R9A07G044_CLK_P0,
+					0x590, 1),
+		DEF_MOD("rspi2",	R9A07G044_RSPI2_CLKB, R9A07G044_CLK_P0,
+					0x590, 2),
+		DEF_MOD("canfd",	R9A07G044_CANFD_PCLK, R9A07G044_CLK_P0,
+					0x594, 0),
+		DEF_MOD("gpio",		R9A07G044_GPIO_HCLK, R9A07G044_OSCCLK,
+					0x598, 0),
+		DEF_MOD("adc_adclk",	R9A07G044_ADC_ADCLK, R9A07G044_CLK_TSU,
+					0x5a8, 0),
+		DEF_MOD("adc_pclk",	R9A07G044_ADC_PCLK, R9A07G044_CLK_P0,
+					0x5a8, 1),
+		DEF_MOD("tsu_pclk",	R9A07G044_TSU_PCLK, R9A07G044_CLK_TSU,
+					0x5ac, 0),
+	},
+#ifdef CONFIG_CLK_R9A07G054
+	.drp = {
+	},
+#endif
 };
 
 static struct rzg2l_reset r9a07g044_resets[] = {
@@ -336,8 +359,8 @@ static const unsigned int r9a07g044_crit_mod_clks[] __initconst = {
 
 const struct rzg2l_cpg_info r9a07g044_cpg_info = {
 	/* Core Clocks */
-	.core_clks = r9a07g044_core_clks,
-	.num_core_clks = ARRAY_SIZE(r9a07g044_core_clks),
+	.core_clks = core_clks.common,
+	.num_core_clks = ARRAY_SIZE(core_clks.common),
 	.last_dt_core_clk = LAST_DT_CORE_CLK,
 	.num_total_core_clks = MOD_CLK_BASE,
 
@@ -346,11 +369,34 @@ const struct rzg2l_cpg_info r9a07g044_cpg_info = {
 	.num_crit_mod_clks = ARRAY_SIZE(r9a07g044_crit_mod_clks),
 
 	/* Module Clocks */
-	.mod_clks = r9a07g044_mod_clks,
-	.num_mod_clks = ARRAY_SIZE(r9a07g044_mod_clks),
+	.mod_clks = mod_clks.common,
+	.num_mod_clks = ARRAY_SIZE(mod_clks.common),
 	.num_hw_mod_clks = R9A07G044_TSU_PCLK + 1,
 
 	/* Resets */
 	.resets = r9a07g044_resets,
-	.num_resets = ARRAY_SIZE(r9a07g044_resets),
+	.num_resets = R9A07G044_TSU_PRESETN + 1, /* Last reset ID + 1 */
+};
+
+#ifdef CONFIG_CLK_R9A07G054
+const struct rzg2l_cpg_info r9a07g054_cpg_info = {
+	/* Core Clocks */
+	.core_clks = core_clks.common,
+	.num_core_clks = ARRAY_SIZE(core_clks.common) + ARRAY_SIZE(core_clks.drp),
+	.last_dt_core_clk = LAST_DT_CORE_CLK,
+	.num_total_core_clks = MOD_CLK_BASE,
+
+	/* Critical Module Clocks */
+	.crit_mod_clks = r9a07g044_crit_mod_clks,
+	.num_crit_mod_clks = ARRAY_SIZE(r9a07g044_crit_mod_clks),
+
+	/* Module Clocks */
+	.mod_clks = mod_clks.common,
+	.num_mod_clks = ARRAY_SIZE(mod_clks.common) + ARRAY_SIZE(mod_clks.drp),
+	.num_hw_mod_clks = R9A07G054_STPAI_ACLK_DRP + 1,
+
+	/* Resets */
+	.resets = r9a07g044_resets,
+	.num_resets = R9A07G054_STPAI_ARESETN + 1, /* Last reset ID + 1 */
 };
+#endif
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index edd0abe34a37..486d0656c58a 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -952,6 +952,12 @@ static const struct of_device_id rzg2l_cpg_match[] = {
 		.compatible = "renesas,r9a07g044-cpg",
 		.data = &r9a07g044_cpg_info,
 	},
+#endif
+#ifdef CONFIG_CLK_R9A07G054
+	{
+		.compatible = "renesas,r9a07g054-cpg",
+		.data = &r9a07g054_cpg_info,
+	},
 #endif
 	{ /* sentinel */ }
 };
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 5729d102034b..ce657beaf160 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -203,5 +203,6 @@ struct rzg2l_cpg_info {
 };
 
 extern const struct rzg2l_cpg_info r9a07g044_cpg_info;
+extern const struct rzg2l_cpg_info r9a07g054_cpg_info;
 
 #endif
-- 
2.25.1


