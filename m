Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3290CC4450D
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:07 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89138.1783073285877614503
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:08:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=r6bKUfYw;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493be1b9564so2595795e9.2
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073284; x=1783678084; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O07MoSwpoouvwzicFFWIEu1QmNc0ERYwYSVoMnM4t2k=;
        b=r6bKUfYwYR6w1IUPEnMZ6ZQNBKfKcYSNK2MBRcD/XajM+W91u8cWfu2JW3R37ZM68Y
         4dS/ZmS9w7ejzo+lKCHQYTBf9mwqLsqIvbI6Dj1XJFPeTelaB36TT0tdXJOy28i+OmvS
         Vry3PLqH4SlTIqEVJA13Ursu7xTzNqsmWn3QirpFRLeikk+NwEud19EHgJmE2qAFW3S5
         Z4lkPayDZdg6t1JiZBL2hZRGb8N9ANroXROfHFzFjyBnQe3dvVsTALSJHqk1ZRjML/iV
         veCzCCZQuGmi3/VSSEbjk/lvORFbJ1ccl9ySWT0v71U+kCiFVpoRQe81km7d+qypLClT
         nagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073284; x=1783678084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O07MoSwpoouvwzicFFWIEu1QmNc0ERYwYSVoMnM4t2k=;
        b=NsKERsNDHIHM4XCnOVacXP7Cxi7DTwyEGz83XEJkUsfDx9khm3I7UF6bTy0vDBkwXZ
         ZK/Jk5Iefss3kiWgpVzX+XF1O3Ktiryz1x1Hs3tzvwUyfaaZj4vQH666Aw9kZIvyQxPc
         9MCMl9EC8p0d4HTYJMlHCHzZ1jbC9HTjQrQmqho44hDyvpgYOOfMizlbKro7V+vDRMfh
         aborpMZ6Y2KnM9pBzl9K6Q5We41IpsWUIQWjc2QNALatCbbeXkmxlKo0uNcdfKV07lmc
         P53YaCKhQxPkP8PI2E0JAJ147jiHsbaSmKazGDrCsye8cWlf1zIXPGuA43d2bOxhD7rz
         jMBQ==
X-Gm-Message-State: AOJu0Yyvd20XfZxlFAISGVRnR+UKSTm64Gxhbb5LDwsGcxYCqWwSMlOH
	ytWE0d8FS+uzuUFiV6Jlm7bWGEdayEJHB35Y/d6Ev+vRkV5Q5Ub0pqwH9FfvyhGQ
X-Gm-Gg: AfdE7cm6c9YCnU4Ig+ql310QQMeP0Rq2YlM0qVwg7OQsZQGar9UuaoMENQ1bU3dGq3t
	6jtv3F/5rfYwjup0ev9ytbkR+VDGRl28YDHs2o6vIXR9IhbnMNL3QT/f1QoxIqqMiMahMsq/b7a
	i6XEqMf9bEAsN5ytPRV2jrsfqr84RdALk8hFreGnwmQEx0TLVlxx71xQjIu///+JZ57KM9T16EW
	44SOr4ZaMhrVnt3KyIRqdNOvhNqCd9Zb4Tjds5PunkIlGQuzy6hyJ+j2dHL5kYH6/Ho8ojnhNBG
	jGn7sofFpUsnb1u3p0Nmz1v8VoQNAVfAeIRygxgJ9o1hgsjg47zRh10t/wq/l//xsd0WcjGircD
	xsWK3twGtObuj1b7h/e9t6mPY/+92xZekt+jI6jmcHdU+eUxHRI99BUxuTU7qwC1BeiD9gJwhhj
	duwH1sNPIjeXGC95Notpo/
X-Received: by 2002:a05:600c:5292:b0:492:3754:15f2 with SMTP id 5b1f17b1804b1-493c3cfbc7amr130428715e9.32.1783073283935;
        Fri, 03 Jul 2026 03:08:03 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab3a8sm40993765e9.6.2026.07.03.03.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:08:03 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 13/26] irqchip/renesas-rzg2l: Replace rzg2l_irqc_irq_{enable,disable} with TINT-specific handlers
Date: Fri,  3 Jul 2026 11:07:32 +0100
Message-ID: <20260703100756.238233-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23405

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 83ed8efca07a076906c4c24749ee2fd5835c0ade ]

