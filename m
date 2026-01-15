Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3148D33A31
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:35:31 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31290.1768466127469887077
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:35:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=eU1Uv5Xv;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64d1ef53cf3so931487a12.0
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466126; x=1769070926; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+pnE9iYe+zUNdCKyaar7khBZ28BMZm4zs8dQrsZUXE=;
        b=eU1Uv5XvnZ72qQhA2FrB80OngKCZuy6ZMSp5NFLmaKZVRuRapn8L8wMkilfE6+NxvP
         W14wVubRhNnK+ftTN6uTBVBxgLL/9r/Ia/WirHDdZvXum/XZASR039VuzBtS97yixfxF
         85YS0ZQ6Fk9m3HIzAs+ihmvwFMVP5vTH0DMYeD+3+WsaokGlPb8wYNava/Pza10tQoY5
         Ylb5fGRyp/nuIGIDMjQRYpJLYmpRVZHp6JiQY+ptqLP9Rt78zhbGoftnlgGLh6/hLsO8
         EEBvg8UsQsgHlRr2ozuCs2+f15z3FVtWd8DL5weM2GbnzQ1Wm9C/hwH2sXvf+34jXkim
         VbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466126; x=1769070926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w+pnE9iYe+zUNdCKyaar7khBZ28BMZm4zs8dQrsZUXE=;
        b=guD0aQgZnYMN0R3f+I/TvPCXmyIdXjZKgzP7mPAfT6x3TaPQTgg9OasfqqLsHyBdFi
         AMkup/PCz3UawZua3oKdSRzoO/ddtkpKz8HG8UNzKM+GNgsPnH7/LlCucCai+/lIkcfV
         Q8IxDu21+R6zaoayQlqELFiZkxIYPol2Y8HAd+r3sF8obnrKY3vhO7yaMbUGeI2UVRXt
         pJWJ3mui8+0EQFuNEk6BPouADscIO3Afd1qcPPMHKYK2WGHNlFnNVTASPTibkHnZQtoM
         jGxdWZuTgjRcxQtI0AtRDeIyol4JooVsa3lvAoo0C37jLlU9z4neNLZKnb4pFAEisXz1
         jq3g==
X-Gm-Message-State: AOJu0YwLtwRYLqywz4FUVEuUOJz+vbnAj68FW2JkIA+mkhCANTmtCloH
	b6mK7Elft5e/038G/2CbqD9g0gqH3V/DXPOgUBcJ4MDYaDs953kJfQhkKcCVIwJfls8=
X-Gm-Gg: AY/fxX7eJ/EBtz34VnFdkC9/YP7EZSgLzIDK9Es3yLRKvkYm9eUIkwQuhedVK3bdu7X
	ow/50qdcZgjEocLMm/faAkyecoBjxJdnNB8wlLiAkYdfwAEzXhQXUaRCA+Jn9/48qFwxyIJh+Lb
	PUhs82Ifg8+jgi8yzVEywt+ccSccvc1Jw5p+YsUFxnXB9dP/TeQd8zqM7QSrKFJflCsIGD72GWw
	+tWka6At0oZAa6dTmpNmJm6cjv6cbPAgjk7Df4MEcimMGeUq1O0KUlEccKjxvhEl2QQp/RmcqNL
	l/gnFAwz6R4ONNNjvrL/ot1uLOXa6flqKBlTzXia8OAYFV2drtWVWrXprv6DvgE3i53JDA8mkyS
	wwI1jaRZNlHOfdorAgXJWCSJ1pDHewQ8T3iygQj8GJ5ZF5HFaPeBOwr1Oo6DFBLQkQWTSLdLKon
	bcoPr6cp0JjHlz6GoW1qenU6LC62v4oyYZeBqPTdTPv5GLiKWPMFU6BXqiE42BErWSLmNt214tK
	J+C
X-Received: by 2002:a05:6402:3513:b0:64c:fee2:1dc5 with SMTP id 4fb4d7f45d1cf-653ee1a8050mr4091442a12.19.1768466125722;
        Thu, 15 Jan 2026 00:35:25 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411f70f66sm1915660a12.19.2026.01.15.00.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:35:24 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v3 18/19] clk: renesas: r9a07g044: Add MSTOP for RZ/G2L
