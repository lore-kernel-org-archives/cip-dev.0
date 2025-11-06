Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066B0CCFA19
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:15 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10093.1762416728012542798
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:12:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=qlvChmzI;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4775ae77516so7472035e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416726; x=1763021526; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTzCq29AYcuuwLJLTnWnRTb91xl0P/AoOCk13pqBfl8=;
        b=qlvChmzIKInEElbEn1e7WGebammL0tXEdnQxvEIpC6JRFG5OEgr4jRUyhmEocSvvPv
         kP7ei65UBkiWqXIr5Y2p7ATY1IoIv+AlxQ95WABLmp1OaGBh32XUCCp5jZSrzJMJaGx3
         cGrmA32//z+6pfQVlSkpoN8LagFMWFFHUeNGhWBvY2sewmcC3f2/XuawjFsAW0SDVc+e
         u6sMde0sIL0VqICtvXa2EcTj5pDhScr13FRFUtAdnekzQp5Pha+/zRXm1olhT+3SzEPw
         QuLfc91sa+wfkFUMNskJtO2F/LGb8whbKtZr5a+0Uxtu1N6ioUV6L61sVzQjQLXYV21w
         hHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416726; x=1763021526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTzCq29AYcuuwLJLTnWnRTb91xl0P/AoOCk13pqBfl8=;
        b=aPEq9pZpjPtXpyK6uW2mao7JbUdGdBoY2d4BPYN+KPE6uL6SwYXjKnryfX9NQoDuzF
         3oa8P0EjoFwIMg5rU3aKPOq4iiDZ4NpB1lQD5cG+xsUPlXktnfo/fU5fwNVX4YH7Piqu
         3sbez01aoqpcyqClfpItfbgxV39WYGK9fST12cv/bxRxR16r5xgq4Mc20DyEDyUZDL7y
         Nl/9zmLeq1XuZpLbLyywESLhjoOVdHv54y1h7umR/n9GXWbiq4UXPQLsAXzCDb1rT68A
         5gm2za34Sm/beExjiVI+qahOvPRrAHt67vfeZXojUEOHVod5Q5MppAv/HWGibmi942DE
         tEaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLtYiJjkJE1n63qZ2VZVHTno/Mso/jrFl4xwl9Uu2GJno/eZsgJ9Bn56NHCid6OCWIrQBw2g4S@lists.cip-project.org
X-Gm-Message-State: AOJu0YxtUx4T2/yPfGK1xZm8xCVJ/trGNoON1YdnmQ2mR4x1Uy9EYY0L
	ocetFyT+r+dHv7THQjcCbDYLp5jl/6Uzjs/sJalQg5EFnq6MxMNKWdPB0Q32MVHagqQ=
X-Gm-Gg: ASbGnctMGf3u5q+cQWQjTy8q2qcbQBJxlk6bJArQj9X4SSk0lBZBZhHoBD3F9sDmMEZ
	J98iWZ5m4JXkR27TFTJ+F3MYrlAG661Ync/+vbGik7Deco/U8HMPH67UMaEdzwNSVXeyZiWj7X/
	znVs3pAYJHsxWKuFl4KRifA0RcDECj1B3JCxzys4eVVOCOVGreWXRTe9kf6yRaMNk4Z6Ah6ziD+
	/fsiK1vviIuzKKpwKkwA7T7z0LkhwRcIiYsUNo6P5J3l037OmjVvtO387x/mI5ENPA4I+lzwllk
	Ks5mxB/DZoo/PqtbguouDDAYKTryTF/Uyc8J9V+asX8giuOHePe25Rnief8c2+UyUrtKmW6yc0M
	H3FjRkY3vUHclte+iNkpbBRXJR9v493AeWbjpGTxb4m2/naoHOFUrWGcPHvuLA1NmYdYg4ntwRB
	x0NsRXvsINNjh02XYa1UiUCdUtlNogag==
X-Google-Smtp-Source: AGHT+IEpzFypoQF9txb23Py1vly2vgej+Pq1opbQX6m3BnNidacWozhbA6hy6TfSsYjvLKWn4HNJmw==
X-Received: by 2002:a05:600c:5303:b0:477:5ad9:6df1 with SMTP id 5b1f17b1804b1-4775cdad3bbmr53447425e9.3.1762416726295;
        Thu, 06 Nov 2025 00:12:06 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477624f86a2sm32862295e9.6.2025.11.06.00.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:12:04 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 22/23] clk: renesas: r9a07g043: Add MSTOP for RZ/G2UL
