Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45829C43458
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:17 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.89976.1783073286948698327
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:08:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=d/eZ69cV;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so2584305e9.0
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073285; x=1783678085; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jntt8D+hMpkREaUSeB6EcHnWC6nOZfQA/exyeb8Iyg=;
        b=d/eZ69cVDGI13eaezR7KRm7QM0JMckczsSJd6unKQ8lq4KeNT9mcBzlruBdqqZjfz1
         h0h/i15g6Mw/rjAdxFBMnXPiRC5nz7bzSQqks6FXlxx/EaX/nrsDvaU1HIMgximkjhc5
         vEbiJbL4pxiXHOQH1V3Dlg9QE6xP4aoTvq1dM9v8GMp9fXzV3jDomKKIfyqiEsoibMth
         hl7Yth52iT9SgHwnRcpXD89oFwdmlVuPXlObH00/enSzWOjllSB34e3koYhZS+qgtF9U
         yldOH8wdHjZsHL1X1HcGsCp0pu5ch2ScUzC9H8CPH59Db9nz/fp1aB8a7doO93TH9K7F
         qWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073285; x=1783678085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9jntt8D+hMpkREaUSeB6EcHnWC6nOZfQA/exyeb8Iyg=;
        b=adLxWXYGggFReQUitxZegNakvOwaKfU2cYSKksmvsN75MNRhTuibk1TI8uVl3kjwvn
         l+Ix58eh9btlsRBI3pzzoV0XZtcJlgyb60d22FcEg19SP81TOIEW9ffpXwIYu9Ri/pfn
         MeYmr5W9jmmQV7/jzcctraoFazQ+L90jyhHBDSGcrkyv0rWLE72AuY8IDUybcfINFYm+
         np6JXwYpQIEIUhVLClZCwZ4KaAgbmNo5Zvp7mOKvtWHkGrpMBW7Dx8NY7xAWt9CervLD
         AadOJZ0AtHnweNbMyldMCzaONbmPDKqJ3ZmqJqUDi0RRjzXTvw8FcnkO5+hSBBcYdn27
         Xf3A==
X-Gm-Message-State: AOJu0Ywf3Ie1nxy4JOQVPSPVTxL9aMUf+QXkE21pJUk21H1clnRzec0k
	VuzqywT3Wbq/oyLLCiHX82q9EhcE+I+o4CszCeNNSSoifVarYxbJE5xM0Jmdx4lh
X-Gm-Gg: AfdE7ckQRB78GbUDLvvfr5z6cqU1zdwfVDz1DMQRD3LvzmLLsFxK0LI0kHt2vnic0cJ
	DXO0xVqHQYaciP6wM/5EL1D6Jw8N6QFfc4qZLismDnjAgCv2PseZQELWZaxsrIwWvvPygiMlXni
	gEImRUVUJda9Y+YDzVfC11ulfq1EDVz9I9kvj3/UOsUMq+3vls0GKv60xXQCybZesJfh5m31cHb
	TGlTq1JyLb5iJvKZUKpUQsTD/U2qOTQrdQXyq68ra884QB8S+bH1RDVB2cbX63d9Sf5rYThmSan
	xFOj2ZofHmqUZXxMsyT4tiyCwnxNU5Qs7Tjltgu9Zal6k0GV8uJr03jSt8ElNMSpQYKGNpEb6MA
	r4BbgKNoTXES9RCQl4FqwEwGDssyJRvRnMXug+URYz7O/bIre9lnEZZcIrYlDZJQCYRoNghZyxh
	pIc4TTX9O2D5MfBLWxqGrA
X-Received: by 2002:a05:600c:4ecf:b0:493:ae5d:8c40 with SMTP id 5b1f17b1804b1-493c2b95cfbmr135891815e9.27.1783073285115;
        Fri, 03 Jul 2026 03:08:05 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab3a8sm40993765e9.6.2026.07.03.03.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:08:04 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 15/26] irqchip/renesas-rzg2l: Split rzfive_irqc_{mask,unmask} into separate IRQ and TINT handlers
Date: Fri,  3 Jul 2026 11:07:34 +0100
Message-ID: <20260703100756.238233-16-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23407

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit bcb30669088a69cc8de2a5cf446b8b72f6b6e8eb ]

rzfive_irqc_mask() and rzfive_irqc_unmask() use hw_irq range checks to
dispatch between IRQ and TINT masking operations. Split each into two
dedicated handlers — rzfive_irqc_irq_mask(), rzfive_irqc_tint_mask(),
rzfive_irqc_irq_unmask(), and rzfive_irqc_tint_unmask() — each operating
unconditionally on its respective interrupt type, removing the runtime
conditionals.

