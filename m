Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CE6C4450C
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:18 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89143.1783073289137295192
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:08:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Fnl/RsAn;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493c52cde9eso3902625e9.3
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073287; x=1783678087; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NqNevrZk6YLTxSnD137nI18tRXDY4nryGHm6RZShhU=;
        b=Fnl/RsAn5w7zcHaatQitooWrYGqiDHWclnSJLYF5bfb2U+wWz5t1IQIbUUZz2VVw+H
         MshAFPyGdUNPH6y9HvQ8x+n0V2IJ8BuqAVWqDPoBJ3nkpe/dOWxlfMfhdl4Ol/AMFstI
         x09v9RBaiEpT/vyIum0eHL7EcFbVCsZZJuVqMGF0+PhOuwKSDz3SN6RBGuZudEXKmdcS
         2n4f+5FJSh4yVwM+/tsRgD1QOKBS3jOTtlyAYaltB/cn0ReQW8uwwTBFedgwKFY51xEJ
         sexvPbVVZwaTWKiwyjdR+rJ5IlgVU9gTnT4jq+zRbeo2XnBWpvn43Zbw1TnUitgO52yj
         N3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073287; x=1783678087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9NqNevrZk6YLTxSnD137nI18tRXDY4nryGHm6RZShhU=;
        b=e81v+69v1ocxV8Y7QhPPGOwNlzEse0ABYyUCFn7VxxomOH2emZwAXnV9wc3/aF0UmP
         uHPOn+i6HBKYbrHaAyNb8sUr9Htk1Mwx4zLqj4iEeu8dpghcJmoxyidseXsZnTLJ2eAz
         8c+5O0IpnQQ0JW9QRIFuXCGpSk3uYVpgbdgJtwSqybt2WFDgHZNiHbE+KjuKANvpdM0T
         DLGG95RmLUmhXEIapimkfxo9019ASBr1RVAhuLqQXzfIRHd47AXdeh8ZWZnT+3kAdW9D
         NEmrRex7LNwEbY0sZGs0F/sOLZ1qFUCMCwVHNxxiN2Erw/0DFgqIjAjvdHSWaL1Y70c1
         lvpQ==
X-Gm-Message-State: AOJu0YxJM/czitoVdQCXzI2vu2X/lqMhkVrxciFMemweOoxDuFYbpbJC
	2NBrDljFUnptlCe9+d4UyH5R2k1yiC+noSzS0v3MKkFhuqfbaOuUNuzUq5aMzrz1
X-Gm-Gg: AfdE7ckAL+ozhbCg5SHszYM+ODxVPO4GYzzOD3n9OLwZJkJlyEIYqQJfYt3GKPX3VAY
	MXyriyKE/uSFXXsSv97RCh3a++9brWSr7OfF+2VheMBwN5SDdoKwhp4qnX+y4A2iaCVheCPoALA
	q/H+dBRTCaVro9GpXX9XXS2ALkTcbFL+/gTFwMzMJ5roSVCDi6ePxMndg5xvqqmsrN3l+Y7mAVH
	Y+xqjzZ7VRrhKFHbU3CCqiQAZcNYT5bAxAheKoMQiqehYDWvcqfwQUvR7GQ8CDBt/9QPovXwxB5
	QDB8h/FxeWX1ddtVaImLEjzjSIxcD2PocsezwwAisV/c/NUS4cGQRXAWUI1iue/Ofp5WPa7lRxM
	FS60c3rpxs02vTDzTmamfPe4UhhYH5jZs3H0Cmxdg5dbaMsaiCfOUP0EOvTzZ07EHgTcJkfxVId
	dQx98Ile4TtXcWnEUwbKT5
X-Received: by 2002:a05:600d:3:b0:492:523f:a3df with SMTP id 5b1f17b1804b1-493c2b161b3mr117762945e9.5.1783073287306;
        Fri, 03 Jul 2026 03:08:07 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab3a8sm40993765e9.6.2026.07.03.03.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:08:07 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 19/26] irqchip/renesas-rzg2l: Drop IRQC_IRQ_COUNT macro
Date: Fri,  3 Jul 2026 11:07:38 +0100
Message-ID: <20260703100756.238233-20-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23411

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit f9544cad3600f251a7d24c2fb77e7f2abdceb42e ]

The total number of external interrupts in RZ/G2L and RZ/G3L SoC are
different. The RZ/G3L has 16 external interrupts whereas RZ/G2L has only 8
external interrupts. Add irq_count variable in struct rzg2l_hw_info to
handle these differences and drop the macro IRQC_IRQ_COUNT.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260325192451.172562-15-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 73f6e86b57d6..86e79f1484c2 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -22,7 +22,6 @@
 #include <linux/syscore_ops.h>
 
 #define IRQC_IRQ_START			1
-#define IRQC_IRQ_COUNT			8
 #define IRQC_TINT_COUNT			32
 
 #define ISCR				0x10
@@ -69,10 +68,12 @@ struct rzg2l_irqc_reg_cache {
 
 /**
  * struct rzg2l_hw_info - Interrupt Control Unit controller hardware info structure.
+ * @irq_count:		Number of IRQC interrupts
  * @tint_start:		Start of TINT interrupts
  * @num_irq:		Total Number of interrupts
  */
 struct rzg2l_hw_info {
+	unsigned int	irq_count;
 	unsigned int	tint_start;
 	unsigned int	num_irq;
 };
@@ -570,7 +571,7 @@ static int rzg2l_irqc_alloc(struct irq_domain *domain, unsigned int virq,
 	 * from 16-31 bits. TINT from the pinctrl driver needs to be programmed
 	 * in IRQC registers to enable a given gpio pin as interrupt.
 	 */
-	if (hwirq > IRQC_IRQ_COUNT) {
+	if (hwirq > priv->info.irq_count) {
 		tint = TINT_EXTRACT_GPIOINT(hwirq);
 		hwirq = TINT_EXTRACT_HWIRQ(hwirq);
 		chip = priv->tint_chip;
@@ -693,8 +694,9 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 }
 
 static const struct rzg2l_hw_info rzg2l_hw_params = {
-	.tint_start	= IRQC_IRQ_START + IRQC_IRQ_COUNT,
-	.num_irq	= IRQC_IRQ_START + IRQC_IRQ_COUNT + IRQC_TINT_COUNT,
+	.irq_count	= 8,
+	.tint_start	= IRQC_IRQ_START + 8,
+	.num_irq	= IRQC_IRQ_START + 8 + IRQC_TINT_COUNT,
 };
 
 static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
-- 
2.43.0


