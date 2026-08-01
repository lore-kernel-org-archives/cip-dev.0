Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C44C55174
	for <webhook@archiver.kernel.org>; Sat,  1 Aug 2026 09:15:12 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2453.1785575703472242711
 for <cip-dev@lists.cip-project.org>;
 Sat, 01 Aug 2026 02:15:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=SBzskFVK;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so7969215e9.1
        for <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 02:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785575702; x=1786180502; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YRwcAXOth9Ti9xehvuLC1aR3289GBlH3QEVblLd4eGw=;
        b=SBzskFVKFM4Sb0toJy2d95KioaSvf02ED7+jb+k/E8ZsoByTU2gnqGFxSRTsJLFIXE
         2x5lBYqcr+9yOAx4n+yvWORTiEQDnw14hnA0clw75kbiYt1kgnQu4PH+EAioxLLEsUM4
         LRDJ2tcyDkMGpZBxgHZZ87+XpJKfmnufaPQdtwq4YvdAA2VeTwynbFCOrGu0d0d7zgTl
         D4fVL8CsQpMTRjCpMHyTMcK9/R+aedLf8z5NHPjKfEl3iPKWgdeSvQ1wnM7+deCSsA0o
         BRb5Nc/K1TYHH/2LlZSsK8uNQjwogh6MDIW5ImuFOHozWPDcdzJ2Vb4STSezgZARry6j
         8nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575702; x=1786180502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YRwcAXOth9Ti9xehvuLC1aR3289GBlH3QEVblLd4eGw=;
        b=f3dF2QMWtJ6pga3fS9FWQLFcZOiM2o6r1X4XoaY+KVALdvz4kkXyxDB7kSr7ClNnt6
         s5QWUdEMPDv3HnreIFtC9kHDvPu2fJkvzGDvYwWm+E6yWPz8CnFLubKyke7hN0+nzrFG
         M2+OLIYfkAFcOdoaphGanbYPnqn1umSnJjT/UifpCHYS/KX/q1QeWcbYOX5r5GVfNq3y
         ctVBGlpHjUb0eAcBSTCgp6U6bGJpCvbvMydpMwwuruYeuJn0ng/x2YrOYZQU4FhPx67o
         eO+TJ2ulUKL/OdKJoHD9dq10P20bF717qIESh2MiA4w9WqHZ02Qmojs8DOzLhYLNibQO
         qmCg==
X-Gm-Message-State: AOJu0YxrH37saCFDcIZjXlSiPEoPR+RsNE1lwSuxBd5wUycwOwf5Sm35
	zf595iBs6GYyVnqPeYCTMhS7VhFH1M7PiP3D2R7/I6eyorVWBiwtv+YfbgGqXQ==
X-Gm-Gg: AR+sD11DjlzGdiuiGwEb3WEqjaUzmLAYN+5yfPGrC6cex/+xQxudFeAkAWWhUBMhYP6
	GrNuwYyOh9A3XQus/ccYuV5xsxxDH+TmtKgMDREVxsKA4rvSBQzr+EFSx3sDs+2TvKfwJAccCCf
	1ynDNHiO0Oj41hB4XRHY6ZmbTtW8ersr5RMXYUWAFPN3Tdn6kD5ya2YJQP3gam+4u0573xFESlp
	lgrxcHXu0cgsxseU4wYs5LSEtHnjyrQl2znSTFF7XQPTODSzqLelCPB22oeAgNedKNYwXN4WARY
	7nBmMeRRHWYFaXsMfIWzqceebiHRAasqfWOUUQrHOjGVS4n94UfpLTNdOcZ4f8iYizXmJWiUclI
	TIMWyjTQZxWm97fSlxfbP9uqM4iW8OOAocy1qghqAXDKP6heMr/se+3xDM2S432xbVRp/uqsxFa
	aXm6qg0siuWZ5MTWXWQ4b07Wayor3JlX6YKKKpQ+CQkwG5ZdBtW/e9J1GG9YH7K7M2ZhdfqvCnb
	V7bogVTqrKpww==
