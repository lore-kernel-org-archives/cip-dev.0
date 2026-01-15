Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFB2D33A1F
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:34:01 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31272.1768466041043335294
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:34:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=rS1ize+2;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so924626a12.2
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466039; x=1769070839; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpFVYKr+NBqOw35O+n96x4JFqRxZnD6qb3n/toZ0KFk=;
        b=rS1ize+2SnuI9wGFJhVNuXRmVyhul2hK6/+pXZu92r/DZ1rTVjI1bdgoejnDYuE3it
         Njapt+twJ+aX0pgKIIBx6tDP3JdYeb8LYhfMG9lVxye2kM3TYAkNK7S6zVH2Jf+GdiFk
         y38vcW+2FEHDYz+eFMP9qO6E8HAPEblvvIMvIxEKQMzz+Fdl0Bw3xAgDkKh/DL8gtv2X
         9bS4jZaMqaXp/n45C9vM2cs1VKUZZKLFoL3SEE3SUozrE205U4JOR/iI40yYo92xPZBE
         ywIIe4L2nJsSPqWUwmOcpbYwHm6AiFXdzigV+50/olKYxT41llFJ/jqvZh9sendbB2Sa
         oqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466039; x=1769070839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WpFVYKr+NBqOw35O+n96x4JFqRxZnD6qb3n/toZ0KFk=;
        b=bmAzfNX2F2IxcfMV/lnG0fnjEe90qgjkop1gmOc7X+foU7ToGiUQKtOy3b6CXTBoBW
         UTKJIBEefRgRGO8OQ3QdE7iAsCLObswZ/qKRVFX7PwHEYMHY83dcR/5/nDIdhLjDou+3
         wfzJhYCz2k6Mp7pAAwVgRdBAccJtG715mAKYSDESAB3D2+O+OyI7lgo6IN5ljQKpXSWr
         LfoWuvu+SpE8NAJoeD245OTP45vOQZH1UuYfVrHK+R2DN8kHMaL02TFTzfZ4usjUGgUs
         XaQYjFWNuwwrXzUbujZoMaq8UeEi3l5H+44ywIgNHNNURWSNGnrbRjEKbcglzFdAi6OO
         uhTQ==
X-Gm-Message-State: AOJu0Yzv+/+VrtcpDxF4uSruv2oY4YWCbMtCyPHfeC8ehiswJE6SR5Rw
	F2Xr6ZNdVbgrnzB68arO0NmKrTGmSyzl/gkJYVXbbgO6kL6vCoo0jYFmfuWtUREGRls=
X-Gm-Gg: AY/fxX4B3p01APXVHP8cOzF8RPAQCbPUgxibiMgPJbu9NQA+xkiRZajtJ0uIALU96An
	Yyln4/yjzfgPvegbnyfR/hwQ2VRpcMYQKg4ZF3Wsp7nvI+jcg9t66xrysvpNsAcw19QhRIM7hD6
	9neoGR/mRoJnudpRATj2bwGcrF5N85lGQeXcr0rRdIdbSfKx2tuQ3uMjkRDLcCoabyysoBcDMCW
	p54nVRBd6Wnot4SNnfOjC51tjZ9F2ymO0mAPCARgAudBvkJ+L+2ME9fHeNceXpH69hw8R2AVmHH
	ccbj8GtKOqcAiaGYWZH6kfKH4tvH0lDFQQ3qibggCtxcJSIfQ3G6qB93xCn95YGw2XvJoHRZoyl
	Vc+7VokG2FsseD6Rr58/t6McB6tlgb3DQbxfJCNt0OqdI0eWhf/BRc6iT5xZasIopgEdd19uvOR
	WdRI6t6S44jAHQXMoyF3WmRmG9GJMxKQgJCR3DkWIuwUI9iZrqP5vKJ7gxP1/r1h2fEA==
X-Received: by 2002:a17:906:7314:b0:b87:6f7c:6094 with SMTP id a640c23a62f3a-b876f7c6538mr330574866b.41.1768466039415;
        Thu, 15 Jan 2026 00:33:59 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8731f0718asm833387066b.67.2026.01.15.00.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:33:58 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v3 14/18] clk: renesas: r9a08g045: Drop power domain instantiation
Date: Thu, 15 Jan 2026 10:33:28 +0200
Message-ID: <20260115083332.1063820-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:34:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21575

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c4969595274609055c71cbe831c2989361730876 upstream.

