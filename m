Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF21C4450F
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:07 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.89975.1783073286385392854
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:08:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=J4zhdX8R;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493c7902f47so2340345e9.1
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073285; x=1783678085; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buQSCCc7HLtk5I+GHBA7mAtb8zTXwNzpRKXqfz1QE3c=;
        b=J4zhdX8Rkos3A+sKJmwkFU4vodYNXUM76zusrMW8Qi+NEBaApWgrLvQjSFn10JNQ2i
         J3lK85OqKcDuXW/NUShVdSKp/oPKElkEAmkI0c0AjTjp/sII6YU81ggAVI/psMe2o7Ml
         0Hw1o3oJ120vwfw6smQt+aawEhkFJ1qHNFF7qyFQqnl0qKlNQ9g+JHXfX7W9tkCr4HwG
         /cyKU468SXNFxfNcp+eE3pA/a3r2C+YcveiOiBFAXes/PmCvDBsSitLtIk+YXfiTTUwc
         Wt5HnWyApoO4ErUfwoAmcnQDtpbQqij8PWiGaWmUBsTEXQwszSpZug7Ljd91x9jwiCIU
         hDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073285; x=1783678085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=buQSCCc7HLtk5I+GHBA7mAtb8zTXwNzpRKXqfz1QE3c=;
        b=HRxquRGCsNXzbTuXWdue9+oXvqrgjTTv63yg2SJ5z4RgtBOK7USv9n0GZrDNAuaq44
         PZU007SwNz1Qo6UIYEI5MayczyPqybcY9MP12j3td0904HY1Zx4nBCcpgguUFJoKGZ8g
         vru19x/ui5qOdbHgEW35Eydq3hoEtlA5uKf6mroHX2TKx4WhtRum6A3T9bcuPdqAlpdj
         pxl2xvJgSdE9MdC/h5htqWAApKuj4OBay8tlWlswncghlEEmGfM5NqLQTyeTZ6b3cSuV
         IUPJ65QVeXgi9W7ymuSF3+EP2yi6L0l9BiIKW9+KFLJhUMF7CMr1+YmG4Dr686do/pgL
         pHuQ==
X-Gm-Message-State: AOJu0YxWOqMCcHaDAaOn3LVTyY81tPvp12MUgRfJdFJfaCeU3HWqf7za
	y0ncwg1VVGWUIOYaMxn304oteteuoZz8ccPBI1jwlLQNu0o2BD4ohxemW/c3sFPr
X-Gm-Gg: AfdE7clFiyZsPMllZAyJ44+7ekn+IB45YoGpEs5E37brdOCrZY18DELh4vi38MwH5kU
	DrcxUfD5b/P0stw61hkiYYn3kAm9BCitv5l+L4nSHyKtDn839yK9ZwxkPPTjluw2BKu6SA9f2kG
	5LWtwtgqQnswXDz81uo0mGYqwCdN8PfTzW/YAU6dBZaMYE/MlSTnvi5J/pB8BlVIXy1NAQdokw4
	TlPArWQXAjVNTZ2NVt+YEnQ+2ocT/qHQTHk+lU49Oxgk4wsK3tTPTnALaouxFouUHKJqzE+gTby
	RZdaREc/IE3lYpWH+4LZJpMsk4/poIZVw0ERxoatbOdaLIEik0CV5LwQD/HSrGlxCWzrCvWvei6
	kj0K6o0gzC+JkcuBZzm2TpwCFypKRsQ+qHY0RE46hn6CKYbV9sp+N8CoffFJ+NknIS0gkY2gK3E
	iGFLN2f+9adfFBEgi+DcomQTBoFg3oV4E=
X-Received: by 2002:a05:600c:3646:b0:493:b150:c607 with SMTP id 5b1f17b1804b1-493c2b4cf23mr85539895e9.12.1783073284474;
        Fri, 03 Jul 2026 03:08:04 -0700 (PDT)
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
Subject: [PATCH 6.12.y-cip 14/26] irqchip/renesas-rzg2l: Split rzfive_tint_irq_endisable() into separate IRQ and TINT helpers
Date: Fri,  3 Jul 2026 11:07:33 +0100
Message-ID: <20260703100756.238233-15-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23406

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 0b2675fadf4fdfdb69c492b38cc0d6f6a3e2f937 ]

rzfive_tint_irq_endisable() handles both IRQ and TINT enable/disable paths
via a hw_irq range check.

Split this into two dedicated helpers, rzfive_irq_endisable() for IRQ
interrupts and rzfive_tint_endisable() for TINT interrupts, each operating
unconditionally on their respective interrupt type.

