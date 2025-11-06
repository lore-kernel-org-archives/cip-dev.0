Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628AACCF9F8
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:55 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10072.1762416765120963793
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:12:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Jh22hVrT;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429b7eecf7cso422629f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416763; x=1763021563; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dbvLSCHcbTpL8b0fsyrawrZ/QktSuWRfM/tVSTnSWA=;
        b=Jh22hVrTnRUijIYFJMmdtHy5z5d6jhYd4PQURTdMBXgq1uv4mtV/ftZivd1l+o9B4J
         vyyORFnp2lL7ndanwIobWN5QB+/M0QRGw0UJW1kcvIO5RrYAdH/hbWz5HVLjvNwrOq8T
         849Nn14vP4Mr9bIjNNBSweG8HYORfsK6xqCeEWGg/ZnACeWaEoVWpbVVL6NTRhnKPC8b
         B5ojyBi0ayQQIdD57IGhArrTCykKx01WgLWQRwkTc0JST0T1JJrh5IGTUvST4y4cN6LO
         O+FRNag4EiQQgHIAbZaAcx/dTnMuydc7aHrwsqJwikoQb/e5d5y1MRK9Younj6Y4uQ+y
         nNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416763; x=1763021563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dbvLSCHcbTpL8b0fsyrawrZ/QktSuWRfM/tVSTnSWA=;
        b=Gc2v68+/1VuFjLtPFJO1KVCtB7ZCNzKZk2KybNr7gbUQDPMVepHxv7xAhzzW4r8Hlq
         MO26DpI6W/D3wEU3SIf3XYP5KhM39K1YOvmsMv2E3q6uTcnuh4TxGwwfJhUR9m65r3wJ
         PEfWoacu0y2Nd1K+qtE1f0xYba4HDKG0fNM2RxW9TXfuaUXQrMZ+1B7plDKL2RD3qDC1
         uPG+euNQ3QdZojiEq9aYE8dQEMzViAMHS4WhoCPoWV1SCkGR22A18iBdzyKAVJ5a3AnD
         wS2Y04oDONviZZt7MHbpiFruzFJEmTl3iStleakhZ3JQe7X0flFneUZPJSy3zdJJUDrQ
         ZxoA==
X-Forwarded-Encrypted: i=1; AJvYcCWWYyoxo8IdVnP2O40fezTBCvsK25SmJCXzfl6iB1LnK5MygU04F5ydbXcEW0FpcZ7LyCbkPXhC@lists.cip-project.org
X-Gm-Message-State: AOJu0YyO5x5gzrw9TYZkSbypg6XHBLGyI7BhaeUg2SzZXADpJM6O0T3H
	Y/PKbYjP4mL1b1vhYGUCNzWO9KTI4aXSa9xpyFLuYX6ZhB3SP655gLPa0UQaMesCw+w=
X-Gm-Gg: ASbGncsx4yl05GXVdT9U9FvEq4mjVMXOHQg1TYC0oZzHQuNLamde6XB6ZO6/Zq9v/lo
	OWgLzet8P3dLGo5+0/0ZcwjYKXfOoRVqhhrEwuujqJaYwQh/D5/XaMkBd4fQxUClY+bPdTIZeg4
	AD3pr5gMQ0X+zq/40nK9ITQvLd1F6JoOzNS1cRCMFKfYLL0UgPEipj0o711O8fKunIZEI5/tP3n
	YyFZSog8EX9t9XSPilm8rJasNo4zG0WqdkGUHpGMihEM9yGDENFXc/up+FCYqTA4Ow+kGxBru9T
	4gKceUlFD4umASCbNIVOZx/mNviaxz9TWU410JJx0cLepqqmJ2RmoL8aS25gUSy9aKUFRVE1tzj
	P3AVbHvPBFU1aLPF8yCmlk1t39XUlfXXgn645QaBxnKFUgZbe19GD6yYHa7bK6ixSrV9u9krL70
	u0ggRyMzQ7lh9GwQyr7QoXFDQ6r/6rCml/3ntRSt5W
X-Google-Smtp-Source: AGHT+IGXXVoWaeHoMJ6clQqZHH7IQsndDzrpPEhIbjd6ZrVJcoCkvX7jf2wtRv0icSmChTtdeSze5A==
X-Received: by 2002:a05:6000:40c7:b0:429:ca7f:8d6f with SMTP id ffacd0b85a97d-429eb16cf27mr2199435f8f.15.1762416763452;
        Thu, 06 Nov 2025 00:12:43 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eceaed27sm2486647f8f.27.2025.11.06.00.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:12:43 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 17/22] clk: renesas: r9a08g045: Drop power domain instantiation
Date: Thu,  6 Nov 2025 10:12:13 +0200
Message-ID: <20251106081218.2574950-18-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20434

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c4969595274609055c71cbe831c2989361730876 upstream.

Since the configuration order between the individual MSTOP and CLKON
bits cannot be preserved with the power domain abstraction, drop the
power domain instantiations.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20250527112403.1254122-6-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: dropped USB and TSU clocks as these are not integrated
 in v5.10 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 126 ++++++++++++++++++----------
 1 file changed, 84 insertions(+), 42 deletions(-)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index a1e09b1214fc..f5f0ddca4b8b 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -190,53 +190,95 @@ static const struct cpg_core_clk r9a08g045_core_clks[] __initconst = {
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
-	DEF_MOD("vbat_bclk",		R9A08G045_VBAT_BCLK, R9A08G045_OSCCLK, 0x614, 0, 0),
+	DEF_MOD("adc_adclk",		R9A08G045_ADC_ADCLK, R9A08G045_CLK_TSU, 0x5a8, 0,
+					MSTOP(BUS_MCPU2, BIT(14))),
+	DEF_MOD("adc_pclk",		R9A08G045_ADC_PCLK, R9A08G045_CLK_TSU, 0x5a8, 1,
+					MSTOP(BUS_MCPU2, BIT(14))),
+	DEF_MOD("vbat_bclk",		R9A08G045_VBAT_BCLK, R9A08G045_OSCCLK, 0x614, 0,
+					MSTOP(BUS_MCPU3, GENMASK(8, 7))),
 };
 
 static const struct rzg2l_reset r9a08g045_resets[] = {
-- 
2.43.0


