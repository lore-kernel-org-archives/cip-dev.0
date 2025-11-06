Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5610DCCFA19
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:14 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10067.1762416672510464647
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=gshTjrfS;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so505097f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416671; x=1763021471; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CT27CK3hnKYbj46HrGpwLJF7fL+a+pwL3ksxOdx7zZ0=;
        b=gshTjrfSmT9ICPQSvmRIDxjCBhzzY4RrYbrPUweq+VoYHEg9AR4ZISoCmsS+OIiv2e
         IcMOTZJwz89EWEQLkehXzap1vS4Xqkhdm+kTJ+yMQDhLqe6ZDQ4UhwuQ/DDVh4Ck/68Z
         ATVCmVFntb/hl1/eN8wi4v5tXAWYFI5/e1qiLlw1MdKpYI1/KSkwK6HH72I59V46vtyI
         EwUrfXoEVjrstS930cb/SwVQcu652g7EL7Mtu7O2fg4qKyPOirDR6PWm1MIMEq/g0pCa
         4lMLhSq0JykrxQ1XjYE27LsUZtab3iiQdxDD07ey7lIIrc/k/xQxAuTBpi57Q8T26kkS
         ilag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416671; x=1763021471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CT27CK3hnKYbj46HrGpwLJF7fL+a+pwL3ksxOdx7zZ0=;
        b=QBW87zebyzste3nUB26o3R2FFuqsBn6GmgQ3bN7m2XnGbO+0booVXBuCGkZPHCMk7c
         8VlI/i0eozh5NLBDnTiUhrq7oOCigWKPoHqrLe4NpeKArDzGcFjI4k22B45pZBzkwr8Q
         wdrovLv3ZirmR32P3qUNLX5FA7qRJuQgPIEZgOC4BUDyquukQysADKkyM1MNZ24nW1Oa
         GQbkq15ti/SUKxy4VV7E8vJ9aC6Dlh1Sb155Q6lOtAV/BH9Q9tZGWdDf/1VJoeAv1eT8
         rw7fiSI2hS3Tuy2Min7yFTgCxxI9UPRcTbx9RZks6XhAGzo/3qfDCvdYCun66PnYp1rN
         ubYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlkJMlC4W3Rfk790HG3kquT7U8YeF+90LhSEVv3sWDabc8Rx0mLAJ8g/01a79dlBQ8F11cRCu3@lists.cip-project.org
X-Gm-Message-State: AOJu0Yx5PzovrPv5+UkhKgnRKNvT7c/x4ehscwOm2P/9gt1RW5Mc5QWp
	Fvzykj0LIZBF074/4D47ce+RJ/K8HhfIcgIxRo2GFCV4hSRY6k7dUm8t7UQA1bBtXgU=
X-Gm-Gg: ASbGncu/MGg7jvGkCC85Zi014J9NDFees9r8FmB0MfkGUQuECh4uIKRL+CoBaQewwxV
	SFSl3hGpRShy9M09y+qLy0jGlp8NlP4ACbsyOVKuVKypT1vJEm1t+m7wGNAOtJLNtGwT5xiOfp0
	MkKjjDsEKxCYrpffOFCd+YloHBo/z5tVaVg1fW3nngF9xDiEH60SxQI9D6rDG5xd7D0IkuFcfgH
	qnG04n7Jlurx0z0KL+V9d05qr1KD52ISlqbph3u4Ltspc5fl//r4etnLCuOBJ4PQA8v9qDeofw0
	C2Ws8ekf2LmRPZTRkOaQJAvmDwek/tiKYlwTawXvDrIZ5Fo0I3kd/MvPjasB1tv2V7F7f8u/Y/v
	g0AjQ1C4qKVO6ysp0mPZahSp4IpVvcW6QD+Pwpo3me6Dq/GxYmzQpo3dieshDOLz7PbY44kDO8C
	uila+kelHvzFfCzLMopQ+KA5h72bVGlw==
X-Google-Smtp-Source: AGHT+IGIZPaqnFeUiCcMLO00ezhT7He0jG/UFXAN8g9CilPMZ5H6qngIqtR63y/f48wJ8d5glMb16g==
X-Received: by 2002:a5d:5d08:0:b0:3ee:1233:4681 with SMTP id ffacd0b85a97d-429e32e6d39mr5436007f8f.23.1762416670778;
        Thu, 06 Nov 2025 00:11:10 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb47873dsm3486735f8f.31.2025.11.06.00.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:09 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 15/23] clk: renesas: r9a08g045: Drop power domain instantiation
