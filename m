Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36292C27C53
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:09:21 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.web11.43049.1717769351789405106
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:09:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Y5GMBB+G;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6c7ae658d0so296350866b.0
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769350; x=1718374150; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBbjpuyTM5Fj0hbCnfHk/CCWyeA8GO9YhaU4r/unZbc=;
        b=Y5GMBB+GEplZ4GZ8rV/GdG1rPilalWo9UiN0eCHcAHyDd5ATkKxa/FSDogcTxk9ecQ
         0bLNRKJx0NsGWWKCN5ZxQEPD/x/kQ80uvUKsi43h72gqtVKYE5zAqoavJDoaaFQACjoP
         VwVhaCMEB9AStIRFgdcksOmthP3OLpIuemHugoSOCgkqFwUJlVNuQscjibtYsFkG2ICq
         3Ue/UiCZ6KzHav9Ek3ehknVHFafsf5qOUXb7dZ3i+zrlewlsDgqWMGXffyIEDcvZyf8G
         QqCIaFSY1kUxHe0Mgap/IscqNy4mYAF/4LYTXldOGgKdvznU+7kHfJiHnHNduoikLmqO
         3Qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769350; x=1718374150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBbjpuyTM5Fj0hbCnfHk/CCWyeA8GO9YhaU4r/unZbc=;
        b=A//Aqz5i6uR8y1MwVMNCDOVHpOMJfTnCKzHZbyeZ+i/938Cf5J3hFafLizlXbYUIMb
         YA1sS7T7G6WxzziSFfgtrRx/yJ2pNR76wyiMzF6J6qfK1iToOj8FqSeyih5mCv4Bpk3r
         V6sxIVCdh0s0RKM8KAwJxz4Ks8ulIBGUTM1AbL9O6v+4uVSFyHfNDN0nVmwXD6PMyap9
         JRuDUYFCs07udBZmTfgbdhpQwGR2W2hsQPSiGUmNG71TXBcZVnIpRNERFs4KwWA3/iYa
         um9/CTcic9fFq15GXDmf2nwjHIizJQMxhWyRxA5UkIHQyiGx6bU9Jx7k42o03FkINXBW
         46SQ==
X-Gm-Message-State: AOJu0YwCMsA7ge3c4dniIHorFfY98xZVjg0caxZ5Ak3oFI60Qo9mAoFi
	80Qo43fEjIVWW9n8tJXqTODh3dfIGBntl7hEuPB91G1vAJE3i6Pjz6RYfajxkpk=
X-Google-Smtp-Source: AGHT+IFQPGvhEbZVthRMkTNjlnAxtVGbTNNG4YTO/DEVPUwAS6WFkk+zHJPHcoFVPhfQUKVBtyFF6g==
X-Received: by 2002:a17:906:3c54:b0:a66:4b54:9c87 with SMTP id a640c23a62f3a-a6cdb9d66edmr242360966b.76.1717769350265;
        Fri, 07 Jun 2024 07:09:10 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581870sm251987466b.25.2024.06.07.07.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:09:09 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 08/17] pinctrl: renesas: rzg2l: Avoid configuring ISEL in gpio_irq_{en,dis}able*(
Date: Fri,  7 Jun 2024 17:08:47 +0300
Message-Id: <20240607140856.2497508-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:09:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16169

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
index 514aebc3fc8e..38cff01a5852 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1835,22 +1835,18 @@ static void rzg2l_gpio_irq_endisable(struct rzg2l_pinctrl *pctrl,
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
 
@@ -1932,6 +1928,7 @@ static int rzg2l_gpio_child_to_parent_hwirq(struct gpio_chip *gc,
 		goto err;
 	}
 
+	rzg2l_gpio_irq_endisable(pctrl, child, true);
 	pctrl->hwirq[irq] = child;
 	irq += RZG2L_TINT_IRQ_START_INDEX;
 
@@ -1975,6 +1972,7 @@ static void rzg2l_gpio_irq_domain_free(struct irq_domain *domain, unsigned int v
 
 		for (i = 0; i < RZG2L_TINT_MAX_INTERRUPT; i++) {
 			if (pctrl->hwirq[i] == hwirq) {
+				rzg2l_gpio_irq_endisable(pctrl, hwirq, false);
 				rzg2l_gpio_free(gc, hwirq);
 				spin_lock_irqsave(&pctrl->bitmap_lock, flags);
 				bitmap_release_region(pctrl->tint_slot, i, get_order(1));
-- 
2.39.2