Since the configuration order between the individual MSTOP and CLKON
bits cannot be preserved with the power domain abstraction, drop the
power domain instantiations.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20250527112403.1254122-6-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: dropped USB clocks as these are not integrated
 in v5.10 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 129 ++++++++++++++++++----------
 1 file changed, 86 insertions(+), 43 deletions(-)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 6fa061604630..4351bae7b8bd 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -191,54 +191,97 @@ static const struct cpg_core_clk r9a08g045_core_clks[] __initconst = {
 };
 
 static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
-	DEF_MOD("gic_gicclk",		R9A08G045_GIC600_GICCLK, R9A08G045_CLK_P1, 0x514, 0, 0),
-	DEF_MOD("ia55_pclk",		R9A08G045_IA55_PCLK, R9A08G045_CLK_P2, 0x518, 0, 0),
-	DEF_MOD("ia55_clk",		R9A08G045_IA55_CLK, R9A08G045_CLK_P1, 0x518, 1, 0),
-	DEF_MOD("dmac_aclk",		R9A08G045_DMAC_ACLK, R9A08G045_CLK_P3, 0x52c, 0, 0),
-	DEF_MOD("dmac_pclk",		R9A08G045_DMAC_PCLK, CLK_P3_DIV2, 0x52c, 1, 0),
-	DEF_MOD("wdt0_pclk",		R9A08G045_WDT0_PCLK, R9A08G045_CLK_P0, 0x548, 0, 0),
-	DEF_MOD("wdt0_clk",		R9A08G045_WDT0_CLK, R9A08G045_OSCCLK, 0x548, 1, 0),
-	DEF_MOD("sdhi0_imclk",		R9A08G045_SDHI0_IMCLK, CLK_SD0_DIV4, 0x554, 0, 0),
-	DEF_MOD("sdhi0_imclk2",		R9A08G045_SDHI0_IMCLK2, CLK_SD0_DIV4, 0x554, 1, 0),
-	DEF_MOD("sdhi0_clk_hs",		R9A08G045_SDHI0_CLK_HS, R9A08G045_CLK_SD0, 0x554, 2, 0),
-	DEF_MOD("sdhi0_aclk",		R9A08G045_SDHI0_ACLK, R9A08G045_CLK_P1, 0x554, 3, 0),
-	DEF_MOD("sdhi1_imclk",		R9A08G045_SDHI1_IMCLK, CLK_SD1_DIV4, 0x554, 4, 0),
-	DEF_MOD("sdhi1_imclk2",		R9A08G045_SDHI1_IMCLK2, CLK_SD1_DIV4, 0x554, 5, 0),
-	DEF_MOD("sdhi1_clk_hs",		R9A08G045_SDHI1_CLK_HS, R9A08G045_CLK_SD1, 0x554, 6, 0),
-	DEF_MOD("sdhi1_aclk",		R9A08G045_SDHI1_ACLK, R9A08G045_CLK_P1, 0x554, 7, 0),
-	DEF_MOD("sdhi2_imclk",		R9A08G045_SDHI2_IMCLK, CLK_SD2_DIV4, 0x554, 8, 0),
-	DEF_MOD("sdhi2_imclk2",		R9A08G045_SDHI2_IMCLK2, CLK_SD2_DIV4, 0x554, 9, 0),
-	DEF_MOD("sdhi2_clk_hs",		R9A08G045_SDHI2_CLK_HS, R9A08G045_CLK_SD2, 0x554, 10, 0),
-	DEF_MOD("sdhi2_aclk",		R9A08G045_SDHI2_ACLK, R9A08G045_CLK_P1, 0x554, 11, 0),
-	DEF_MOD("ssi0_pclk2",		R9A08G045_SSI0_PCLK2, R9A08G045_CLK_P0, 0x570, 0, 0),
-	DEF_MOD("ssi0_sfr",		R9A08G045_SSI0_PCLK_SFR, R9A08G045_CLK_P0, 0x570, 1, 0),
-	DEF_MOD("ssi1_pclk2",		R9A08G045_SSI1_PCLK2, R9A08G045_CLK_P0, 0x570, 2, 0),
-	DEF_MOD("ssi1_sfr",		R9A08G045_SSI1_PCLK_SFR, R9A08G045_CLK_P0, 0x570, 3, 0),
-	DEF_MOD("ssi2_pclk2",		R9A08G045_SSI2_PCLK2, R9A08G045_CLK_P0, 0x570, 4, 0),
-	DEF_MOD("ssi2_sfr",		R9A08G045_SSI2_PCLK_SFR, R9A08G045_CLK_P0, 0x570, 5, 0),
-	DEF_MOD("ssi3_pclk2",		R9A08G045_SSI3_PCLK2, R9A08G045_CLK_P0, 0x570, 6, 0),
-	DEF_MOD("ssi3_sfr",		R9A08G045_SSI3_PCLK_SFR, R9A08G045_CLK_P0, 0x570, 7, 0),
-	DEF_COUPLED("eth0_axi",		R9A08G045_ETH0_CLK_AXI, R9A08G045_CLK_M0, 0x57c, 0, 0),
+	DEF_MOD("gic_gicclk",		R9A08G045_GIC600_GICCLK, R9A08G045_CLK_P1, 0x514, 0,
+					MSTOP(BUS_ACPU, BIT(3))),
+	DEF_MOD("ia55_pclk",		R9A08G045_IA55_PCLK, R9A08G045_CLK_P2, 0x518, 0,
+					MSTOP(BUS_PERI_CPU, BIT(13))),
+	DEF_MOD("ia55_clk",		R9A08G045_IA55_CLK, R9A08G045_CLK_P1, 0x518, 1,
+					MSTOP(BUS_PERI_CPU, BIT(13))),
+	DEF_MOD("dmac_aclk",		R9A08G045_DMAC_ACLK, R9A08G045_CLK_P3, 0x52c, 0,
+					MSTOP(BUS_REG1, BIT(2))),
+	DEF_MOD("dmac_pclk",		R9A08G045_DMAC_PCLK, CLK_P3_DIV2, 0x52c, 1,
+					MSTOP(BUS_REG1, BIT(3))),
+	DEF_MOD("wdt0_pclk",		R9A08G045_WDT0_PCLK, R9A08G045_CLK_P0, 0x548, 0,
+					MSTOP(BUS_REG0, BIT(0))),
+	DEF_MOD("wdt0_clk",		R9A08G045_WDT0_CLK, R9A08G045_OSCCLK, 0x548, 1,
+					MSTOP(BUS_REG0, BIT(0))),
+	DEF_MOD("sdhi0_imclk",		R9A08G045_SDHI0_IMCLK, CLK_SD0_DIV4, 0x554, 0,
+					MSTOP(BUS_PERI_COM, BIT(0))),
+	DEF_MOD("sdhi0_imclk2",		R9A08G045_SDHI0_IMCLK2, CLK_SD0_DIV4, 0x554, 1,
+					MSTOP(BUS_PERI_COM, BIT(0))),
+	DEF_MOD("sdhi0_clk_hs",		R9A08G045_SDHI0_CLK_HS, R9A08G045_CLK_SD0, 0x554, 2,
+					MSTOP(BUS_PERI_COM, BIT(0))),
+	DEF_MOD("sdhi0_aclk",		R9A08G045_SDHI0_ACLK, R9A08G045_CLK_P1, 0x554, 3,
+					MSTOP(BUS_PERI_COM, BIT(0))),
+	DEF_MOD("sdhi1_imclk",		R9A08G045_SDHI1_IMCLK, CLK_SD1_DIV4, 0x554, 4,
+					MSTOP(BUS_PERI_COM, BIT(1))),
+	DEF_MOD("sdhi1_imclk2",		R9A08G045_SDHI1_IMCLK2, CLK_SD1_DIV4, 0x554, 5,
+					MSTOP(BUS_PERI_COM, BIT(1))),
+	DEF_MOD("sdhi1_clk_hs",		R9A08G045_SDHI1_CLK_HS, R9A08G045_CLK_SD1, 0x554, 6,
+					MSTOP(BUS_PERI_COM, BIT(1))),
+	DEF_MOD("sdhi1_aclk",		R9A08G045_SDHI1_ACLK, R9A08G045_CLK_P1, 0x554, 7,
+					MSTOP(BUS_PERI_COM, BIT(1))),
+	DEF_MOD("sdhi2_imclk",		R9A08G045_SDHI2_IMCLK, CLK_SD2_DIV4, 0x554, 8,
+					MSTOP(BUS_PERI_COM, BIT(11))),
+	DEF_MOD("sdhi2_imclk2",		R9A08G045_SDHI2_IMCLK2, CLK_SD2_DIV4, 0x554, 9,
+					MSTOP(BUS_PERI_COM, BIT(11))),
+	DEF_MOD("sdhi2_clk_hs",		R9A08G045_SDHI2_CLK_HS, R9A08G045_CLK_SD2, 0x554, 10,
+					MSTOP(BUS_PERI_COM, BIT(11))),
+	DEF_MOD("sdhi2_aclk",		R9A08G045_SDHI2_ACLK, R9A08G045_CLK_P1, 0x554, 11,
+					MSTOP(BUS_PERI_COM, BIT(11))),
+	DEF_MOD("ssi0_pclk2",		R9A08G045_SSI0_PCLK2, R9A08G045_CLK_P0, 0x570, 0,
+					MSTOP(BUS_MCPU1, BIT(10))),
+	DEF_MOD("ssi0_sfr",		R9A08G045_SSI0_PCLK_SFR, R9A08G045_CLK_P0, 0x570, 1,
+					MSTOP(BUS_MCPU1, BIT(10))),
+	DEF_MOD("ssi1_pclk2",		R9A08G045_SSI1_PCLK2, R9A08G045_CLK_P0, 0x570, 2,
+					MSTOP(BUS_MCPU1, BIT(11))),
+	DEF_MOD("ssi1_sfr",		R9A08G045_SSI1_PCLK_SFR, R9A08G045_CLK_P0, 0x570, 3,
+					MSTOP(BUS_MCPU1, BIT(11))),
+	DEF_MOD("ssi2_pclk2",		R9A08G045_SSI2_PCLK2, R9A08G045_CLK_P0, 0x570, 4,
+					MSTOP(BUS_MCPU1, BIT(12))),
+	DEF_MOD("ssi2_sfr",		R9A08G045_SSI2_PCLK_SFR, R9A08G045_CLK_P0, 0x570, 5,
+					MSTOP(BUS_MCPU1, BIT(12))),
+	DEF_MOD("ssi3_pclk2",		R9A08G045_SSI3_PCLK2, R9A08G045_CLK_P0, 0x570, 6,
+					MSTOP(BUS_MCPU1, BIT(13))),
+	DEF_MOD("ssi3_sfr",		R9A08G045_SSI3_PCLK_SFR, R9A08G045_CLK_P0, 0x570, 7,
+					MSTOP(BUS_MCPU1, BIT(13))),
+	DEF_COUPLED("eth0_axi",		R9A08G045_ETH0_CLK_AXI, R9A08G045_CLK_M0, 0x57c, 0,
+					MSTOP(BUS_PERI_COM, BIT(2))),
 	DEF_COUPLED("eth0_chi",		R9A08G045_ETH0_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 0, 0),
 	DEF_MOD("eth0_refclk",		R9A08G045_ETH0_REFCLK, R9A08G045_CLK_HP, 0x57c, 8, 0),
