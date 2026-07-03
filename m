Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3FFC44507
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:17 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.89980.1783073291680000506
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:08:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=sLxxCwIi;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b27c7451so14561745e9.0
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073290; x=1783678090; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6z2UAa9Dc220tGmrb/c52SvAgaHDkBUOoQ4fcLLXuA=;
        b=sLxxCwIiQotLcXmEfE2OK4AnIWel+fJPS4muIHmhVUIh3VxwwMgm1uFTDptOnqAcos
         7YWBt+cwqDyNrA9sPtAH5fW1/opDAsyqOs30tgihKxAlLAgnFDq8cf355l9Dk0+EdbwR
         bpJLFzzJMrleE3rCgOmr8Iv2MU/Ekpe+wP/ZxENou4UbsBnWYOG3b6fQqoDiMd8gf7fY
         4xnHWueLeeGngsMF9Nle1qG9hNd/c19OfGZXwq6YWpugDfWALiw9F5nC5ySl4hFNt0uP
         41iK8pBejSyiVrXAQg3fad5epZzNd1e/vr+d8+Xg4Tvy5CH0YYaEY7A0i8O2/RTa7O4T
         lMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073290; x=1783678090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I6z2UAa9Dc220tGmrb/c52SvAgaHDkBUOoQ4fcLLXuA=;
        b=WuKW0QjRlLl1/HSPC8qGG3By2YGmB2dXdAOoMQFlEeaeim8YShFfY+8fZmvq4hCfE2
         CIy44k9EO644gwNOugP3Ec76sWk8XipcgvaVedDbXB27j45fTl12T7x3ai1bnYlYiB7Q
         A57xHZKAFzY50g6dxydM9SFyZwG0S4Sj6z4GQXLYGMPUlMs8DtNx7WxPDuBI8HYHCcTm
         rbzKkHad3DKJsN6aYPwOlBOmTjlMRx6ut3gly0Jp7N+QLqeGq+4yJAWaaxGMMz+AgOX1
         HmDQPG1i3nFJ7Kt5jSiDLn9FLeMIGBZtr26w9IIp01V41VcdaD1gCCdLzTxHsKaUcDnG
         AB+w==
X-Gm-Message-State: AOJu0YyIDjSKcIGYtx+/WtPzD14ogjcgbaXXo2Db0olakd0ZXGj2FKov
	485B2ewXe/H6FTezN3H+XYt+IKUpnzUYyOT4/nDeQHbWST4yr6vjuzs+wBUC5x4h
X-Gm-Gg: AfdE7cmKYGL9k2qifTdiwuqwbt3cgJ/AEK4JcG8eONyqCwX2vua1zx5LOsVBtPolChK
	lrAaoDORfdDn9z58OgO40uTmH3/GmsrNBJ8TFugXRP2DrwcrkCOtkCyEQH5vGwrjnoeEu/vtKIC
	9OOa+4naDKk5XveFrH9o8ktWhOEUDj3cv9u7aDZsuBkWkYLESxff1aXzUja9/cqqHR2D8cnGcLG
	qSAzIEO9RbTBq3bNIxxfGcuGIFBQ884iCjBSfG7retQIInH+GlpUMlDZSgYfyYXsd4ECOrbtit+
	N5tQ9+CVJz7jOA21j3KMlXBhI1qMJpN233G7k/G2dKWyAlogsZYYBI0gRVqH4CvytgtlrfvnjM7
	cBgl96mRSiabGsg2KVaXVD4Ob01fu3Iie/FT6Cuus0SUIHVyWbWM4kIAvDhsCeQD+F2Q2PxCu8l
	hj9aHOwXRKvW9hXdRZCODa
X-Received: by 2002:a05:600c:3f0b:b0:493:cbdc:7cd2 with SMTP id 5b1f17b1804b1-493cbdc80cemr25082985e9.3.1783073289705;
        Fri, 03 Jul 2026 03:08:09 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab3a8sm40993765e9.6.2026.07.03.03.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:08:09 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 23/26] irqchip/renesas-rzg2l: Add shared interrupt support
Date: Fri,  3 Jul 2026 11:07:42 +0100
Message-ID: <20260703100756.238233-24-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23415

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit e0fcae27ff572212c39b1078e7aa0795ce5970e7 ]

The RZ/G3L SoC has 16 external interrupts, of which 8 are shared with TINT
(GPIO interrupts), whereas RZ/G2L has only 8 external interrupts with no
sharing. The shared interrupt line selection between external interrupt and
GPIO interrupt is based on the INTTSEL register. Add shared_irq_cnt
variable to struct rzg2l_hw_info handle these differences.

