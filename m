Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB5DC44508
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:17 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89148.1783073293229765487
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:08:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Hw6R4RYj;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493bfe9f886so2052815e9.0
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073291; x=1783678091; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLfTewrBuQRgce38XwYQizVj26DeWnDiKUm3+gQcxV4=;
        b=Hw6R4RYjdaRkqKpxkmRIIE7yZbWEiRNExSJJ+OMv8Pf5mWDfl0k/n8xo/plZNzLHoz
         tuGtAocY+lTl9XpIFvrnbUS+FcrrUbGB89VJLWZPLrFX/jdNrihpHbAuQl9w3FzrCHG6
         a9wkNmrfZQWB+84YwlTdfBCKme6QT3fmEYt84xp2op2tbvWlcTLHbvKnBWMDeWftmdbK
         3ZVsDdQ42P5fpuON8TMbOm6mzaUR9BoN2NUEdYqKDgcftFOaMQiRpT7OyL4qyBM1HnCI
         zC5ZnFQOFLlmjA8osF5AbDthrfEClP1cS3ois/2EO4GW5aciN2dLzB3iNBuDs5gY0DVy
         mx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073291; x=1783678091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dLfTewrBuQRgce38XwYQizVj26DeWnDiKUm3+gQcxV4=;
        b=b8d6XrqxVTXTQydNfMlnPf7+lFJXANdgDGYtSnLrQJG+Eqf7JtbbbtYxioKLTLEkoa
         KQVK0Dte9XNKPXszsSPX8tBXC7t8c7C2c06DP5YPFGi5nrACStgTJFLlmWEDjfcQWAs2
         Ifssu9tHmXbIK4FXn5SkIq49TM2V2Kcp05dSU9n6Lib2/1Ngv6Dq/kUjMV5lbkasqhBR
         aiy1m0PkHWGnbo2mPozUM6Jafbg4vKGbfUjrw+RLQqExKyK+3O9alJYPOVpJTbe2TNd6
         SCALwVwG2TjzufK6mN9g635Mvr57lVlAbDMdgZlGU+EynLPyRR8pWOO0ippD2AY7V6nk
         ClTQ==
X-Gm-Message-State: AOJu0Yya6J2vu6e5K8+ISQT3YkI2Of+iPRsG7ctjW5Wn6TKbBDd5P/mA
	HwWtyXRHUE2unIkNpl051gpR+9Oc2dWpnKgHiACfgOZoX7nH2zwjsbJGR4S+pOvF
X-Gm-Gg: AfdE7clwIpE41wUm65uBPJtg1nVK1yNWKcCh9zPs6cR04mIcz7sMZEwRi2T9T7E3uaS
	PXcvKLcEeu3Ei2CqaWrgP+jxSPuY/xDLmVfLF+Zu3LuxxznBfi9fp1CxRKfcuS8smqekRhhnknY
	aKLipKCP5YrFPk0pSQMz1i9DGwJ2c6/09Hwvai5OT04VxEZwfrY17pB9aHxSi0XhBmcmru1z+pY
	V7HiagAR9oUGAUe6DD+/YB+HQAZiAQ4y5Lcv/eb9ctIFPuyVsR95cf0FN+aSbAsEEjU/5Fy2w2J
	+wLCpTSRMg+g+oPCMUhxTH1e/3HJm/DNjaMpUP5Rgs4Y/SIPi16wqwrcAywvGCJW2gYcNbra6qZ
	HTPxdPlr1v+/IPEGM+oRhxePT+St7ZLF+Zi6Tg0gXsDP5DpRAqJf0QbfhIP3QNX0IdnkXBLr+RN
	ih7HHXD0GVNtKlFp7hdyIn
X-Received: by 2002:a05:600c:8b16:b0:490:d354:bcf4 with SMTP id 5b1f17b1804b1-493c2b97350mr130754265e9.27.1783073291269;
        Fri, 03 Jul 2026 03:08:11 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab3a8sm40993765e9.6.2026.07.03.03.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:08:11 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 26/26] irqchip/renesas-rzg2l: Add NMI support
Date: Fri,  3 Jul 2026 11:07:45 +0100
Message-ID: <20260703100756.238233-27-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23418

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 0e5988549dc73d985cc12c4cb438771ced74f522 ]

The RZ/G2L SoC has an NMI interrupt. Add support for the NMI interrupt.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260401114504.332825-1-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 99 +++++++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 93510bcd79c2..8a339e5e8946 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -21,11 +21,14 @@
 #include <linux/spinlock.h>
 #include <linux/syscore_ops.h>
 
+#define IRQC_NMI			0
 #define IRQC_IRQ_START			1
 #define IRQC_TINT_COUNT			32
 #define IRQC_SHARED_IRQ_COUNT		8
 #define IRQC_IRQ_SHARED_START		(IRQC_IRQ_START + IRQC_SHARED_IRQ_COUNT)
 
+#define NSCR				0x0
+#define NITSR				0x4
 #define ISCR				0x10
 #define IITSR				0x14
 #define TSCR				0x20
@@ -44,6 +47,10 @@
 #define TSSR_OFFSET(n)			((n) % 4)
 #define TSSR_INDEX(n)			((n) / 4)
 
+#define NSCR_NSTAT			0
+#define NITSR_NTSEL_EDGE_FALLING	0
+#define NITSR_NTSEL_EDGE_RISING		1
+
 #define TITSR_TITSEL_EDGE_RISING	0
 #define TITSR_TITSEL_EDGE_FALLING	1
 #define TITSR_TITSEL_LEVEL_HIGH		2