-	DEF_COUPLED("eth1_axi",		R9A08G045_ETH1_CLK_AXI, R9A08G045_CLK_M0, 0x57c, 1, 0),
+	DEF_COUPLED("eth1_axi",		R9A08G045_ETH1_CLK_AXI, R9A08G045_CLK_M0, 0x57c, 1,
+					MSTOP(BUS_PERI_COM, BIT(3))),
 	DEF_COUPLED("eth1_chi",		R9A08G045_ETH1_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 1, 0),
 	DEF_MOD("eth1_refclk",		R9A08G045_ETH1_REFCLK, R9A08G045_CLK_HP, 0x57c, 9, 0),
-	DEF_MOD("i2c0_pclk",		R9A08G045_I2C0_PCLK, R9A08G045_CLK_P0, 0x580, 0, 0),
-	DEF_MOD("i2c1_pclk",		R9A08G045_I2C1_PCLK, R9A08G045_CLK_P0, 0x580, 1, 0),
-	DEF_MOD("i2c2_pclk",		R9A08G045_I2C2_PCLK, R9A08G045_CLK_P0, 0x580, 2, 0),
-	DEF_MOD("i2c3_pclk",		R9A08G045_I2C3_PCLK, R9A08G045_CLK_P0, 0x580, 3, 0),
-	DEF_MOD("scif0_clk_pck",	R9A08G045_SCIF0_CLK_PCK, R9A08G045_CLK_P0, 0x584, 0, 0),
-	DEF_MOD("scif1_clk_pck",	R9A08G045_SCIF1_CLK_PCK, R9A08G045_CLK_P0, 0x584, 1, 0),
-	DEF_MOD("scif2_clk_pck",	R9A08G045_SCIF2_CLK_PCK, R9A08G045_CLK_P0, 0x584, 2, 0),
-	DEF_MOD("scif3_clk_pck",	R9A08G045_SCIF3_CLK_PCK, R9A08G045_CLK_P0, 0x584, 3, 0),
-	DEF_MOD("scif4_clk_pck",	R9A08G045_SCIF4_CLK_PCK, R9A08G045_CLK_P0, 0x584, 4, 0),
-	DEF_MOD("scif5_clk_pck",	R9A08G045_SCIF5_CLK_PCK, R9A08G045_CLK_P0, 0x584, 5, 0),
+	DEF_MOD("i2c0_pclk",		R9A08G045_I2C0_PCLK, R9A08G045_CLK_P0, 0x580, 0,
+					MSTOP(BUS_MCPU2, BIT(10))),
+	DEF_MOD("i2c1_pclk",		R9A08G045_I2C1_PCLK, R9A08G045_CLK_P0, 0x580, 1,
+					MSTOP(BUS_MCPU2, BIT(11))),
+	DEF_MOD("i2c2_pclk",		R9A08G045_I2C2_PCLK, R9A08G045_CLK_P0, 0x580, 2,
+					MSTOP(BUS_MCPU2, BIT(12))),
+	DEF_MOD("i2c3_pclk",		R9A08G045_I2C3_PCLK, R9A08G045_CLK_P0, 0x580, 3,
+					MSTOP(BUS_MCPU2, BIT(13))),
+	DEF_MOD("scif0_clk_pck",	R9A08G045_SCIF0_CLK_PCK, R9A08G045_CLK_P0, 0x584, 0,
+					MSTOP(BUS_MCPU2, BIT(1))),
+	DEF_MOD("scif1_clk_pck",	R9A08G045_SCIF1_CLK_PCK, R9A08G045_CLK_P0, 0x584, 1,
+					MSTOP(BUS_MCPU2, BIT(2))),
+	DEF_MOD("scif2_clk_pck",	R9A08G045_SCIF2_CLK_PCK, R9A08G045_CLK_P0, 0x584, 2,
+					MSTOP(BUS_MCPU2, BIT(3))),
+	DEF_MOD("scif3_clk_pck",	R9A08G045_SCIF3_CLK_PCK, R9A08G045_CLK_P0, 0x584, 3,
+					MSTOP(BUS_MCPU2, BIT(4))),
+	DEF_MOD("scif4_clk_pck",	R9A08G045_SCIF4_CLK_PCK, R9A08G045_CLK_P0, 0x584, 4,
+					MSTOP(BUS_MCPU2, BIT(5))),
+	DEF_MOD("scif5_clk_pck",	R9A08G045_SCIF5_CLK_PCK, R9A08G045_CLK_P0, 0x584, 5,
+					MSTOP(BUS_MCPU3, BIT(4))),
 	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0, 0),
