Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20830C27C6E
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:09:11 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web11.43044.1717769348322983378
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:09:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=T1CUhg9W;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6c828238dcso213378666b.0
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769347; x=1718374147; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7u49dVyFacqD7i9U4qERwwy+blXNiKV1E/aKZOeh/Gc=;
        b=T1CUhg9W+Z5TKtp/HNdFDFzEDaY9qmIupBeozQjTP4dfZXBFYpScYVkr+4R9KZKr+D
         H5Pzw154Ut7vD2VHJw0ZvtaxQ96ILYTmymWTJebBc6r1F0n2wla6acAMnMO4lYC+sYnQ
         MbPWXv3lIBzeAFC4U+BL2Wja/aY1L6Tb7Z67PfZcjI8YMbUFAs0P4RtzOKpHWpSnRrRW
         H7Q7T3CLoMebZAk6NetWasy7iOSkTXK4+HKywsE2Fjocho8QA4Qs5+Kmzgx4RAO+hpLs
         u9bSBkqfhewaOg712bKeK90eLW0rSIZeAwv07zG4gxa1bMXogJ3Y3flK4y/7VB+ijWst
         zGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769347; x=1718374147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7u49dVyFacqD7i9U4qERwwy+blXNiKV1E/aKZOeh/Gc=;
        b=GqcHmW1ZbQ50itEezAZPbmt1Hbdk6RsWhaGci6ihaM/OqHq/yulAmNU4xBe2Tf5q/l
         hiBUyfPyOYxqfitZnXBMnJ/TsoQe7H8K4URCrdKsRP+Cx6Qzjcemwe2Ao7IzPOqhD/GD
         EqNeRLIxO0P6opnxmW1gOW/xNxYEpz1ktHVOERFThJgJ2Y4u1h/YAyfNdTyy+5GKV/HW
         pxlhV0PHmZrzSgOjuaFnw9Tdx70X67PK2WLm0jA4Le4I6AzCMPEn31UUrqCNfibHdqpT
         7jkGYx2wj2PUs+kM1uNAFbFTZ4B/HlbXGbdsViKzA8d+kAJuD6Hz19z2UZMmiPz/ECFY
         75oQ==
X-Gm-Message-State: AOJu0Yx/hTOVI2xUBwEakUer+OLbKHE8kau8eXV+qQWX7Ap9dYyvUVap
	BqSgeFHb9IUICh3bZkR4CL4C1o1v3g4a8LwmFs+j954Yl/jZl4i2zkhstgnvvN/FjJS6WO7Yv0R
	j
X-Google-Smtp-Source: AGHT+IGXGgxZyx9Hxt0YLkA9FZe9eJHi3xrjdsMW+Da4Zv6BIGSLUmib1ajbGuD7S60cA0WkbLWeQw==
X-Received: by 2002:a17:906:6a29:b0:a6e:a97c:fc97 with SMTP id a640c23a62f3a-a6ea97cfd15mr103302866b.7.1717769346674;
        Fri, 07 Jun 2024 07:09:06 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581870sm251987466b.25.2024.06.07.07.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:09:05 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 06/17] pinctrl: renesas: rzg2l: Configure interrupt input mode
Date: Fri,  7 Jun 2024 17:08:45 +0300
Message-Id: <20240607140856.2497508-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:09:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16167

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 2fd4fe19d01507369cef18a037d84f3439dd5ab2 upstream.

Configure GPIO interrupt as input mode. Also if the bootloader sets
gpio interrupt pin as function, override it as gpio.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240206135115.151218-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 37 +++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 336b7313e108..245eb41aa05a 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1893,6 +1893,26 @@ static const struct irq_chip rzg2l_gpio_irqchip = {
 	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
+static int rzg2l_gpio_interrupt_input_mode(struct gpio_chip *chip, unsigned int offset)
+{
+	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
+	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
+	u64 *pin_data = pin_desc->drv_data;
+	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
+	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
+	u8 reg8;
+	int ret;
+
+	reg8 = readb(pctrl->base + PMC(off));
+	if (reg8 & BIT(bit)) {
+		ret = rzg2l_gpio_request(chip, offset);
+		if (ret)
+			return ret;
+	}
+
+	return rzg2l_gpio_direction_input(chip, offset);
+}
+
 static int rzg2l_gpio_child_to_parent_hwirq(struct gpio_chip *gc,
 					    unsigned int child,
 					    unsigned int child_type,
@@ -1902,16 +1922,24 @@ static int rzg2l_gpio_child_to_parent_hwirq(struct gpio_chip *gc,
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(gc);
 	unsigned long flags;
 	int gpioint, irq;
+	int ret;
 
 	gpioint = rzg2l_gpio_get_gpioint(child, pctrl);
 	if (gpioint < 0)
 		return gpioint;
 
+	ret = rzg2l_gpio_interrupt_input_mode(gc, child);
+	if (ret)
+		return ret;
+
 	spin_lock_irqsave(&pctrl->bitmap_lock, flags);
 	irq = bitmap_find_free_region(pctrl->tint_slot, RZG2L_TINT_MAX_INTERRUPT, get_order(1));
 	spin_unlock_irqrestore(&pctrl->bitmap_lock, flags);
-	if (irq < 0)
-		return -ENOSPC;
+	if (irq < 0) {
+		ret = -ENOSPC;
+		goto err;
+	}
+
 	pctrl->hwirq[irq] = child;
 	irq += RZG2L_TINT_IRQ_START_INDEX;
 
@@ -1919,6 +1947,10 @@ static int rzg2l_gpio_child_to_parent_hwirq(struct gpio_chip *gc,
 	*parent_type = IRQ_TYPE_LEVEL_HIGH;
 	*parent = RZG2L_PACK_HWIRQ(gpioint, irq);
 	return 0;
+
+err:
+	rzg2l_gpio_free(gc, child);
+	return ret;
 }
 
 static int rzg2l_gpio_populate_parent_fwspec(struct gpio_chip *chip,
@@ -1951,6 +1983,7 @@ static void rzg2l_gpio_irq_domain_free(struct irq_domain *domain, unsigned int v
 
 		for (i = 0; i < RZG2L_TINT_MAX_INTERRUPT; i++) {
 			if (pctrl->hwirq[i] == hwirq) {
+				rzg2l_gpio_free(gc, hwirq);
 				spin_lock_irqsave(&pctrl->bitmap_lock, flags);
 				bitmap_release_region(pctrl->tint_slot, i, get_order(1));
 				spin_unlock_irqrestore(&pctrl->bitmap_lock, flags);
-- 
2.39.2


