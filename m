Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92534D24477
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:14:48 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50491.1764872079423445319
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:14:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=a999T6Gs;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42e2d5e119fso594212f8f.2
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872078; x=1765476878; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EK/hfxW+raa7tbjhJkkIkm1mmmU2BTvdkM6FrHMsRt8=;
        b=a999T6GsBXgc2N2tAjBckzyf/d2p/8NNCAu+uKfXyu+nPHf3lMXWbppFHxkZYYxDZf
         nucIUXQLLZqDL8oknfOFI1S57RYObpRZMA4bn1k9hle6o/XGgaOZeQG6d5Bvhx56EvcZ
         aR08IqucUK5sIy4IN+MqHLoXtipsBZYf4s8f03Xqp+ZbG/VH8CpA2P3sYm66oOh3+mDJ
         6D7QO5D2tdXBzLC/9B+HzOAyl+BrpeimTR3v38d6l8VIX/Muei/etSXChEA9b9z1a3Yx
         5eo3KoeE6T+HCl97lKvCQVnD88aE2luSr0Disc0/ZTZdDCqZYYKBsnPwhGC9XAwU7D8+
         fVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872078; x=1765476878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EK/hfxW+raa7tbjhJkkIkm1mmmU2BTvdkM6FrHMsRt8=;
        b=TxHak18jz2WXfmlHZXpZuuAFlKCXEIu7G/IL62q+YabhsdgogwsktbJrT7VLEX0yf9
         TGwP+d6a4FUS6V765k1ZF5Kkx9/XqrJ36WucjrDJ+zd75jrbGMyTPhh5BjBmiQ8E6JZG
         2yqPxWU2rg1jN49kJ0muIYO6L7Xl9moaonMgpUSuNLj4sgsQMKF/Lz4FDkPfo3VW9ZHc
         tb1qoJPLgNiaVx3zuTdOGYYWMVMYrqwJGjCyMmoKL2XmC+itssL/AP1cwBHQuQN9uhjk
         JsurRQyMjbc62AQbJUBmWg29Jjr6Vok55/yIxFz9twCEkb6Gu/VF8L86SqwERDElCBMr
         +PEg==
X-Forwarded-Encrypted: i=1; AJvYcCUFjMDTvJAOfUTGfy5aiWkTgUPJ7eZUdjC26UvaQhLmJiQ/WymmkTkNQA8c+auLBkqUfKoXVoYk@lists.cip-project.org
X-Gm-Message-State: AOJu0Yx92PNVSdkPM+72vOr8sGcAF4gszZaNXTTlR6rmE3j/vb2xqdT2
	ZR6DZYiMN7oDxHdzWViYGwSDuuwgzTjst356Gfo3Z0C9bVhv6ugXIk9gKbGump0h7o8=
X-Gm-Gg: ASbGncvPUyiuN1ZDjsFWkRUnniE86/vcK1kN008yET/49a1vyMBuN72YXpoRhoFfbbG
	Llta7pMMIa8FE6pNwFjTcDCkr0H8GwffaDglCoYrQF2OYXErnJBoL+/7IokZruwlfgljmI0RMJB
	tWpEGy0x+ULs4YdydaKbD50nh30xpfEO/r804NU5ps+54hFS3j3PRaygwopHuDadyctxAlNd5AV
	JWs48DpNCbkEoUhaAuTka5VOTrvYSPkY8cpkEuNvGcv0p3p3YI3Va/VVmyRBdBiFIc/ZduU1cCd
	zpfuWAHyJ7iUlUx+YRmJpFbTXQKFUCH4dOkq09rkgHuv/+k+T+q1JCbrjHtIbNt3g6USh5ueGFR
	h6abwHsE+k77A5MmaAtG33H6xoCt4mzwnA5D3X1/0O7ReaqJMH71Ag1yk3YouOztYYwoQkWGiLs
	VmOxjDi2iA6GXxcbH8rKwwMsLaJr4r9F9Ps5quTnenF2OMqNaH1i8=
X-Google-Smtp-Source: AGHT+IGp34vTWnP4/4zikj5dSn67Rdqg3Htc+T4ccN7g5ayZcBZ1s8THyHIK5Hau/ehWu1nDHP/Dtg==
X-Received: by 2002:a05:6000:428a:b0:42b:2f79:755e with SMTP id ffacd0b85a97d-42f7319051fmr7226660f8f.3.1764872077805;
        Thu, 04 Dec 2025 10:14:37 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cc090bdsm4381629f8f.19.2025.12.04.10.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:14:37 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v2 16/18] clk: renesas: r9a08g045: Add MSTOP for GPIO
Date: Thu,  4 Dec 2025 20:14:13 +0200
Message-ID: <20251204181415.689009-17-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:14:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20863

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
index 6d7295c36d5a..69b027f52506 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -274,7 +274,8 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
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


