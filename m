Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A01C27C5F
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:07:30 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web10.42687.1717769242716583865
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:07:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=N9JnZw5d;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57c614c57e1so379279a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769241; x=1718374041; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=segsXoUuXlO3N4igX6hBHjcsySV2UAYoGG/N5KdrEv8=;
        b=N9JnZw5dGqBgWua7euVRObuQ/5u9z27AGfoKNcyXIGyfCcdblSGDezU/A1w6pdv18s
         DkNrWOUE9ZwHZFyd6GSJokwUdOj1MUlMFrkZDh/U4h8xb8T10pWyPRkYbRigbI6RePCb
         GgiIbA20LxAglVUBeYmoL1IawYi7vGQ8XYuJdN+gYYyzBwSLLiOG0ZVPZqCYrndJGrFL
         sSK9cSg5WIXjTaMMzaviq5QBjuEx/yqM0mKMwjZDD5/215C2KUFtW7zex9ZRFITr3zip
         NMtiajy+1E8UwEYyvBCmXzcmyUu19HvHD2MGmmbUI3qeKNtwLOYFT2Do9FvTuq5C9eQS
         GxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769241; x=1718374041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=segsXoUuXlO3N4igX6hBHjcsySV2UAYoGG/N5KdrEv8=;
        b=U+CM6PbdP35K22slUwuCK6CzjudQKNrQZ8c97BsUy96SCbpTZIrTC0SyFaiS2E6AAO
         3s6fAUf3yR+njwis6Soi4ashsBbM0+9a/vfhcOW76sxuLgI30170+At9H71u1tOJLEhR
         0KWo9gn7MMJUvJaldhKABLD/LmTKnm52n1lpaKixLQo6a5LlJm1KI9sky2il+dewHINO
         o2SsdwYNygD8Qux6ywK3oPVBkJFwH6ecMqlqHz6OSfwG98iRMTUu9+VCrvuhPlcGSN0M
         JQdPmTxA78OylycymVKhgPobaJ/5aK0tO3wP3MdtCUwJaGs9QY7SXZxXXs5iRd1pwXHx
         rAzw==
X-Gm-Message-State: AOJu0YzPHg6G1/7+1ACR5nTmEMShRzJX1d6ktcC0K9ZSHRGuz4L37eYu
	B6YtVBTIhVSYkv59+tXZqmNbMNrwG1jhjMMujf+VUB1L5zEY21rRvxX8cyvkE5I=
X-Google-Smtp-Source: AGHT+IGlcTnI3qU7BiNqlsdNjaXukVM47T9emuX0v0OBRbhchDiPvDP2Q3wor2svVJ9K2vVYljohEw==
X-Received: by 2002:a50:bb49:0:b0:57a:2f68:fe7b with SMTP id 4fb4d7f45d1cf-57c509898c8mr1652579a12.31.1717769241209;
        Fri, 07 Jun 2024 07:07:21 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9cf05sm2823968a12.3.2024.06.07.07.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:07:20 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 5.10.y-cip 06/19] pinctrl: renesas: rzg2l: Configure interrupt input mode
Date: Fri,  7 Jun 2024 17:06:58 +0300
Message-Id: <20240607140711.2497286-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:07:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16147

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
index 0451a0d745f0..f964c6e2a4f6 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1888,6 +1888,26 @@ static const struct irq_chip rzg2l_gpio_irqchip = {
 	.irq_set_affinity = irq_chip_set_affinity_parent,
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
@@ -1897,16 +1917,24 @@ static int rzg2l_gpio_child_to_parent_hwirq(struct gpio_chip *gc,
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
 
@@ -1914,6 +1942,10 @@ static int rzg2l_gpio_child_to_parent_hwirq(struct gpio_chip *gc,
 	*parent_type = IRQ_TYPE_LEVEL_HIGH;
 	*parent = RZG2L_PACK_HWIRQ(gpioint, irq);
 	return 0;
+
+err:
+	rzg2l_gpio_free(gc, child);
+	return ret;
 }
 
 static void *rzg2l_gpio_populate_parent_fwspec(struct gpio_chip *chip,
@@ -1949,6 +1981,7 @@ static void rzg2l_gpio_irq_domain_free(struct irq_domain *domain, unsigned int v
 
 		for (i = 0; i < RZG2L_TINT_MAX_INTERRUPT; i++) {
 			if (pctrl->hwirq[i] == hwirq) {
+				rzg2l_gpio_free(gc, hwirq);
 				spin_lock_irqsave(&pctrl->bitmap_lock, flags);
 				bitmap_release_region(pctrl->tint_slot, i, get_order(1));
 				spin_unlock_irqrestore(&pctrl->bitmap_lock, flags);
-- 
2.39.2