Date: Thu,  6 Nov 2025 10:10:40 +0200
Message-ID: <20251106081048.2574345-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20384

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c4969595274609055c71cbe831c2989361730876 upstream.

Since the configuration order between the individual MSTOP and CLKON
bits cannot be preserved with the power domain abstraction, drop the
power domain instantiations.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20250527112403.1254122-6-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict by:
 - dropping TSU clock as it is not yet integrated in v6.12 CIP
 - dropping r9a08g045_pm_domains[]]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 232 +++++++++++-----------------
 1 file changed, 91 insertions(+), 141 deletions(-)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 9741bb1e0b88..6f0bdf9b6e4b 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -191,58 +191,103 @@ static const struct cpg_core_clk r9a08g045_core_clks[] __initconst = {
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
-	DEF_MOD("usb0_host",		R9A08G045_USB_U2H0_HCLK, R9A08G045_CLK_P1, 0x578, 0, 0),
-	DEF_MOD("usb1_host",		R9A08G045_USB_U2H1_HCLK, R9A08G045_CLK_P1, 0x578, 1, 0),
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
+	DEF_MOD("usb0_host",		R9A08G045_USB_U2H0_HCLK, R9A08G045_CLK_P1, 0x578, 0,
+					MSTOP(BUS_PERI_COM, BIT(5))),
+	DEF_MOD("usb1_host",		R9A08G045_USB_U2H1_HCLK, R9A08G045_CLK_P1, 0x578, 1,
+					MSTOP(BUS_PERI_COM, BIT(7))),
 	DEF_MOD("usb0_func",		R9A08G045_USB_U2P_EXR_CPUCLK, R9A08G045_CLK_P1, 0x578, 2,
-					0),
-	DEF_MOD("usb_pclk",		R9A08G045_USB_PCLK, R9A08G045_CLK_P1, 0x578, 3, 0),
-	DEF_COUPLED("eth0_axi",		R9A08G045_ETH0_CLK_AXI, R9A08G045_CLK_M0, 0x57c, 0, 0),
+					MSTOP(BUS_PERI_COM, BIT(6))),
+	DEF_MOD("usb_pclk",		R9A08G045_USB_PCLK, R9A08G045_CLK_P1, 0x578, 3,
+					MSTOP(BUS_PERI_COM, BIT(4))),
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
@@ -291,97 +336,6 @@ static const unsigned int r9a08g045_crit_mod_clks[] __initconst = {
 	MOD_CLK_BASE + R9A08G045_VBAT_BCLK,
 };
 
