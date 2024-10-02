Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06057CF6D5C
	for <webhook@archiver.kernel.org>; Wed,  2 Oct 2024 17:07:33 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.1130.1727888840918302443
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Oct 2024 10:07:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,172,1725289200"; 
   d="scan'208";a="224579759"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Oct 2024 02:07:24 +0900
Received: from localhost.localdomain (unknown [10.226.92.106])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2208A4009412;
	Thu,  3 Oct 2024 02:07:22 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 04/15] clk: renesas: r9a07g043: Add clock and reset entries for CRU
Date: Wed,  2 Oct 2024 18:06:53 +0100
Message-ID: <20241002170712.655449-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241002170712.655449-1-biju.das.jz@bp.renesas.com>
References: <20241002170712.655449-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Oct 2024 17:07:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16967

commit 78ed252953e5bdd0b3b0dd689502d5213cb6348b upstream.

Add CRU clock and reset entries to CPG driver.

CRU_SYSCLK and CRU_VCLK clocks need to be turned ON/OFF in particular
sequence for the CRU block hence add these clocks to
r9a07g043_no_pm_mod_clks[] array and pass it as part of CPG data for
RZ/G2UL SoCs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240123114415.290918-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 31 +++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index 075ade0925d4..078364ac739e 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -48,6 +48,7 @@ enum clk_ids {
 	CLK_SEL_PLL3_3,
 	CLK_DIV_PLL3_C,
 #ifdef CONFIG_ARM64
+	CLK_M2_DIV2,
 	CLK_PLL5,
 	CLK_PLL5_500,
 	CLK_PLL5_250,
@@ -142,6 +143,10 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 		   mtable_sdhi, 0, rzg2l_cpg_sd_clk_mux_notifier),
 	DEF_FIXED("SD0_DIV4", CLK_SD0_DIV4, R9A07G043_CLK_SD0, 1, 4),
 	DEF_FIXED("SD1_DIV4", CLK_SD1_DIV4, R9A07G043_CLK_SD1, 1, 4),
+#ifdef CONFIG_ARM64
+	DEF_FIXED("M2", R9A07G043_CLK_M2, CLK_PLL3_533, 1, 2),
+	DEF_FIXED("M2_DIV2", CLK_M2_DIV2, R9A07G043_CLK_M2, 1, 2),
+#endif
 };
 
 static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
@@ -195,6 +200,16 @@ static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 				0x554, 6),
 	DEF_MOD("sdhi1_aclk",	R9A07G043_SDHI1_ACLK, R9A07G043_CLK_P1,
 				0x554, 7),
+#ifdef CONFIG_ARM64
+	DEF_MOD("cru_sysclk",   R9A07G043_CRU_SYSCLK, CLK_M2_DIV2,
+				0x564, 0),
+	DEF_MOD("cru_vclk",     R9A07G043_CRU_VCLK, R9A07G043_CLK_M2,
+				0x564, 1),
+	DEF_MOD("cru_pclk",     R9A07G043_CRU_PCLK, R9A07G043_CLK_ZT,
+				0x564, 2),
+	DEF_MOD("cru_aclk",     R9A07G043_CRU_ACLK, R9A07G043_CLK_M0,
+				0x564, 3),
+#endif
 	DEF_MOD("ssi0_pclk",	R9A07G043_SSI0_PCLK2, R9A07G043_CLK_P0,
 				0x570, 0),
 	DEF_MOD("ssi0_sfr",	R9A07G043_SSI0_PCLK_SFR, R9A07G043_CLK_P0,
@@ -286,6 +301,11 @@ static struct rzg2l_reset r9a07g043_resets[] = {
 	DEF_RST(R9A07G043_SPI_RST, 0x850, 0),
 	DEF_RST(R9A07G043_SDHI0_IXRST, 0x854, 0),
 	DEF_RST(R9A07G043_SDHI1_IXRST, 0x854, 1),
+#ifdef CONFIG_ARM64
+	DEF_RST(R9A07G043_CRU_CMN_RSTB, 0x864, 0),
+	DEF_RST(R9A07G043_CRU_PRESETN, 0x864, 1),
+	DEF_RST(R9A07G043_CRU_ARESETN, 0x864, 2),
+#endif
 	DEF_RST(R9A07G043_SSI0_RST_M2_REG, 0x870, 0),
 	DEF_RST(R9A07G043_SSI1_RST_M2_REG, 0x870, 1),
 	DEF_RST(R9A07G043_SSI2_RST_M2_REG, 0x870, 2),
@@ -331,6 +351,13 @@ static const unsigned int r9a07g043_crit_mod_clks[] __initconst = {
 	MOD_CLK_BASE + R9A07G043_DMAC_ACLK,
 };
 
+#ifdef CONFIG_ARM64
+static const unsigned int r9a07g043_no_pm_mod_clks[] = {
+	MOD_CLK_BASE + R9A07G043_CRU_SYSCLK,
+	MOD_CLK_BASE + R9A07G043_CRU_VCLK,
+};
+#endif
+
 const struct rzg2l_cpg_info r9a07g043_cpg_info = {
 	/* Core Clocks */
 	.core_clks = r9a07g043_core_clks,
@@ -347,6 +374,10 @@ const struct rzg2l_cpg_info r9a07g043_cpg_info = {
 	.num_mod_clks = ARRAY_SIZE(r9a07g043_mod_clks),
 #ifdef CONFIG_ARM64
 	.num_hw_mod_clks = R9A07G043_TSU_PCLK + 1,
+
+	/* No PM Module Clocks */
+	.no_pm_mod_clks = r9a07g043_no_pm_mod_clks,
+	.num_no_pm_mod_clks = ARRAY_SIZE(r9a07g043_no_pm_mod_clks),
 #endif
 #ifdef CONFIG_RISCV
 	.num_hw_mod_clks = R9A07G043_IAX45_PCLK + 1,
-- 
2.43.0


