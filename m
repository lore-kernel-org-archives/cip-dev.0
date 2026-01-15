Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB478D33A2F
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:35:31 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31306.1768466125623728946
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:35:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=q4O6VT6k;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64b608ffca7so911902a12.3
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466124; x=1769070924; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UZDzTLg9Hz8uCyVMpSggu9xCGMUjOf2ILiCl/UZzD0=;
        b=q4O6VT6km5MV1NAA1w6BjZxUpVnZnqCxoIOT30xIN56BkCpABAcU7x2Ih64EadSz/C
         SFzM4f70dukejlxaSZ6QU/r9XZrXBHQLlL5Et7DPzNWDdIxJpxbYqFSdFgN0ELedNx3p
         tLf/rhSUTbasWALBPb8FKi/0+G9TsYFzdUV+REtPJQLdn1ftz9DKtuH5w89FAIaxS62A
         xOAxGwLGToI0WVC+1WVSmPOAT47Y0vP56B59BVqfs3bXUMAZCBnwp2/k346dK4fNwOjB
         zWSAyNnerNWaE37miK03WefrIZ/HLqyeKVuNutimrrltXDCdyDCaeCCJ6XdHKPHE6YCN
         CiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466124; x=1769070924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2UZDzTLg9Hz8uCyVMpSggu9xCGMUjOf2ILiCl/UZzD0=;
        b=E+GKssdoznDbGZL74pdRqf21A69MV8CAuR5VeOy0pvh9VUEsvnfmERIynGKxKorI2X
         zSpmpN2+yT47dzBx2WU4RsWHd3ZyWgZzodZVtvUXyA/w2cKhxoUilf4wd3yzpW/NKghB
         pptQEUnbYhvh3/M+oYPQ1qR018cTRhqxmG4yU7HXX0mnJgGENCNKDVYQs93bPNnhqBLA
         jFoweHizjoPw+BZEbX3ndAGRzx5UBOmmNz2YgK9ckrzRWMf+Jwa8nCQagsJLvZkXhhpR
         7hfGVOaoLEGXcBPgebenglKoiN3U7EFVcHX7HDR+t1vP/w32BQJerdyKYW96mhedtGmP
         AKWg==
X-Gm-Message-State: AOJu0YyIdvSuvrvBwB1XgHopl9Xs763KK9WfaMPNUzFh7hv/qLbu26YJ
	1/AneqSf0BOM76WZWI+igyOl3RjhmLPIglP2dc5adxaW7kft2zQBbRSA/d5kqT7mXcg=
X-Gm-Gg: AY/fxX6STIGv1odmfd3ebmqqi8ZQ4iAG+GdbrmJMebgzlO0ukjfpEXYDCmtW1w99hEG
	EQhotfHFYhmTU70bxD2WPvVSMuzhoIK9HPlncZ2hd9zrj3O0JBwDDXpZaazVX7Etj23NCKGn2cK
	zhWAhd9PQ8+mfFxMYktu4O8UghjsWMtqAuu2aY7o2g7ECdw23DggUtwXCJ8S73o1yYnKzJPzHLh
	lZjvkGKDHtTk7otZorIEsIo1vlRBvV7Stdnge1RJ3iLf3jnoWdwjb3/kKPkthdBNCC01MZOQrAO
	N1qBfqM9gMcr3BnZnbPu9YItUJcG5KDbzXxY6qjLcJV373Clx1t4YQkuOBth6Di6v/kQDpUq5ta
	1jLKzL7AjA7cynFx0PqEs4FF2Xek/o5wFjaSx/n5rObyVU/Pnrqn+LCRyo37P9ZyMUIwDUUx8iA
	dFNU2zGqfJ69T6Nxbe9P9wHT+mwXCZnjQ8XDQ7q0HUkEl+1LZE3xzdBrnW0LhNOyiJcw==
X-Received: by 2002:aa7:cb84:0:b0:653:e85b:76de with SMTP id 4fb4d7f45d1cf-653ec462b91mr3436310a12.26.1768466124011;
        Thu, 15 Jan 2026 00:35:24 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411f70f66sm1915660a12.19.2026.01.15.00.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:35:23 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v3 17/19] clk: renesas: r9a08g045: Add MSTOP for GPIO
Date: Thu, 15 Jan 2026 10:34:49 +0200
Message-ID: <20260115083451.1064048-18-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:35:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21597

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
index 87c79df6406b..c3b64f94e188 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -275,7 +275,8 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
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


