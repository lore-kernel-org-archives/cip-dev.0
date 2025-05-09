Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FF4C3ABC9
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:34:14 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web11.10316.1746783244357092845
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:34:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=RjG6yBzY;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5fc7edf00b2so2355195a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783243; x=1747388043; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NN1kHZnpiwrM/E1GKZNg1TSC5j/KrvJ0Loesijqd9Jc=;
        b=RjG6yBzY4ooQns8EBn+BR1DzyLu6mZ3yvwtPAdXS3se0oG5ZYptclkD9g/SSRMthYH
         fATvE6Al16r6oMNX7t2grFq+ZHS0U2LIWjCsWaed5l7WHQYjYt07jPQyME3DjXwZrrHr
         pKtKNIg07+xu0Q4xh2nSIUlejIkgT0TflqybhEVpIjlB/0BiICHgnaKUoMvRqOb8Nk0+
         Rg+lyasP/b3eaCJJbgbixPFzmBZsoEjo09bs4o1y7Vd/1L9txYPRVvH630R6rhijcwt2
         bGVuM+qm4PXW11fmJcb6bQkKW/6Kxyb6UHbSOxFw8rppQIVOfrKBsNP5zOkGKw0iiomV
         wMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783243; x=1747388043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NN1kHZnpiwrM/E1GKZNg1TSC5j/KrvJ0Loesijqd9Jc=;
        b=C564/f9RE3wMkcVLcP5js3gGRqwy/+uIpUgBzN7VUIFpPpFwipwcZzS8ajNxx/1mhD
         MnJ/NRJCVyuOiw2yPEwasuomTfWWAVQxpLlwDKLMg+ZAsiEGVdkKOUEu6mHmxSQo5Ur9
         tbIL28iHHvcXGfO7cfuUOat+zLtH8YggquyV6/oLD0BbRIta8Ho4Uko2BnP0XK6xZIFK
         elZXMiumm5L5VNfZ751CNng7LRRFQfOIT1v7gEhPHFNR4tj8KBPsdpHNz6TWWus52wOL
         Ts0Tgsabxw403666fNf4yPfBPxVYSoIn/9Xc0uq0ESmx2Ac2oJmJ6YIesgPX2+7xemzp
         EKvw==
X-Forwarded-Encrypted: i=1; AJvYcCWvzCDctOll7uAR+hDtQlE4BOlZCrfRo23G2Rb9uCEz6b9hTO5z7MjT8HF+84a3YHxhbKZIoKvT@lists.cip-project.org
X-Gm-Message-State: AOJu0YxNs1NKyOdwp9WLo5JqS8+oWzEGBVSzQFQb4HOveWgkZIVdWo5L
	n/3e2gSIq1ORLy5MRMCocPOZbwyHufrYdVW1vJzA/fQCcZSDWhs4IhwbkRE93eI=
X-Gm-Gg: ASbGncscZdsUtLGWCFc78UxOWkyjgMMQibSVDGUA66NJ5FKfEvU4yuYMOVYNvvZDyf/
	n8kbfVxdndVM4LG2z1KcQs67BXqW0qa2GnMvYdOjCkyb3iu4h4RhSpE6q+96IrTRhbplyKI836W
	wWt3UQTpDBc44V4lbxV9borX59NB0xpz6Go8UXfvVjYKDtu8d1X43NcgerdR79r5iW1NniPMmU/
	+oifZu3S69AfGoPWnrazBl5TCvbAZfMlsRYN8A5OGi5V5dXaHnVowqWXb5SvcTCOBDAoBaGniZB
	o9xitnwx/0cWUOenFGb1WruOhDnY54izYFw4kPt5aMtKtcyowDg25+KftT04VBZHevAUWg==
X-Google-Smtp-Source: AGHT+IEJC52TsDHTFjFw1r7fqmAAju3l3BnmtUpy4XPlivx9ihpjnWl3Qd2Sh1POKrXXIAkTGKg5Eg==
X-Received: by 2002:a05:6402:34c6:b0:5f6:212f:ed3 with SMTP id 4fb4d7f45d1cf-5fca07707eamr2122243a12.15.1746783242781;
        Fri, 09 May 2025 02:34:02 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:34:01 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 29/34] pinctrl: renesas: rzg2l: Add audio clock pins on RZ/G3S
Date: Fri,  9 May 2025 12:33:13 +0300
Message-ID: <20250509093318.4014916-30-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:34:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18846

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 03fc60cd8e7b7e6f330d0a48c54545740addd9d8 upstream.

Add audio clock pins on the RZ/G3S SoC.  These are used by audio IPs as
input pins to feed them with audio clocks.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241113133540.2005850-6-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 41944e91f6eb..3ff6bc8e4137 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2192,6 +2192,8 @@ static const struct rzg2l_dedicated_configs rzg3s_dedicated_pins[] = {
 	{ "TMS/SWDIO", RZG2L_SINGLE_PIN_PACK(0x1, 0, (PIN_CFG_IOLH_A | PIN_CFG_IEN |
 						      PIN_CFG_SOFT_PS)) },
 	{ "TDO", RZG2L_SINGLE_PIN_PACK(0x1, 1, (PIN_CFG_IOLH_A | PIN_CFG_SOFT_PS)) },
+	{ "AUDIO_CLK1", RZG2L_SINGLE_PIN_PACK(0x2, 0, PIN_CFG_IEN) },
+	{ "AUDIO_CLK2", RZG2L_SINGLE_PIN_PACK(0x2, 1, PIN_CFG_IEN) },
 	{ "WDTOVF_PERROUT#", RZG2L_SINGLE_PIN_PACK(0x6, 0, PIN_CFG_IOLH_A | PIN_CFG_SOFT_PS) },
 	{ "SD0_CLK", RZG2L_SINGLE_PIN_PACK(0x10, 0, (PIN_CFG_IOLH_B | PIN_CFG_IO_VMC_SD0)) },
 	{ "SD0_CMD", RZG2L_SINGLE_PIN_PACK(0x10, 1, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
-- 
2.43.0