-static const struct rzg2l_cpg_pm_domain_init_data r9a08g045_pm_domains[] = {
-	/* Keep always-on domain on the first position for proper domains registration. */
-	DEF_PD("always-on",	R9A08G045_PD_ALWAYS_ON,
-				DEF_REG_CONF(0, 0),
-				RZG2L_PD_F_ALWAYS_ON),
-	DEF_PD("gic",		R9A08G045_PD_GIC,
-				DEF_REG_CONF(CPG_BUS_ACPU_MSTOP, BIT(3)),
-				RZG2L_PD_F_ALWAYS_ON),
-	DEF_PD("ia55",		R9A08G045_PD_IA55,
-				DEF_REG_CONF(CPG_BUS_PERI_CPU_MSTOP, BIT(13)),
-				RZG2L_PD_F_ALWAYS_ON),
-	DEF_PD("dmac",		R9A08G045_PD_DMAC,
-				DEF_REG_CONF(CPG_BUS_REG1_MSTOP, GENMASK(3, 0)),
-				RZG2L_PD_F_ALWAYS_ON),
-	DEF_PD("wdt0",		R9A08G045_PD_WDT0,
-				DEF_REG_CONF(CPG_BUS_REG0_MSTOP, BIT(0)),
-				RZG2L_PD_F_NONE),
-	DEF_PD("sdhi0",		R9A08G045_PD_SDHI0,
-				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(0)),
-				RZG2L_PD_F_NONE),
-	DEF_PD("sdhi1",		R9A08G045_PD_SDHI1,
-				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(1)),
-				RZG2L_PD_F_NONE),
-	DEF_PD("sdhi2",		R9A08G045_PD_SDHI2,
-				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(11)),
-				RZG2L_PD_F_NONE),
-	DEF_PD("ssi0",		R9A08G045_PD_SSI0,
-				DEF_REG_CONF(CPG_BUS_MCPU1_MSTOP, BIT(10)),
-				RZG2L_PD_F_NONE),
-	DEF_PD("ssi1",		R9A08G045_PD_SSI1,
-				DEF_REG_CONF(CPG_BUS_MCPU1_MSTOP, BIT(11)),
-				RZG2L_PD_F_NONE),
-	DEF_PD("ssi2",		R9A08G045_PD_SSI2,
-				DEF_REG_CONF(CPG_BUS_MCPU1_MSTOP, BIT(12)),
-				RZG2L_PD_F_NONE),
-	DEF_PD("ssi3",		R9A08G045_PD_SSI3,
-				DEF_REG_CONF(CPG_BUS_MCPU1_MSTOP, BIT(13)),
-				RZG2L_PD_F_NONE),
-	DEF_PD("usb0",		R9A08G045_PD_USB0,
-				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, GENMASK(6, 5)),
-				RZG2L_PD_F_NONE),
-	DEF_PD("usb1",		R9A08G045_PD_USB1,
-				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(7)),
-				RZG2L_PD_F_NONE),
-	DEF_PD("usb-phy",	R9A08G045_PD_USB_PHY,
-				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(4)),
-				RZG2L_PD_F_NONE),
-	DEF_PD("eth0",		R9A08G045_PD_ETHER0,
-				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(2)),
-				RZG2L_PD_F_NONE),
-	DEF_PD("eth1",		R9A08G045_PD_ETHER1,
-				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(3)),
-				RZG2L_PD_F_NONE),
-	DEF_PD("i2c0",		R9A08G045_PD_I2C0,
-				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(10)),
-				RZG2L_PD_F_NONE),
-	DEF_PD("i2c1",		R9A08G045_PD_I2C1,
-				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(11)),
-				RZG2L_PD_F_NONE),
-	DEF_PD("i2c2",		R9A08G045_PD_I2C2,
-				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(12)),
-				RZG2L_PD_F_NONE),
-	DEF_PD("i2c3",		R9A08G045_PD_I2C3,
-				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(13)),
-				RZG2L_PD_F_NONE),
-	DEF_PD("scif0",		R9A08G045_PD_SCIF0,
-				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(1)),
-				RZG2L_PD_F_NONE),
-	DEF_PD("scif1",		R9A08G045_PD_SCIF1,
-				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(2)),
-				RZG2L_PD_F_NONE),
-	DEF_PD("scif2",		R9A08G045_PD_SCIF2,
-				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(3)),
-				RZG2L_PD_F_NONE),
-	DEF_PD("scif3",		R9A08G045_PD_SCIF3,
-				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(4)),
-				RZG2L_PD_F_NONE),
-	DEF_PD("scif4",		R9A08G045_PD_SCIF4,
-				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(5)),
-				RZG2L_PD_F_NONE),
-	DEF_PD("scif5",		R9A08G045_PD_SCIF5,
-				DEF_REG_CONF(CPG_BUS_MCPU3_MSTOP, BIT(4)),
-				RZG2L_PD_F_NONE),
-	DEF_PD("adc",		R9A08G045_PD_ADC,
-				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(14)),
-				RZG2L_PD_F_NONE),
-	DEF_PD("vbat",		R9A08G045_PD_VBAT,
-				DEF_REG_CONF(CPG_BUS_MCPU3_MSTOP, BIT(8)),
-				RZG2L_PD_F_ALWAYS_ON),
-};
-
 const struct rzg2l_cpg_info r9a08g045_cpg_info = {
 	/* Core Clocks */
 	.core_clks = r9a08g045_core_clks,
@@ -402,9 +356,5 @@ const struct rzg2l_cpg_info r9a08g045_cpg_info = {
 	.resets = r9a08g045_resets,
 	.num_resets = R9A08G045_VBAT_BRESETN + 1, /* Last reset ID + 1 */
 
-	/* Power domains */
-	.pm_domains = r9a08g045_pm_domains,
-	.num_pm_domains = ARRAY_SIZE(r9a08g045_pm_domains),
-
 	.has_clk_mon_regs = true,
 };
-- 
2.43.0


