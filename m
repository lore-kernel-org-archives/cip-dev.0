Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839D4CCFA1C
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:24 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10017.1762416679973724274
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Wf400g3a;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429cf861327so516329f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416678; x=1763021478; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGD0lmiReAU2/7lebyrJsn3VkN1sqRl8AyBtMHF7HHw=;
        b=Wf400g3ayaq0R5vev/ilkoSgQoKaxlNZwtUsStIaohkzutwTFALyyoUg3DL4SCOonr
         eEVMmFeen3KNlq15rqbjEzIEUzz5kl9HapwR+eUhmMKgNl9MHYUSzDJZCDUKrR5TvwZr
         jOjQewdXYuXA3vhizspMsMQNayAY9aWjAtHJOv9a4lOq68giMoLjS13avhqjHaRh2lwx
         W0a4VHTOdnu36J+Za0IlzQ48k1VtL/weikHE+tBsbD3v07XkFi97TZpnNN/C0f4hyAJm
         Is2uR1kopp3YL5ZN/RST4KmHoSre0rSfusJnkB5e0ObWYK9tCPeE5iE1PoF71Bkp4ukL
         R9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416678; x=1763021478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGD0lmiReAU2/7lebyrJsn3VkN1sqRl8AyBtMHF7HHw=;
        b=J717xCtdsx5B1F9l28KNlyX1BNfc6AnVCaUsaUX6mlHVhjIkr8U6VzFMhGcwZ/Z0dI
         8ZILwURDOIYTM60WvZl+L7N7960AwduBp0PEI0DWILVMSul6RKpD43emXGzWzuoNogQi
         loA/ZDqxonnpgRfSTkmBVG87//dMIaJ5QAQYNZGn+6Ch5KFAhgnbEJIW9Kh8Mk8Rt3cc
         azejlFT270PElc4K96yyTP++mFAF+R5Z69I1fVsYipdf8jhHkTZNTzWGZvgAzkL5JmpK
         tNC4Ia5Boqe6tKQvR2Ud86l6cgpiIsdsITqYWagqFItnkzEcoAdEuRVbi26/5x8vtQ4R
         DH1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8IPgjuZYoPSfBhijESZNv2SGId52UqFj+8Z9O0lPZgzO9/69sTpc30P6d92hMZF3c2cCcZpcU@lists.cip-project.org
X-Gm-Message-State: AOJu0YzXK/OdYnsCVeAZnJQnxc0PB2YNXyfTvdGngzkjPCX9n70t0f6j
	ma9vuH1RIsHVJER+PVyw7VNArFlBJGKErmM+czyyA5CAyBlW7tck19twD6m4atbkZUk=
X-Gm-Gg: ASbGncviqKnqGX4ms657zB700tcS+Mg7JfwGzQPVX1x7oG91PC0ftzjg0cdtYEHy81K
	DrHetigt9dVmZmPlocr0s7ekLl4T9DjkWBuVTyfHcyotoabk4LNlBrHAt0Rqlj4hNAqKzTroRJv
	9iBl981H2bAx6gr5tm0/jQl3dIwwAuzw5O1tb8Jdv8G9DN41mmi6J5pxe93vggCQsFGSHgjXKOY
	qd5FUDqLkuCfv4mT+MO+D9iBh60W/4rZUhXVbEESfvAzuJSh0kmSsY5RiVXA+griWi4pgB9gcsl
	GjwJE0F3uUzSM3M3ZLeFKb0ulCJ6lcglGpioCZeek814jJP3UiQuo9Z5HiQ/zwjejA2xZtZIH86
	1nKcwhyyDqoru8UG0HY73Lk0UkmxcoU4GawH3v1XNpilbbj6AF3xHGhaLYBX/AvAKQgB3olY40D
	YiQjCm1Dpa4ygIJdGC++wO+nCKs9Crog==
X-Google-Smtp-Source: AGHT+IFDA+ppcuLJ4a9P8Ihh3LWlFzTMsnjA/jf2Tff3FB0wqizpUr+QHJD3m/v11EH3mYyuni315w==
X-Received: by 2002:a05:6000:646:b0:425:7406:d298 with SMTP id ffacd0b85a97d-429e32dd8a7mr4672455f8f.5.1762416678365;
        Thu, 06 Nov 2025 00:11:18 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb47873dsm3486735f8f.31.2025.11.06.00.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:17 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 20/23] clk: renesas: r9a08g045: Add MSTOP for GPIO
Date: Thu,  6 Nov 2025 10:10:45 +0200
Message-ID: <20251106081048.2574345-21-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20389

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


