Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EFAC41513
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:07:30 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web11.42965.1717769249509704609
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:07:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=pc3yvVks;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.173, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e72b8931caso22143931fa.0
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769248; x=1718374048; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eVqw3H6/lJZpRHr/3Me5vca5SgmSViQJq8Y34dYPMw=;
        b=pc3yvVksNIdSRojq9+2iKLu5n1QUScmWHfRb1Mrj7/gSZTIROZFVW2dR/GK0+KFIW2
         ilyhNMCW5OwaeBiDGkFLV+O/eg9fMCFbBzGA3HBsI6nGC63QsFOGoYkz0dYnCkUSQgmF
         u726fzHl/3mPlAksvSlyK1Gh8ckZJaUu3VaVPI8YABJ24kf7kreVFj1nrZD9LKUhk+Gu
         GlpRZHrtL2h+oWGb6UFw9b4s6MGceYuYAq0Z95+PzIVTKFZOC+kFOV84g5ifjwrRNZN1
         D6ehVqvynoT/jJYC7NuaRpWm7RBLeSs3saJhpft89q7vHEo291oyLFDRWPCHdHhTG5cf
         svyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769248; x=1718374048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+eVqw3H6/lJZpRHr/3Me5vca5SgmSViQJq8Y34dYPMw=;
        b=WiquaCuLlSf5Gd3V0Oe25RfNOGp9umvcOl02AC8DdQEMFg/oG/y0GNLhv/1iBGHNzW
         98PMJNfHfHBGUXLx5f1MJMU1GsR71aMFmClKHMXuyqILtCN2yzm1FBM+hT70ozZPCSkX
         +S61Sq/SyTg6VxtVQ9f0sZiicxUpiVuIJLUqNNXN3shyl+xwwsAKJBN0mn+zALiwQFew
         +Gtb1VtENW3DLTnJ8FhjFc65Uq9QCWPgtKVyaQVO2pDnyTrNInX+AxwP3jxoD0dEV4DI
         AzfEQ10OiKH2z1j1rYI+Z4xn1Yx560UepAtqmAZLP7SH/ZuhUQ3ps9znoMBrxIAITyxe
         keSA==
X-Gm-Message-State: AOJu0YzH3SpXHDFkHnArq/LpxuI+d2CL1gq1h/aDys9eQdyH4IjkZSJj
	RIj8v15knGCm5efIef36MdPyAwc0P26GTM2kFsDB++cV+FMwKf95pbKC+OG7jjo=
X-Google-Smtp-Source: AGHT+IE+LD7mfnB75bTJ2zX9HDeEOKDtj+nEmBDY7+A/6SpOFlmhpdA/i9CAs5F8nswlhfLfbrkzvQ==
X-Received: by 2002:a2e:a595:0:b0:2ea:df8f:2002 with SMTP id 38308e7fff4ca-2eadf8f229cmr14672011fa.42.1717769247623;
        Fri, 07 Jun 2024 07:07:27 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9cf05sm2823968a12.3.2024.06.07.07.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:07:26 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 5.10.y-cip 10/19] irqchip/renesas-rzg2l: Add support for suspend to RAM
Date: Fri,  7 Jun 2024 17:07:02 +0300
Message-Id: <20240607140711.2497286-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:07:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16151

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 74d2ef5f6f4b2437e6292ab2502400e8048db4aa upstream.

The irqchip-renesas-rzg2l driver is used on RZ/G3S SoC. RZ/G3S can go into
deep sleep states where power to different SoC's parts is cut off and RAM
is switched to self-refresh. The resume from these states is done with the
help of the bootloader.

The IA55 IRQ controller needs to be reconfigured when resuming from deep
sleep state. For this the IA55 registers are cached in suspend and restored
in resume.

The IA55 IRQ controller is connected to GPIO controller and GIC as follows:

                                      ┌──────────┐          ┌──────────┐
                                      │          │ SPIX     │          │
                                      │          ├─────────►│          │
                                      │          │          │          │
                                      │          │          │          │
              ┌────────┐IRQ0-7        │  IA55    │          │  GIC     │
 Pin0 ───────►│        ├─────────────►│          │          │          │
              │        │              │          │ PPIY     │          │
 ...          │  GPIO  │              │          ├─────────►│          │
              │        │GPIOINT0-127  │          │          │          │
 PinN ───────►│        ├─────────────►│          │          │          │
              └────────┘              └──────────┘          └──────────┘

where:
  - Pin0 is the first GPIO controller pin
  - PinN is the last GPIO controller pin

  - SPIX is the SPI interrupt with identifier X
  - PPIY is the PPI interrupt with identifier Y

Implement suspend/resume functionality with syscore_ops to be able to
cache/restore the registers after/before the GPIO controller suspend/resume
functions are invoked.

As the syscore_ops suspend/resume functions do not take any argument make
the driver private data static so it can be accessed from the
suspend/resume functions.

The IA55 interrupt controller is resumed before the GPIO controller. As
GPIO pins could be in an a state which causes spurious interrupts, the
reconfiguration of the interrupt controller is restricted to restore the
interrupt type and leave them disabled.

An eventually required interrupt enable operation will be done as part of
the GPIO controller resume function after restoring the GPIO state.

