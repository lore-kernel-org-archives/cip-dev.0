Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03414C41513
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:09:11 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web11.43045.1717769349984742171
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:09:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=f4Z804gx;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6266ffdba8so210570366b.1
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769348; x=1718374148; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoWJBvPGJ9fssOgqja5Ka6zFMPgFZrfkf4EO+n1ct5o=;
        b=f4Z804gxUqSDH6Ol7qZDZcqqyc2dlr6EoDixAvGY0PukC3BM6H/+UK40E28p8E3Jq0
         BNkEPH5+QRRJWeAzN5r6DgNae0tUzmCxDZ3+PpcNaKc2wTSfaTMfHLMWHUS2L4YEHRWw
         qdIGHUey1ac7EJpmOUn4g2LLRSi8lbcXe2vhwzz4Mt8dCuYYO3+y0Q9zgUbLc2kU6Pk8
         SpLHCl41WgtJDEdcLD+8C9Oozhr3UfO8CaZZ0Ui4FycURslm9y3emjBCchPYo68OTtfV
         NI84jyS3pn40iZorCieHhxV4qMPWfo0rAH+C2K7rBXe6FresBOHAdNvTv/K5AA4U3ChU
         6+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769348; x=1718374148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoWJBvPGJ9fssOgqja5Ka6zFMPgFZrfkf4EO+n1ct5o=;
        b=aW2G3PFoqiC6Ag+Gt5/WvsIbwGYwUqqS3EUcCS/yzQf45V2wMR25Zg1zyNfZ+7fibB
         2KqvlxmEuiCiBKbch/vgqOI2tS6yJjT7SxAtOYSUlYhueRzlDycyBlsc2+u6uOQVL4dC
         0GeS1ooZqaH/SzvTsq1SvY+e9cUgdX19R845+p4Cmw7tQBnxLIsXrDoIytg0rYzyf1Ek
         XcQfACTiAet+qzFbcIo4sBi9ySIgkPADHWUlmWgpSmoKnnOqQzLl2S9buT+w1/JlvcJ1
         Q3C0ySBEcqxqj8xqONlJ0oHrdgDmX/plcmWvemJ9NNxFkOA/hP/F9m6j9UCscWYdTzqh
         pVPQ==
X-Gm-Message-State: AOJu0Yz2ySsrwHpRDZjfvDdq7Z2CuJspks8bGe4JWfeRsW1C5cIcjY5x
	wv2Qb9xshNWg6CtM4RquApws2JcmVMIyrlVhJqDcyYJxwpdBFXsfIrU00XI2kJJW+OiYBThXxAd
	9
X-Google-Smtp-Source: AGHT+IHkTmFdy0hDdG93VD7n3k5zyNa8z00nukZtlVT4C6dO0uKvF1/1LAXhz/LeMaQ6X7Re6m8Qww==
X-Received: by 2002:a17:906:6a1e:b0:a68:c9b2:6932 with SMTP id a640c23a62f3a-a6cdc0e4180mr218626666b.65.1717769348391;
        Fri, 07 Jun 2024 07:09:08 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581870sm251987466b.25.2024.06.07.07.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:09:07 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 07/17] pinctrl: renesas: rzg2l: Simplify rzg2l_gpio_irq_{en,dis}able()
Date: Fri,  7 Jun 2024 17:08:46 +0300
Message-Id: <20240607140856.2497508-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:09:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16168

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
index 245eb41aa05a..514aebc3fc8e 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1808,11 +1808,9 @@ static int rzg2l_gpio_get_gpioint(unsigned int virq, struct rzg2l_pinctrl *pctrl
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
@@ -1820,8 +1818,6 @@ static void rzg2l_gpio_irq_disable(struct irq_data *d)
 	unsigned long flags;
 	void __iomem *addr;
 
-	irq_chip_disable_parent(d);
-
 	addr = pctrl->base + ISEL(off);
 	if (bit >= 4) {
 		bit -= 4;
@@ -1829,9 +1825,21 @@ static void rzg2l_gpio_irq_disable(struct irq_data *d)
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
 
@@ -1840,25 +1848,9 @@ static void rzg2l_gpio_irq_enable(struct irq_data *d)
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


