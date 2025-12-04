Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5329DD29FAC
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:16:29 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50564.1764872185364407858
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:16:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=P8b9nJq0;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso13722025e9.3
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872184; x=1765476984; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGD0lmiReAU2/7lebyrJsn3VkN1sqRl8AyBtMHF7HHw=;
        b=P8b9nJq0P9vpnh0DpZI2mcz3HbUi2BGZ8lNKBO8fM33DcsqXim4AubUxrQcWOzSr1r
         KOMqW25kdRFbCUtLKUix2Xau+8Bv67JYbrBb+D1m+tM6mh8laRkOpyieavckfmzHzBe3
         ISUjc8ax/il+ANz0ge1/kEgHjeLxygrMDctDp/AnyF7MMdAp8wh3tFfwTYUxXHWJDORS
         jh5pIn6jRF9w4HYl29BGZ54CDaMt0ESJMs62fGucakueNXJGazMaWCsXWkwWqlipCEWf
         +bHE17id4Ce560PJIqDAntmIaFQupxQa1GHef1KlUKL66nFFu3ddBb/LU8DzlIh6vi13
         FfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872184; x=1765476984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aGD0lmiReAU2/7lebyrJsn3VkN1sqRl8AyBtMHF7HHw=;
        b=bdxwbEasYTmq9IsALSYbEEy7KOMdDsH7jz++wtTI1m5ZKU9gEFRFWupJHCC2Yq8JVf
         En7SesbjQ5793tZo6cnoAPW8ptvzfhIvbQstGJaE6Xh9bLGfKrk+EGKGv2kIIczlT1ew
         jJ6E/9zNHzPiuyDUDe6WVH2jBDHWOO5XF7Ya7K7r4MDzr8xKZ+mgnwWyP8M7XxZ7qmIc
         ZOEaAw/6d3AllbybRJH5LpHaX3JPrFElNHswPWh3b5U68UvSFmoz6MwNjTzzgpJyRhyJ
         ptV631qKc985qwKqiQkzPDJ65j2A/42vsumSmnbtug8GObCtxArrPLbxqm94i32s9qHa
         K2GA==
X-Forwarded-Encrypted: i=1; AJvYcCWYsm1faYIOVK9rNT7HpnFubHPkojjJh4aILnFY/YJZH8CIC5ldkwXJQMeOJt+z9SJLWhFT0uTC@lists.cip-project.org
X-Gm-Message-State: AOJu0YzlIRi6gIsHAOk8rWxsl6kj+A21gHEGFouUv5b5FJn78P/s4MTa
	z9+yDNtyo6CN0RMoSfiHE2V0tbgf0NE6mf1ux8vRT+KkGSKKoXb5nkLpzxP8C6nW0x8=
X-Gm-Gg: ASbGnct8uo3U2H2AyLc7id6b0HEySK4w0uT3XOXhNvmfz8M/MFZy/l4okl5ImR4EoMv
	wIdNGGCczHb1UhGgnxc/6qcvKBDilCgmgmH9eS6ivvCcSacfhwTIFQjI2dFWoRTD5rkxXag77Wb
	q//A3feZ304JDPYob8PETdQFF5LCN5++IM/37avYviRGVZ4793MfJF11DnLhPzo9fyuC/+W2vD6
	3APKpjgPcYKEI8IVy+ApNDXOOyHRL3Ai1bNwQsxOJdvevY8VWWhBrd80ICOtYKsej79PJYhcd2y
	4rmmW7f9vf1/g001rJvV19BdVxfUIPZvyIAOSlVfSpOGMpdMU5dYNNwAIEWE+muZ1GSTuBRnQLI
	+AFpKGdweBpEAcwo6ImGBDr63mSL9YEgKJwLWh+YIQAl9SaWhSkB6CnTo2Ooi6t56JSNrxJ3swQ
	cIONWXldG36OjNATTUqiDHoHOS1fIHdcpJN9BoKUJoshwlOkvHXe8=
X-Google-Smtp-Source: AGHT+IGQ5reKCLP1kpbytGX0noSZHE9Krx24TtKJ+bUALEAC0LqED0tmMs96Rj3kyJLLjx6R5ujZsA==
X-Received: by 2002:a05:600c:6610:b0:46f:b327:ecfb with SMTP id 5b1f17b1804b1-4792aeeb50cmr59930045e9.9.1764872183767;
        Thu, 04 Dec 2025 10:16:23 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d353f75sm4665971f8f.42.2025.12.04.10.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:16:23 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v2 17/19] clk: renesas: r9a08g045: Add MSTOP for GPIO
Date: Thu,  4 Dec 2025 20:15:58 +0200
Message-ID: <20251204181600.689203-18-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:16:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20903

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit f0cb3463d0244765ab66792a88dc5e2152c130e1 upstream.

The GPIO module also supports MSTOP. Add it in the description of the gpio
clock.

Fixes: c49695952746 ("clk: renesas: r9a08g045: Drop power domain instantiation")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250806092129.621194-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index c1365385d61a..c2fe31bcf7b5 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -283,7 +283,8 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 					MSTOP(BUS_MCPU2, BIT(5))),
 	DEF_MOD("scif5_clk_pck",	R9A08G045_SCIF5_CLK_PCK, R9A08G045_CLK_P0, 0x584, 5,
 					MSTOP(BUS_MCPU3, BIT(4))),
-	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0, 0),
+	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0,
+					MSTOP(BUS_PERI_CPU, BIT(6))),
 	DEF_MOD("adc_adclk",		R9A08G045_ADC_ADCLK, R9A08G045_CLK_TSU, 0x5a8, 0,
 					MSTOP(BUS_MCPU2, BIT(14))),
 	DEF_MOD("adc_pclk",		R9A08G045_ADC_PCLK, R9A08G045_CLK_TSU, 0x5a8, 1,
-- 
2.43.0


