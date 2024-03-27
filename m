Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF03CD12A1
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web10.32431.1711527485732217901
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=fhGPAKT8;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-515a86daf09so4702968e87.3
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527483; x=1712132283; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTVFpAnxOy49xmXW1ND7nm+6rstiLIGNXDNWsOvaO1o=;
        b=fhGPAKT8yFYCZNjOhG/Gm1agR8JsXdt5FlnZlS5jqquyauTpPYqZXUCWRS7KVNOO/q
         d3EMYyxbxLhgHjoQeQcDs7NVisR8idzr7jGViOp4AS/wepqoMKLSXPSutngmYlFROaUp
         ABrIDp0o8pKscTgyUT0/QSv3MoJp+VqZfgqbL6VNYNW9y3noEQv3GAKNLoB0wfJ7cXCs
         KFecaqVDKWbPpiFHeim5jIYTUUtrHUOuYoCqELKOdp+guntiTFA786KnXEo8LN2XULs7
         V8Nj2sfjYAgl61pry2ssgd2f82vTOeha7op04q6PyI65Q99w0UT/UHSI0S5EFD7ua6Xj
         2/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527483; x=1712132283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTVFpAnxOy49xmXW1ND7nm+6rstiLIGNXDNWsOvaO1o=;
        b=OJ9u98aRJAxBo+BQSBsHFpW7pyj73Ci9pUnwDthYsJba2CHdOWiOhTGAygwqWT/0/P
         JHI9/PRR5CMRnIGj9lJshUxVr9H64pJhexkWBzcc2tJ5UTUKmG0Yyk8s7TKMDKev4CTs
         DJSRwC3g++7HygDRIbmJwlxitDjFL1VY3uLNylTXHnoZhOcRRpkaCn4fBGUDkJJB/wxc
         BN/WPHtzsySqQh8ANY3oo/CdKuK8lNmWx2UpdO6bbh2kkZfZ34hMFsu6tF8ZChcxc/t8
         yK107C/Af6DcdEM/Qu0aasGgTddx5Vjsz/Hy/giYVpdiCrNAuzKJgPIeDCY0SHqz8FJQ
         pI8Q==
X-Gm-Message-State: AOJu0YxS2DFGQUeGz6AiImrJ/Z1JezqyrcRzEEtcjNKg+TSrI9S416m0
	8aNbPVvEgRxfSUykxsaB8LgwELBQDMFmPPVwE9njsiOQJCB9bOdI5xMuutN5gFc=
X-Google-Smtp-Source: AGHT+IH9JOe6DwE41YXlCzYrP4YsNPZ4FnHv8IHyWZvE/25SbT3pd7ALU+ZWsmUaW46c+yd4VGYHTg==
X-Received: by 2002:a2e:2c18:0:b0:2d4:9489:67ba with SMTP id s24-20020a2e2c18000000b002d4948967bamr433129ljs.12.1711527483533;
        Wed, 27 Mar 2024 01:18:03 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:03 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 04/36] pinctrl: renesas: rzg2l: Fix configuring the GPIO pins as interrupts
Date: Wed, 27 Mar 2024 10:17:24 +0200
Message-Id: <20240327081756.2228036-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15421

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 00dfe29887761405ccd23cc0aa07cb86623bb2b7 upstream.

On the RZ/G2UL SoC we have less number of pins compared to RZ/G2L and also
the pin configs are completely different. This patch makes sure we use the
appropriate pin configs for each SoC (which is passed as part of the OF
data) while configuring the GPIO pin as interrupts instead of using
rzg2l_gpio_configs[] for all the SoCs.

Fixes: bfc69bdbaad1 ("pinctrl: renesas: rzg2l: Add RZ/G2UL support")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20230102221815.273719-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 8e33d3a34c06..063f8233a5eb 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -128,6 +128,7 @@ struct rzg2l_dedicated_configs {
 struct rzg2l_pinctrl_data {
 	const char * const *port_pins;
 	const u32 *port_pin_configs;
+	unsigned int n_ports;
 	struct rzg2l_dedicated_configs *dedicated_pins;
 	unsigned int n_port_pins;
 	unsigned int n_dedicated_pins;
@@ -1141,7 +1142,7 @@ static struct {
 	}
 };
 
-static int rzg2l_gpio_get_gpioint(unsigned int virq)
+static int rzg2l_gpio_get_gpioint(unsigned int virq, const struct rzg2l_pinctrl_data *data)
 {
 	unsigned int gpioint;
 	unsigned int i;
@@ -1150,13 +1151,13 @@ static int rzg2l_gpio_get_gpioint(unsigned int virq)
 	port = virq / 8;
 	bit = virq % 8;
 
-	if (port >= ARRAY_SIZE(rzg2l_gpio_configs) ||
-	    bit >= RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[port]))
+	if (port >= data->n_ports ||
+	    bit >= RZG2L_GPIO_PORT_GET_PINCNT(data->port_pin_configs[port]))
 		return -EINVAL;
 
 	gpioint = bit;
 	for (i = 0; i < port; i++)
-		gpioint += RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[i]);
+		gpioint += RZG2L_GPIO_PORT_GET_PINCNT(data->port_pin_configs[i]);
 
 	return gpioint;
 }
@@ -1254,7 +1255,7 @@ static int rzg2l_gpio_child_to_parent_hwirq(struct gpio_chip *gc,
 	unsigned long flags;
 	int gpioint, irq;
 
-	gpioint = rzg2l_gpio_get_gpioint(child);
+	gpioint = rzg2l_gpio_get_gpioint(child, pctrl->data);
 	if (gpioint < 0)
 		return gpioint;
 
@@ -1331,8 +1332,8 @@ static void rzg2l_init_irq_valid_mask(struct gpio_chip *gc,
 		port = offset / 8;
 		bit = offset % 8;
 
-		if (port >= ARRAY_SIZE(rzg2l_gpio_configs) ||
-		    bit >= RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[port]))
+		if (port >= pctrl->data->n_ports ||
+		    bit >= RZG2L_GPIO_PORT_GET_PINCNT(pctrl->data->port_pin_configs[port]))
 			clear_bit(offset, valid_mask);
 	}
 }
@@ -1538,6 +1539,7 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 static struct rzg2l_pinctrl_data r9a07g043_data = {
 	.port_pins = rzg2l_gpio_names,
 	.port_pin_configs = r9a07g043_gpio_configs,
+	.n_ports = ARRAY_SIZE(r9a07g043_gpio_configs),
 	.dedicated_pins = rzg2l_dedicated_pins.common,
 	.n_port_pins = ARRAY_SIZE(r9a07g043_gpio_configs) * RZG2L_PINS_PER_PORT,
 	.n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common),
@@ -1546,6 +1548,7 @@ static struct rzg2l_pinctrl_data r9a07g043_data = {
 static struct rzg2l_pinctrl_data r9a07g044_data = {
 	.port_pins = rzg2l_gpio_names,
 	.port_pin_configs = rzg2l_gpio_configs,
+	.n_ports = ARRAY_SIZE(rzg2l_gpio_configs),
 	.dedicated_pins = rzg2l_dedicated_pins.common,
 	.n_port_pins = ARRAY_SIZE(rzg2l_gpio_names),
 	.n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common) +
-- 
2.39.2


