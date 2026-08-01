Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C92C5518B
	for <webhook@archiver.kernel.org>; Sat,  1 Aug 2026 09:15:13 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2474.1785575704821786496
 for <cip-dev@lists.cip-project.org>;
 Sat, 01 Aug 2026 02:15:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=cYSyba9d;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-495635a85d2so4998145e9.0
        for <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 02:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785575703; x=1786180503; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0d/DuDHrftjxYyE2VQ+4yTObHMLZ8qS7Mr25QO+xOds=;
        b=cYSyba9d8xwkDfy37y/n4/V3R3wk6bWy6IQ2FxFpkrQGN/iZb8m5Iv4on0ePjBl/rD
         6ESthOxxp6/M4bK2vwRpg7ZVMaOxnzlAgBADCv7CToUE3iQf2L/SSCLM6MlHT1+rCmoW
         8yQFSAgKvaGLuETnNyrH4s/W44JXTOyZtiFKWb/SQYRj3It8Dj8X7wznDcTLNQXGj5iJ
         1ni7cVaej52YYlLMRCaIHSrqLJzNpIqrRVl9o35fi/ze8i33CUbsEN9F/3CwfcLdS63N
         S2//2L320+5oA1TETeUVcrN7BLR4KuQVGxw5rGY7jdINWPffNewM4sKXvR328UVU79NL
         2ZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575703; x=1786180503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0d/DuDHrftjxYyE2VQ+4yTObHMLZ8qS7Mr25QO+xOds=;
        b=Sns9AAn5uuhf/FywX2HBFYMmIVOqonAhh9o5WgSMMygsrjJzcKy1QuGI6kYNctpjxb
         pJh2YdNE7aCqEYi8zEotjtZKZ3L7q3fRYBOCtSMNx3bkHMvM20bg5SumzCiIuiI6GFY4
         it3iR3sndMPvkHvkqr1iZeKCNeaDN8IJLaqZ07XLJt/ukSccWbcyk88X9Fxjrg1y2O04
         G3NzmOslPr+6jckqqRNy5fTtHf3j/LX9FNcjxVI4o5O1wtkItDiZknSdzVvgoHp3uPbK
         R+bisG6z8fZRR79RSBsDCPdrpK4zDHhJuB9JAC7To65YvTnWaGLAyUgZ1Wc0bqUB3wdO
         +wZQ==
X-Gm-Message-State: AOJu0YxITRGfRpr1/P00cefJBBrtC8R0FQfgHjtA/WIoLBURftcLjMLh
	zDyiG8IWizhTdli5NhxPreRhy1GkgWfXK8eMXXDKzejB8aqE+OF9kx2oQ+cSCg==
X-Gm-Gg: AR+sD13z1AXJwjO7g8XFjxulvN9lRN/xvP4mGQ4T7l7tt8/krRdAxPgX3fUTRPkds/G
	7nTbKIGs1SzL1IZxjgnLjqgcBddSEL2GuPXstQkEYM4BHLDVuYJbrpkxw3G5qYYfB2+ml6Wx3zx
	cuKupXZylg797zqibhxNhXS+ASX92k9nMPpq2tWCM/P5AMQGrnZwPrk/L40jFDYG6NZ8Dd4/AEB
	cWEED2Cc1GvNfy6iBtqk01uN5dAUmVotIkL55ggx6OttWFp/UoqAvb6hD1L7oEc0PZUB4KtP7ra
	jgCTanDpVaoBnd9jFmiNuBpxGUN+msYJBfUzR6acnKGl5vQLIkyJAulV9fkOR8CR8ovp0m0ec3r
	fpG/PbYF9f2A7F5iNxeHK9y2xahlRsh+ODbL6ixVs5Yt05ZC18xBjSruKwJbb88x9hp+pXaLJP/
	EX0L0HaFf4rgwddLsmhqt4B9oEWdxBq0tY7Befftwzcerh/LVg3CyJAzUz5HF2k66fc28Jhm9Hh
	C8LBgGxGTtq6jgxXSOcTEIc