X-Received: by 2002:a05:600c:4708:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-4980eb4e95dmr22295815e9.0.1785575701607;
        Sat, 01 Aug 2026 02:15:01 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c3e4:203e:a11f:3195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5f007sm36171565e9.6.2026.08.01.02.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:15:01 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 02/19] clk: renesas: r9a08g046: Add RSCI clocks and resets
Date: Sat,  1 Aug 2026 10:14:33 +0100
Message-ID: <20260801091458.14026-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
References: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 09:15:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23829

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 9bec6a9dc213aa0134d672f70d6afa363f4b3c88 ]

Add clock and reset entries for the Serial Communications Interfaces
(RSCI) found on the RZ/G3L SoC.  This includes various dividers and mux
clocks needed for the four RSCI channels.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260505071544.8965-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g046-cpg.c | 71 +++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g046-cpg.c b/drivers/clk/renesas/r9a08g046-cpg.c
index 0004b9516fdf..0cb681358642 100644
--- a/drivers/clk/renesas/r9a08g046-cpg.c
+++ b/drivers/clk/renesas/r9a08g046-cpg.c
@@ -18,8 +18,10 @@
 #define G3L_CPG_PL2_DDIV		(0x204)
 #define G3L_CPG_PL3_DDIV		(0x208)
 #define G3L_CPG_CA55CORE_DDIV		(0x234)
+#define G3L_CPG_RSCI_DDIV		(0x238)
 #define G3L_CLKDIVSTATUS		(0x280)
 #define G3L_CPG_ETH_SSEL		(0x410)
+#define G3L_CPG_RSCI_SSEL		(0x414)
 #define G3L_CPG_ETH_SDIV		(0x434)
 
 /* RZ/G3L Specific division configuration.  */
@@ -30,6 +32,10 @@
 #define G3L_DIV_CA55_CORE1	DDIV_PACK(G3L_CPG_CA55CORE_DDIV, 4, 3)
 #define G3L_DIV_CA55_CORE2	DDIV_PACK(G3L_CPG_CA55CORE_DDIV, 8, 3)
 #define G3L_DIV_CA55_CORE3	DDIV_PACK(G3L_CPG_CA55CORE_DDIV, 12, 3)
+#define G3L_DIV_RSCI0		DDIV_PACK(G3L_CPG_RSCI_DDIV, 0, 2)
+#define G3L_DIV_RSCI1		DDIV_PACK(G3L_CPG_RSCI_DDIV, 2, 2)
+#define G3L_DIV_RSCI2		DDIV_PACK(G3L_CPG_RSCI_DDIV, 4, 2)
+#define G3L_DIV_RSCI3		DDIV_PACK(G3L_CPG_RSCI_DDIV, 6, 2)
 #define G3L_SDIV_ETH_A		DDIV_PACK(G3L_CPG_ETH_SDIV, 0, 2)
 #define G3L_SDIV_ETH_B		DDIV_PACK(G3L_CPG_ETH_SDIV, 4, 1)
 #define G3L_SDIV_ETH_C		DDIV_PACK(G3L_CPG_ETH_SDIV, 8, 2)
@@ -43,6 +49,10 @@
 #define G3L_DIV_CA55_CORE1_STS	DDIV_PACK(G3L_CLKDIVSTATUS, 13, 1)
 #define G3L_DIV_CA55_CORE2_STS	DDIV_PACK(G3L_CLKDIVSTATUS, 14, 1)
 #define G3L_DIV_CA55_CORE3_STS	DDIV_PACK(G3L_CLKDIVSTATUS, 15, 1)
