Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8391FCCFA1A
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:24 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10019.1762416681347358563
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=avRixA6g;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso378155f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416680; x=1763021480; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NK2f4jlhog/VU4zNoSbklRgRHT7oj4JuX+L96Q+k/D0=;
        b=avRixA6gQOeQYsFwLloFkmpfBXK2pXoupmZwLQ5xB8BZjs7jsIHypsK1QDGyrWhPA/
         0pxKj7RXzyEbzl1W5BjpT06PP+akiJ8suA000878M6qK/PktLXjvJtwNvbTEyzfWw6pQ
         09MKNnNSkh7Z3ywqRKsPRGlzjCK0/g5SIdl9GDTgxnEIh0LTnIHVLz6yF+lOD9BsXdpo
         1HHYnu08wNqnYd2P2GLvc8QgI8SO9V5MY2UROzULArHmH7EZM6jbo5+Uh6bMTxFjFMRJ
         Vmioy8AieNkrjSk01Av1ordSs41Rb221iQM0PcynXI3kBjI0R3FnAyRapVAbXa8BsVaD
         PABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416680; x=1763021480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NK2f4jlhog/VU4zNoSbklRgRHT7oj4JuX+L96Q+k/D0=;
        b=n6SaGLAzqsfUz1sH0Vck7mFU0D4Cl15R/4+LWzhj8XK4/PQX7b3eukWG8UWKYZl84b
         mDCuPeFBj3MuhFIV+0Ipgt8fqCK2wy0EyrpiEyDdNbBDZpUsKXS7ET5AcYIr1bONBBmN
         FZcEIsL+ohXnh9w9GxtQ53rheE/g4zgTfXZIvb/586837kJRy2ZcjDFN3AApRK1Og0Pl
         garjBe6TlU5rDwUI5EJOsnfH8I2jsU37bqnAooHE2NFuBLs22oqzoKw0+woO47i+3wpn
         rWJtPEsKsyp9lQDILUupdIRV38jb4JD+VZLsFHg1bhU+6gtR0cM34EUmCp5tnWBzRSlY
         Y0Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXTYjadjfa7E/fcTIcLcNzX2aglV1yDKf9oxWRyGuIQ0rm+vrYFQZoe9NswDQJteHMXm11Ygc4n@lists.cip-project.org
X-Gm-Message-State: AOJu0YyXaobSd5pUcQt1ySaba2ri0XgPbgKo5RMVS3Wit+DdE4qg3UDV
	AxqjkgtiHcvrNjPgvFM+Pmgjn3L2F2WXyNWh6rG1TW15VPeeL0MYY6e5ztbqqhWhrfI=
X-Gm-Gg: ASbGncv8Ez20ZbGK0GqKSNQDN4cp0jEQ8LHHZ61VmsljsfCqdi2NTsmWZ1fQLq3r7qD
	u7oCk+f6Qh3PLRqO01KPXC/JZv003Ei8sunAFJ7GQHBI3silWyx2FQW7cvIark6clPLDegN7yat
	hfqtiu2+GtWazmyoMmxpFsT1BZ2eXo4dJYLRxDddphVR/W/hx0rxIUN+wtjF9zyZ8yn1+HgOnn8
	IbxOJkFFv8oh1KuAyfHr4YVFG1s0rSjFApxXJlpJrnj98pdcjX+NpfG78ZlE9a6+tmej/wzI7hf
	rdvNB81uXi1xbEA4P7jKYDG5ku2v4ADlmMfyIkHHfnynqCPXnbTZ9A6Up0XFWp99PpYqPTXs7df
	FFVbOkOOwMrf4r02l4BwAYZ7pL9f+fpi/wO81NSZsiDjDn5zSF8ld9Y6BIF+5OtxhznuZ279erm
	9wmhziFeI9yrSMZjxqHZwSBVR8G8Ll78Txln566Bck
X-Google-Smtp-Source: AGHT+IE5VmlB95jAORM33i8qj8E28UBI+c3SqID8qy3qJ3xAxrX91YL1cS3R2aqZrcluKQ9TP1AlHw==
X-Received: by 2002:a05:6000:2083:b0:429:d290:231a with SMTP id ffacd0b85a97d-429e32c81a1mr5036369f8f.4.1762416679598;
        Thu, 06 Nov 2025 00:11:19 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb47873dsm3486735f8f.31.2025.11.06.00.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:18 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 21/23] clk: renesas: r9a07g044: Add MSTOP for RZ/G2L
Date: Thu,  6 Nov 2025 10:10:46 +0200
Message-ID: <20251106081048.2574345-22-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20390

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
index c851d4eeebbe..fdbc0635a869 100644
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


