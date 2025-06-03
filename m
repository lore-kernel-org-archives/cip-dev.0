Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794C3C61DB2
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:20:17 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web10.6997.1748942410457859810
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:20:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=S72X7Ysl;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad883afdf0cso1020460666b.0
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942409; x=1749547209; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrGN8NBWDM4xuwsVHmicnKnIvM4AZqMWDBS5VF60a6c=;
        b=S72X7Ysls3QDZHBNAA5hKfetz6yn7oOW8miJi2wa0ohmu51sStlTMwJwoJ/+mY2qUo
         b6ub+VO5NSpoz2QokvTwiOiCoSRqNYrjams9IAqlrOiF4MEdTMSFUFTJ9CNQeIVPjMAL
         gHyrrr5ygnfQBI7AX1wGZNfVnpIRGNY8gUDEHe/jJtdPIAiyd2KS8vwavQArhxKiHUhW
         T9kW02p+1F8FP5WUYTKmpW49hd3bM+gdP0Og4UC4Nre6c/AqnkD4e1No/5lYGDJ2DG/K
         8/bSSgMtBpjx5mq41VUgqLDdA80AxD3f+AkfkSsbPbdzHhc0kRfohk5AAXsnVgHGPj0t
         qGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942409; x=1749547209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrGN8NBWDM4xuwsVHmicnKnIvM4AZqMWDBS5VF60a6c=;
        b=Nu60Hyya1ucJxqAOusrRfRDA9YrMayId8NNFA2m3dw44J3mDh2korULV1W2Snglhgh
         Y1934O9jK5D0HN4dIkvLRbildoYJ6O1FVZjsr3V0XJFueDFcwE2ApC0GRrvnFwNpQYKL
         Rm1zy7Sxjwi0XF7QNhyRFxclzy3bu69UNzhRJaQpKBHaHea2RQo5wW1IeACqdQ2M9Fd9
         5bm5iMfkFNad4OwQzF6G0HpSs8fNo6eRKz8J5fZ+8mLZlZkSO8q+Kl6mkcKLYhwY93wA
         qMfiX66htKs/d5ok/E7nDrIf8Nqm2urd9neG99OJ0oyrHJEBmWM0LT/G3+mZ85veU9rP
         aKOA==
X-Forwarded-Encrypted: i=1; AJvYcCX07Bk2LuSCzzyw5SFaMNwXzS8jG6PYEklTUEdwfYI/rpMxQn/76ArmIgsNQWr4ZmoUM0+bcv+E@lists.cip-project.org
X-Gm-Message-State: AOJu0YwuFaEFMyIpVwBtGM6UNlu7TVOqyYKHm2mW7HaAdOS5s/zruNiB
	Jpz6Qlv9SXO7QFgjtpLZu8ktu4tcV1mjwfsj1O+/7tynwkeWPCh5e67vzFZr0YrG6Bc=
X-Gm-Gg: ASbGncs41kpUwwZfquWMA00uyzuLNWEHCllLQ5a9ET2Wqq1fUSuiq4qhCPDfFeAHzJU
	kEkLKeqxbRf1x2N6c83BfoKoMYmi/X8CNXQN7bHddHLC381z41+H2jIyjnO+K7Z4i1UqOAtoLDu
	glTvTTj6gEJDxPkvevqPfRbCRgyGKazcFY3zYY41XnRr20WaS2vvO1UjnsZR4ujoYLIdCyoxF/X
	y9EB0SRrkO8D2X8E7f0sQ899qBKsBRydPEdJ2gMra1cTxCr3TQfVmRx/qVUkYU1IrhxbDk3AUmV
	rarUvm1ZqUIS3vuIsHEnIzhWyWgKKysKxIO5U5xlUXQjNNtVknE734/QvikTp9JzM4vaUxW1Hlp
	6pjjipqX2Mx1UgLGT
X-Google-Smtp-Source: AGHT+IHN2UMknOkKqnvqbmTUoK1ZeN3cLqQu1+yLao66XaUQPh4Ki3zQ49aiJKnjsTIlv/if43B39g==
X-Received: by 2002:a17:906:4794:b0:ad2:2dc9:e3d3 with SMTP id a640c23a62f3a-adb36c07b40mr1629134466b.57.1748942408696;
        Tue, 03 Jun 2025 02:20:08 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adb2e220548sm817017266b.109.2025.06.03.02.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:20:08 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 1/7] clk: renesas: r9a08g045: Add clock, reset and power domain for the remaining SCIFs
