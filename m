Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EDAC27C6F
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:07:30 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
 by mx.groups.io with SMTP id smtpd.web10.42690.1717769244142559408
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:07:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=nusdeu2m;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.176, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e78fe9fc2bso31372301fa.3
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769242; x=1718374042; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqtUqqNFFy8qL6kUu+GxuYv3m/rgauhyWoJ3qFY+5SE=;
        b=nusdeu2mbDJ2r4kO0+dGlGBRUVL7t43EZTWx2p29K4mtNvGllg3c+5azsQLeqYaWs2
         bRZwAPZMG1bYpPGcyLsQfery1oziIZkorvqIDL68WuJR0hX2+2OMuVd6+YBmM19Ga50b
         UitHF6zNZRjAw3vzb9pCpMh8xsAwFENV9jiWUQYxkJjz9Mth8CCIUFkfvnkPd7XZh0Tb
         BtbARteQ9RkgxQ3cl2kWFFJIIBiujXzwF5sgIyervMYQhadp+d02p9p/88Tqo7Ie+kS1
         vgghPgjP6o10rWaTHkGdzs+1a+LdvkZgl1rFQ4pjRKv9QxJkiXFHzbn/CdS6A0y+S17H
         nXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769242; x=1718374042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqtUqqNFFy8qL6kUu+GxuYv3m/rgauhyWoJ3qFY+5SE=;
        b=O2jIvkLmEiL1dYoAsewvVh0Azo4vBvHJDjcd1oGuobs5sSXF9BcVqv+tPWYDQrQ97W
         iI/DVHjapGw6u4dvaefcOKh6V/W1qwgKM4WoEEDXWBquRxHeBV0Ysw5zJH9CC0g/5/QZ
         0vKFM1gRVdh8m+7av1lkWajeAf+vYzBnPa1q+mMaOQmRhpjwdFXT99aLZ5C4cV8j+1/0
         2eM9wsrlZ8eiS7VKbwEHwvNEqKCM3MPGJbhsCnthyojPfKrbPgavBL4ESJ5S209wCZgn
         dT7pBpJlhqUkU6j+H4MttF3s0lDTi4Ijw/toPBhyG7XgZZlM3iMLBTN4GSsVXmYpCflv
         SG8g==
X-Gm-Message-State: AOJu0YyToCL40MU+PQQ+7cLXheoSQSNjla7uukp+aYR+YG4CIMNgwq6W
	BwZnYWohJLocBFy866kMtL/hLPYLqXfu04DI37dD/eF8oyENKW8MJ49sujTmLeE=
X-Google-Smtp-Source: AGHT+IGW9rCUKanGuUQA05rJpqMx1N3FdEMKeMRcx/g7vHaYwmq84jL4wWsJqGIA7qXApi0k6vXZIg==
X-Received: by 2002:a05:651c:1a12:b0:2ea:9449:7719 with SMTP id 38308e7fff4ca-2eadcb7334amr21751471fa.0.1717769242202;
        Fri, 07 Jun 2024 07:07:22 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9cf05sm2823968a12.3.2024.06.07.07.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:07:21 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 5.10.y-cip 07/19] pinctrl: renesas: rzg2l: Simplify rzg2l_gpio_irq_{en,dis}able()
Date: Fri,  7 Jun 2024 17:06:59 +0300
Message-Id: <20240607140711.2497286-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:07:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16148

From: Biju Das <biju.das.jz@bp.renesas.com>

commit d3c49299339051b17ae3f2fe70fa5af7bbb82011 upstream.

Simplify rzg2l_gpio_irq_{en,dis}able() by adding a helper function
rzg2l_gpio_irq_endisable().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240206135115.151218-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 40 ++++++++++---------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index f964c6e2a4f6..40b0c325f509 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1805,11 +1805,9 @@ static int rzg2l_gpio_get_gpioint(unsigned int virq, struct rzg2l_pinctrl *pctrl
 	return gpioint;
 }
 
-static void rzg2l_gpio_irq_disable(struct irq_data *d)
+static void rzg2l_gpio_irq_endisable(struct rzg2l_pinctrl *pctrl,
+				     unsigned int hwirq, bool enable)
 {
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl, gpio_chip);
-	unsigned int hwirq = irqd_to_hwirq(d);
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[hwirq];
 	u64 *pin_data = pin_desc->drv_data;
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
@@ -1817,8 +1815,6 @@ static void rzg2l_gpio_irq_disable(struct irq_data *d)
 	unsigned long flags;
 	void __iomem *addr;
 
-	irq_chip_disable_parent(d);
-
 	addr = pctrl->base + ISEL(off);
 	if (bit >= 4) {
 		bit -= 4;
@@ -1826,9 +1822,21 @@ static void rzg2l_gpio_irq_disable(struct irq_data *d)
 	}
 
 	spin_lock_irqsave(&pctrl->lock, flags);
-	writel(readl(addr) & ~BIT(bit * 8), addr);
+	if (enable)
+		writel(readl(addr) | BIT(bit * 8), addr);
+	else
+		writel(readl(addr) & ~BIT(bit * 8), addr);
 	spin_unlock_irqrestore(&pctrl->lock, flags);
+}
 
+static void rzg2l_gpio_irq_disable(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl, gpio_chip);
+	unsigned int hwirq = irqd_to_hwirq(d);
+
+	irq_chip_disable_parent(d);
+	rzg2l_gpio_irq_endisable(pctrl, hwirq, false);
 	gpiochip_disable_irq(gc, hwirq);
 }
 
@@ -1837,25 +1845,9 @@ static void rzg2l_gpio_irq_enable(struct irq_data *d)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl, gpio_chip);
 	unsigned int hwirq = irqd_to_hwirq(d);
-	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[hwirq];
-	u64 *pin_data = pin_desc->drv_data;
-	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
-	u8 bit = RZG2L_PIN_ID_TO_PIN(hwirq);
-	unsigned long flags;
-	void __iomem *addr;
 
 	gpiochip_enable_irq(gc, hwirq);
-
-	addr = pctrl->base + ISEL(off);
-	if (bit >= 4) {
-		bit -= 4;
-		addr += 4;
-	}
-
-	spin_lock_irqsave(&pctrl->lock, flags);
-	writel(readl(addr) | BIT(bit * 8), addr);
-	spin_unlock_irqrestore(&pctrl->lock, flags);
-
+	rzg2l_gpio_irq_endisable(pctrl, hwirq, true);
 	irq_chip_enable_parent(d);
 }
 
-- 
2.39.2