Date: Thu,  6 Nov 2025 10:11:31 +0200
Message-ID: <20251106081132.2574638-23-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20415

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 0f078d37aeeefa197f4ffff6acd677cd3220a070 upstream.

Add MSTOP configuration for all the module clocks on the RZ/G2UL
based SoCs (RZ/G2UL, RZ/Five).

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250806092129.621194-4-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 132 ++++++++++++++--------------
 1 file changed, 66 insertions(+), 66 deletions(-)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index 02dc5cecfd8d..f050f8565916 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -164,143 +164,143 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 static const struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 #ifdef CONFIG_ARM64
 	DEF_MOD("gic",		R9A07G043_GIC600_GICCLK, R9A07G043_CLK_P1,
-				0x514, 0, 0),
+				0x514, 0, MSTOP(BUS_REG1, BIT(7))),
 	DEF_MOD("ia55_pclk",	R9A07G043_IA55_PCLK, R9A07G043_CLK_P2,
-				0x518, 0, 0),
+				0x518, 0, MSTOP(BUS_PERI_CPU, BIT(13))),
 	DEF_MOD("ia55_clk",	R9A07G043_IA55_CLK, R9A07G043_CLK_P1,
-				0x518, 1, 0),
+				0x518, 1, MSTOP(BUS_PERI_CPU, BIT(13))),
 #endif
 #ifdef CONFIG_RISCV
 	DEF_MOD("iax45_pclk",	R9A07G043_IAX45_PCLK, R9A07G043_CLK_P2,
-				0x518, 0, 0),
+				0x518, 0, MSTOP(BUS_PERI_CPU, BIT(13))),
 	DEF_MOD("iax45_clk",	R9A07G043_IAX45_CLK, R9A07G043_CLK_P1,
-				0x518, 1, 0),
+				0x518, 1, MSTOP(BUS_PERI_CPU, BIT(13))),
 #endif
 	DEF_MOD("dmac_aclk",	R9A07G043_DMAC_ACLK, R9A07G043_CLK_P1,
-				0x52c, 0, 0),
+				0x52c, 0, MSTOP(BUS_REG1, BIT(2))),
 	DEF_MOD("dmac_pclk",	R9A07G043_DMAC_PCLK, CLK_P1_DIV2,
-				0x52c, 1, 0),
+				0x52c, 1, MSTOP(BUS_REG1, BIT(3))),
 	DEF_MOD("ostm0_pclk",	R9A07G043_OSTM0_PCLK, R9A07G043_CLK_P0,
-				0x534, 0, 0),
+				0x534, 0, MSTOP(BUS_REG0, BIT(4))),
 	DEF_MOD("ostm1_pclk",	R9A07G043_OSTM1_PCLK, R9A07G043_CLK_P0,
-				0x534, 1, 0),
+				0x534, 1, MSTOP(BUS_REG0, BIT(5))),
 	DEF_MOD("ostm2_pclk",	R9A07G043_OSTM2_PCLK, R9A07G043_CLK_P0,
-				0x534, 2, 0),
+				0x534, 2, MSTOP(BUS_REG0, BIT(6))),
 	DEF_MOD("mtu_x_mck",	R9A07G043_MTU_X_MCK_MTU3, R9A07G043_CLK_P0,
-				0x538, 0, 0),
+				0x538, 0, MSTOP(BUS_MCPU1, BIT(2))),
 	DEF_MOD("wdt0_pclk",	R9A07G043_WDT0_PCLK, R9A07G043_CLK_P0,
-				0x548, 0, 0),
+				0x548, 0, MSTOP(BUS_REG0, BIT(2))),
 	DEF_MOD("wdt0_clk",	R9A07G043_WDT0_CLK, R9A07G043_OSCCLK,
-				0x548, 1, 0),
+				0x548, 1, MSTOP(BUS_REG0, BIT(2))),
 	DEF_MOD("spi_clk2",	R9A07G043_SPI_CLK2, R9A07G043_CLK_SPI1,
-				0x550, 0, 0),
+				0x550, 0, MSTOP(BUS_MCPU1, BIT(1))),
 	DEF_MOD("spi_clk",	R9A07G043_SPI_CLK, R9A07G043_CLK_SPI0,
-				0x550, 1, 0),
+				0x550, 1, MSTOP(BUS_MCPU1, BIT(1))),
 	DEF_MOD("sdhi0_imclk",	R9A07G043_SDHI0_IMCLK, CLK_SD0_DIV4,
-				0x554, 0, 0),
+				0x554, 0, MSTOP(BUS_PERI_COM, BIT(0))),
 	DEF_MOD("sdhi0_imclk2",	R9A07G043_SDHI0_IMCLK2, CLK_SD0_DIV4,
-				0x554, 1, 0),
+				0x554, 1, MSTOP(BUS_PERI_COM, BIT(0))),
 	DEF_MOD("sdhi0_clk_hs",	R9A07G043_SDHI0_CLK_HS, R9A07G043_CLK_SD0,
-				0x554, 2, 0),
+				0x554, 2, MSTOP(BUS_PERI_COM, BIT(0))),
 	DEF_MOD("sdhi0_aclk",	R9A07G043_SDHI0_ACLK, R9A07G043_CLK_P1,
-				0x554, 3, 0),
+				0x554, 3, MSTOP(BUS_PERI_COM, BIT(0))),
 	DEF_MOD("sdhi1_imclk",	R9A07G043_SDHI1_IMCLK, CLK_SD1_DIV4,
-				0x554, 4, 0),
+				0x554, 4, MSTOP(BUS_PERI_COM, BIT(1))),
 	DEF_MOD("sdhi1_imclk2",	R9A07G043_SDHI1_IMCLK2, CLK_SD1_DIV4,
-				0x554, 5, 0),
+				0x554, 5, MSTOP(BUS_PERI_COM, BIT(1))),
 	DEF_MOD("sdhi1_clk_hs",	R9A07G043_SDHI1_CLK_HS, R9A07G043_CLK_SD1,
-				0x554, 6, 0),
+				0x554, 6, MSTOP(BUS_PERI_COM, BIT(1))),
 	DEF_MOD("sdhi1_aclk",	R9A07G043_SDHI1_ACLK, R9A07G043_CLK_P1,
-				0x554, 7, 0),
+				0x554, 7, MSTOP(BUS_PERI_COM, BIT(1))),
 #ifdef CONFIG_ARM64
 	DEF_MOD("cru_sysclk",   R9A07G043_CRU_SYSCLK, CLK_M2_DIV2,
-				0x564, 0, 0),
+				0x564, 0, MSTOP(BUS_PERI_VIDEO, BIT(3))),
 	DEF_MOD("cru_vclk",     R9A07G043_CRU_VCLK, R9A07G043_CLK_M2,
-				0x564, 1, 0),
+				0x564, 1, MSTOP(BUS_PERI_VIDEO, BIT(3))),
 	DEF_MOD("cru_pclk",     R9A07G043_CRU_PCLK, R9A07G043_CLK_ZT,
-				0x564, 2, 0),
+				0x564, 2, MSTOP(BUS_PERI_VIDEO, BIT(3))),
 	DEF_MOD("cru_aclk",     R9A07G043_CRU_ACLK, R9A07G043_CLK_M0,
-				0x564, 3, 0),
+				0x564, 3, MSTOP(BUS_PERI_VIDEO, BIT(3))),
 	DEF_COUPLED("lcdc_clk_a", R9A07G043_LCDC_CLK_A, R9A07G043_CLK_M0,
-				0x56c, 0, 0),
+				0x56c, 0, MSTOP(BUS_PERI_VIDEO, GENMASK(8, 7))),
 	DEF_COUPLED("lcdc_clk_p", R9A07G043_LCDC_CLK_P, R9A07G043_CLK_ZT,
-				0x56c, 0, 0),
+				0x56c, 0, MSTOP(BUS_PERI_VIDEO, GENMASK(8, 7))),
 	DEF_MOD("lcdc_clk_d",	R9A07G043_LCDC_CLK_D, R9A07G043_CLK_M3,
-				0x56c, 1, 0),
+				0x56c, 1, MSTOP(BUS_PERI_VIDEO, BIT(9))),
 #endif
 	DEF_MOD("ssi0_pclk",	R9A07G043_SSI0_PCLK2, R9A07G043_CLK_P0,
-				0x570, 0, 0),
+				0x570, 0, MSTOP(BUS_MCPU1, BIT(10))),
 	DEF_MOD("ssi0_sfr",	R9A07G043_SSI0_PCLK_SFR, R9A07G043_CLK_P0,
-				0x570, 1, 0),
+				0x570, 1, MSTOP(BUS_MCPU1, BIT(10))),
 	DEF_MOD("ssi1_pclk",	R9A07G043_SSI1_PCLK2, R9A07G043_CLK_P0,
-				0x570, 2, 0),
+				0x570, 2, MSTOP(BUS_MCPU1, BIT(11))),
 	DEF_MOD("ssi1_sfr",	R9A07G043_SSI1_PCLK_SFR, R9A07G043_CLK_P0,
-				0x570, 3, 0),
+				0x570, 3, MSTOP(BUS_MCPU1, BIT(11))),
 	DEF_MOD("ssi2_pclk",	R9A07G043_SSI2_PCLK2, R9A07G043_CLK_P0,
-				0x570, 4, 0),
+				0x570, 4, MSTOP(BUS_MCPU1, BIT(12))),
 	DEF_MOD("ssi2_sfr",	R9A07G043_SSI2_PCLK_SFR, R9A07G043_CLK_P0,
-				0x570, 5, 0),
+				0x570, 5, MSTOP(BUS_MCPU1, BIT(12))),
 	DEF_MOD("ssi3_pclk",	R9A07G043_SSI3_PCLK2, R9A07G043_CLK_P0,
-				0x570, 6, 0),
+				0x570, 6, MSTOP(BUS_MCPU1, BIT(13))),
 	DEF_MOD("ssi3_sfr",	R9A07G043_SSI3_PCLK_SFR, R9A07G043_CLK_P0,
-				0x570, 7, 0),
+				0x570, 7, MSTOP(BUS_MCPU1, BIT(13))),
 	DEF_MOD("usb0_host",	R9A07G043_USB_U2H0_HCLK, R9A07G043_CLK_P1,
-				0x578, 0, 0),
+				0x578, 0, MSTOP(BUS_PERI_COM, BIT(5))),
 	DEF_MOD("usb1_host",	R9A07G043_USB_U2H1_HCLK, R9A07G043_CLK_P1,
-				0x578, 1, 0),
+				0x578, 1, MSTOP(BUS_PERI_COM, BIT(7))),
 	DEF_MOD("usb0_func",	R9A07G043_USB_U2P_EXR_CPUCLK, R9A07G043_CLK_P1,
-				0x578, 2, 0),
+				0x578, 2, MSTOP(BUS_PERI_COM, BIT(6))),
 	DEF_MOD("usb_pclk",	R9A07G043_USB_PCLK, R9A07G043_CLK_P1,
-				0x578, 3, 0),
+				0x578, 3, MSTOP(BUS_PERI_COM, BIT(4))),
 	DEF_COUPLED("eth0_axi",	R9A07G043_ETH0_CLK_AXI, R9A07G043_CLK_M0,
-				0x57c, 0, 0),
+				0x57c, 0, MSTOP(BUS_PERI_COM, BIT(2))),
 	DEF_COUPLED("eth0_chi",	R9A07G043_ETH0_CLK_CHI, R9A07G043_CLK_ZT,
-				0x57c, 0, 0),
+				0x57c, 0, MSTOP(BUS_PERI_COM, BIT(2))),
 	DEF_COUPLED("eth1_axi",	R9A07G043_ETH1_CLK_AXI, R9A07G043_CLK_M0,
-				0x57c, 1, 0),
+				0x57c, 1, MSTOP(BUS_PERI_COM, BIT(3))),
 	DEF_COUPLED("eth1_chi",	R9A07G043_ETH1_CLK_CHI, R9A07G043_CLK_ZT,
-				0x57c, 1, 0),
+				0x57c, 1, MSTOP(BUS_PERI_COM, BIT(3))),
 	DEF_MOD("i2c0",		R9A07G043_I2C0_PCLK, R9A07G043_CLK_P0,
-				0x580, 0, 0),
+				0x580, 0, MSTOP(BUS_MCPU2, BIT(10))),
 	DEF_MOD("i2c1",		R9A07G043_I2C1_PCLK, R9A07G043_CLK_P0,
-				0x580, 1, 0),
+				0x580, 1, MSTOP(BUS_MCPU2, BIT(11))),
 	DEF_MOD("i2c2",		R9A07G043_I2C2_PCLK, R9A07G043_CLK_P0,
-				0x580, 2, 0),
+				0x580, 2, MSTOP(BUS_MCPU2, BIT(12))),
 	DEF_MOD("i2c3",		R9A07G043_I2C3_PCLK, R9A07G043_CLK_P0,
-				0x580, 3, 0),
+				0x580, 3, MSTOP(BUS_MCPU2, BIT(13))),
 	DEF_MOD("scif0",	R9A07G043_SCIF0_CLK_PCK, R9A07G043_CLK_P0,
-				0x584, 0, 0),
+				0x584, 0, MSTOP(BUS_MCPU2, BIT(1))),
 	DEF_MOD("scif1",	R9A07G043_SCIF1_CLK_PCK, R9A07G043_CLK_P0,
-				0x584, 1, 0),
+				0x584, 1, MSTOP(BUS_MCPU2, BIT(2))),
 	DEF_MOD("scif2",	R9A07G043_SCIF2_CLK_PCK, R9A07G043_CLK_P0,
-				0x584, 2, 0),
+				0x584, 2, MSTOP(BUS_MCPU2, BIT(3))),
 	DEF_MOD("scif3",	R9A07G043_SCIF3_CLK_PCK, R9A07G043_CLK_P0,
-				0x584, 3, 0),
+				0x584, 3, MSTOP(BUS_MCPU2, BIT(4))),
 	DEF_MOD("scif4",	R9A07G043_SCIF4_CLK_PCK, R9A07G043_CLK_P0,
-				0x584, 4, 0),
+				0x584, 4, MSTOP(BUS_MCPU2, BIT(5))),
 	DEF_MOD("sci0",		R9A07G043_SCI0_CLKP, R9A07G043_CLK_P0,
-				0x588, 0, 0),
+				0x588, 0, MSTOP(BUS_MCPU2, BIT(7))),
 	DEF_MOD("sci1",		R9A07G043_SCI1_CLKP, R9A07G043_CLK_P0,
-				0x588, 1, 0),
+				0x588, 1, MSTOP(BUS_MCPU2, BIT(8))),
 	DEF_MOD("rspi0",	R9A07G043_RSPI0_CLKB, R9A07G043_CLK_P0,
-				0x590, 0, 0),
+				0x590, 0, MSTOP(BUS_MCPU1, BIT(14))),
 	DEF_MOD("rspi1",	R9A07G043_RSPI1_CLKB, R9A07G043_CLK_P0,
-				0x590, 1, 0),
+				0x590, 1, MSTOP(BUS_MCPU1, BIT(15))),
 	DEF_MOD("rspi2",	R9A07G043_RSPI2_CLKB, R9A07G043_CLK_P0,
-				0x590, 2, 0),
+				0x590, 2, MSTOP(BUS_MCPU2, BIT(0))),
 	DEF_MOD("canfd",	R9A07G043_CANFD_PCLK, R9A07G043_CLK_P0,
-				0x594, 0, 0),
+				0x594, 0, MSTOP(BUS_MCPU2, BIT(9))),
 	DEF_MOD("gpio",		R9A07G043_GPIO_HCLK, R9A07G043_OSCCLK,
-				0x598, 0, 0),
+				0x598, 0, MSTOP(BUS_PERI_CPU, BIT(6))),
 	DEF_MOD("adc_adclk",	R9A07G043_ADC_ADCLK, R9A07G043_CLK_TSU,
-				0x5a8, 0, 0),
+				0x5a8, 0, MSTOP(BUS_MCPU2, BIT(14))),
 	DEF_MOD("adc_pclk",	R9A07G043_ADC_PCLK, R9A07G043_CLK_P0,
-				0x5a8, 1, 0),
+				0x5a8, 1, MSTOP(BUS_MCPU2, BIT(14))),
 	DEF_MOD("tsu_pclk",	R9A07G043_TSU_PCLK, R9A07G043_CLK_TSU,
-				0x5ac, 0, 0),
+				0x5ac, 0, MSTOP(BUS_MCPU2, BIT(15))),
 #ifdef CONFIG_RISCV
 	DEF_MOD("nceplic_aclk",	R9A07G043_NCEPLIC_ACLK, R9A07G043_CLK_P1,
-				0x608, 0, 0),
+				0x608, 0, MSTOP(BUS_REG1, BIT(7))),
 #endif
 };
 
-- 
2.43.0