While at it, simplify rzfive_{irq,tint}_endisable by replacing
raw_spin_lock locking/unlocking with guard() and update the variable types
of offset, tssr_offset, and tssr_index to unsigned int, as these variables
are used only for calculation.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260325192451.172562-10-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 75 +++++++++++++++++------------
 1 file changed, 44 insertions(+), 31 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index ae2d8923aa30..547191642f26 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -213,48 +213,61 @@ static void rzfive_irqc_unmask(struct irq_data *d)
 	irq_chip_unmask_parent(d);
 }
 
-static void rzfive_tint_irq_endisable(struct irq_data *d, bool enable)
+static void rzfive_irq_endisable(struct irq_data *d, bool enable)
 {
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 	unsigned int hwirq = irqd_to_hwirq(d);
 
-	if (hwirq >= IRQC_TINT_START && hwirq < IRQC_NUM_IRQ) {
-		u32 offset = hwirq - IRQC_TINT_START;
-		u32 tssr_offset = TSSR_OFFSET(offset);
-		u8 tssr_index = TSSR_INDEX(offset);
-		u32 reg;
-
-		raw_spin_lock(&priv->lock);
-		if (enable)
-			rzfive_irqc_unmask_tint_interrupt(priv, hwirq);
-		else
-			rzfive_irqc_mask_tint_interrupt(priv, hwirq);
-		reg = readl_relaxed(priv->base + TSSR(tssr_index));
-		if (enable)
-			reg |= TIEN << TSSEL_SHIFT(tssr_offset);
-		else
-			reg &= ~(TIEN << TSSEL_SHIFT(tssr_offset));
-		writel_relaxed(reg, priv->base + TSSR(tssr_index));
-		raw_spin_unlock(&priv->lock);
-	} else {
-		raw_spin_lock(&priv->lock);
-		if (enable)
-			rzfive_irqc_unmask_irq_interrupt(priv, hwirq);
-		else
-			rzfive_irqc_mask_irq_interrupt(priv, hwirq);
-		raw_spin_unlock(&priv->lock);
-	}
+	guard(raw_spinlock)(&priv->lock);
+	if (enable)
+		rzfive_irqc_unmask_irq_interrupt(priv, hwirq);
+	else
+		rzfive_irqc_mask_irq_interrupt(priv, hwirq);
+}
+
+static void rzfive_tint_endisable(struct irq_data *d, bool enable)
+{
+	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
+	unsigned int offset = hwirq - IRQC_TINT_START;
+	unsigned int tssr_offset = TSSR_OFFSET(offset);
+	unsigned int tssr_index = TSSR_INDEX(offset);
+	u32 reg;
+
+	guard(raw_spinlock)(&priv->lock);
+	if (enable)
+		rzfive_irqc_unmask_tint_interrupt(priv, hwirq);
+	else
+		rzfive_irqc_mask_tint_interrupt(priv, hwirq);
+	reg = readl_relaxed(priv->base + TSSR(tssr_index));
+	if (enable)
+		reg |= TIEN << TSSEL_SHIFT(tssr_offset);
+	else
+		reg &= ~(TIEN << TSSEL_SHIFT(tssr_offset));
+	writel_relaxed(reg, priv->base + TSSR(tssr_index));
 }
 
 static void rzfive_irqc_irq_disable(struct irq_data *d)
 {
 	irq_chip_disable_parent(d);
-	rzfive_tint_irq_endisable(d, false);
+	rzfive_irq_endisable(d, false);
 }
 
 static void rzfive_irqc_irq_enable(struct irq_data *d)
 {
-	rzfive_tint_irq_endisable(d, true);
+	rzfive_irq_endisable(d, true);
+	irq_chip_enable_parent(d);
+}
+
+static void rzfive_irqc_tint_disable(struct irq_data *d)
+{
+	irq_chip_disable_parent(d);
+	rzfive_tint_endisable(d, false);
+}
+
+static void rzfive_irqc_tint_enable(struct irq_data *d)
+{
+	rzfive_tint_endisable(d, true);
 	irq_chip_enable_parent(d);
 }
 
@@ -498,8 +511,8 @@ static const struct irq_chip rzfive_irqc_tint_chip = {
 	.irq_eoi		= rzg2l_irqc_tint_eoi,
 	.irq_mask		= rzfive_irqc_mask,
 	.irq_unmask		= rzfive_irqc_unmask,
-	.irq_disable		= rzfive_irqc_irq_disable,
-	.irq_enable		= rzfive_irqc_irq_enable,
+	.irq_disable		= rzfive_irqc_tint_disable,
+	.irq_enable		= rzfive_irqc_tint_enable,
 	.irq_get_irqchip_state	= irq_chip_get_parent_state,
 	.irq_set_irqchip_state	= irq_chip_set_parent_state,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-- 
2.43.0