Assign the IRQ-specific handlers to rzfive_irqc_irq_chip and the
TINT-specific handlers to rzfive_irqc_tint_chip, consistent with the
separation applied to the EOI, set_type, and enable/disable callbacks in
previous patches.

While at it, simplify rzfive_irqc_{irq,tint}_{mask,unmask}() by replacing
raw_spin_lock locking/unlocking with scoped_guard().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260325192451.172562-11-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 44 ++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 547191642f26..1511e6bcbc4e 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -185,31 +185,47 @@ static void rzfive_irqc_unmask_tint_interrupt(struct rzg2l_irqc_priv *priv,
 	writel_relaxed(readl_relaxed(priv->base + TMSK) & ~bit, priv->base + TMSK);
 }
 
-static void rzfive_irqc_mask(struct irq_data *d)
+static void rzfive_irqc_irq_mask(struct irq_data *d)
 {
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 	unsigned int hwirq = irqd_to_hwirq(d);
 
-	raw_spin_lock(&priv->lock);
-	if (hwirq >= IRQC_IRQ_START && hwirq <= IRQC_IRQ_COUNT)
+	scoped_guard(raw_spinlock, &priv->lock)
 		rzfive_irqc_mask_irq_interrupt(priv, hwirq);
-	else if (hwirq >= IRQC_TINT_START && hwirq < IRQC_NUM_IRQ)
+
+	irq_chip_mask_parent(d);
+}
+
+static void rzfive_irqc_tint_mask(struct irq_data *d)
+{
+	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
+
+	scoped_guard(raw_spinlock, &priv->lock)
 		rzfive_irqc_mask_tint_interrupt(priv, hwirq);
-	raw_spin_unlock(&priv->lock);
+
 	irq_chip_mask_parent(d);
 }
 
-static void rzfive_irqc_unmask(struct irq_data *d)
+static void rzfive_irqc_irq_unmask(struct irq_data *d)
 {
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 	unsigned int hwirq = irqd_to_hwirq(d);
 
-	raw_spin_lock(&priv->lock);
-	if (hwirq >= IRQC_IRQ_START && hwirq <= IRQC_IRQ_COUNT)
+	scoped_guard(raw_spinlock, &priv->lock)
 		rzfive_irqc_unmask_irq_interrupt(priv, hwirq);
-	else if (hwirq >= IRQC_TINT_START && hwirq < IRQC_NUM_IRQ)
+
+	irq_chip_unmask_parent(d);
+}
+
+static void rzfive_irqc_tint_unmask(struct irq_data *d)
+{
+	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
+
+	scoped_guard(raw_spinlock, &priv->lock)
 		rzfive_irqc_unmask_tint_interrupt(priv, hwirq);
-	raw_spin_unlock(&priv->lock);
+
 	irq_chip_unmask_parent(d);
 }
 
@@ -492,8 +508,8 @@ static const struct irq_chip rzg2l_irqc_tint_chip = {
 static const struct irq_chip rzfive_irqc_irq_chip = {
 	.name			= "rzfive-irqc",
 	.irq_eoi		= rzg2l_irqc_irq_eoi,
-	.irq_mask		= rzfive_irqc_mask,
-	.irq_unmask		= rzfive_irqc_unmask,
+	.irq_mask		= rzfive_irqc_irq_mask,
+	.irq_unmask		= rzfive_irqc_irq_unmask,
 	.irq_disable		= rzfive_irqc_irq_disable,
 	.irq_enable		= rzfive_irqc_irq_enable,
 	.irq_get_irqchip_state	= irq_chip_get_parent_state,
@@ -509,8 +525,8 @@ static const struct irq_chip rzfive_irqc_irq_chip = {
 static const struct irq_chip rzfive_irqc_tint_chip = {
 	.name			= "rzfive-irqc",
 	.irq_eoi		= rzg2l_irqc_tint_eoi,
-	.irq_mask		= rzfive_irqc_mask,
-	.irq_unmask		= rzfive_irqc_unmask,
+	.irq_mask		= rzfive_irqc_tint_mask,
+	.irq_unmask		= rzfive_irqc_tint_unmask,
 	.irq_disable		= rzfive_irqc_tint_disable,
 	.irq_enable		= rzfive_irqc_tint_enable,
 	.irq_get_irqchip_state	= irq_chip_get_parent_state,
-- 
2.43.0