[ tglx: Massaged changelog ]

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20231120111820.87398-8-claudiu.beznea.uj@bp.renesas.com
[claudiu.beznea:
 - fixed merge conflict due to the fact that irqc_chip
   object has no const qualifier in v5.10
 - get rid of "for loop initial declarations are only allowed in C99 or
   C11 mode" compilation error]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 70 ++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 628b1c606bcf..7721092c634e 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -19,6 +19,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/spinlock.h>
+#include <linux/syscore_ops.h>
 
 #define IRQC_IRQ_START			1
 #define IRQC_IRQ_COUNT			8
@@ -56,17 +57,29 @@
 #define TINT_EXTRACT_HWIRQ(x)		FIELD_GET(GENMASK(15, 0), (x))
 #define TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
 
+/**
+ * struct rzg2l_irqc_reg_cache - registers cache (necessary for suspend/resume)
+ * @iitsr: IITSR register
+ * @titsr: TITSR registers
+ */
+struct rzg2l_irqc_reg_cache {
+	u32	iitsr;
+	u32	titsr[2];
+};
+
 /**
  * struct rzg2l_irqc_priv - IRQ controller private data structure
  * @base:	Controller's base address
  * @fwspec:	IRQ firmware specific data
  * @lock:	Lock to serialize access to hardware registers
+ * @cache:	Registers cache for suspend/resume
  */
-struct rzg2l_irqc_priv {
+static struct rzg2l_irqc_priv {
 	void __iomem			*base;
 	struct irq_fwspec		fwspec[IRQC_NUM_IRQ];
 	raw_spinlock_t			lock;
-};
+	struct rzg2l_irqc_reg_cache	cache;
+} *rzg2l_irqc_data;
 
 static struct rzg2l_irqc_priv *irq_data_to_priv(struct irq_data *data)
 {
@@ -283,6 +296,40 @@ static int rzg2l_irqc_set_type(struct irq_data *d, unsigned int type)
 	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
 }
 
+static int rzg2l_irqc_irq_suspend(void)
+{
+	struct rzg2l_irqc_reg_cache *cache = &rzg2l_irqc_data->cache;
+	void __iomem *base = rzg2l_irqc_data->base;
+	u8 i;
+
+	cache->iitsr = readl_relaxed(base + IITSR);
+	for (i = 0; i < 2; i++)
+		cache->titsr[i] = readl_relaxed(base + TITSR(i));
+
+	return 0;
+}
+
+static void rzg2l_irqc_irq_resume(void)
+{
+	struct rzg2l_irqc_reg_cache *cache = &rzg2l_irqc_data->cache;
+	void __iomem *base = rzg2l_irqc_data->base;
+	u8 i;
+
+	/*
+	 * Restore only interrupt type. TSSRx will be restored at the
+	 * request of pin controller to avoid spurious interrupts due
+	 * to invalid PIN states.
+	 */
+	for (i = 0; i < 2; i++)
+		writel_relaxed(cache->titsr[i], base + TITSR(i));
+	writel_relaxed(cache->iitsr, base + IITSR);
+}
+
+static struct syscore_ops rzg2l_irqc_syscore_ops = {
+	.suspend	= rzg2l_irqc_irq_suspend,
+	.resume		= rzg2l_irqc_irq_resume,
+};
+
 static struct irq_chip irqc_chip = {
 	.name			= "rzg2l-irqc",
 	.irq_eoi		= rzg2l_irqc_eoi,
@@ -368,7 +415,6 @@ static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
 	struct irq_domain *irq_domain, *parent_domain;
 	struct platform_device *pdev;
 	struct reset_control *resetn;
-	struct rzg2l_irqc_priv *priv;
 	int ret;
 
 	pdev = of_find_device_by_node(node);
@@ -381,15 +427,15 @@ static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
 		return -ENODEV;
 	}
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
+	rzg2l_irqc_data = devm_kzalloc(&pdev->dev, sizeof(*rzg2l_irqc_data), GFP_KERNEL);
+	if (!rzg2l_irqc_data)
 		return -ENOMEM;
 
-	priv->base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
+	rzg2l_irqc_data->base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
+	if (IS_ERR(rzg2l_irqc_data->base))
+		return PTR_ERR(rzg2l_irqc_data->base);
 
-	ret = rzg2l_irqc_parse_interrupts(priv, node);
+	ret = rzg2l_irqc_parse_interrupts(rzg2l_irqc_data, node);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot parse interrupts: %d\n", ret);
 		return ret;
@@ -412,17 +458,19 @@ static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
 		goto pm_disable;
 	}
 
-	raw_spin_lock_init(&priv->lock);
+	raw_spin_lock_init(&rzg2l_irqc_data->lock);
 
 	irq_domain = irq_domain_add_hierarchy(parent_domain, 0, IRQC_NUM_IRQ,
 					      node, &rzg2l_irqc_domain_ops,
-					      priv);
+					      rzg2l_irqc_data);
 	if (!irq_domain) {
 		dev_err(&pdev->dev, "failed to add irq domain\n");
 		ret = -ENOMEM;
 		goto pm_put;
 	}
 
+	register_syscore_ops(&rzg2l_irqc_syscore_ops);
+
 	return 0;
 
 pm_put:
-- 
2.39.2


