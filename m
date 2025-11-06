Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A50CCFA03
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:55 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10114.1762416768460491175
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:12:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=V08WtpDh;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429b895458cso376873f8f.1
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416767; x=1763021567; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EK/hfxW+raa7tbjhJkkIkm1mmmU2BTvdkM6FrHMsRt8=;
        b=V08WtpDhahU2Cg3F82ms9yKrg2bVsqh94my4A7HsqoZ9d8WhbKSwOxKrMZDdNSNX9C
         ybAXTwH/MVAs/7Eo2V4Q6sdMcv6cF5+FtPTelk/vlQ9CBFdPkAwj+wAU7IgUPT1zOSE1
         InJ/oxfdgLzg4NSwAqDhDmDnsvXo1IA+dCUUEradgeEZp6bJ+dum6EfeOT/4W7begL2p
         +zbzTf/3XuhiPmiSwRPmjG1WRGYtst7HJUPl59HcmeOgjWDZSMUedP6lYXzaokb8CMSn
         rHgBrzXPL+OVD+tKSNdxkOWTZ6t6wLxUaFWMvMuo1sSKtRAJ4KdUrvN0P1OlNgppho57
         nWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416767; x=1763021567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EK/hfxW+raa7tbjhJkkIkm1mmmU2BTvdkM6FrHMsRt8=;
        b=ZX6YXylYp/MwSYQDLamq4zUB0fhuN8ZkEYCdWgJL4w65QltLeJV68JMIuTecvJqFHA
         pJKaKcHkX2dy3n81Q7r8dnzRW33xEibFFqrpr96lgNcin7sujLOs+HX7/j7ttvpRpYL5
         LotskV/WUDxNBVi7292jbTy9udM4s4MwGqeKA9RDciFSJGN1p/NfkHCmVyxXp7+Umh0q
         HcQYt6SaytsDgWUhhnn7SJy7KxN60T1hG3Doi03JUUK0XTMBXzuLRFpq8cKJFclb07v/
         gW4Hzxll8DbFE3W6Xh6Okf1J21//d0QjQomBrJIzAdTHKCyXEdFV3b9zcYiIM+OHDOae
         8ngA==
X-Forwarded-Encrypted: i=1; AJvYcCVuUGGT2eB2GNbOJvRDwbV7OTxMy4OwhZfx44LvNA59an4S+TLCcuRX5dwBVd+25NjdJXUli17P@lists.cip-project.org
X-Gm-Message-State: AOJu0YzkS6GeHXcZCNdCrOxride+/HzuHxd9u7uo/CZlBsuT19G8XR5L
	cFF743dPRaAxT5M4GswkeU07oIOupWUQVMKixNzQO0N++bkNEcF3OHG6JJ5fJkwVXXw=
X-Gm-Gg: ASbGncsp+52Q4GAS9/Xgh7KAxJ+EI8hkmd6k3PePRYSgc5M+2THgPnsLBMxX4lb3NLY
	Lr+0LRNlfsdiuTvkzQBvxyK9qQCvKfk14owStJceyb4JoQPlJ3k0bzTyW/lWK7Zu4xevUaZLwa/
	8hl30odIfoannKjoypYS4z2LpBx/0L/ro8yZsPGwbWhAv4boXMj1agTTz/ZHDlvXPswWZI1X/Pe
	b3ivXHsT/8ncwu9zb9BUbAaS5oh6YAaHgHjTGSXfRmsFwfUVWXuX/rPlfSNHLj32AhwlaD3r98e
	NOa/dfURkAzvZxfxw618TbmkC1XpO0hKRKMOKvM1JPPVbjzb1L8jCGrMYvhN9GnmdMIqgs6xN5u
	OuCYbkzy7/6rWEvdrxIPFCZ/YTxvvVlleKqvoV2A7eiGtPQJ3XmUcVy2VvJfapO4zk3nRn6v48e
	d3fG8VRkHnaZajpGFZkJI1sm134NQiWQ==
X-Google-Smtp-Source: AGHT+IFikqoVNwfCk1vt5q3k91J8UXjyoPUv4+WZSm4+tptO0K3EiU+pec3hTpb3YwfvyJQ2198+jg==
X-Received: by 2002:a05:6000:1acb:b0:429:ca7f:8d73 with SMTP id ffacd0b85a97d-429e32e4732mr5726563f8f.26.1762416766905;
        Thu, 06 Nov 2025 00:12:46 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eceaed27sm2486647f8f.27.2025.11.06.00.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:12:45 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 19/22] clk: renesas: r9a08g045: Add MSTOP for GPIO
Date: Thu,  6 Nov 2025 10:12:15 +0200
Message-ID: <20251106081218.2574950-20-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20436

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


