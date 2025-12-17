Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929F9D6553E
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 10:32:25 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11760.1765967536439196235
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 02:32:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ZWdmX6wE;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b72b495aa81so983035466b.2
        for <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 02:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765967535; x=1766572335; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9P4ibVN4zr/jdWt2fgG0nwwoBCfeeHETpxlhpmrgLE=;
        b=ZWdmX6wE+WLTaFg88HzS9H4/PHNzxiWlGzH4Ex5u2nPeELcnQGCFqDmIDxxNdxXZJu
         gbfjAdfbtqUFocmdoN51uSJQAD0Ym4sECux9QzHV0jP4FQh3LAaWNryBH637Z09C9ctM
         ziS4QZn0YfR/6fcUwuwePW3HmYun+tiMeZ/Ra92xsIzST/dEFoDj2C5d3yWYaakNZCtc
         TZtvqgxXuvcKk1AfPzAlIQbEQIzCDJYpvFseEaI9/VynVRxuOz7Kmr0fo3izSr7Mcr6s
         rftsbXHVRq7uQZohZo+cPGkt8SxtDvWea67gNSsJ6bATf4esDLSDqJMslX09F2b/kvsX
         4e9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765967535; x=1766572335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q9P4ibVN4zr/jdWt2fgG0nwwoBCfeeHETpxlhpmrgLE=;
        b=RS0RNx/HaDXVjpsr+7Wiqj7vPgqjHhMOc9dUdgxhH7En9SkIrXUhTtqh8a6J3lq1XW
         Pu42pF4hqMF5zHno+3wF6ELj3QWSWMkIxAFpW4hUK37ZG8cG2AFT4EvxeT8kRXPAKPIH
         dIoShhT0tMDVKnYnFrVfOg4nqs8Pc8O9irhrlUgvO22pAXMWinIWANcD90Ut6jPJcZig
         4ELDZ3XF1H8FFrNNgfbsMkvzGrnRbBIO1CTfd4Xj/auptPGSfRXhX3nRjvsdh8PUIxhr
         07zJVMU4lOVxUro/5EIe/KJyTey2Sv8rr7PdHosC0Mq/to+qMxKsN8RCOMaRsq6HBQ+R
         oLUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6halAvs7uSf3j30ORx32dAECVcSlMKAxfdn+6eopMUljYGMlXKtPXWUrUskR1ITfM8IRdjilu@lists.cip-project.org
X-Gm-Message-State: AOJu0Yy2FjQtRLcyE0quZ+wveiL/mY9C3Pp+RftrSkAFI4AF8YRKYWLL
	9va1yPA2Dq0NgHLkmO3aiJQEso9dJx8C/CRLQWmkNqFdIHlMeouKh4xD4exTL1qFbRA=
X-Gm-Gg: AY/fxX4/yaQpqym60Hrn/JK4FnM+708QZMWC/sQtJq4ssTe3jWgpyBUEWZuoYGHeywO
	4uy3WzeKUgPq4lXyIK/HZWDzBQOSsX1TzJGVj4oM4dMHkGnAIKBN3HE5p6Y2Uo96SMjAAnQfZjb
	uUni7WAF/yO6pP8W8NoqSMFk6bPSBnefGuX61z4/SrjclGCz31LykeNlplMrde1/PlTUNdxR0+S
	uWp7bl3vjEsy0gJKcCv4iE/fPHhDSPapKvnHh/9Ocn3l4RokCY9VsLcQM5I0lOyCUVfDI75b8pf
	LXhcUAJ8drHYE3c2zWVmN4E13dMd3xG671P561kdClcaJst3SlZhcCxWxUc6dROoMAQTMS/0Q/Y
	B1iB23ZBnmj2zUt/V12oZVN1A/+6oaYo2SDqCYr6REkEopX2e8/pLbAdSYu9JevSrH1wshhdNrH
	pSK5P0UcB53LMsK5i6YzreBbIkpa6rXaWGJSNw7ZT4
X-Google-Smtp-Source: AGHT+IHyKTuGyeHltoHocA+sCTkX/1FyDrwWYCmfQPJEiXNu5cGpvCwO2iqvNM5kWtAjYSpGnEXOyg==
X-Received: by 2002:a17:907:a088:b0:b73:6bd8:ebde with SMTP id a640c23a62f3a-b7d23c0bb1emr1661740366b.53.1765967534787;
        Wed, 17 Dec 2025 02:32:14 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29eb76sm1930249166b.12.2025.12.17.02.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 02:32:14 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 2/7] clk: renesas: r9a08g045: Add clocks, resets and power domain support for the TSU IP
Date: Wed, 17 Dec 2025 12:32:05 +0200
Message-ID: <20251217103210.4183025-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217103210.4183025-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251217103210.4183025-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 10:32:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21107

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 5599c7c4b4df440aa4a470a5b72669081413981f upstream.

Add clocks, resets and power domains for the TSU IP available on the
Renesas RZ/G3S SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250103163805.1775705-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: drop the power domain description array as the core code
 is not available in v6.1 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index eddf6cad8d35..acfa9fa01031 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -237,6 +237,7 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0),
 	DEF_MOD("adc_adclk",		R9A08G045_ADC_ADCLK, R9A08G045_CLK_TSU, 0x5a8, 0),
 	DEF_MOD("adc_pclk",		R9A08G045_ADC_PCLK, R9A08G045_CLK_TSU, 0x5a8, 1),
+	DEF_MOD("tsu_pclk",		R9A08G045_TSU_PCLK, R9A08G045_CLK_TSU, 0x5ac, 0),
 	DEF_MOD("vbat_bclk",		R9A08G045_VBAT_BCLK, R9A08G045_OSCCLK, 0x614, 0),
 };
 
@@ -271,6 +272,7 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_GPIO_SPARE_RESETN, 0x898, 2),
 	DEF_RST(R9A08G045_ADC_PRESETN, 0x8a8, 0),
 	DEF_RST(R9A08G045_ADC_ADRST_N, 0x8a8, 1),
+	DEF_RST(R9A08G045_TSU_PRESETN, 0x8ac, 0),
 	DEF_RST(R9A08G045_VBAT_BRESETN, 0x914, 0),
 };
 
-- 
2.43.0