X-Received: by 2002:a05:600c:b99:b0:493:f78f:cd70 with SMTP id 5b1f17b1804b1-4980c67d770mr30378405e9.18.1785575702767;
        Sat, 01 Aug 2026 02:15:02 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c3e4:203e:a11f:3195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5f007sm36171565e9.6.2026.08.01.02.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:15:02 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 04/19] clk: renesas: r9a08g046: Add RSPI clocks and resets
Date: Sat,  1 Aug 2026 10:14:35 +0100
Message-ID: <20260801091458.14026-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
References: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 09:15:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23831

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 5fcbbc1fcc4fa78bb5a184caa2c32db423676577 ]

Add clock and reset definitions for the three RSPI (Serial Peripheral
Interface) channels on the RZ/G3L (R9A08G046) SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260505071544.8965-4-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g046-cpg.c | 49 +++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g046-cpg.c b/drivers/clk/renesas/r9a08g046-cpg.c
index fe3cb9a4f0ec..fc9db5a2f0ac 100644
--- a/drivers/clk/renesas/r9a08g046-cpg.c
+++ b/drivers/clk/renesas/r9a08g046-cpg.c
@@ -19,9 +19,11 @@
 #define G3L_CPG_PL3_DDIV		(0x208)
 #define G3L_CPG_CA55CORE_DDIV		(0x234)
 #define G3L_CPG_RSCI_DDIV		(0x238)
+#define G3L_CPG_RSPI_DDIV		(0x23c)
 #define G3L_CLKDIVSTATUS		(0x280)
 #define G3L_CPG_ETH_SSEL		(0x410)
 #define G3L_CPG_RSCI_SSEL		(0x414)
+#define G3L_CPG_RSPI_SSEL		(0x418)
 #define G3L_CPG_ETH_SDIV		(0x434)
 
 /* RZ/G3L Specific division configuration.  */
@@ -36,6 +38,9 @@
 #define G3L_DIV_RSCI1		DDIV_PACK(G3L_CPG_RSCI_DDIV, 2, 2)
 #define G3L_DIV_RSCI2		DDIV_PACK(G3L_CPG_RSCI_DDIV, 4, 2)
 #define G3L_DIV_RSCI3		DDIV_PACK(G3L_CPG_RSCI_DDIV, 6, 2)
+#define G3L_DIV_RSPI0		DDIV_PACK(G3L_CPG_RSPI_DDIV, 0, 2)
+#define G3L_DIV_RSPI1		DDIV_PACK(G3L_CPG_RSPI_DDIV, 2, 2)
+#define G3L_DIV_RSPI2		DDIV_PACK(G3L_CPG_RSPI_DDIV, 4, 2)
 #define G3L_SDIV_ETH_A		DDIV_PACK(G3L_CPG_ETH_SDIV, 0, 2)
 #define G3L_SDIV_ETH_B		DDIV_PACK(G3L_CPG_ETH_SDIV, 4, 1)
 #define G3L_SDIV_ETH_C		DDIV_PACK(G3L_CPG_ETH_SDIV, 8, 2)
@@ -53,6 +58,9 @@
 #define G3L_DIV_RSCI1_STS	DDIV_PACK(G3L_CLKDIVSTATUS, 17, 1)
 #define G3L_DIV_RSCI2_STS	DDIV_PACK(G3L_CLKDIVSTATUS, 18, 1)
 #define G3L_DIV_RSCI3_STS	DDIV_PACK(G3L_CLKDIVSTATUS, 19, 1)
+#define G3L_DIV_RSPI0_STS	DDIV_PACK(G3L_CLKDIVSTATUS, 20, 1)
+#define G3L_DIV_RSPI1_STS	DDIV_PACK(G3L_CLKDIVSTATUS, 21, 1)
+#define G3L_DIV_RSPI2_STS	DDIV_PACK(G3L_CLKDIVSTATUS, 22, 1)
 
 /* RZ/G3L Specific clocks select. */
 #define G3L_SEL_ETH0_TX		SEL_PLL_PACK(G3L_CPG_ETH_SSEL, 0, 1)
