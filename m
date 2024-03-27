Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008EBCD1293
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.32667.1711528524827209331
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:35:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=DxJ2VapV;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-341b01dbebbso5017080f8f.0
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711528523; x=1712133323; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1z0IJwHMKaIHUipl9L+gJ/oXlxgEc4M8WRcCg0pMBc=;
        b=DxJ2VapVh5IWNHoSKksmbcZHaTuWvQUbw5mkCRUF/7MwNTbdI2ZOtGrmv9FwqIjZuo
         xuq7iD1HW4+hLkrrvkZwxnymHfZAgaYjjzYV3UNuHKt/zda6w4I3SLArqxZxF8HCgS2f
         uGSm0cMPbkaxINsU+uHAJTg5mkbku/+Yp1+TMl2GfvwPOeFzpzAcpfkI0oxTtTnlZTqE
         bGVf835YYhpmOffSRwk8gcwBRJ2uHXgAcNBttm08it+EQ0n33IxnrHj/62Er9r5VoS6n
         sNAwVtExsx3hNMrkm7tHFwHyv91YSJSs7hF6Ms0UgpXeEGn9rzuLJjJR36G/PuCC9wSb
         sI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711528523; x=1712133323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1z0IJwHMKaIHUipl9L+gJ/oXlxgEc4M8WRcCg0pMBc=;
        b=nKZ9rqNHNGliuDyt+zf6J5kfcW+seOETRbcrqKZziayXEzSgq8WgBvu1nZrdOGdvw7
         fe5F7zPYhaZyWmK9kJ8wsngocvh4KnDkVHyS8tmIosM+RW5TIdMhAAJAz1z2S4Wg2OJE
         3d7YTnqnoxqp5FDB+eivLqPL6q2gyyjyNtbPIMC6zulzRGMiVgrJLcBsGOVjLt4uoF8D
         5iXgHI9s/SvJsGHqWG1HzqMjqBLzCjtplBXIQbPhS0H2jQbKe8ZfaAx7aNozvwIeyNs4
         CqqmDt85Om41KlQvIz3G3XhYftIHoip6mVQUZyitMMTgfKNbKBlyoxyJYPblfW08d7J8
         Zk1Q==
X-Gm-Message-State: AOJu0Yw8kQ1pkQ/G/1vGAz7mdC6KAH7mnpDC8TOLQwiLtjPnxc48wGws
	iyKICbdX0GMoYtOdGzmwX82lmiEwVpLqJXPbT7gE3c1Gn4ip4IRIKrDDrbF78xo=
X-Google-Smtp-Source: AGHT+IFq8iUSiJ4FiRIT8rMd8qpWM/bTAnZaiuh2ropT89Dq3qMsQr07IB7UmCYtfmtlUx9BJoXmOQ==
X-Received: by 2002:adf:ee89:0:b0:33d:2474:5aa with SMTP id b9-20020adfee89000000b0033d247405aamr1453940wro.40.1711528523350;
        Wed, 27 Mar 2024 01:35:23 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id bq28-20020a5d5a1c000000b00341d84f641asm3591461wrb.8.2024.03.27.01.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:35:22 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 6.1.y-cip 12/13] irqchip/renesas-rzg2l: Prevent spurious interrupts when setting trigger type
Date: Wed, 27 Mar 2024 10:35:07 +0200
Message-Id: <20240327083508.2229567-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15466

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 853a6030303f8a8fa54929b68e5665d9b21aa405 upstream.

RZ/G2L interrupt chips require that the interrupt is masked before changing
the NMI, IRQ, TINT interrupt settings. Aside of that, after setting an edge
trigger type it is required to clear the interrupt status register in order
to avoid spurious interrupts.

The current implementation fails to do either of that and therefore is
prone to generate spurious interrupts when setting the trigger type.

Address this by:

  - Ensuring that the interrupt is masked at the chip level across the
    update for the TINT chip

  - Clearing the interrupt status register after updating the trigger mode
    for edge type interrupts