+#define G3L_DIV_RSCI0_STS	DDIV_PACK(G3L_CLKDIVSTATUS, 16, 1)
+#define G3L_DIV_RSCI1_STS	DDIV_PACK(G3L_CLKDIVSTATUS, 17, 1)
+#define G3L_DIV_RSCI2_STS	DDIV_PACK(G3L_CLKDIVSTATUS, 18, 1)
+#define G3L_DIV_RSCI3_STS	DDIV_PACK(G3L_CLKDIVSTATUS, 19, 1)
 
 /* RZ/G3L Specific clocks select. */
 #define G3L_SEL_ETH0_TX		SEL_PLL_PACK(G3L_CPG_ETH_SSEL, 0, 1)
@@ -55,6 +65,10 @@
 #define G3L_SEL_ETH1_RM		SEL_PLL_PACK(G3L_CPG_ETH_SSEL, 10, 1)
 #define G3L_SEL_ETH1_CLK_TX_I	SEL_PLL_PACK(G3L_CPG_ETH_SSEL, 11, 1)
 #define G3L_SEL_ETH1_CLK_RX_I	SEL_PLL_PACK(G3L_CPG_ETH_SSEL, 12, 1)
+#define G3L_SEL_RSCI0		SEL_PLL_PACK(G3L_CPG_RSCI_SSEL, 0, 2)
+#define G3L_SEL_RSCI1		SEL_PLL_PACK(G3L_CPG_RSCI_SSEL, 2, 2)
+#define G3L_SEL_RSCI2		SEL_PLL_PACK(G3L_CPG_RSCI_SSEL, 4, 2)
+#define G3L_SEL_RSCI3		SEL_PLL_PACK(G3L_CPG_RSCI_SSEL, 6, 2)
 
 /* PLL 1/4/6/7 configuration registers macro. */
 #define G3L_PLL1467_CONF(clk1, clk2, setting)	((clk1) << 22 | (clk2) << 12 | (setting))
