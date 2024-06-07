Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6A1C27C6E
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:07:30 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web11.42964.1717769247911422236
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:07:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Ai8NS/2l;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57c5c51cb89so708647a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769246; x=1718374046; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8FZhwPQvMH1JIZhOAo3VHi2tKsDV+frqb2Lxr4jz9c=;
        b=Ai8NS/2lj7LgEaYLvu1b94fk41iJdqlQz1cO6oIJORwlh20xsfWFGu/qfBGHRnnVMa
         4j82MviKw8/zcjWlHMS/GhxfMo08yS2h/cW+Ae4RsaCm76MYElrxc4DngoU/5uU3dDrZ
         rcRIZ/D0kigzrhvAJjQqrZhyDHbFtqSlhhL2yrOnrNOJvBimo7ezlGon0SHpnb4eMCWw
         etR2E/Zep7Zxr4gsA4NHn65V2Y5LIUwx5lATLT18QPMeZjXB/RMRTQzXjqKb2JkghCqs
         KG3O6WzWFumdqk6lVTuoGso7T5CTj/CUb8+gEEqMdmmn6B9M7QwEgBSI7sHpkc2OVcW8
         vVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769246; x=1718374046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8FZhwPQvMH1JIZhOAo3VHi2tKsDV+frqb2Lxr4jz9c=;
        b=MIuoVq0yDmAeDfa/ZpSv8Lr6474aFU2Bj/EGYPXmH2mb8okgSGT4YA193H8I6MDNMN
         dnFTnsQ3UtH1lH2aQmpv5vqhhzCkAs4s9S6rtgeJdIchKs57rrjyqvPiNWzXcbFiP5qV
         TLKYHgj2oLTQD1fXf7uBtlwAgMNgTtvGrCDpm/l8+76MVVokVbiD+IBANUMvn615I9yf
         Yf6USS1GySx9hhPcklwQdta9Xe2gHIkEuvp44Le9MHT16JzUZhyxjLtIQV6plqbPKnoF
         6lqykiJbfq4+u4VjqDlN8z2R+p3xB7Y/0JG9jemC5w/40xFxfiim5WPEfJJiTdgiBuCV
         pEQA==
X-Gm-Message-State: AOJu0YxE9pKbbklNP4lHxJPFkw/Djpr1tL7eduOgnNjCPDEhNlHM9bNp
	KmNSSuAmj4rgEF4JnEbegy0PVjUNxi6d806VahH4v+CnnANeKC0p9g1CTdZEK2XBiIDWmaqBIC1
	E
X-Google-Smtp-Source: AGHT+IG2yHLtIjURJ3BiKtVYf4/sQMxD5cIQXgquuxgi26vTZKNciGhFhNOlU9uMkpWpv19oLZJ1hg==
X-Received: by 2002:a50:8d54:0:b0:57c:5eed:4ebf with SMTP id 4fb4d7f45d1cf-57c5eed4ed9mr1202840a12.19.1717769246198;
        Fri, 07 Jun 2024 07:07:26 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9cf05sm2823968a12.3.2024.06.07.07.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:07:25 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 5.10.y-cip 09/19] pinctrl: renesas: rzg2l: Add suspend/resume support
Date: Fri,  7 Jun 2024 17:07:01 +0300
Message-Id: <20240607140711.2497286-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:07:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16150

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 254203f9a94cf8f8f406e241a11f38b8e4701d91 upstream.

pinctrl-rzg2l driver is used on RZ/G3S which support deep sleep states
where power to most of the SoC components is turned off.

For this add suspend/resume support. This involves saving and restoring
configured registers along with disabling clock in case there is no pin
configured as wakeup sources.

To save/restore registers 2 caches were allocated: one for GPIO pins and
one for dedicated pins.

On suspend path the pin controller registers are saved and if none of the
pins are configured as wakeup sources the pinctrl clock is disabled.
Otherwise it remains on.

On resume path the configuration is done as follows:
1/ setup PFCs by writing to registers on pin based accesses
2/ setup GPIOs by writing to registers on port based accesses and
   following configuration steps specified in hardware manual
3/ setup dedicated pins by writing to registers on port based accesses
4/ setup interrupts.

