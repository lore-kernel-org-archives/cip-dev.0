Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C95C27C75
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:07:30 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web11.42962.1717769246086178184
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:07:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=TTcP2OmX;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57c614c57e1so379368a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769244; x=1718374044; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xl0f7+3sgbt+/c1OJPLg4c5dSI1Vd24XGLrBbFY0ck4=;
        b=TTcP2OmXbVkfTo/ujbP7n1gh7Ad6HQ0TpGc/rSWTc+Il9yCA8mamupIRf/fQ/4czvN
         y2LI3nXtB3WQCC6ajb+ChqaxzwOT4LhaPDilQUwFBJJVVRqHgwwRwD62AaDiiNIFSFRs
         lnMO5vP/mbA9UrsNgQnewkrBB7ylggpJQwGUX5uf5IqZ4YR8t+mxx+IzSbxZti9THIlR
         fVEFHsqGhJTuYOLT+ag0ccWs7ov5yf3EkmVza0ytNeH77KliiO6Zr0PoEncajru8z5+o
         2WPzGEdz/KNiDrcvcI6u2o29UEDNr8O9ac7u/bdeRzL9jZHaRlyIA7vwlJ1+GoQ6/tfW
         1oBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769244; x=1718374044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xl0f7+3sgbt+/c1OJPLg4c5dSI1Vd24XGLrBbFY0ck4=;
        b=O82Jg/gNzvQfG405sMb/Ff9f1D0farnPa/VXmxtIf5IfM8fiwjvO1DFNinSBkht4HD
         zvi/BdpyX/Plmz+7panoMSw/Vk699UzXft6LrOx9D9Nnv9gJKPaXV0CxC3VUJE1aKcqi
         kXPGz1sojdldVocrVwOAODoMWVQLkCI18Xli+v2PPm3xwJQIWOwqE4JXzPWWSwWTm8FD
         3Rz10ysnThrh8JXNwrIaaRw2S2Fr5rpueVoSgBoeap8+HSooxeI7b8+Pa/IxIV9S5535
         cg3oqsE3BemCtxVX00T9TDCtrpuI7AiUtucoBtG7CYrdIHJdW8Xc/MZ10htNln1mW6Jo
         /KEw==
X-Gm-Message-State: AOJu0YyNi9twVWJ+u3O9KTGdjgkso391R602BlYvcS3pFYy+tEo1Nqeo
	9cPYq9NmlDzDGh7aZ7g5Wm0zZ9yn2tV5E7R2XkhVJhXsx17oGB4uo+bbdZrGF/U=
X-Google-Smtp-Source: AGHT+IEhDQxnDIPcJXhw4ketE8PoLF4mOwd0lyKTa0gQfJmpu2TTgaLDGjlCiBswBzKoX9s63QDkgA==
X-Received: by 2002:a50:d799:0:b0:57a:2fc1:e838 with SMTP id 4fb4d7f45d1cf-57c50928dd9mr1647658a12.22.1717769244381;
        Fri, 07 Jun 2024 07:07:24 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9cf05sm2823968a12.3.2024.06.07.07.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:07:22 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 5.10.y-cip 08/19] pinctrl: renesas: rzg2l: Avoid configuring ISEL in gpio_irq_{en,dis}able*(
Date: Fri,  7 Jun 2024 17:07:00 +0300
Message-Id: <20240607140711.2497286-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:07:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16149

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 1d2da79708cb4e23ec3d19c6c5b528753ca08e67 upstream.

Currently on irq_disable(), we are disabling gpio interrupt enable(ISEL).
That means the pin is just gpio input and not gpio input interrupt any
more.  So, move configuring ISEL in rzg2l_gpio_child_to_parent_hwirq()/
rzg2l_gpio_irq_domain_free() so that the pin will be gpioint always even
during irq_disable().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240206135318.165426-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 40b0c325f509..5f0ed9a9a44a 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1832,22 +1832,18 @@ static void rzg2l_gpio_irq_endisable(struct rzg2l_pinctrl *pctrl,
 static void rzg2l_gpio_irq_disable(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl, gpio_chip);
 	unsigned int hwirq = irqd_to_hwirq(d);
 
 	irq_chip_disable_parent(d);
-	rzg2l_gpio_irq_endisable(pctrl, hwirq, false);
 	gpiochip_disable_irq(gc, hwirq);
 }
 
 static void rzg2l_gpio_irq_enable(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl, gpio_chip);
 	unsigned int hwirq = irqd_to_hwirq(d);
 
 	gpiochip_enable_irq(gc, hwirq);
-	rzg2l_gpio_irq_endisable(pctrl, hwirq, true);
 	irq_chip_enable_parent(d);
 }
 
@@ -1927,6 +1923,7 @@ static int rzg2l_gpio_child_to_parent_hwirq(struct gpio_chip *gc,
 		goto err;
 	}
 
+	rzg2l_gpio_irq_endisable(pctrl, child, true);
 	pctrl->hwirq[irq] = child;
 	irq += RZG2L_TINT_IRQ_START_INDEX;
 
@@ -1973,6 +1970,7 @@ static void rzg2l_gpio_irq_domain_free(struct irq_domain *domain, unsigned int v
 
 		for (i = 0; i < RZG2L_TINT_MAX_INTERRUPT; i++) {
 			if (pctrl->hwirq[i] == hwirq) {
+				rzg2l_gpio_irq_endisable(pctrl, hwirq, false);
 				rzg2l_gpio_free(gc, hwirq);
 				spin_lock_irqsave(&pctrl->bitmap_lock, flags);
 				bitmap_release_region(pctrl->tint_slot, i, get_order(1));
-- 
2.39.2