Date: Tue,  3 Jun 2025 12:19:59 +0300
Message-ID: <20250603092005.3917850-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603092005.3917850-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250603092005.3917850-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:20:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18984

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit b73435047ef74c82d6e82c333810eba0038f9cf7 upstream.

The Renesas RZ/G3S SoC has 6 SCIF interfaces.  SCIF0 is used as debug
console and is already enabled.  Add clock, reset and power domain
support for the remaining ones.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241115134401.3893008-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict by using RZG2L_PD_F_NONE instead of zero
 to describe the power domain flags]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 1610d4bf203f..70ad59f63d45 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -232,6 +232,11 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("i2c2_pclk",		R9A08G045_I2C2_PCLK, R9A08G045_CLK_P0, 0x580, 2),
 	DEF_MOD("i2c3_pclk",		R9A08G045_I2C3_PCLK, R9A08G045_CLK_P0, 0x580, 3),
 	DEF_MOD("scif0_clk_pck",	R9A08G045_SCIF0_CLK_PCK, R9A08G045_CLK_P0, 0x584, 0),
+	DEF_MOD("scif1_clk_pck",	R9A08G045_SCIF1_CLK_PCK, R9A08G045_CLK_P0, 0x584, 1),
+	DEF_MOD("scif2_clk_pck",	R9A08G045_SCIF2_CLK_PCK, R9A08G045_CLK_P0, 0x584, 2),
+	DEF_MOD("scif3_clk_pck",	R9A08G045_SCIF3_CLK_PCK, R9A08G045_CLK_P0, 0x584, 3),
+	DEF_MOD("scif4_clk_pck",	R9A08G045_SCIF4_CLK_PCK, R9A08G045_CLK_P0, 0x584, 4),
+	DEF_MOD("scif5_clk_pck",	R9A08G045_SCIF5_CLK_PCK, R9A08G045_CLK_P0, 0x584, 5),
 	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0),
 	DEF_MOD("vbat_bclk",		R9A08G045_VBAT_BCLK, R9A08G045_OSCCLK, 0x614, 0),
 };
@@ -261,6 +266,11 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_I2C2_MRST, 0x880, 2),
 	DEF_RST(R9A08G045_I2C3_MRST, 0x880, 3),
 	DEF_RST(R9A08G045_SCIF0_RST_SYSTEM_N, 0x884, 0),
+	DEF_RST(R9A08G045_SCIF1_RST_SYSTEM_N, 0x884, 1),
+	DEF_RST(R9A08G045_SCIF2_RST_SYSTEM_N, 0x884, 2),
+	DEF_RST(R9A08G045_SCIF3_RST_SYSTEM_N, 0x884, 3),
+	DEF_RST(R9A08G045_SCIF4_RST_SYSTEM_N, 0x884, 4),
+	DEF_RST(R9A08G045_SCIF5_RST_SYSTEM_N, 0x884, 5),
 	DEF_RST(R9A08G045_GPIO_RSTN, 0x898, 0),
 	DEF_RST(R9A08G045_GPIO_PORT_RESETN, 0x898, 1),
 	DEF_RST(R9A08G045_GPIO_SPARE_RESETN, 0x898, 2),
@@ -343,6 +353,21 @@ static const struct rzg2l_cpg_pm_domain_init_data r9a08g045_pm_domains[] = {
 	DEF_PD("scif0",		R9A08G045_PD_SCIF0,
 				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(1)),
 				RZG2L_PD_F_NONE),
+	DEF_PD("scif1",		R9A08G045_PD_SCIF1,
+				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(2)),
+				RZG2L_PD_F_NONE),
+	DEF_PD("scif2",		R9A08G045_PD_SCIF2,
+				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(3)),
+				RZG2L_PD_F_NONE),
+	DEF_PD("scif3",		R9A08G045_PD_SCIF3,
+				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(4)),
+				RZG2L_PD_F_NONE),
+	DEF_PD("scif4",		R9A08G045_PD_SCIF4,
+				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(5)),
+				RZG2L_PD_F_NONE),
+	DEF_PD("scif5",		R9A08G045_PD_SCIF5,
+				DEF_REG_CONF(CPG_BUS_MCPU3_MSTOP, BIT(4)),
+				RZG2L_PD_F_NONE),
 	DEF_PD("vbat",		R9A08G045_PD_VBAT,
 				DEF_REG_CONF(CPG_BUS_MCPU3_MSTOP, BIT(8)),
 				RZG2L_PD_F_ALWAYS_ON),
-- 
2.43.0