Date: Thu, 15 Jan 2026 10:34:50 +0200
Message-ID: <20260115083451.1064048-19-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:35:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21598

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 56de5e305d4ba25eed5740b338f7ecb8cf342aa6 upstream.

Add MSTOP configuration for all the module clocks on the RZ/G2L
based SoCs (RZ/G2L, RZ/G2LC, RZ/V2L).

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250806092129.621194-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g044-cpg.c | 154 ++++++++++++++--------------
 drivers/clk/renesas/rzg2l-cpg.h     |   1 +
 2 files changed, 78 insertions(+), 77 deletions(-)

diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index a3ece556f9a7..5028b4ffdf5f 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -242,163 +242,163 @@ static const struct {
 } mod_clks = {
 	.common = {
 		DEF_MOD("gic",		R9A07G044_GIC600_GICCLK, R9A07G044_CLK_P1,
-					0x514, 0, 0),
+					0x514, 0, MSTOP(BUS_REG1, BIT(7))),
 		DEF_MOD("ia55_pclk",	R9A07G044_IA55_PCLK, R9A07G044_CLK_P2,
-					0x518, 0, 0),
+					0x518, 0, MSTOP(BUS_PERI_CPU, BIT(13))),
 		DEF_MOD("ia55_clk",	R9A07G044_IA55_CLK, R9A07G044_CLK_P1,
-					0x518, 1, 0),
+					0x518, 1, MSTOP(BUS_PERI_CPU, BIT(13))),
 		DEF_MOD("dmac_aclk",	R9A07G044_DMAC_ACLK, R9A07G044_CLK_P1,
-					0x52c, 0, 0),
+					0x52c, 0, MSTOP(BUS_REG1, BIT(2))),
 		DEF_MOD("dmac_pclk",	R9A07G044_DMAC_PCLK, CLK_P1_DIV2,
-					0x52c, 1, 0),
+					0x52c, 1, MSTOP(BUS_REG1, BIT(3))),
 		DEF_MOD("ostm0_pclk",	R9A07G044_OSTM0_PCLK, R9A07G044_CLK_P0,
-					0x534, 0, 0),
+					0x534, 0, MSTOP(BUS_REG0, BIT(4))),
 		DEF_MOD("ostm1_pclk",	R9A07G044_OSTM1_PCLK, R9A07G044_CLK_P0,
-					0x534, 1, 0),
+					0x534, 1, MSTOP(BUS_REG0, BIT(5))),
 		DEF_MOD("ostm2_pclk",	R9A07G044_OSTM2_PCLK, R9A07G044_CLK_P0,
-					0x534, 2, 0),
+					0x534, 2, MSTOP(BUS_REG0, BIT(6))),
 		DEF_MOD("mtu_x_mck",	R9A07G044_MTU_X_MCK_MTU3, R9A07G044_CLK_P0,
-					0x538, 0, 0),
+					0x538, 0, MSTOP(BUS_MCPU1, BIT(2))),
 		DEF_MOD("gpt_pclk",	R9A07G044_GPT_PCLK, R9A07G044_CLK_P0,
-					0x540, 0, 0),
+					0x540, 0, MSTOP(BUS_MCPU1, BIT(4))),
 		DEF_MOD("poeg_a_clkp",	R9A07G044_POEG_A_CLKP, R9A07G044_CLK_P0,
-					0x544, 0, 0),
+					0x544, 0, MSTOP(BUS_MCPU1, BIT(5))),
 		DEF_MOD("poeg_b_clkp",	R9A07G044_POEG_B_CLKP, R9A07G044_CLK_P0,
-					0x544, 1, 0),
+					0x544, 1, MSTOP(BUS_MCPU1, BIT(6))),
 		DEF_MOD("poeg_c_clkp",	R9A07G044_POEG_C_CLKP, R9A07G044_CLK_P0,
-					0x544, 2, 0),
+					0x544, 2, MSTOP(BUS_MCPU1, BIT(7))),
 		DEF_MOD("poeg_d_clkp",	R9A07G044_POEG_D_CLKP, R9A07G044_CLK_P0,
-					0x544, 3, 0),
+					0x544, 3, MSTOP(BUS_MCPU1, BIT(8))),
 		DEF_MOD("wdt0_pclk",	R9A07G044_WDT0_PCLK, R9A07G044_CLK_P0,
-					0x548, 0, 0),
+					0x548, 0, MSTOP(BUS_REG0, BIT(2))),
 		DEF_MOD("wdt0_clk",	R9A07G044_WDT0_CLK, R9A07G044_OSCCLK,
-					0x548, 1, 0),
+					0x548, 1, MSTOP(BUS_REG0, BIT(2))),
 		DEF_MOD("wdt1_pclk",	R9A07G044_WDT1_PCLK, R9A07G044_CLK_P0,
-					0x548, 2, 0),
+					0x548, 2, MSTOP(BUS_REG0, BIT(3))),
 		DEF_MOD("wdt1_clk",	R9A07G044_WDT1_CLK, R9A07G044_OSCCLK,
-					0x548, 3, 0),
+					0x548, 3, MSTOP(BUS_REG0, BIT(3))),
 		DEF_MOD("spi_clk2",	R9A07G044_SPI_CLK2, R9A07G044_CLK_SPI1,
-					0x550, 0, 0),
+					0x550, 0, MSTOP(BUS_MCPU1, BIT(1))),
 		DEF_MOD("spi_clk",	R9A07G044_SPI_CLK, R9A07G044_CLK_SPI0,
-					0x550, 1, 0),
+					0x550, 1, MSTOP(BUS_MCPU1, BIT(1))),
 		DEF_MOD("sdhi0_imclk",	R9A07G044_SDHI0_IMCLK, CLK_SD0_DIV4,
-					0x554, 0, 0),
+					0x554, 0, MSTOP(BUS_PERI_COM, BIT(0))),
 		DEF_MOD("sdhi0_imclk2",	R9A07G044_SDHI0_IMCLK2, CLK_SD0_DIV4,
-					0x554, 1, 0),
+					0x554, 1, MSTOP(BUS_PERI_COM, BIT(0))),
 		DEF_MOD("sdhi0_clk_hs",	R9A07G044_SDHI0_CLK_HS, R9A07G044_CLK_SD0,
-					0x554, 2, 0),
+					0x554, 2, MSTOP(BUS_PERI_COM, BIT(0))),
 		DEF_MOD("sdhi0_aclk",	R9A07G044_SDHI0_ACLK, R9A07G044_CLK_P1,
-					0x554, 3, 0),
+					0x554, 3, MSTOP(BUS_PERI_COM, BIT(0))),
 		DEF_MOD("sdhi1_imclk",	R9A07G044_SDHI1_IMCLK, CLK_SD1_DIV4,
-					0x554, 4, 0),
+					0x554, 4, MSTOP(BUS_PERI_COM, BIT(1))),
 		DEF_MOD("sdhi1_imclk2",	R9A07G044_SDHI1_IMCLK2, CLK_SD1_DIV4,
-					0x554, 5, 0),
+					0x554, 5, MSTOP(BUS_PERI_COM, BIT(1))),
 		DEF_MOD("sdhi1_clk_hs",	R9A07G044_SDHI1_CLK_HS, R9A07G044_CLK_SD1,
-					0x554, 6, 0),
+					0x554, 6, MSTOP(BUS_PERI_COM, BIT(1))),
 		DEF_MOD("sdhi1_aclk",	R9A07G044_SDHI1_ACLK, R9A07G044_CLK_P1,
-					0x554, 7, 0),
+					0x554, 7, MSTOP(BUS_PERI_COM, BIT(1))),
 		DEF_MOD("gpu_clk",	R9A07G044_GPU_CLK, R9A07G044_CLK_G,
-					0x558, 0, 0),
+					0x558, 0, MSTOP(BUS_REG1, BIT(4))),
 		DEF_MOD("gpu_axi_clk",	R9A07G044_GPU_AXI_CLK, R9A07G044_CLK_P1,
 					0x558, 1, 0),
 		DEF_MOD("gpu_ace_clk",	R9A07G044_GPU_ACE_CLK, R9A07G044_CLK_P1,
 					0x558, 2, 0),
 		DEF_MOD("cru_sysclk",   R9A07G044_CRU_SYSCLK, CLK_M2_DIV2,
-					0x564, 0, 0),
+					0x564, 0, MSTOP(BUS_PERI_VIDEO, BIT(3))),
 		DEF_MOD("cru_vclk",     R9A07G044_CRU_VCLK, R9A07G044_CLK_M2,
-					0x564, 1, 0),
+					0x564, 1, MSTOP(BUS_PERI_VIDEO, BIT(3))),
 		DEF_MOD("cru_pclk",     R9A07G044_CRU_PCLK, R9A07G044_CLK_ZT,
-					0x564, 2, 0),
+					0x564, 2, MSTOP(BUS_PERI_VIDEO, BIT(3))),
 		DEF_MOD("cru_aclk",     R9A07G044_CRU_ACLK, R9A07G044_CLK_M0,
-					0x564, 3, 0),
+					0x564, 3, MSTOP(BUS_PERI_VIDEO, BIT(3))),
 		DEF_MOD("dsi_pll_clk",	R9A07G044_MIPI_DSI_PLLCLK, R9A07G044_CLK_M1,
-					0x568, 0, 0),
+					0x568, 0, MSTOP(BUS_PERI_VIDEO, GENMASK(6, 5))),
 		DEF_MOD("dsi_sys_clk",	R9A07G044_MIPI_DSI_SYSCLK, CLK_M2_DIV2,
-					0x568, 1, 0),
+					0x568, 1, MSTOP(BUS_PERI_VIDEO, GENMASK(6, 5))),
 		DEF_MOD("dsi_aclk",	R9A07G044_MIPI_DSI_ACLK, R9A07G044_CLK_P1,
-					0x568, 2, 0),
+					0x568, 2, MSTOP(BUS_PERI_VIDEO, GENMASK(6, 5))),
 		DEF_MOD("dsi_pclk",	R9A07G044_MIPI_DSI_PCLK, R9A07G044_CLK_P2,
-					0x568, 3, 0),
+					0x568, 3, MSTOP(BUS_PERI_VIDEO, GENMASK(6, 5))),
 		DEF_MOD("dsi_vclk",	R9A07G044_MIPI_DSI_VCLK, R9A07G044_CLK_M3,
-					0x568, 4, 0),
+					0x568, 4, MSTOP(BUS_PERI_VIDEO, GENMASK(6, 5))),
 		DEF_MOD("dsi_lpclk",	R9A07G044_MIPI_DSI_LPCLK, R9A07G044_CLK_M4,
-					0x568, 5, 0),
+					0x568, 5, MSTOP(BUS_PERI_VIDEO, GENMASK(6, 5))),
 		DEF_COUPLED("lcdc_a",	R9A07G044_LCDC_CLK_A, R9A07G044_CLK_M0,
-					0x56c, 0, 0),
+					0x56c, 0, MSTOP(BUS_PERI_VIDEO, GENMASK(8, 7))),
 		DEF_COUPLED("lcdc_p",	R9A07G044_LCDC_CLK_P, R9A07G044_CLK_ZT,
-					0x56c, 0, 0),
+					0x56c, 0, MSTOP(BUS_PERI_VIDEO, GENMASK(8, 7))),
 		DEF_MOD("lcdc_clk_d",	R9A07G044_LCDC_CLK_D, R9A07G044_CLK_M3,
-					0x56c, 1, 0),
+					0x56c, 1, MSTOP(BUS_PERI_VIDEO, BIT(9))),
 		DEF_MOD("ssi0_pclk",	R9A07G044_SSI0_PCLK2, R9A07G044_CLK_P0,
-					0x570, 0, 0),
+					0x570, 0, MSTOP(BUS_MCPU1, BIT(10))),
 		DEF_MOD("ssi0_sfr",	R9A07G044_SSI0_PCLK_SFR, R9A07G044_CLK_P0,
-					0x570, 1, 0),
+					0x570, 1, MSTOP(BUS_MCPU1, BIT(10))),
 		DEF_MOD("ssi1_pclk",	R9A07G044_SSI1_PCLK2, R9A07G044_CLK_P0,
-					0x570, 2, 0),
+					0x570, 2, MSTOP(BUS_MCPU1, BIT(11))),
 		DEF_MOD("ssi1_sfr",	R9A07G044_SSI1_PCLK_SFR, R9A07G044_CLK_P0,
-					0x570, 3, 0),
+					0x570, 3, MSTOP(BUS_MCPU1, BIT(11))),
 		DEF_MOD("ssi2_pclk",	R9A07G044_SSI2_PCLK2, R9A07G044_CLK_P0,
-					0x570, 4, 0),
+					0x570, 4, MSTOP(BUS_MCPU1, BIT(12))),
 		DEF_MOD("ssi2_sfr",	R9A07G044_SSI2_PCLK_SFR, R9A07G044_CLK_P0,
-					0x570, 5, 0),
+					0x570, 5, MSTOP(BUS_MCPU1, BIT(12))),
 		DEF_MOD("ssi3_pclk",	R9A07G044_SSI3_PCLK2, R9A07G044_CLK_P0,
-					0x570, 6, 0),
+					0x570, 6, MSTOP(BUS_MCPU1, BIT(13))),
 		DEF_MOD("ssi3_sfr",	R9A07G044_SSI3_PCLK_SFR, R9A07G044_CLK_P0,
-					0x570, 7, 0),
+					0x570, 7, MSTOP(BUS_MCPU1, BIT(13))),
 		DEF_MOD("usb0_host",	R9A07G044_USB_U2H0_HCLK, R9A07G044_CLK_P1,
-					0x578, 0, 0),
+					0x578, 0, MSTOP(BUS_PERI_COM, BIT(5))),
 		DEF_MOD("usb1_host",	R9A07G044_USB_U2H1_HCLK, R9A07G044_CLK_P1,
-					0x578, 1, 0),
+					0x578, 1, MSTOP(BUS_PERI_COM, BIT(7))),
 		DEF_MOD("usb0_func",	R9A07G044_USB_U2P_EXR_CPUCLK, R9A07G044_CLK_P1,
-					0x578, 2, 0),
+					0x578, 2, MSTOP(BUS_PERI_COM, BIT(6))),
 		DEF_MOD("usb_pclk",	R9A07G044_USB_PCLK, R9A07G044_CLK_P1,
-					0x578, 3, 0),
+					0x578, 3, MSTOP(BUS_PERI_COM, BIT(4))),
 		DEF_COUPLED("eth0_axi",	R9A07G044_ETH0_CLK_AXI, R9A07G044_CLK_M0,
-					0x57c, 0, 0),
+					0x57c, 0, MSTOP(BUS_PERI_COM, BIT(2))),
 		DEF_COUPLED("eth0_chi",	R9A07G044_ETH0_CLK_CHI, R9A07G044_CLK_ZT,
-					0x57c, 0, 0),
+					0x57c, 0, MSTOP(BUS_PERI_COM, BIT(2))),
 		DEF_COUPLED("eth1_axi",	R9A07G044_ETH1_CLK_AXI, R9A07G044_CLK_M0,
-					0x57c, 1, 0),
+					0x57c, 1, MSTOP(BUS_PERI_COM, BIT(3))),
 		DEF_COUPLED("eth1_chi",	R9A07G044_ETH1_CLK_CHI, R9A07G044_CLK_ZT,
-					0x57c, 1, 0),
+					0x57c, 1, MSTOP(BUS_PERI_COM, BIT(3))),
 		DEF_MOD("i2c0",		R9A07G044_I2C0_PCLK, R9A07G044_CLK_P0,
-					0x580, 0, 0),
+					0x580, 0, MSTOP(BUS_MCPU2, BIT(10))),
 		DEF_MOD("i2c1",		R9A07G044_I2C1_PCLK, R9A07G044_CLK_P0,
-					0x580, 1, 0),
+					0x580, 1, MSTOP(BUS_MCPU2, BIT(11))),
 		DEF_MOD("i2c2",		R9A07G044_I2C2_PCLK, R9A07G044_CLK_P0,
-					0x580, 2, 0),
+					0x580, 2, MSTOP(BUS_MCPU2, BIT(12))),
 		DEF_MOD("i2c3",		R9A07G044_I2C3_PCLK, R9A07G044_CLK_P0,
-					0x580, 3, 0),
+					0x580, 3, MSTOP(BUS_MCPU2, BIT(13))),
 		DEF_MOD("scif0",	R9A07G044_SCIF0_CLK_PCK, R9A07G044_CLK_P0,
-					0x584, 0, 0),
+					0x584, 0, MSTOP(BUS_MCPU2, BIT(1))),
 		DEF_MOD("scif1",	R9A07G044_SCIF1_CLK_PCK, R9A07G044_CLK_P0,
-					0x584, 1, 0),
+					0x584, 1, MSTOP(BUS_MCPU2, BIT(2))),
 		DEF_MOD("scif2",	R9A07G044_SCIF2_CLK_PCK, R9A07G044_CLK_P0,
-					0x584, 2, 0),
+					0x584, 2, MSTOP(BUS_MCPU2, BIT(3))),
 		DEF_MOD("scif3",	R9A07G044_SCIF3_CLK_PCK, R9A07G044_CLK_P0,
-					0x584, 3, 0),
+					0x584, 3, MSTOP(BUS_MCPU2, BIT(4))),
 		DEF_MOD("scif4",	R9A07G044_SCIF4_CLK_PCK, R9A07G044_CLK_P0,
-					0x584, 4, 0),
+					0x584, 4, MSTOP(BUS_MCPU2, BIT(5))),
 		DEF_MOD("sci0",		R9A07G044_SCI0_CLKP, R9A07G044_CLK_P0,
-					0x588, 0, 0),
+					0x588, 0, MSTOP(BUS_MCPU2, BIT(7))),
 		DEF_MOD("sci1",		R9A07G044_SCI1_CLKP, R9A07G044_CLK_P0,
-					0x588, 1, 0),
+					0x588, 1, MSTOP(BUS_MCPU2, BIT(8))),
 		DEF_MOD("rspi0",	R9A07G044_RSPI0_CLKB, R9A07G044_CLK_P0,
-					0x590, 0, 0),
+					0x590, 0, MSTOP(BUS_MCPU1, BIT(14))),
 		DEF_MOD("rspi1",	R9A07G044_RSPI1_CLKB, R9A07G044_CLK_P0,
-					0x590, 1, 0),
+					0x590, 1, MSTOP(BUS_MCPU1, BIT(15))),
 		DEF_MOD("rspi2",	R9A07G044_RSPI2_CLKB, R9A07G044_CLK_P0,
-					0x590, 2, 0),
+					0x590, 2, MSTOP(BUS_MCPU2, BIT(0))),
 		DEF_MOD("canfd",	R9A07G044_CANFD_PCLK, R9A07G044_CLK_P0,
-					0x594, 0, 0),
+					0x594, 0, MSTOP(BUS_MCPU2, BIT(9))),
 		DEF_MOD("gpio",		R9A07G044_GPIO_HCLK, R9A07G044_OSCCLK,
-					0x598, 0, 0),
+					0x598, 0, MSTOP(BUS_PERI_CPU, BIT(6))),
 		DEF_MOD("adc_adclk",	R9A07G044_ADC_ADCLK, R9A07G044_CLK_TSU,
-					0x5a8, 0, 0),
+					0x5a8, 0, MSTOP(BUS_MCPU2, BIT(14))),
 		DEF_MOD("adc_pclk",	R9A07G044_ADC_PCLK, R9A07G044_CLK_P0,
-					0x5a8, 1, 0),
+					0x5a8, 1, MSTOP(BUS_MCPU2, BIT(14))),
 		DEF_MOD("tsu_pclk",	R9A07G044_TSU_PCLK, R9A07G044_CLK_TSU,
-					0x5ac, 0, 0),
+					0x5ac, 0, MSTOP(BUS_MCPU2, BIT(15))),
 	},
 #ifdef CONFIG_CLK_R9A07G054
 	.drp = {
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 0a71c5ec24b6..55e815be16c8 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -34,6 +34,7 @@
 #define CPG_BUS_PERI_COM_MSTOP	(0xB6C)
 #define CPG_BUS_PERI_CPU_MSTOP	(0xB70)
 #define CPG_BUS_PERI_DDR_MSTOP	(0xB74)
+#define CPG_BUS_PERI_VIDEO_MSTOP (0xB78)
 #define CPG_BUS_REG0_MSTOP	(0xB7C)
 #define CPG_BUS_REG1_MSTOP	(0xB80)
 #define CPG_BUS_TZCDDR_MSTOP	(0xB84)
-- 
2.43.0