Because interrupt signals are routed to IA55 interrupt controller and
IA55 interrupt controller resumes before pin controller, patch restores
also the configured interrupts just after pin settings are restored to
avoid invalid interrupts while resuming.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240215124112.2259103-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea:
 - fixed conflict for rzg2l_gpio_irqchip.irq_set_wake
 - got rid of "for loop initial declarations are only allowed in C99 or
   C11 mode" compilation error
 - used __maybe_unused on suspend/resume functions
 - replaced NOIRQ_SYSTEM_SLEEP_PM_OPS with SET_NOIRQ_SYSTEM_SLEEP_PM_OPS
 - removed pm_sleep_ptr()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 415 +++++++++++++++++++++++-
 1 file changed, 411 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 5f0ed9a9a44a..c4d9bcb6f80f 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -145,6 +145,33 @@
 #define RZG2L_TINT_IRQ_START_INDEX	9
 #define RZG2L_PACK_HWIRQ(t, i)		(((t) << 16) | (i))
 
+/* Read/write 8 bits register */
+#define RZG2L_PCTRL_REG_ACCESS8(_read, _addr, _val)	\
+	do {						\
+		if (_read)				\
+			_val = readb(_addr);		\
+		else					\
+			writeb(_val, _addr);		\
+	} while (0)
+
+/* Read/write 16 bits register */
+#define RZG2L_PCTRL_REG_ACCESS16(_read, _addr, _val)	\
+	do {						\
+		if (_read)				\
+			_val = readw(_addr);		\
+		else					\
+			writew(_val, _addr);		\
+	} while (0)
+
+/* Read/write 32 bits register */
+#define RZG2L_PCTRL_REG_ACCESS32(_read, _addr, _val)	\
+	do {						\
+		if (_read)				\
+			_val = readl(_addr);		\
+		else					\
+			writel(_val, _addr);		\
+	} while (0)
+
 /**
  * struct rzg2l_register_offsets - specific register offsets
  * @pwpr: PWPR register offset
@@ -237,6 +264,32 @@ struct rzg2l_pinctrl_pin_settings {
 	u16 drive_strength_ua;
 };
 
+/**
+ * struct rzg2l_pinctrl_reg_cache - register cache structure (to be used in suspend/resume)
+ * @p: P registers cache
+ * @pm: PM registers cache
+ * @pmc: PMC registers cache
+ * @pfc: PFC registers cache
+ * @iolh: IOLH registers cache
+ * @ien: IEN registers cache
+ * @sd_ch: SD_CH registers cache
+ * @eth_poc: ET_POC registers cache
+ * @eth_mode: ETH_MODE register cache
+ * @qspi: QSPI registers cache
+ */
+struct rzg2l_pinctrl_reg_cache {
+	u8	*p;
+	u16	*pm;
+	u8	*pmc;
+	u32	*pfc;
+	u32	*iolh[2];
+	u32	*ien[2];
+	u8	sd_ch[2];
+	u8	eth_poc[2];
+	u8	eth_mode;
+	u8	qspi;
+};
+
 struct rzg2l_pinctrl {
 	struct pinctrl_dev		*pctl;
 	struct pinctrl_desc		desc;
@@ -246,6 +299,8 @@ struct rzg2l_pinctrl {
 	void __iomem			*base;
 	struct device			*dev;
 
+	struct clk			*clk;
+
 	struct gpio_chip		gpio_chip;
 	struct pinctrl_gpio_range	gpio_range;
 	DECLARE_BITMAP(tint_slot, RZG2L_TINT_MAX_INTERRUPT);
@@ -256,6 +311,9 @@ struct rzg2l_pinctrl {
 	struct mutex			mutex; /* serialize adding groups and functions */
 
 	struct rzg2l_pinctrl_pin_settings *settings;
+	struct rzg2l_pinctrl_reg_cache	*cache;
+	struct rzg2l_pinctrl_reg_cache	*dedicated_cache;
+	atomic_t			wakeup_path;
 };
 
 static const u16 available_ps[] = { 1800, 2500, 3300 };
@@ -1864,6 +1922,28 @@ static void rzg2l_gpio_irq_print_chip(struct irq_data *data, struct seq_file *p)
 	seq_printf(p, dev_name(gc->parent));
 }
 
+static int rzg2l_gpio_irq_set_wake(struct irq_data *data, unsigned int on)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+	struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl, gpio_chip);
+	int ret;
+
+	/* It should not happen. */
+	if (!data->parent_data)
+		return -EOPNOTSUPP;
+
+	ret = irq_chip_set_wake_parent(data, on);
+	if (ret)
+		return ret;
+
+	if (on)
+		atomic_inc(&pctrl->wakeup_path);
+	else
+		atomic_dec(&pctrl->wakeup_path);
+
+	return 0;
+}
+
 static const struct irq_chip rzg2l_gpio_irqchip = {
 	.name = "rzg2l-gpio",
 	.irq_disable = rzg2l_gpio_irq_disable,
@@ -1874,6 +1954,7 @@ static const struct irq_chip rzg2l_gpio_irqchip = {
 	.irq_eoi = rzg2l_gpio_irqc_eoi,
 	.irq_print_chip = rzg2l_gpio_irq_print_chip,
 	.irq_set_affinity = irq_chip_set_affinity_parent,
+	.irq_set_wake = rzg2l_gpio_irq_set_wake,
 };
 
 static int rzg2l_gpio_interrupt_input_mode(struct gpio_chip *chip, unsigned int offset)
@@ -1955,6 +2036,36 @@ static void *rzg2l_gpio_populate_parent_fwspec(struct gpio_chip *chip,
 	return fwspec;
 }
 
+static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
+{
+	struct irq_domain *domain = pctrl->gpio_chip.irq.domain;
+	unsigned int i;
+
+	for (i = 0; i < RZG2L_TINT_MAX_INTERRUPT; i++) {
+		struct irq_data *data;
+		unsigned int virq;
+
+		if (!pctrl->hwirq[i])
+			continue;
+
+		virq = irq_find_mapping(domain, pctrl->hwirq[i]);
+		if (!virq) {
+			dev_crit(pctrl->dev, "Failed to find IRQ mapping for hwirq %u\n",
+				 pctrl->hwirq[i]);
+			continue;
+		}
+
+		data = irq_domain_get_irq_data(domain, virq);
+		if (!data) {
+			dev_crit(pctrl->dev, "Failed to get IRQ data for virq=%u\n", virq);
+			continue;
+		}
+
+		if (!irqd_irq_disabled(data))
+			rzg2l_gpio_irq_enable(data);
+	}
+}
+
 static void rzg2l_gpio_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 				       unsigned int nr_irqs)
 {
@@ -2005,6 +2116,69 @@ static void rzg2l_init_irq_valid_mask(struct gpio_chip *gc,
 	}
 }
 