Add used_irqs bitmap to struct rzg2l_irqc_priv to track allocation state.
In the alloc callback, use test_and_set_bit() to enforce mutual exclusion
and configure the INTTSEL register to route to either the external
interrupt or TINT. In the free callback, use test_and_clear_bit() to
release the shared interrupt line and reset the INTTSEL. Also add INTTSEL
register save/restore support to the suspend/resume path.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260325192451.172562-17-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 118 +++++++++++++++++++++++++++-
 1 file changed, 115 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 0dd3ce30f7ad..f97d8f170634 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -23,6 +23,8 @@
 
 #define IRQC_IRQ_START			1
 #define IRQC_TINT_COUNT			32
+#define IRQC_SHARED_IRQ_COUNT		8
+#define IRQC_IRQ_SHARED_START		(IRQC_IRQ_START + IRQC_SHARED_IRQ_COUNT)
 
 #define ISCR				0x10
 #define IITSR				0x14
@@ -30,6 +32,7 @@
 #define TITSR(n)			(0x24 + (n) * 4)
 #define TITSR0_MAX_INT			16
 #define TITSEL_WIDTH			0x2
+#define INTTSEL				0x2c
 #define TSSR(n)				(0x30 + ((n) * 4))
 #define TIEN				BIT(7)
 #define TSSEL_SHIFT(n)			(8 * (n))
@@ -53,16 +56,21 @@
 #define IITSR_IITSEL_EDGE_BOTH		3
 #define IITSR_IITSEL_MASK(n)		IITSR_IITSEL((n), 3)
 
+#define INTTSEL_TINTSEL(n)		BIT(n)
+#define INTTSEL_TINTSEL_START		24
+
 #define TINT_EXTRACT_HWIRQ(x)		FIELD_GET(GENMASK(15, 0), (x))
 #define TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
 
 /**
  * struct rzg2l_irqc_reg_cache - registers cache (necessary for suspend/resume)
  * @iitsr: IITSR register
+ * @inttsel: INTTSEL register
  * @titsr: TITSR registers
  */
 struct rzg2l_irqc_reg_cache {
 	u32	iitsr;
+	u32	inttsel;
 	u32	titsr[2];
 };
 
