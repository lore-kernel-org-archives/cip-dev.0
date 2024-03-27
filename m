Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F89CD129E
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web11.32302.1711527508313419931
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=MaNEYmnk;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-515a81928faso4095957e87.1
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527506; x=1712132306; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79HGkxc3zqzaRqpIOSMeiSnu105LzImNQUCew6Iy78E=;
        b=MaNEYmnkdnBKKN3kBlBmRoK8hY60K0fgPCU0MuoHuTm0x1w+7Kxykcklmsimj1fUaz
         RWJaiEVV7y79TzKLC7aLPdf2Is7FG19TbS5vB3fQfPl/I6pcgirx95K+j+2iTXqVtrXt
         5zUICJdqSrTwynfvHGq5AYvPRbdzr34wAR1T8r9lBH1563LsZOVQYYl97gq6csXrOD40
         4dnaKCoUbucvJJAp1QLUs/+2H1rq0ZezEnv67guWRLlRrG8s0qLL4T5kBotudrrPTs7p
         nVistMxSEB0uFa/7MN4lJCE5UO8KX+qzzHh3OlAloF7C7nFgOdFcW3IVu0B2vOpY4CfH
         sEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527506; x=1712132306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79HGkxc3zqzaRqpIOSMeiSnu105LzImNQUCew6Iy78E=;
        b=eadywWQkIfgBfTbg7nqPzqz4jKfXDS5wRY9m5jPhnUF00om/vHdkVzw4I/o2iUpGjx
         KCrio0QkEXiMkd+R4MxgPh4oGTBckSW7M8BTbsLXFj6SBosoynaUlZbJcv1ypc+C2DkE
         lQg8IySErb5iwfV37UM2KspHfZk+zrbkPfcYWQlq+49AspBDzpm4x2Ixjz+GMST97Wbi
         GtsK/Dieq9ROdSpZ546BNcjdA6hwLUWy7WTGLGvpXFcnFBOroFmZ2L8SNFl0XIQGc3AT
         PnzS9VDXgMFVYGdi7tuo1xEDKOyTi00VKbnH981vetKbPD6/Nr/PNjsK9ZRI48tD8exU
         h4/g==
X-Gm-Message-State: AOJu0YxwhfGw/Dqxd1TJjh7ZPb7nXZd96c1fb04fYUMkbI0kE1DNkFEg
	VLwByF08vc7MFA0R3N4gl09ysBlu2S0zt10Z18Wb/VR+4Xkfo8mcJ9LflPT5Zg0=
X-Google-Smtp-Source: AGHT+IEU69R4mlPEhe2AR0XWb89XT9JV4dBYxdyvJ4HfhnpdB/0BlG45bJMOhKzsU4WF4iEGZzZqPg==
X-Received: by 2002:a05:6512:3082:b0:515:bacd:adbf with SMTP id z2-20020a056512308200b00515bacdadbfmr2704073lfd.34.1711527506629;
        Wed, 27 Mar 2024 01:18:26 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:26 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 24/36] irqchip/renesas-rzg2l: Prevent spurious interrupts when setting trigger type
Date: Wed, 27 Mar 2024 10:17:44 +0200
Message-Id: <20240327081756.2228036-25-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15441

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
index 09bae23e5c8f..7b20af3886c7 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -169,8 +169,10 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
 
 static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
 {
-	unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_IRQ_START;
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
+	u32 iitseln = hwirq - IRQC_IRQ_START;
+	bool clear_irq_int = false;
 	u16 sense, tmp;
 
 	switch (type & IRQ_TYPE_SENSE_MASK) {
@@ -180,14 +182,17 @@ static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
 
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
@@ -196,21 +201,40 @@ static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
 
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
@@ -232,10 +256,14 @@ static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
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


