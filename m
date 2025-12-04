Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A63D29F9C
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:15:58 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50872.1764872156936516531
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:15:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ZUOlzzLK;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47774d3536dso12489475e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872155; x=1765476955; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EK/hfxW+raa7tbjhJkkIkm1mmmU2BTvdkM6FrHMsRt8=;
        b=ZUOlzzLK3VTK1n0fz/89OAAyDElMTNm/RBj9wgUrImoxQ3QOdyAXe5RTn5ui5Z/oJU
         ysbdSxyHGW0pzA/nK7Tvz/9UBGTPjRrheVnWEEzEURzaChz4HALfuLq0WCYSe0d2jtN/
         YN1SoQuFf31eMi/oMYpXuLs0/sUqIsCabZVW3MSlKiQv1Z1y025s1fm6RtYYFK/mV5Ua
         1zDrjpnTvLOFOM1weC8pYBIiyHE3x5yrO7Rpcy9gG3kdBjg9C5RRvS1W46ei2hvI0e91
         JJi47FcjKFjrQMluB3PLNq9h/3QfxrYnihOU5Y7LaVKHg4VwRvCrv9VRHnZuLdzyueCY
         Ns2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872155; x=1765476955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EK/hfxW+raa7tbjhJkkIkm1mmmU2BTvdkM6FrHMsRt8=;
        b=RGGZGl90OSLzMM8FIJIN9qge2QlrqjclMHTmdxTehv6rUvVzbbOkYS8Asn1LuM9APi
         acNWd9Ce3YBoDF80zvSC1w+Z/BsmYiB4oXNVfBSUr8LfzqAp8D+ePSLzaUlA4bMSIYUI
         oq8zTD1rLNPT5ag9LsQwgiZUdA44yT+yceZM26s2nOSIe1fbAp530IKfU7CtgPSeOK8F
         +4qxr442wF05GxfahbqWqH2LWXO/9h3+64R56LITO5nACcpFjb2SsJDfatoA5MBOkLDW
         Xa7VNViPShosw+mM5JAMsaSNWlvd4sc9DQ7O79rzFj5qy91wt/VrUO+MRCEoPbzdcI9d
         eFTw==
X-Forwarded-Encrypted: i=1; AJvYcCW78N6GyhovJ5WuxttvqD6BShNfsZJAeFdCF/UAlfKYRPuUNP4Ohx/+wxphArOedRblTyZZmCVU@lists.cip-project.org
X-Gm-Message-State: AOJu0Yx9PeuNsjgVnq3ufT8WuIvHKzAPdW2Q/lwkDzx4vZCvq+OW8lG/
	IRxODhvpF7ZPHA/kQVQV7XqwjUg5E2e6KcovY0fT1o+LC4k/JP7uRAjCeSOmYm/zP4kdjc1O8vH
	jvYLp
X-Gm-Gg: ASbGncsZrwxz+ouRRQTeCOftAmeb/+ekOpLceDmlkUTyXaaLRhPndTKNAwiKLrqoBwG
	uHUr4ZZxTcU9BvD59c5SkeDVTh7C3LkqkCEXhxU7rKooosyMLqofE+FADyUblj8k06AMJbIEiMj
	dJSCIu6zeLWTaV2JOe3S0KW+OUD9YtkXt2HIADtM1vOBLIG1qTeFgnA0DEP7VYtYv25Ml28YzDL
	u3KQWENsLbtUOeuOOXdsdCUjkrm0Mt3Of7gKYAMkrOJolZ55auSw8E8OL3BGbDIKIfvJOBjQWXS
	iTWKTuN52XRs3eA5kRKyunh8MSQ3Ws2PxAtaCssgl+sFgWe4zsT6ltoErl/MDSMvVoyvzXjs9QM
	eOYtssjB3lo3Znw4LkVTWGn2+z5Wg0WEA67KL48T5jW6pTz97ZEt7bH3+RmLKnlcfVljCFcYtGt
	xD+jQhdUN48HCzMRtpeGOFJt/gYtiwXbMPX2dP4lMO
X-Google-Smtp-Source: AGHT+IGQDYB0I9bfXrEVdrBOLnvqjm2Lg8dIWp9lV5uWxYtadyUjxjJuITrVGLWCF15h9HAhHl65bQ==
X-Received: by 2002:a05:600c:4691:b0:46f:a2ba:581f with SMTP id 5b1f17b1804b1-4792eb4cfcfmr49049555e9.16.1764872155255;
        Thu, 04 Dec 2025 10:15:55 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930f286f4sm42953625e9.0.2025.12.04.10.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:15:54 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 17/19] clk: renesas: r9a08g045: Add MSTOP for GPIO
Date: Thu,  4 Dec 2025 20:15:28 +0200
Message-ID: <20251204181530.689132-18-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:15:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20883

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