-	DEF_MOD("adc_adclk",		R9A08G045_ADC_ADCLK, R9A08G045_CLK_TSU, 0x5a8, 0, 0),
-	DEF_MOD("adc_pclk",		R9A08G045_ADC_PCLK, R9A08G045_CLK_TSU, 0x5a8, 1, 0),
-	DEF_MOD("tsu_pclk",		R9A08G045_TSU_PCLK, R9A08G045_CLK_TSU, 0x5ac, 0, 0),
-	DEF_MOD("vbat_bclk",		R9A08G045_VBAT_BCLK, R9A08G045_OSCCLK, 0x614, 0, 0),
+	DEF_MOD("adc_adclk",		R9A08G045_ADC_ADCLK, R9A08G045_CLK_TSU, 0x5a8, 0,
+					MSTOP(BUS_MCPU2, BIT(14))),
+	DEF_MOD("adc_pclk",		R9A08G045_ADC_PCLK, R9A08G045_CLK_TSU, 0x5a8, 1,
+					MSTOP(BUS_MCPU2, BIT(14))),
+	DEF_MOD("tsu_pclk",		R9A08G045_TSU_PCLK, R9A08G045_CLK_TSU, 0x5ac, 0,
+					MSTOP(BUS_MCPU2, BIT(15))),
+	DEF_MOD("vbat_bclk",		R9A08G045_VBAT_BCLK, R9A08G045_OSCCLK, 0x614, 0,
+					MSTOP(BUS_MCPU3, GENMASK(8, 7))),
 };
 
 static const struct rzg2l_reset r9a08g045_resets[] = {
-- 
2.43.0