@@ -64,11 +71,13 @@
 
 /**
  * struct rzg2l_irqc_reg_cache - registers cache (necessary for suspend/resume)
- * @iitsr: IITSR register
- * @inttsel: INTTSEL register
- * @titsr: TITSR registers
+ * @nitsr:	NITSR register
+ * @iitsr:	IITSR register
+ * @inttsel:	INTTSEL register
+ * @titsr:	TITSR registers
  */
 struct rzg2l_irqc_reg_cache {
+	u32	nitsr;
 	u32	iitsr;
 	u32	inttsel;
 	u32	titsr[2];
@@ -117,6 +126,28 @@ static struct rzg2l_irqc_priv *irq_data_to_priv(struct irq_data *data)
 	return data->domain->host_data;
 }
 
+static void rzg2l_clear_nmi_int(struct rzg2l_irqc_priv *priv)
+{
+	u32 bit = BIT(NSCR_NSTAT);
+	u32 reg;
+
+	/*
+	 * No locking required as the register is not shared
+	 * with other interrupts.
+	 *
+	 * Writing is allowed only when NSTAT is 1
+	 */
+	reg = readl_relaxed(priv->base + NSCR);
+	if (reg & bit) {
+		writel_relaxed(reg & ~bit, priv->base + NSCR);
+		/*
+		 * Enforce that the posted write is flushed to prevent that the
+		 * just handled interrupt is raised again.
+		 */
+		readl_relaxed(priv->base + NSCR);
+	}
+}
+
 static void rzg2l_clear_irq_int(struct rzg2l_irqc_priv *priv, unsigned int hwirq)
 {
 	unsigned int hw_irq = hwirq - IRQC_IRQ_START;
@@ -156,6 +187,14 @@ static void rzg2l_clear_tint_int(struct rzg2l_irqc_priv *priv, unsigned int hwir
 	}
 }
 
+static void rzg2l_irqc_nmi_eoi(struct irq_data *d)
+{
+	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+
+	rzg2l_clear_nmi_int(priv);
+	irq_chip_eoi_parent(d);
+}
+
 static void rzg2l_irqc_irq_eoi(struct irq_data *d)
 {
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
@@ -342,6 +381,26 @@ static void rzg2l_irqc_tint_enable(struct irq_data *d)
 	irq_chip_enable_parent(d);
 }
 
+static int rzg2l_nmi_set_type(struct irq_data *d, unsigned int type)
+{
+	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	u32 sense;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_EDGE_FALLING:
+		sense = NITSR_NTSEL_EDGE_FALLING;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		sense = NITSR_NTSEL_EDGE_RISING;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	writel_relaxed(sense, priv->base + NITSR);
+	return 0;
+}
+
 static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
@@ -468,11 +527,23 @@ static int rzg2l_irqc_tint_set_type(struct irq_data *d, unsigned int type)
 	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
 }
 
+static int rzg2l_irqc_nmi_set_type(struct irq_data *d, unsigned int type)
+{
+	int ret;
+
+	ret = rzg2l_nmi_set_type(d, type);
+	if (ret)
+		return ret;
+
+	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
+}
+
 static int rzg2l_irqc_irq_suspend(void)
 {
 	struct rzg2l_irqc_reg_cache *cache = &rzg2l_irqc_data->cache;
 	void __iomem *base = rzg2l_irqc_data->base;
 
+	cache->nitsr = readl_relaxed(base + NITSR);
 	cache->iitsr = readl_relaxed(base + IITSR);
 	if (rzg2l_irqc_data->info.shared_irq_cnt)
 		cache->inttsel = readl_relaxed(base + INTTSEL);
@@ -497,6 +568,7 @@ static void rzg2l_irqc_irq_resume(void)
 	if (rzg2l_irqc_data->info.shared_irq_cnt)
 		writel_relaxed(cache->inttsel, base + INTTSEL);
 	writel_relaxed(cache->iitsr, base + IITSR);
+	writel_relaxed(cache->nitsr, base + NITSR);
 }
 
 static struct syscore_ops rzg2l_irqc_syscore_ops = {
@@ -504,6 +576,23 @@ static struct syscore_ops rzg2l_irqc_syscore_ops = {
 	.resume		= rzg2l_irqc_irq_resume,
 };
 
+static const struct irq_chip rzg2l_irqc_nmi_chip = {
+	.name			= "rzg2l-irqc",
+	.irq_eoi		= rzg2l_irqc_nmi_eoi,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_disable		= irq_chip_disable_parent,
+	.irq_enable		= irq_chip_enable_parent,
+	.irq_get_irqchip_state	= irq_chip_get_parent_state,
+	.irq_set_irqchip_state	= irq_chip_set_parent_state,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_type		= rzg2l_irqc_nmi_set_type,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND |
+				  IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE,
+};
+
 static const struct irq_chip rzg2l_irqc_irq_chip = {
 	.name			= "rzg2l-irqc",
 	.irq_eoi		= rzg2l_irqc_irq_eoi,
@@ -659,7 +748,9 @@ static int rzg2l_irqc_alloc(struct irq_domain *domain, unsigned int virq,
 	 * from 16-31 bits. TINT from the pinctrl driver needs to be programmed
 	 * in IRQC registers to enable a given gpio pin as interrupt.
 	 */
-	if (hwirq > priv->info.irq_count) {
+	if (hwirq == IRQC_NMI) {
+		chip = &rzg2l_irqc_nmi_chip;
+	} else if (hwirq > priv->info.irq_count) {
 		tint = TINT_EXTRACT_GPIOINT(hwirq);
 		hwirq = TINT_EXTRACT_HWIRQ(hwirq);
 		chip = priv->tint_chip;
-- 
2.43.0