[ tglx: Massaged changelog and reverted the spin_lock_irqsave() change as
  	the set_type() callback is always called with interrupts disabled. ]

Fixes: 3fed09559cd8 ("irqchip: Add RZ/G2L IA55 Interrupt Controller driver")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 36 +++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index fb04e5450497..3acdecf39404 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -168,8 +168,10 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
 
 static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
 {
-	unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_IRQ_START;
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
+	u32 iitseln = hwirq - IRQC_IRQ_START;
+	bool clear_irq_int = false;
 	u16 sense, tmp;
 
 	switch (type & IRQ_TYPE_SENSE_MASK) {
@@ -179,14 +181,17 @@ static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
 
 	case IRQ_TYPE_EDGE_FALLING:
 		sense = IITSR_IITSEL_EDGE_FALLING;
+		clear_irq_int = true;
 		break;
 
 	case IRQ_TYPE_EDGE_RISING:
 		sense = IITSR_IITSEL_EDGE_RISING;
+		clear_irq_int = true;
 		break;
 
 	case IRQ_TYPE_EDGE_BOTH:
 		sense = IITSR_IITSEL_EDGE_BOTH;
+		clear_irq_int = true;
 		break;
 
 	default:
@@ -195,21 +200,40 @@ static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
 
 	raw_spin_lock(&priv->lock);
 	tmp = readl_relaxed(priv->base + IITSR);
-	tmp &= ~IITSR_IITSEL_MASK(hw_irq);
-	tmp |= IITSR_IITSEL(hw_irq, sense);
+	tmp &= ~IITSR_IITSEL_MASK(iitseln);
+	tmp |= IITSR_IITSEL(iitseln, sense);
+	if (clear_irq_int)
+		rzg2l_clear_irq_int(priv, hwirq);
 	writel_relaxed(tmp, priv->base + IITSR);
 	raw_spin_unlock(&priv->lock);
 
 	return 0;
 }
 
+static u32 rzg2l_disable_tint_and_set_tint_source(struct irq_data *d, struct rzg2l_irqc_priv *priv,
+						  u32 reg, u32 tssr_offset, u8 tssr_index)
+{
+	u32 tint = (u32)(uintptr_t)irq_data_get_irq_chip_data(d);
+	u32 tien = reg & (TIEN << TSSEL_SHIFT(tssr_offset));
+
+	/* Clear the relevant byte in reg */
+	reg &= ~(TSSEL_MASK << TSSEL_SHIFT(tssr_offset));
+	/* Set TINT and leave TIEN clear */
+	reg |= tint << TSSEL_SHIFT(tssr_offset);
+	writel_relaxed(reg, priv->base + TSSR(tssr_index));
+
+	return reg | tien;
+}
+
 static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
 {
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 	unsigned int hwirq = irqd_to_hwirq(d);
 	u32 titseln = hwirq - IRQC_TINT_START;
+	u32 tssr_offset = TSSR_OFFSET(titseln);
+	u8 tssr_index = TSSR_INDEX(titseln);
 	u8 index, sense;
-	u32 reg;
+	u32 reg, tssr;
 
 	switch (type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -231,10 +255,14 @@ static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
 	}
 
 	raw_spin_lock(&priv->lock);
+	tssr = readl_relaxed(priv->base + TSSR(tssr_index));
+	tssr = rzg2l_disable_tint_and_set_tint_source(d, priv, tssr, tssr_offset, tssr_index);
 	reg = readl_relaxed(priv->base + TITSR(index));
 	reg &= ~(IRQ_MASK << (titseln * TITSEL_WIDTH));
 	reg |= sense << (titseln * TITSEL_WIDTH);
 	writel_relaxed(reg, priv->base + TITSR(index));
+	rzg2l_clear_tint_int(priv, hwirq);
+	writel_relaxed(tssr, priv->base + TSSR(tssr_index));
 	raw_spin_unlock(&priv->lock);
 
 	return 0;
-- 
2.39.2


