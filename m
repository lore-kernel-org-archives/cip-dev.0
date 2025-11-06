Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E5ECCFA1A
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:15 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10051.1762416726027776481
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:12:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=WVjpUxMU;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4711810948aso4202215e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416724; x=1763021524; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jol6K2L6b64bd9EEBerFhjJ68myX7DFc3dd93nj/o6E=;
        b=WVjpUxMUcN7RBF62Js2GhUnsF4NFNuuDbqolpqoB95tsBrYoCvdbKaUt2ClVvlKiob
         FkkINEOunBD6chrWHqsmM4i9A/gBeIyVRuJiXnUUpTCYR8EPFeOsEEaTXnvnwO1o9EbI
         CAoOFZ9AHv5hxS/FHdIS8/u6b8435nYdBOqhCCavco2NpbYGlhwWrGzI9oJXKxbUq5eZ
         NB8fx7CUDzbqGVbITU7kg8YQ5LvSix5gIpSlvrvNuhYGizWvp7QBVjPbqFx8G0EikawD
         JGsVE6mjT0z+nRmCMovsXKu/1WEwwlIJgFwIuGMn5JhsHLwNcTj9rPaYtPIbuqSZiWVU
         opTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416724; x=1763021524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jol6K2L6b64bd9EEBerFhjJ68myX7DFc3dd93nj/o6E=;
        b=H/TAyNY69Nr9hyaPr2+sZtJPoirT2Zg6Yh+w6GA5NlzbNibZl5Smnj0vaXGwt6mqTc
         fFbRHYxFtyW8/z2N6D0taK+uaG111JPBnq45pBoOiQ63m+46PwgSENMlfaKgs9gAIZYi
         AH4GBoO0G8Y/y0UKmIhCFG+ENGBVZ6gO0Og4rsEFG8DkTNAtJ+HiSl4caUM3Ye0NDLbh
         G4a3vsNePnTAnBVKHZrdXVA8B9cScgiuCRYhlnGZoWfFLwgQmUcrIJixmjyH3OOcWJba
         UxxrbsYL0l+OwZ/vrik/mVM60BnJhWKdK4JZxhE+Rmi6YBar+n4D7rqKfKSM6UF2De7F
         W4gg==
X-Forwarded-Encrypted: i=1; AJvYcCUJrsbw3Cv0R5mWmsSGPb56fpT6CIwqppxe5ByXmnK7hnQNPbIrciqOBkn3FJIjaEsAVhkJ8ux3@lists.cip-project.org
X-Gm-Message-State: AOJu0YxFrBRvuJ9onPGi/CcXdk1MIbIDjSq8B6+JdnToqLUkciqGFlRG
	8cctsU0KvCRA4lAMJp0YDMahIjlt12tfkd/UqEbYlPpGW6AzYG3KBOyL/FEpna7yVdOeC4D3LZS
	ugwMuPvE=
X-Gm-Gg: ASbGncsX4Syf0aPY2HQmEsDkoxUYm2hR+D+ANmCicCnzCpJfCa9N9pBYRlgILPvCGzL
	qaXSWhDf2WIHgfzrmCPR4t+88X/hJKP2gJC0UJMIjDauti3ST2eP4cHuTBo0VXmELiHgb9oGp9i
	TfIW/S0ZZi4kCddGLv2TlPl8KK6dZBMVLwHNs4QtvX3/hfBM8edwNjkoDSMIHIW2uj/j91noNbq
	IGyJ0/ZZvp0qkbd04bK4Pk0nvfzXQVliWoT6oXhjpQozIEnyjeqZrS7LpVwfxrpqu+QXTEeOd1a
	z7hIYufciWeTKLUCakzrDtvKNMpJtsCvjnPX/fVFEiaTyCFtnMyyY/cVyZKY9uH4q1RYWijG4ca
	2+1kSTEeHKejfYA4TN3UR1eukgzsreTI7sWUJ098GIJ15F7oOLEuXVu7d2BQ2zLjpj1DsmDAXoy
	DXXdS5c6yPVjsShBmpi2Aw3ijMukGKjUDnEG4SpKxh
X-Google-Smtp-Source: AGHT+IEgxJqTI7r+RNRjQtFCvTOVGmRzmTno8BQb4yI+n1iXvf+jNWYsr8MjPgxz58PagWqIQJWZNg==
X-Received: by 2002:a05:600c:a0d:b0:477:1622:7f78 with SMTP id 5b1f17b1804b1-4775ce24859mr56085625e9.40.1762416724326;
        Thu, 06 Nov 2025 00:12:04 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477624f86a2sm32862295e9.6.2025.11.06.00.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:12:03 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 21/23] clk: renesas: r9a07g044: Add MSTOP for RZ/G2L
Date: Thu,  6 Nov 2025 10:11:30 +0200
Message-ID: <20251106081132.2574638-22-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20414

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
index 077004015431..5d9cf7865a18 100644
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