+static int rzg2l_pinctrl_reg_cache_alloc(struct rzg2l_pinctrl *pctrl)
+{
+	u32 nports = pctrl->data->n_port_pins / RZG2L_PINS_PER_PORT;
+	struct rzg2l_pinctrl_reg_cache *cache, *dedicated_cache;
+	u8 i;
+
+	cache = devm_kzalloc(pctrl->dev, sizeof(*cache), GFP_KERNEL);
+	if (!cache)
+		return -ENOMEM;
+
+	dedicated_cache = devm_kzalloc(pctrl->dev, sizeof(*dedicated_cache), GFP_KERNEL);
+	if (!dedicated_cache)
+		return -ENOMEM;
+
+	cache->p = devm_kcalloc(pctrl->dev, nports, sizeof(*cache->p), GFP_KERNEL);
+	if (!cache->p)
+		return -ENOMEM;
+
+	cache->pm = devm_kcalloc(pctrl->dev, nports, sizeof(*cache->pm), GFP_KERNEL);
+	if (!cache->pm)
+		return -ENOMEM;
+
+	cache->pmc = devm_kcalloc(pctrl->dev, nports, sizeof(*cache->pmc), GFP_KERNEL);
+	if (!cache->pmc)
+		return -ENOMEM;
+
+	cache->pfc = devm_kcalloc(pctrl->dev, nports, sizeof(*cache->pfc), GFP_KERNEL);
+	if (!cache->pfc)
+		return -ENOMEM;
+
+	for (i = 0; i < 2; i++) {
+		u32 n_dedicated_pins = pctrl->data->n_dedicated_pins;
+
+		cache->iolh[i] = devm_kcalloc(pctrl->dev, nports, sizeof(*cache->iolh[i]),
+					      GFP_KERNEL);
+		if (!cache->iolh[i])
+			return -ENOMEM;
+
+		cache->ien[i] = devm_kcalloc(pctrl->dev, nports, sizeof(*cache->ien[i]),
+					     GFP_KERNEL);
+		if (!cache->ien[i])
+			return -ENOMEM;
+
+		/* Allocate dedicated cache. */
+		dedicated_cache->iolh[i] = devm_kcalloc(pctrl->dev, n_dedicated_pins,
+							sizeof(*dedicated_cache->iolh[i]),
+							GFP_KERNEL);
+		if (!dedicated_cache->iolh[i])
+			return -ENOMEM;
+
+		dedicated_cache->ien[i] = devm_kcalloc(pctrl->dev, n_dedicated_pins,
+						       sizeof(*dedicated_cache->ien[i]),
+						       GFP_KERNEL);
+		if (!dedicated_cache->ien[i])
+			return -ENOMEM;
+	}
+
+	pctrl->cache = cache;
+	pctrl->dedicated_cache = dedicated_cache;
+
+	return 0;
+}
+
 static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
 {
 	struct device_node *np = pctrl->dev->of_node;
@@ -2145,6 +2319,10 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
 		}
 	}
 
