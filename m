Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F731C05052
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:38 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web10.15316.1713514714014936181
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=nP6DSzUJ;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a5269c3f9c7so192702466b.2
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514712; x=1714119512; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoUlEaYptIxHAAha0kI3E2qQMB1I0667JVuMWCK9CEs=;
        b=nP6DSzUJBB1pCS5VTT+m2jPPaJxyyZe3+o9LT10+QatrNSIpzGKVNWXb3ueenzSwnt
         hszTm0IB6td1VS6DoZanE3UzruH5T6re/pHHrsI72OUPyyTvXB8ISmW8WeGHGLLAXDN7
         pfzNYNa9txNA+EgV5vCdChtmy7yi2WW7rLcCBsPHSb9GvGp5jFdJPKNW0ihY+viuLsJj
         fTiYELOMt2bCcsDa6Yy/rBgPIq6QwYmSA7GONjrF3Gqp1K0NMIJl75IkeGelFxXIwUaB
         VIaHD4asBNZFPGX7Tpe1K5I8tSc4GXOsLpA3xKpTZHvvmyBXtM3HGcfqGz0w3IlrHqbH
         nJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514712; x=1714119512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoUlEaYptIxHAAha0kI3E2qQMB1I0667JVuMWCK9CEs=;
        b=GR+Y/SLVc2fZkfvabO2Cicffr1ggDFBHRw2xvIpW9+h+cP9T5bRwgpybgIZLUgjfSF
         QNyQ/bBX/ygZ6W0ALN1z8SsTwHbNNKBHQ7Nf/K+bYpPeiN6DmLARr25bQrpGsVL45agz
         r63EWajmHVrEglv6deYaiGWaO+UMSByfBCX2eOtHdkAS9DzrASHokv94wqUg0kCYGoJm
         e6ugo7/0wWGm09dZ6vckM3dbNFlYIVvf5s4J1WCV1muyTi7YwPM0A4/z851JUHumx/TB
         oj+RkZun+RAduHUW+4quUBwUhFe7si1YCQRobFS94oRP74K21IPD+J0L5X3J3ZI/VgN7
         WcNA==
X-Gm-Message-State: AOJu0YyWoxTGiS85ygfJRiYf1IgM3P0XFUvvlErC//nnm7eLe2p+UmbT
	hAxcc1MrvOCLJeVM33uBJKSWk0uvBtK9N9u0Zr5SKlOImuH/V9FGljDY81l0zhw=
X-Google-Smtp-Source: AGHT+IHMRCijOOlv6zrh0OpXalajVhqnfr5nnvUVx6QL0ojtHYJwYbM5HT+m420UUfjzNJYpAUhXrg==
X-Received: by 2002:a17:907:2daa:b0:a51:deec:483c with SMTP id gt42-20020a1709072daa00b00a51deec483cmr1236842ejc.6.1713514712499;
        Fri, 19 Apr 2024 01:18:32 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:32 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 32/53] pinctrl: renesas: rzg2l: Add validation of GPIO pin in rzg2l_gpio_request()
Date: Fri, 19 Apr 2024 11:17:21 +0300
Message-Id: <20240419081742.3496709-33-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15619

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit c944d9dea75e453d18bc8c100022e990c2eac3cb upstream.

Validate the GPIO pin request in the rzg2l_gpio_request() callback using
the rzg2l_validate_gpio_pin() function.  This stops any accidental usage
of GPIO pins which are not supported by the SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20230925154548.27048-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index beb6fd73c3fa..85d9d2895fc3 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -791,12 +791,18 @@ static const struct pinconf_ops rzg2l_pinctrl_confops = {
 static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
+	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
 	u32 port = RZG2L_PIN_ID_TO_PORT(offset);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
+	u32 *pin_data = pin_desc->drv_data;
 	unsigned long flags;
 	u8 reg8;
 	int ret;
 
+	ret = rzg2l_validate_gpio_pin(pctrl, *pin_data, port, bit);
+	if (ret)
+		return ret;
+
 	ret = pinctrl_gpio_request(chip->base + offset);
 	if (ret)
 		return ret;
-- 
2.39.2