@@ -69,6 +77,9 @@
 #define G3L_SEL_RSCI1		SEL_PLL_PACK(G3L_CPG_RSCI_SSEL, 2, 2)
 #define G3L_SEL_RSCI2		SEL_PLL_PACK(G3L_CPG_RSCI_SSEL, 4, 2)
 #define G3L_SEL_RSCI3		SEL_PLL_PACK(G3L_CPG_RSCI_SSEL, 6, 2)
+#define G3L_SEL_RSPI0		SEL_PLL_PACK(G3L_CPG_RSPI_SSEL, 0, 2)
+#define G3L_SEL_RSPI1		SEL_PLL_PACK(G3L_CPG_RSPI_SSEL, 2, 2)
+#define G3L_SEL_RSPI2		SEL_PLL_PACK(G3L_CPG_RSPI_SSEL, 4, 2)
 
 /* PLL 1/4/6/7 configuration registers macro. */
 #define G3L_PLL1467_CONF(clk1, clk2, setting)	((clk1) << 22 | (clk2) << 12 | (setting))
@@ -106,6 +117,9 @@ enum clk_ids {
 	CLK_SEL_RSCI1,
 	CLK_SEL_RSCI2,
 	CLK_SEL_RSCI3,
+	CLK_SEL_RSPI0,
+	CLK_SEL_RSPI1,
+	CLK_SEL_RSPI2,
 	CLK_ETH0_TR,
 	CLK_ETH0_RM,
 	CLK_ETH1_TR,
@@ -116,6 +130,14 @@ enum clk_ids {
 };
 
 /* Divider tables */
+static const struct clk_div_table dtable_1_8[] = {
+	{ 0, 1 },
+	{ 1, 2 },
+	{ 2, 4 },
+	{ 3, 8 },
+	{ 0, 0 },
+};
+
 static const struct clk_div_table dtable_1_32[] = {
 	{ 0, 1 },
 	{ 1, 2 },
@@ -202,6 +224,9 @@ static const struct cpg_core_clk r9a08g046_core_clks[] __initconst = {
 	DEF_MUX(".sel_rsci1", CLK_SEL_RSCI1, G3L_SEL_RSCI1, sel_rsci_rspi),
 	DEF_MUX(".sel_rsci2", CLK_SEL_RSCI2, G3L_SEL_RSCI2, sel_rsci_rspi),
 	DEF_MUX(".sel_rsci3", CLK_SEL_RSCI3, G3L_SEL_RSCI3, sel_rsci_rspi),
+	DEF_MUX(".sel_rspi0", CLK_SEL_RSPI0, G3L_SEL_RSPI0, sel_rsci_rspi),
+	DEF_MUX(".sel_rspi1", CLK_SEL_RSPI1, G3L_SEL_RSPI1, sel_rsci_rspi),
+	DEF_MUX(".sel_rspi2", CLK_SEL_RSPI2, G3L_SEL_RSPI2, sel_rsci_rspi),
 	DEF_MUX(".sel_eth0_tx", CLK_SEL_ETH0_TX, G3L_SEL_ETH0_TX, sel_eth0_tx),
 	DEF_MUX(".sel_eth0_rx", CLK_SEL_ETH0_RX, G3L_SEL_ETH0_RX, sel_eth0_rx),
 	DEF_MUX(".sel_eth0_rm", CLK_SEL_ETH0_RM, G3L_SEL_ETH0_RM, sel_eth0_rm),
@@ -236,6 +261,12 @@ static const struct cpg_core_clk r9a08g046_core_clks[] __initconst = {
 		    dtable_2_16, 0, 100000000UL, 0, NULL),
 	DEF_G3S_DIV("P16", R9A08G046_CLK_P16, CLK_SEL_RSCI3, G3L_DIV_RSCI3, G3L_DIV_RSCI3_STS,
 		    dtable_2_16, 0, 100000000UL, 0, NULL),
+	DEF_G3S_DIV("P17", R9A08G046_CLK_P17, CLK_SEL_RSPI0, G3L_DIV_RSPI0, G3L_DIV_RSPI0_STS,
+		    dtable_1_8, 0, 200000000UL, 0, NULL),
+	DEF_G3S_DIV("P18", R9A08G046_CLK_P18, CLK_SEL_RSPI1, G3L_DIV_RSPI1, G3L_DIV_RSPI1_STS,
+		    dtable_1_8, 0, 200000000UL, 0, NULL),
+	DEF_G3S_DIV("P19", R9A08G046_CLK_P19, CLK_SEL_RSPI2, G3L_DIV_RSPI2, G3L_DIV_RSPI2_STS,
+		    dtable_1_8, 0, 200000000UL, 0, NULL),
 	DEF_FIXED("HP", R9A08G046_CLK_HP, CLK_PLL6_DIV10, 1, 1),
 	DEF_MUX_FLAGS("ETHTX01", R9A08G046_CLK_ETHTX01, G3L_SEL_ETH0_CLK_TX_I, sel_eth0_clk_tx_i,
 		      CLK_SET_RATE_PARENT),
@@ -345,6 +376,18 @@ static const struct rzg2l_mod_clk r9a08g046_mod_clks[] = {
 					MSTOP(BUS_MCPU2, BIT(5))),
 	DEF_MOD("scif5_clk_pck",	R9A08G046_SCIF5_CLK_PCK, R9A08G046_CLK_P0, 0x584, 5,
 					MSTOP(BUS_MCPU3, BIT(4))),
+	DEF_MOD("rspi0_pclk",		R9A08G046_RSPI0_PCLK, R9A08G046_CLK_P3, 0x590, 0,
+					MSTOP(BUS_MCPU1, BIT(14))),
+	DEF_MOD("rspi1_pclk",		R9A08G046_RSPI1_PCLK, R9A08G046_CLK_P3, 0x590, 1,
+					MSTOP(BUS_MCPU1, BIT(15))),
+	DEF_MOD("rspi2_pclk",		R9A08G046_RSPI2_PCLK, R9A08G046_CLK_P3, 0x590, 2,
+					MSTOP(BUS_MCPU2, BIT(0))),
+	DEF_MOD("rspi0_tclk",		R9A08G046_RSPI0_TCLK, R9A08G046_CLK_P17, 0x590, 8,
+					MSTOP(BUS_MCPU1, BIT(14))),
+	DEF_MOD("rspi1_tclk",		R9A08G046_RSPI1_TCLK, R9A08G046_CLK_P18, 0x590, 9,
+					MSTOP(BUS_MCPU1, BIT(15))),
+	DEF_MOD("rspi2_tclk",		R9A08G046_RSPI2_TCLK, R9A08G046_CLK_P19, 0x590, 10,
+					MSTOP(BUS_MCPU2, BIT(0))),
 	DEF_MOD("gpio_hclk",		R9A08G046_GPIO_HCLK, R9A08G046_OSCCLK, 0x598, 0,
 					MSTOP(BUS_PERI_CPU, BIT(6))),
 	DEF_MOD("rsci0_pclk",		R9A08G046_RSCI0_PCLK, R9A08G046_CLK_P0, 0x618, 0,
@@ -388,6 +431,12 @@ static const struct rzg2l_reset r9a08g046_resets[] = {
 	DEF_RST(R9A08G046_SCIF3_RST_SYSTEM_N, 0x884, 3),
 	DEF_RST(R9A08G046_SCIF4_RST_SYSTEM_N, 0x884, 4),
 	DEF_RST(R9A08G046_SCIF5_RST_SYSTEM_N, 0x884, 5),
+	DEF_RST(R9A08G046_RSPI0_PRESETN, 0x890, 0),
+	DEF_RST(R9A08G046_RSPI1_PRESETN, 0x890, 1),
+	DEF_RST(R9A08G046_RSPI2_PRESETN, 0x890, 2),
+	DEF_RST(R9A08G046_RSPI0_TRESETN, 0x890, 8),
+	DEF_RST(R9A08G046_RSPI1_TRESETN, 0x890, 9),
+	DEF_RST(R9A08G046_RSPI2_TRESETN, 0x890, 10),
 	DEF_RST(R9A08G046_GPIO_RSTN, 0x898, 0),
 	DEF_RST(R9A08G046_GPIO_PORT_RESETN, 0x898, 1),
 	DEF_RST(R9A08G046_GPIO_SPARE_RESETN, 0x898, 2),
-- 
2.43.0