@@ -74,6 +88,10 @@ enum clk_ids {
 	CLK_PLL1,
 	CLK_PLL2,
 	CLK_PLL2_DIV2,
+	CLK_PLL2_DIV2_4,
+	CLK_PLL2_DIV5,
+	CLK_PLL2_DIV6,
+	CLK_PLL2_DIV7,
 	CLK_PLL3,
 	CLK_PLL3_DIV2,
 	CLK_PLL6,
@@ -84,6 +102,10 @@ enum clk_ids {
 	CLK_SEL_ETH1_TX,
 	CLK_SEL_ETH1_RX,
 	CLK_SEL_ETH1_RM,
+	CLK_SEL_RSCI0,
+	CLK_SEL_RSCI1,
+	CLK_SEL_RSCI2,
+	CLK_SEL_RSCI3,
 	CLK_ETH0_TR,
 	CLK_ETH0_RM,
 	CLK_ETH1_TR,
@@ -110,6 +132,14 @@ static const struct clk_div_table dtable_2_20[] = {
 	{ 0, 0 },
 };
 
+static const struct clk_div_table dtable_2_16[] = {
+	{ 0, 2 },
+	{ 1, 4 },
+	{ 2, 8 },
+	{ 3, 16 },
+	{ 0, 0 },
+};
+
 static const struct clk_div_table dtable_4_128[] = {
 	{ 0, 4 },
 	{ 1, 8 },
@@ -140,6 +170,7 @@ static const char * const sel_eth0_rm[] = { ".pll6_div10", "eth0_rxc_rx_clk" };
 static const char * const sel_eth1_tx[] = { ".div_eth1_tr", "eth1_txc_tx_clk" };
 static const char * const sel_eth1_rx[] = { ".div_eth1_tr", "eth1_rxc_rx_clk" };
 static const char * const sel_eth1_rm[] = { ".pll6_div10", "eth1_rxc_rx_clk" };
+static const char * const sel_rsci_rspi[] = { ".pll2_div5", ".pll2_div6", ".pll2_div7", ".pll2_div2_4" };
 static const char * const sel_eth0_clk_tx_i[] = { ".sel_eth0_tx", ".div_eth0_rm" };
 static const char * const sel_eth0_clk_rx_i[] = { ".sel_eth0_rx", ".div_eth0_rm" };
 static const char * const sel_eth1_clk_tx_i[] = { ".sel_eth1_tx", ".div_eth1_rm" };
@@ -161,8 +192,16 @@ static const struct cpg_core_clk r9a08g046_core_clks[] __initconst = {
 	DEF_G3L_PLL(".pll6", CLK_PLL6, CLK_EXTAL, G3L_PLL1467_CONF(0x54, 0x58, 0),
 		    500000000UL),
 	DEF_FIXED(".pll2_div2", CLK_PLL2_DIV2, CLK_PLL2, 1, 2),
+	DEF_FIXED(".pll2_div2_4", CLK_PLL2_DIV2_4, CLK_PLL2_DIV2, 1, 4),
+	DEF_FIXED(".pll2_div5", CLK_PLL2_DIV5, CLK_PLL2, 1, 5),
+	DEF_FIXED(".pll2_div6", CLK_PLL2_DIV6, CLK_PLL2, 1, 6),
+	DEF_FIXED(".pll2_div7", CLK_PLL2_DIV7, CLK_PLL2, 1, 7),
 	DEF_FIXED(".pll3_div2", CLK_PLL3_DIV2, CLK_PLL3, 1, 2),
 	DEF_FIXED(".pll6_div10", CLK_PLL6_DIV10, CLK_PLL6, 1, 10),
+	DEF_MUX(".sel_rsci0", CLK_SEL_RSCI0, G3L_SEL_RSCI0, sel_rsci_rspi),
+	DEF_MUX(".sel_rsci1", CLK_SEL_RSCI1, G3L_SEL_RSCI1, sel_rsci_rspi),
+	DEF_MUX(".sel_rsci2", CLK_SEL_RSCI2, G3L_SEL_RSCI2, sel_rsci_rspi),
+	DEF_MUX(".sel_rsci3", CLK_SEL_RSCI3, G3L_SEL_RSCI3, sel_rsci_rspi),
 	DEF_MUX(".sel_eth0_tx", CLK_SEL_ETH0_TX, G3L_SEL_ETH0_TX, sel_eth0_tx),
 	DEF_MUX(".sel_eth0_rx", CLK_SEL_ETH0_RX, G3L_SEL_ETH0_RX, sel_eth0_rx),
 	DEF_MUX(".sel_eth0_rm", CLK_SEL_ETH0_RM, G3L_SEL_ETH0_RM, sel_eth0_rm),
@@ -189,6 +228,14 @@ static const struct cpg_core_clk r9a08g046_core_clks[] __initconst = {
 		    dtable_4_128, 0, 0, 0, NULL),
 	DEF_G3S_DIV("P3", R9A08G046_CLK_P3, CLK_PLL2_DIV2, G3L_DIVPL2A, G3L_DIVPL2A_STS,
 		    dtable_4_128, 0, 0, 0, NULL),
+	DEF_G3S_DIV("P13", R9A08G046_CLK_P13, CLK_SEL_RSCI0, G3L_DIV_RSCI0, G3L_DIV_RSCI0_STS,
+		    dtable_2_16, 0, 100000000UL, 0, NULL),
+	DEF_G3S_DIV("P14", R9A08G046_CLK_P14, CLK_SEL_RSCI1, G3L_DIV_RSCI1, G3L_DIV_RSCI1_STS,
+		    dtable_2_16, 0, 100000000UL, 0, NULL),
+	DEF_G3S_DIV("P15", R9A08G046_CLK_P15, CLK_SEL_RSCI2, G3L_DIV_RSCI2, G3L_DIV_RSCI2_STS,
+		    dtable_2_16, 0, 100000000UL, 0, NULL),
+	DEF_G3S_DIV("P16", R9A08G046_CLK_P16, CLK_SEL_RSCI3, G3L_DIV_RSCI3, G3L_DIV_RSCI3_STS,
+		    dtable_2_16, 0, 100000000UL, 0, NULL),
 	DEF_FIXED("HP", R9A08G046_CLK_HP, CLK_PLL6_DIV10, 1, 1),
 	DEF_MUX_FLAGS("ETHTX01", R9A08G046_CLK_ETHTX01, G3L_SEL_ETH0_CLK_TX_I, sel_eth0_clk_tx_i,
 		      CLK_SET_RATE_PARENT),
@@ -284,6 +331,22 @@ static const struct rzg2l_mod_clk r9a08g046_mod_clks[] = {
 					MSTOP(BUS_MCPU3, BIT(4))),
 	DEF_MOD("gpio_hclk",		R9A08G046_GPIO_HCLK, R9A08G046_OSCCLK, 0x598, 0,
 					MSTOP(BUS_PERI_CPU, BIT(6))),
+	DEF_MOD("rsci0_pclk",		R9A08G046_RSCI0_PCLK, R9A08G046_CLK_P0, 0x618, 0,
+					MSTOP(BUS_MCPU2, BIT(7))),
+	DEF_MOD("rsci1_pclk",		R9A08G046_RSCI1_PCLK, R9A08G046_CLK_P0, 0x618, 1,
+					MSTOP(BUS_MCPU2, BIT(8))),
+	DEF_MOD("rsci2_pclk",		R9A08G046_RSCI2_PCLK, R9A08G046_CLK_P0, 0x618, 2,
+					MSTOP(BUS_MCPU3, BIT(11))),
+	DEF_MOD("rsci3_pclk",		R9A08G046_RSCI3_PCLK, R9A08G046_CLK_P0, 0x618, 3,
+					MSTOP(BUS_MCPU3, BIT(12))),
+	DEF_MOD("rsci0_tclk",		R9A08G046_RSCI0_TCLK, R9A08G046_CLK_P13, 0x618, 8,
+					MSTOP(BUS_MCPU2, BIT(7))),
+	DEF_MOD("rsci1_tclk",		R9A08G046_RSCI1_TCLK, R9A08G046_CLK_P14, 0x618, 9,
+					MSTOP(BUS_MCPU2, BIT(8))),
+	DEF_MOD("rsci2_tclk",		R9A08G046_RSCI2_TCLK, R9A08G046_CLK_P15, 0x618, 10,
+					MSTOP(BUS_MCPU3, BIT(11))),
+	DEF_MOD("rsci3_tclk",		R9A08G046_RSCI3_TCLK, R9A08G046_CLK_P16, 0x618, 11,
+					MSTOP(BUS_MCPU3, BIT(12))),
 };
 
 static const struct rzg2l_reset r9a08g046_resets[] = {
@@ -308,6 +371,14 @@ static const struct rzg2l_reset r9a08g046_resets[] = {
 	DEF_RST(R9A08G046_GPIO_RSTN, 0x898, 0),
 	DEF_RST(R9A08G046_GPIO_PORT_RESETN, 0x898, 1),
 	DEF_RST(R9A08G046_GPIO_SPARE_RESETN, 0x898, 2),
+	DEF_RST(R9A08G046_RSCI0_PRESETN, 0x918, 0),
+	DEF_RST(R9A08G046_RSCI1_PRESETN, 0x918, 1),
+	DEF_RST(R9A08G046_RSCI2_PRESETN, 0x918, 2),
+	DEF_RST(R9A08G046_RSCI3_PRESETN, 0x918, 3),
+	DEF_RST(R9A08G046_RSCI0_TRESETN, 0x918, 8),
+	DEF_RST(R9A08G046_RSCI1_TRESETN, 0x918, 9),
+	DEF_RST(R9A08G046_RSCI2_TRESETN, 0x918, 10),
+	DEF_RST(R9A08G046_RSCI3_TRESETN, 0x918, 11),
 };
 
 static const unsigned int r9a08g046_crit_mod_clks[] __initconst = {
-- 
2.43.0