rzg2l_irqc_irq_disable() and rzg2l_irqc_irq_enable() are used by both the
IRQ and TINT chips, but only perform TINT-specific work via
rzg2l_tint_irq_endisable(), guarded by a hw_irq range check.

Since the IRQ chip does not require this extra enable/disable handling,
replace its callbacks with the generic irq_chip_disable_parent() and
irq_chip_enable_parent() directly.

While at it, simplify rzfive_irqc_irq_enable() by replacing raw_spin_lock
locking/unlocking with guard() and update the variable types of offset,
tssr_offset, and tssr_index to unsigned int, as these variables are used
only for calculation.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260325192451.172562-9-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 40 +++++++++++++----------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 3704e58a0def..ae2d8923aa30 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -260,33 +260,29 @@ static void rzfive_irqc_irq_enable(struct irq_data *d)
 
 static void rzg2l_tint_irq_endisable(struct irq_data *d, bool enable)
 {
+	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 	unsigned int hw_irq = irqd_to_hwirq(d);
+	unsigned int offset = hw_irq - IRQC_TINT_START;
+	unsigned int tssr_offset = TSSR_OFFSET(offset);
+	unsigned int tssr_index = TSSR_INDEX(offset);
+	u32 reg;
 
-	if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
-		struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
-		u32 offset = hw_irq - IRQC_TINT_START;
-		u32 tssr_offset = TSSR_OFFSET(offset);
-		u8 tssr_index = TSSR_INDEX(offset);
-		u32 reg;
-
-		raw_spin_lock(&priv->lock);
-		reg = readl_relaxed(priv->base + TSSR(tssr_index));
-		if (enable)
-			reg |= TIEN << TSSEL_SHIFT(tssr_offset);
-		else
-			reg &= ~(TIEN << TSSEL_SHIFT(tssr_offset));
-		writel_relaxed(reg, priv->base + TSSR(tssr_index));
-		raw_spin_unlock(&priv->lock);
-	}
+	guard(raw_spinlock)(&priv->lock);
+	reg = readl_relaxed(priv->base + TSSR(tssr_index));
+	if (enable)
+		reg |= TIEN << TSSEL_SHIFT(tssr_offset);
+	else
+		reg &= ~(TIEN << TSSEL_SHIFT(tssr_offset));
+	writel_relaxed(reg, priv->base + TSSR(tssr_index));
 }
 
-static void rzg2l_irqc_irq_disable(struct irq_data *d)
+static void rzg2l_irqc_tint_disable(struct irq_data *d)
 {
 	irq_chip_disable_parent(d);
 	rzg2l_tint_irq_endisable(d, false);
 }
 
-static void rzg2l_irqc_irq_enable(struct irq_data *d)
+static void rzg2l_irqc_tint_enable(struct irq_data *d)
 {
 	rzg2l_tint_irq_endisable(d, true);
 	irq_chip_enable_parent(d);
@@ -451,8 +447,8 @@ static const struct irq_chip rzg2l_irqc_irq_chip = {
 	.irq_eoi		= rzg2l_irqc_irq_eoi,
 	.irq_mask		= irq_chip_mask_parent,
 	.irq_unmask		= irq_chip_unmask_parent,
-	.irq_disable		= rzg2l_irqc_irq_disable,
-	.irq_enable		= rzg2l_irqc_irq_enable,
+	.irq_disable		= irq_chip_disable_parent,
+	.irq_enable		= irq_chip_enable_parent,
 	.irq_get_irqchip_state	= irq_chip_get_parent_state,
 	.irq_set_irqchip_state	= irq_chip_set_parent_state,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
@@ -468,8 +464,8 @@ static const struct irq_chip rzg2l_irqc_tint_chip = {
 	.irq_eoi		= rzg2l_irqc_tint_eoi,
 	.irq_mask		= irq_chip_mask_parent,
 	.irq_unmask		= irq_chip_unmask_parent,
-	.irq_disable		= rzg2l_irqc_irq_disable,
-	.irq_enable		= rzg2l_irqc_irq_enable,
+	.irq_disable		= rzg2l_irqc_tint_disable,
+	.irq_enable		= rzg2l_irqc_tint_enable,
 	.irq_get_irqchip_state	= irq_chip_get_parent_state,
 	.irq_set_irqchip_state	= irq_chip_set_parent_state,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-- 
2.43.0


