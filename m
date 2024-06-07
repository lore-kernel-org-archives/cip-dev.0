Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D41C27C77
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:09:21 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web10.42763.1717769356496463770
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:09:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=PDwd33qS;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52bbdb15dd5so798581e87.3
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769355; x=1718374155; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u81mZfEinelIyL03W15UUf0MJDX3JCbJOhGAI4+NIxI=;
        b=PDwd33qSfoAWjYvtuoirlEUl6GrZIxVA7HlxFpYTg3L/E0AneW1Pv2xXGlM3UIwNlA
         gRrxxCk+wPAOCRmRWSJznxdny4o8qK1xSpEgDfpJLYeswntShLeIvgs1izcPyBApzMDT
         wDR79122isnSUDmiiS3MahU6s0vTzaYDbmfCqzHQhY/br82GTrP75HiJlpWRc2muelJ2
         XY5snECS5j509sd95IFLWQamU8QUhdOuyv7ReOl8HhVtmOcJ0Y7iCjsq5OxXiCWqvVd7
         yWCRvISq5nOqx2Lw02777RmXsY0/EatmQWdk1P8xfejRZB+UkE9jsXIlV97fWnm96L9N
         rnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769355; x=1718374155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u81mZfEinelIyL03W15UUf0MJDX3JCbJOhGAI4+NIxI=;
        b=r29QaU6qokWS3mEny4YrzRhWSAdyk4lyAjnxiMc9kbqCwNV41R9kYI3VC3TUcCorVS
         91GrIGcmqmtZ21+iPbk36fZ+jDwdTRUnpwQljq5fOlRT2WE9DVqbRhn4zRSYDvpfQO6G
         dESm6SgdO2nrCgb0ALkOJP5Ki7Q/BGC260PdNT6aZWSCLguZJ40jce5EYYrTBsUxbCwo
         WgfeKIlI/eqpYG1sWBspAhyovLoitTPwR1Po/OjPafz7o2Ew5f894SXOtdHp4CeEjWw5
         wLy/DcKt3CHK5X0MWw+lhLl9UU9YlkD7OEHXALR6s3yDAcPeXfQo9auTU2ju5xMMChKQ
         dpfw==
X-Gm-Message-State: AOJu0Yz2f6V9gxjspoIUeop8ZeVTLL28/kCLKLG+Iuqwqo5LrGSpz5Op
	2jtCT/InHr8THm9PoR6/dgPDc4f6rS6vtRzR8/IJx40tVP1EDW1MUlKBpCqkgWU=
X-Google-Smtp-Source: AGHT+IHzEXvkKlEo2IxuxVtDwkTk2hBRZD8L8fap2EFE4m5TRm4WtGmGrpIuO6+vS78HeDuhrRoUoQ==
X-Received: by 2002:a05:6512:3092:b0:52b:4f30:9cac with SMTP id 2adb3069b0e04-52bb9fcf7eemr2182338e87.56.1717769354643;
        Fri, 07 Jun 2024 07:09:14 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581870sm251987466b.25.2024.06.07.07.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:09:13 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 11/17] irqchip/renesas-rzg2l: Add support for suspend to RAM
Date: Fri,  7 Jun 2024 17:08:50 +0300
Message-Id: <20240607140856.2497508-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:09:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16172

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
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 68 ++++++++++++++++++++++++-----
 1 file changed, 57 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 9b0a748ea2cb..ae67fec2ab46 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -18,6 +18,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/spinlock.h>
+#include <linux/syscore_ops.h>
 
 #define IRQC_IRQ_START			1
 #define IRQC_IRQ_COUNT			8
@@ -55,17 +56,29 @@
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
@@ -282,6 +295,38 @@ static int rzg2l_irqc_set_type(struct irq_data *d, unsigned int type)
 	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
 }
 
+static int rzg2l_irqc_irq_suspend(void)
+{
+	struct rzg2l_irqc_reg_cache *cache = &rzg2l_irqc_data->cache;
+	void __iomem *base = rzg2l_irqc_data->base;
+
+	cache->iitsr = readl_relaxed(base + IITSR);
+	for (u8 i = 0; i < 2; i++)
+		cache->titsr[i] = readl_relaxed(base + TITSR(i));
+
+	return 0;
+}
+
+static void rzg2l_irqc_irq_resume(void)
+{
+	struct rzg2l_irqc_reg_cache *cache = &rzg2l_irqc_data->cache;
+	void __iomem *base = rzg2l_irqc_data->base;
+
+	/*
+	 * Restore only interrupt type. TSSRx will be restored at the
+	 * request of pin controller to avoid spurious interrupts due
+	 * to invalid PIN states.
+	 */
+	for (u8 i = 0; i < 2; i++)
+		writel_relaxed(cache->titsr[i], base + TITSR(i));
+	writel_relaxed(cache->iitsr, base + IITSR);
+}
+
+static struct syscore_ops rzg2l_irqc_syscore_ops = {
+	.suspend	= rzg2l_irqc_irq_suspend,
+	.resume		= rzg2l_irqc_irq_resume,
+};
+
 static const struct irq_chip irqc_chip = {
 	.name			= "rzg2l-irqc",
 	.irq_eoi		= rzg2l_irqc_eoi,
@@ -367,7 +412,6 @@ static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
 	struct irq_domain *irq_domain, *parent_domain;
 	struct platform_device *pdev;
 	struct reset_control *resetn;
-	struct rzg2l_irqc_priv *priv;
 	int ret;
 
 	pdev = of_find_device_by_node(node);
@@ -380,15 +424,15 @@ static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
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
@@ -411,17 +455,19 @@ static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
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


