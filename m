Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC1FCD12A4
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.32285.1711527486113386673
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=LTBH7vYq;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41494c0405eso1810665e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527484; x=1712132284; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJpqfAAhV3/Qu/RqfWVpReBN5TRvm6YlSV/idrybxS4=;
        b=LTBH7vYq5aOIQFZid8Zb5eaeUvH91N8JCTe5hF4ZtDCiPzHLZzpZnyCTV7H9r9BZh2
         IvfzVCuzTVF1hweImB4wmqqlt11LnwuAmkEh6JFCWGJsRgCkgOuHGQ7/DcTk8iVMc4VD
         BAnCSxahVjjziSEtnfr3QNIi4nHTM7OZZl+0JHUUAcOY0uiARXswtjZuk3aecuZ1RWyi
         JvjCVq2uBUMX+xZLXJIKZEewhJm+Lo3V11AMYyjFqOXmgBbOb+55LMGzfE2QpXEzUgae
         ZVy68Wv4bO9j1UXbACy5bwYdC9vaZKCUs4TkR6iIcepkLECqoxxu7mFE/UvDeFZCrDn3
         +OjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527484; x=1712132284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJpqfAAhV3/Qu/RqfWVpReBN5TRvm6YlSV/idrybxS4=;
        b=NFLhUUaRwbMZVv0OstQmdoH2qkQJRKPJKCSwXccA1Zn3xdMcc0g8ZhPfGoxaWG/481
         qwsm8sJrg4A+hVGc4sUwNIUS7LSFgqklQnw2TqU9Jn73a7PSTswOun/4T6A1LJ1sOc/w
         Z2hmwuDlHHVJCqZmqvvr1PGPuuikXUpwstHVOTv5xkre/YWWdZ8TECFxpBKXZWcjqO+3
         V6JdGlW+0uCnrYZH2DVFirMHLbWQJt/S+oB5oDtHwrCSu1uNAnkdYDiP0RRW9+faD+26
         7G/iCSLcw6rQqr3avvG013ykVjHQgqVe8mc8c5TwElPWk0v8DSnV4MyPTyTpWu5XXXiN
         KAaA==
X-Gm-Message-State: AOJu0YwxFl9ua4nM9VvZSA6rk/tbdRPz62NrDqXeqEpVoZTZXDOwnR0Q
	1cm8gWXLu6PBksWDEqs5nBMPAZcSZKESftkoWlYkEaXzSx0MH5UJAczCpDW2paM=
X-Google-Smtp-Source: AGHT+IGWH5uLB2cL+gM79iV2KTnnTTkvXKehtPftmYY6MWpQcyd+fM/H4xrdU4yLmhbSCEZY6G25fA==
X-Received: by 2002:a05:600c:1382:b0:414:8fd8:3b44 with SMTP id u2-20020a05600c138200b004148fd83b44mr2348257wmf.31.1711527484587;
        Wed, 27 Mar 2024 01:18:04 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:04 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 05/36] pinctrl: renesas: rzg2l: Add BUILD_BUG_ON() checks
Date: Wed, 27 Mar 2024 10:17:25 +0200
Message-Id: <20240327081756.2228036-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15422

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 2d4a628cade2fe9cf7aa5629cffe768afe0e7ae1 upstream.

Add BUILD_BUG_ON() checks to avoid overflows for GPIO configs for each
supported SoC.

While at it, for readability set n_port_pins based on the GPIO pin configs
and not on GPIO names for r9a07g044_data as done for r9a07g043_data.

Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20230102221815.273719-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 063f8233a5eb..230075645094 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1486,6 +1486,12 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 	struct rzg2l_pinctrl *pctrl;
 	int ret;
 
+	BUILD_BUG_ON(ARRAY_SIZE(rzg2l_gpio_configs) * RZG2L_PINS_PER_PORT >
+		     ARRAY_SIZE(rzg2l_gpio_names));
+
+	BUILD_BUG_ON(ARRAY_SIZE(r9a07g043_gpio_configs) * RZG2L_PINS_PER_PORT >
+		     ARRAY_SIZE(rzg2l_gpio_names));
+
 	pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
 	if (!pctrl)
 		return -ENOMEM;
@@ -1550,7 +1556,7 @@ static struct rzg2l_pinctrl_data r9a07g044_data = {
 	.port_pin_configs = rzg2l_gpio_configs,
 	.n_ports = ARRAY_SIZE(rzg2l_gpio_configs),
 	.dedicated_pins = rzg2l_dedicated_pins.common,
-	.n_port_pins = ARRAY_SIZE(rzg2l_gpio_names),
+	.n_port_pins = ARRAY_SIZE(rzg2l_gpio_configs) * RZG2L_PINS_PER_PORT,
 	.n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common) +
 		ARRAY_SIZE(rzg2l_dedicated_pins.rzg2l_pins),
 };
-- 
2.39.2


