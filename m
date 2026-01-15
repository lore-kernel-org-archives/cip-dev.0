Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95791D33A21
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:34:11 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31265.1768466044471986003
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:34:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=QoPGneF/;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b58553449so1053996a12.1
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466043; x=1769070843; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UZDzTLg9Hz8uCyVMpSggu9xCGMUjOf2ILiCl/UZzD0=;
        b=QoPGneF/M+lFxp7yGndRmmSD6UW25Lct14209XI8IwYur09t/vLnIcrwpyUqFIIpk5
         zi2nHBRdyZFNqAmUQqehjX/7+UJIL0iEX5jS1ac2BQ6Gf4YmsxjVkxZPr7crBd4HBnVb
         QiblhU9sikDqXTMeNr8bxnaV7/nJs8qrIHP2LmHgW7OASh8YE99S6uNNhq6qJHhEoUVx
         FvKxdRhXn411Owq+fkKEbenunHl5VoH7mADB9PnzUsh3MtTaxp5JMPywcOkNmhWPqN6S
         c6VKF/ijA1cO4rGkzNTaphNISCxffND5Y1633yIGMc1rkyUL811XPR25OtvPS1s8EmUL
         FXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466043; x=1769070843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2UZDzTLg9Hz8uCyVMpSggu9xCGMUjOf2ILiCl/UZzD0=;
        b=BG0c0uyfpuBxROvDqyoYHDt7jllN8rDrBUnmGGIDOlw0aqPb5mXVpPSEOsOUhsEf01
         wVEbfzThLmFfK67z4UNw4LZKCtS1HVd++sttDQrTb6glZ0EZdoUDaGHtKbafaSRer9T6
         avYGtdnetYQMwbeyrGfbvUUJ5fbttQzLGCG8LE6wXbOpph31n5C956T3KLGLK5S7/d2X
         lCj5GYcMhXI6N16dkfWBEfbwtcHnCBPEVAmANCQADbegIwGALzck2EkVjDgWZFbD+X9w
         P42E2AW3CKzPJQdoX3I92eR7PcNdbPSZM55QzHJxwIzM4IU/iY5yS9CQQrdRd5/iyyyy
         3LIA==
X-Gm-Message-State: AOJu0YwSG/GBJzPl4IzfB/unPDaG565ho4PvYBP+NcYZb+0U+w+0CvL6
	hj5cOGJ2YK9h8qsdjGfX29XOdfljgqag12ahQkfTWRSb/U9w8etdGdbDPwCEiigxDLlw8HpDZT0
	cz7vc
X-Gm-Gg: AY/fxX4H1td36H3E9h0a/pC2N+y7hkcnCUfQbICi6L+gEA9xtS3v2fHpSLh6MbvsCiV
	OienVhEWwvtVCWu94x9gGP+zKKNXZfsns4FEpU3CqhmMliyqdrvEcvNfJAwEq3Jrn5qnGypk52/
	/dY5xLgZC2l9wH69rIo3t6ZnEJYkeghCjV3X1lnJL7M+d4sIuTCjXlmv59dRinEB4c3e/jnVjA4
	+T3T3BlgK3Xw2UIkmeTv1wBT/Ak6up8ZMQ79jhRviiGy8RYBZVOLTF0We9lkJW2JcBi5NlCBjVN
	5o+ZTR9/N1emHfavmTlM3nlKY4kk4HqYhs/Xi370zDlGcPX3LVVWd1Jaqeqaj59LuHGhP/ixkK0
	F3PLwcAwo4w+f2Oo/gq0h6ltUGOEDITnYW+3LlSWfmI6pZke3jtZDftP+XcGIaKV50brm8pS5t2
	HjWpa9Nol610tLozCoJAvDZUfoUWAw/1G9VRQF4cP1SdUISPWwAaTy9yLIWdwNKtZwyg==
X-Received: by 2002:a17:907:d11:b0:b80:3738:2f11 with SMTP id a640c23a62f3a-b8760fe0630mr457647066b.13.1768466042899;
        Thu, 15 Jan 2026 00:34:02 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8731f0718asm833387066b.67.2026.01.15.00.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:34:02 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v3 16/18] clk: renesas: r9a08g045: Add MSTOP for GPIO
Date: Thu, 15 Jan 2026 10:33:30 +0200
Message-ID: <20260115083332.1063820-17-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:34:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21577

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