+	ret = rzg2l_pinctrl_reg_cache_alloc(pctrl);
+	if (ret)
+		return ret;
+
 	ret = devm_pinctrl_register_and_init(pctrl->dev, &pctrl->desc, pctrl,
 					     &pctrl->pctl);
 	if (ret) {
@@ -2170,7 +2348,6 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
 static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 {
 	struct rzg2l_pinctrl *pctrl;
-	struct clk *clk;
 	int ret;
 
 	BUILD_BUG_ON(ARRAY_SIZE(r9a07g044_gpio_configs) * RZG2L_PINS_PER_PORT >
@@ -2196,14 +2373,16 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(pctrl->base))
 		return PTR_ERR(pctrl->base);
 
-	clk = devm_clk_get_enabled(pctrl->dev, NULL);
-	if (IS_ERR(clk))
-		return dev_err_probe(pctrl->dev, PTR_ERR(clk),
+	pctrl->clk = devm_clk_get_enabled(pctrl->dev, NULL);
+	if (IS_ERR(pctrl->clk)) {
+		return dev_err_probe(pctrl->dev, PTR_ERR(pctrl->clk),
 				     "failed to enable GPIO clk\n");
+	}
 
 	spin_lock_init(&pctrl->lock);
 	spin_lock_init(&pctrl->bitmap_lock);
 	mutex_init(&pctrl->mutex);
+	atomic_set(&pctrl->wakeup_path, 0);
 
 	platform_set_drvdata(pdev, pctrl);
 
@@ -2215,6 +2394,229 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_pinctrl *pctrl, bool suspend)
+{
+	u32 nports = pctrl->data->n_port_pins / RZG2L_PINS_PER_PORT;
+	struct rzg2l_pinctrl_reg_cache *cache = pctrl->cache;
+	u32 port;
+
+	for (port = 0; port < nports; port++) {
+		bool has_iolh, has_ien;
+		u32 off, caps;
+		u8 pincnt;
+		u64 cfg;
+
+		cfg = pctrl->data->port_pin_configs[port];
+		off = RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg);
+		pincnt = hweight8(FIELD_GET(PIN_CFG_PIN_MAP_MASK, cfg));
+
+		caps = FIELD_GET(PIN_CFG_MASK, cfg);
+		has_iolh = !!(caps & (PIN_CFG_IOLH_A | PIN_CFG_IOLH_B | PIN_CFG_IOLH_C));
+		has_ien = !!(caps & PIN_CFG_IEN);
+
+		if (suspend)
+			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + PFC(off), cache->pfc[port]);
+
+		/*
+		 * Now cache the registers or set them in the order suggested by
+		 * HW manual (section "Operation for GPIO Function").
+		 */
+		RZG2L_PCTRL_REG_ACCESS8(suspend, pctrl->base + PMC(off), cache->pmc[port]);
+		if (has_iolh) {
+			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + IOLH(off),
+						 cache->iolh[0][port]);
+			if (pincnt >= 4) {
+				RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + IOLH(off) + 4,
+							 cache->iolh[1][port]);
+			}
+		}
+
+		RZG2L_PCTRL_REG_ACCESS16(suspend, pctrl->base + PM(off), cache->pm[port]);
+		RZG2L_PCTRL_REG_ACCESS8(suspend, pctrl->base + P(off), cache->p[port]);
+
+		if (has_ien) {
+			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + IEN(off),
+						 cache->ien[0][port]);
+			if (pincnt >= 4) {
+				RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + IEN(off) + 4,
+							 cache->ien[1][port]);
+			}
+		}
+	}
+}
+
+static void rzg2l_pinctrl_pm_setup_dedicated_regs(struct rzg2l_pinctrl *pctrl, bool suspend)
+{
+	struct rzg2l_pinctrl_reg_cache *cache = pctrl->dedicated_cache;
+	u32 i, caps;
+
+	/*
+	 * Make sure entries in pctrl->data->n_dedicated_pins[] having the same
+	 * port offset are close together.
+	 */
+	for (i = 0, caps = 0; i < pctrl->data->n_dedicated_pins; i++) {
+		bool has_iolh, has_ien;
+		u32 off, next_off = 0;
+		u64 cfg, next_cfg;
+		u8 pincnt;
+
+		cfg = pctrl->data->dedicated_pins[i].config;
+		off = RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg);
+		if (i + 1 < pctrl->data->n_dedicated_pins) {
+			next_cfg = pctrl->data->dedicated_pins[i + 1].config;
+			next_off = RZG2L_PIN_CFG_TO_PORT_OFFSET(next_cfg);
+		}
+
+		if (off == next_off) {
+			/* Gather caps of all port pins. */
+			caps |= FIELD_GET(PIN_CFG_MASK, cfg);
+			continue;
+		}
+
+		/* And apply them in a single shot. */
+		has_iolh = !!(caps & (PIN_CFG_IOLH_A | PIN_CFG_IOLH_B | PIN_CFG_IOLH_C));
+		has_ien = !!(caps & PIN_CFG_IEN);
+		pincnt = hweight8(FIELD_GET(RZG2L_SINGLE_PIN_BITS_MASK, cfg));
+
+		if (has_iolh) {
+			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + IOLH(off),
+						 cache->iolh[0][i]);
+		}
+		if (has_ien) {
+			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + IEN(off),
+						 cache->ien[0][i]);
+		}
+
+		if (pincnt >= 4) {
+			if (has_iolh) {
+				RZG2L_PCTRL_REG_ACCESS32(suspend,
+							 pctrl->base + IOLH(off) + 4,
+							 cache->iolh[1][i]);
+			}
+			if (has_ien) {
+				RZG2L_PCTRL_REG_ACCESS32(suspend,
+							 pctrl->base + IEN(off) + 4,
+							 cache->ien[1][i]);
+			}
+		}
+		caps = 0;
+	}
+}
+
+static void rzg2l_pinctrl_pm_setup_pfc(struct  rzg2l_pinctrl *pctrl)
+{
+	u32 nports = pctrl->data->n_port_pins / RZG2L_PINS_PER_PORT;
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
+	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
+	u32 port;
+
+	/* Set the PWPR register to allow PFC register to write. */
+	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=0, PFCWE=0 */
+	writel(PWPR_PFCWE, pctrl->base + regs->pwpr);	/* B0WI=0, PFCWE=1 */
+
+	/* Restore port registers. */
+	for (port = 0; port < nports; port++) {
+		unsigned long pinmap;
+		u8 pmc = 0, max_pin;
+		u32 off, pfc = 0;
+		u64 cfg;
+		u16 pm;
+		u8 pin;
+
+		cfg = pctrl->data->port_pin_configs[port];
+		off = RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg);
+		pinmap = FIELD_GET(PIN_CFG_PIN_MAP_MASK, cfg);
+		max_pin = fls(pinmap);
+
+		pm = readw(pctrl->base + PM(off));
+		for_each_set_bit(pin, &pinmap, max_pin) {
+			struct rzg2l_pinctrl_reg_cache *cache = pctrl->cache;
+
+			/* Nothing to do if PFC was not configured before. */
+			if (!(cache->pmc[port] & BIT(pin)))
+				continue;
+
+			/* Set pin to 'Non-use (Hi-Z input protection)' */
+			pm &= ~(PM_MASK << (pin * 2));
+			writew(pm, pctrl->base + PM(off));
+
+			/* Temporarily switch to GPIO mode with PMC register */
+			pmc &= ~BIT(pin);
+			writeb(pmc, pctrl->base + PMC(off));
+
+			/* Select Pin function mode. */
+			pfc &= ~(PFC_MASK << (pin * 4));
+			pfc |= (cache->pfc[port] & (PFC_MASK << (pin * 4)));
+			writel(pfc, pctrl->base + PFC(off));
+
+			/* Switch to Peripheral pin function. */
+			pmc |= BIT(pin);
+			writeb(pmc, pctrl->base + PMC(off));
+		}
+	}
+
+	/* Set the PWPR register to be write-protected. */
+	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=0, PFCWE=0 */
+	writel(PWPR_B0WI, pctrl->base + regs->pwpr);	/* B0WI=1, PFCWE=0 */
+}
+
+static int __maybe_unused rzg2l_pinctrl_suspend_noirq(struct device *dev)
+{
+	struct rzg2l_pinctrl *pctrl = dev_get_drvdata(dev);
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
+	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
+	struct rzg2l_pinctrl_reg_cache *cache = pctrl->cache;
+	u8 i;
+
+	rzg2l_pinctrl_pm_setup_regs(pctrl, true);
+	rzg2l_pinctrl_pm_setup_dedicated_regs(pctrl, true);
+
+	for (i = 0; i < 2; i++) {
+		cache->sd_ch[i] = readb(pctrl->base + SD_CH(regs->sd_ch, i));
+		cache->eth_poc[i] = readb(pctrl->base + ETH_POC(regs->eth_poc, i));
+	}
+
+	cache->qspi = readb(pctrl->base + QSPI);
+	cache->eth_mode = readb(pctrl->base + ETH_MODE);
+
+	if (!atomic_read(&pctrl->wakeup_path))
+		clk_disable_unprepare(pctrl->clk);
+	else
+		device_set_wakeup_path(dev);
+
+	return 0;
+}
+
+static int __maybe_unused rzg2l_pinctrl_resume_noirq(struct device *dev)
+{
+	struct rzg2l_pinctrl *pctrl = dev_get_drvdata(dev);
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
+	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
+	struct rzg2l_pinctrl_reg_cache *cache = pctrl->cache;
+	int ret;
+	u8 i;
+
+	if (!atomic_read(&pctrl->wakeup_path)) {
+		ret = clk_prepare_enable(pctrl->clk);
+		if (ret)
+			return ret;
+	}
+
+	writeb(cache->qspi, pctrl->base + QSPI);
+	writeb(cache->eth_mode, pctrl->base + ETH_MODE);
+	for (i = 0; i < 2; i++) {
+		writeb(cache->sd_ch[i], pctrl->base + SD_CH(regs->sd_ch, i));
+		writeb(cache->eth_poc[i], pctrl->base + ETH_POC(regs->eth_poc, i));
+	}
+
+	rzg2l_pinctrl_pm_setup_pfc(pctrl);
+	rzg2l_pinctrl_pm_setup_regs(pctrl, false);
+	rzg2l_pinctrl_pm_setup_dedicated_regs(pctrl, false);
+	rzg2l_gpio_irq_restore(pctrl);
+
+	return 0;
+}
+
 static const struct rzg2l_hwcfg rzg2l_hwcfg = {
 	.regs = {
 		.pwpr = 0x3014,
@@ -2311,10 +2713,15 @@ static const struct of_device_id rzg2l_pinctrl_of_table[] = {
 	{ /* sentinel */ }
 };
 
+static const struct dev_pm_ops rzg2l_pinctrl_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(rzg2l_pinctrl_suspend_noirq, rzg2l_pinctrl_resume_noirq)
+};
+
 static struct platform_driver rzg2l_pinctrl_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = of_match_ptr(rzg2l_pinctrl_of_table),
+		.pm = &rzg2l_pinctrl_pm_ops,
 	},
 	.probe = rzg2l_pinctrl_probe,
 };
-- 
2.39.2