@@ -72,12 +80,14 @@ struct rzg2l_irqc_reg_cache {
  * @irq_count:		Number of IRQC interrupts
  * @tint_start:		Start of TINT interrupts
  * @num_irq:		Total Number of interrupts
+ * @shared_irq_cnt:	Number of shared interrupts
  */
 struct rzg2l_hw_info {
 	const u8	*tssel_lut;
 	unsigned int	irq_count;
 	unsigned int	tint_start;
 	unsigned int	num_irq;
+	unsigned int	shared_irq_cnt;
 };
 
 /**
@@ -89,6 +99,7 @@ struct rzg2l_hw_info {
  * @lock:	Lock to serialize access to hardware registers
  * @info:	Hardware specific data
  * @cache:	Registers cache for suspend/resume
+ * @used_irqs:	Bitmap to manage the shared interrupts
  */
 static struct rzg2l_irqc_priv {
 	void __iomem			*base;
@@ -98,6 +109,7 @@ static struct rzg2l_irqc_priv {
 	raw_spinlock_t			lock;
 	struct rzg2l_hw_info		info;
 	struct rzg2l_irqc_reg_cache	cache;
+	DECLARE_BITMAP(used_irqs, IRQC_SHARED_IRQ_COUNT);
 } *rzg2l_irqc_data;
 
 static struct rzg2l_irqc_priv *irq_data_to_priv(struct irq_data *data)
@@ -463,6 +475,8 @@ static int rzg2l_irqc_irq_suspend(void)
 	void __iomem *base = rzg2l_irqc_data->base;
 
 	cache->iitsr = readl_relaxed(base + IITSR);
+	if (rzg2l_irqc_data->info.shared_irq_cnt)
+		cache->inttsel = readl_relaxed(base + INTTSEL);
 	for (u8 i = 0; i < 2; i++)
 		cache->titsr[i] = readl_relaxed(base + TITSR(i));
 
@@ -481,6 +495,8 @@ static void rzg2l_irqc_irq_resume(void)
 	 */
 	for (u8 i = 0; i < 2; i++)
 		writel_relaxed(cache->titsr[i], base + TITSR(i));
+	if (rzg2l_irqc_data->info.shared_irq_cnt)
+		writel_relaxed(cache->inttsel, base + INTTSEL);
 	writel_relaxed(cache->iitsr, base + IITSR);
 }
 
@@ -557,6 +573,72 @@ static const struct irq_chip rzfive_irqc_tint_chip = {
 				  IRQCHIP_SKIP_SET_WAKE,
 };
 
+static bool rzg2l_irqc_is_shared_irqc(const struct rzg2l_hw_info info, unsigned int hw_irq)
+{
+	return ((hw_irq >= (info.tint_start - info.shared_irq_cnt)) && hw_irq < info.tint_start);
+}
+
+static bool rzg2l_irqc_is_shared_tint(const struct rzg2l_hw_info info, unsigned int hw_irq)
+{
+	return ((hw_irq >= (info.num_irq - info.shared_irq_cnt)) && hw_irq < info.num_irq);
+}
+
+static bool rzg2l_irqc_is_shared_and_get_irq_num(struct rzg2l_irqc_priv *priv,
+						 irq_hw_number_t hwirq, unsigned int *irq_num)
+{
+	bool is_shared = false;
+
+	if (rzg2l_irqc_is_shared_irqc(priv->info, hwirq)) {
+		*irq_num = hwirq - IRQC_IRQ_SHARED_START;
+		is_shared = true;
+	} else if (rzg2l_irqc_is_shared_tint(priv->info, hwirq)) {
+		*irq_num = hwirq - IRQC_TINT_COUNT - IRQC_IRQ_SHARED_START;
+		is_shared = true;
+	}
+
+	return is_shared;
+}
+
+static void rzg2l_irqc_set_inttsel(struct rzg2l_irqc_priv *priv, unsigned int offset,
+				   unsigned int select_irq)
+{
+	u32 reg;
+
+	guard(raw_spinlock_irqsave)(&priv->lock);
+	reg = readl_relaxed(priv->base + INTTSEL);
+	if (select_irq)
+		reg |= INTTSEL_TINTSEL(offset);
+	else
+		reg &= ~INTTSEL_TINTSEL(offset);
+	writel_relaxed(reg, priv->base + INTTSEL);
+}
+
+static int rzg2l_irqc_shared_irq_alloc(struct rzg2l_irqc_priv *priv, irq_hw_number_t hwirq)
+{
+	unsigned int irq_num;
+
+	if (rzg2l_irqc_is_shared_and_get_irq_num(priv, hwirq, &irq_num)) {
+		if (test_and_set_bit(irq_num, priv->used_irqs))
+			return -EBUSY;
+
+		if (hwirq < priv->info.tint_start)
+			rzg2l_irqc_set_inttsel(priv, INTTSEL_TINTSEL_START + irq_num, 1);
+		else
+			rzg2l_irqc_set_inttsel(priv, INTTSEL_TINTSEL_START + irq_num, 0);
+	}
+
+	return 0;
+}
+
+static void rzg2l_irqc_shared_irq_free(struct rzg2l_irqc_priv *priv, irq_hw_number_t hwirq)
+{
+	unsigned int irq_num;
+
+	if (rzg2l_irqc_is_shared_and_get_irq_num(priv, hwirq, &irq_num) &&
+	    test_and_clear_bit(irq_num, priv->used_irqs))
+		rzg2l_irqc_set_inttsel(priv, INTTSEL_TINTSEL_START + irq_num, 0);
+}
+
 static int rzg2l_irqc_alloc(struct irq_domain *domain, unsigned int virq,
 			    unsigned int nr_irqs, void *arg)
 {
@@ -589,16 +671,45 @@ static int rzg2l_irqc_alloc(struct irq_domain *domain, unsigned int virq,
 	if (hwirq >= priv->info.num_irq)
 		return -EINVAL;
 
+	if (priv->info.shared_irq_cnt) {
+		ret = rzg2l_irqc_shared_irq_alloc(priv, hwirq);
+		if (ret)
+			return ret;
+	}
+
 	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq, chip, (void *)(uintptr_t)tint);
 	if (ret)
-		return ret;
+		goto shared_irq_free;
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &priv->fwspec[hwirq]);
+	if (ret)
+		goto shared_irq_free;
+
+	return 0;
+
+shared_irq_free:
+	if (priv->info.shared_irq_cnt)
+		rzg2l_irqc_shared_irq_free(priv, hwirq);
+
+	return ret;
+}
 
-	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &priv->fwspec[hwirq]);
+static void rzg2l_irqc_free(struct irq_domain *domain, unsigned int virq, unsigned int nr_irqs)
+{
+	struct rzg2l_irqc_priv *priv = domain->host_data;
+
+	irq_domain_free_irqs_common(domain, virq, nr_irqs);
+
+	if (priv->info.shared_irq_cnt) {
+		struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+
+		rzg2l_irqc_shared_irq_free(priv, irqd_to_hwirq(d));
+	}
 }
 
 static const struct irq_domain_ops rzg2l_irqc_domain_ops = {
 	.alloc = rzg2l_irqc_alloc,
-	.free = irq_domain_free_irqs_common,
+	.free = rzg2l_irqc_free,
 	.translate = irq_domain_translate_twocell,
 };
 
@@ -728,6 +839,7 @@ static const struct rzg2l_hw_info rzg3l_hw_params = {
 	.irq_count	= 16,
 	.tint_start	= IRQC_IRQ_START + 16,
 	.num_irq	= IRQC_IRQ_START + 16 + IRQC_TINT_COUNT,
+	.shared_irq_cnt	= IRQC_SHARED_IRQ_COUNT,
 };
 
 static const struct rzg2l_hw_info rzg2l_hw_params = {
-- 
2.43.0


