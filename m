Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAB9C71135
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:15:09 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web10.7048.1749809705671786533
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=lKnVex3L;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad1b94382b8so354206466b.0
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809704; x=1750414504; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjfCpIVovp7G/dAcAxi2sdE49DmY03tav6ed1o125r4=;
        b=lKnVex3LXeiu9RxK2IzWMiRedDZk+kh7UKeJkA0AN61FheXvH99O8NV+EjipblNe7a
         I5upgJ0DmrDsSlaTErhoosPwX6NUp3MCz2QFonQsA/Tq5VwnE2p86acTf77tXIulXkhG
         uCbpw86xZJYISa1SbO1DCHxlUrqKECww1XRhbPQymnhxSg2uhKqLnXAaqDst3Tw/AOhZ
         Og0rHj1Hyw6iLe8ZlgyNT4hZuN5faOzSMxSqGtCnw7+FvrbdbhSpE/JIto+RFnbdtW5J
         o/rRFt2Uin/9C1KcAdWqm1qE5G4qeV+0CTIEVp7rJUufTKfZsxsqhRRfc8VAF2jFBgbi
         PpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809704; x=1750414504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjfCpIVovp7G/dAcAxi2sdE49DmY03tav6ed1o125r4=;
        b=Z+vh84tw6wWTvx/u2kZ1t8Ked9URIY4tuHnvRdJCzzvTLGoGY4LvLCbJkHqQZyecpQ
         e7DrSs7/5K0/Y58VMR0vbPBvpNOQswDe6vdmOZY5Y2Ke2+veEedifmPhbvnWbq4CEoKZ
         u+RWeeeoLzG0cJyb98avrumXH/di5AWpGlprB56z67rcu04LEh67yP67xTpE+eE0m64W
         RRFVpSevgOgwWBaMKAf7tELRt1pVQqddtR4VFfkFCw4JSxlr8QFv/Ghf5YsK5ug0SZZ9
         g1/QyXoYm0RqObVgXr/Gs/yUxEOkeKjggmYJzfLa8NGg4ksrkfdXwkovUN4nY37swvPl
         +2fA==
X-Forwarded-Encrypted: i=1; AJvYcCUg69+uvRUBauvjwep56ClLNjWbVdHYoVg2CxG0T+KVs8sGkpQ1ixphnzX28IyzQ8FOyXhsmn7W@lists.cip-project.org
X-Gm-Message-State: AOJu0YxUbA6mN66dYXjmvw4SQ3dbQsiOM4bc9R4xSd1WzVebRzgUD1Ye
	za/WtYYCfh024kZW8yVmKEaefviwvUHqJ5k5EPZoABVapUXBg+obWctHHQRfGRWFTDg=
X-Gm-Gg: ASbGncvvq8qaEcd/FztALkfTw6ZNykis8ebPaFyCbwWbu9pXYxg388Mz4JWCN6nb6rZ
	hTBjFwBtixc9wMRZ1OFanqUS7uSd4GQ9Zroy8ArSmqELKRhPHOBONy3RzMxavx4AFVUG8L7ciFI
	OF5qDUAsyFCbTKybc+VaYOXGdCqC5gorfPq3sJO5nMlMB4QgIuVj6hzPpYicWZsWXTRa68w5QEo
	K/gH0M0RabrnHyvsUlCIFGawbZBhj7sSTdBTwQ9u4Ui/8FvfeDZG+C4cPKviv+JQryuoOSusVg6
	7B72tms+8G4BMnoezkI9BYPATe1ZBSpOmjBeG/bsTw/NwisAePnwDHavGZw4d6P7YPYp0KNmy1H
	GaMc23RfwswOLRZTQ
X-Google-Smtp-Source: AGHT+IGkIXAaG4zjWp5UVA8QYSt1hD/OxJHnnHiqlNE4tcBwt7ofTvp3y7+2jv2ROWjcNhzYYpNN+g==
X-Received: by 2002:a17:907:7f28:b0:ad8:a9fc:8146 with SMTP id a640c23a62f3a-adec56a068bmr220312166b.44.1749809703923;
        Fri, 13 Jun 2025 03:15:03 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8159377sm105101466b.9.2025.06.13.03.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:03 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 01/12] clk: renesas: r9a08g045: Add clocks, resets and power domain support for the ADC IP
Date: Fri, 13 Jun 2025 13:14:50 +0300
Message-ID: <20250613101501.262091-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:15:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19042

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit f962745289958e89bf520407728e384e52ea8e27 upstream.

Add clocks, resets and power domains for ADC IP available on the Renesas
RZ/G3S SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/20241206111337.726244-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: drop the power domain description array as the core code
 is not available in v6.1]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 7f96b615f087..89d6f361a5d3 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -186,6 +186,7 @@ static const struct cpg_core_clk r9a08g045_core_clks[] __initconst = {
 	DEF_FIXED("OSC", R9A08G045_OSCCLK, CLK_EXTAL, 1, 1),
 	DEF_FIXED("OSC2", R9A08G045_OSCCLK2, CLK_EXTAL, 1, 3),
 	DEF_FIXED("HP", R9A08G045_CLK_HP, CLK_PLL6, 1, 2),
+	DEF_FIXED("TSU", R9A08G045_CLK_TSU, CLK_PLL2_DIV2, 1, 8),
 };
 
 static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
@@ -233,6 +234,8 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("scif4_clk_pck",	R9A08G045_SCIF4_CLK_PCK, R9A08G045_CLK_P0, 0x584, 4),
 	DEF_MOD("scif5_clk_pck",	R9A08G045_SCIF5_CLK_PCK, R9A08G045_CLK_P0, 0x584, 5),
 	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0),
+	DEF_MOD("adc_adclk",		R9A08G045_ADC_ADCLK, R9A08G045_CLK_TSU, 0x5a8, 0),
+	DEF_MOD("adc_pclk",		R9A08G045_ADC_PCLK, R9A08G045_CLK_TSU, 0x5a8, 1),
 	DEF_MOD("vbat_bclk",		R9A08G045_VBAT_BCLK, R9A08G045_OSCCLK, 0x614, 0),
 };
 
@@ -265,6 +268,8 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_GPIO_RSTN, 0x898, 0),
 	DEF_RST(R9A08G045_GPIO_PORT_RESETN, 0x898, 1),
 	DEF_RST(R9A08G045_GPIO_SPARE_RESETN, 0x898, 2),
+	DEF_RST(R9A08G045_ADC_PRESETN, 0x8a8, 0),
+	DEF_RST(R9A08G045_ADC_ADRST_N, 0x8a8, 1),
 	DEF_RST(R9A08G045_VBAT_BRESETN, 0x914, 0),
 };
 
-- 
2.43.0


