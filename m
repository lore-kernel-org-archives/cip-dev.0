Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB21CDC188
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:06:29 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88498.1767701183769132547
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 04:06:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZXVpLPg9;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so6810135e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 04:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767701182; x=1768305982; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tG2ZRWNda3xd/GkVMibgoQcqL3nmcpXML0/IfQ8Hm4=;
        b=ZXVpLPg9YAHDJYZg/Eash6QZ2W27o+tjbNv3QNkcNHCP/iGrioRc3uWMDXEDLnG+y2
         vsGDhWo0fMiK6PEUbc2nGgBomIImiBaiA/oaUDbhBrgEA5EzIYqio7ob7lzogHgHWeAp
         3GO7iV9ds2AJDM3Yl7R7p7mulxkQHPgRh8VGJEGazXLFJo1KksKHNU6Dxhsp6mOQy9bS
         JtMITqOd1oQlZaoCgc3OtBvWFXieBdOtF+40i/Qp4bfYlkSST+UmIhbrLEeadIGeSnJU
         ASUo+BHOuH7yzzcTBflCpIv8vQUq05ZJzc1PgXREDAOkuvmyuh6lVQ2iVhEWy+x062Zn
         Kv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767701182; x=1768305982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7tG2ZRWNda3xd/GkVMibgoQcqL3nmcpXML0/IfQ8Hm4=;
        b=vPhVEGAfQ0ViRoDOZjMnN4diwi+NPZFbc5sE3jM0fTXVKaiwfNLfnPGORV5uLei6B1
         xJc7PHjG6JPV0wA76cU4uS+zP1eBmSjLxbX0l/Y8Ust93t9tCKx+J5z0RFzxy8QAt+nj
         3+ut5wZjso3o9Dhr2gDQWoe6Bi+z3dH1+FV/t8iFYBY5TtEx81ak5+A1rYfQNDKsTJ8U
         kxtv7wXC8n0bqCgK1FQfOX5ZQEXOATYO7v183lBHfc6OpD0pmnCODJAMt3b4BiDH7OYv
         D+fZ0HK8W9Z0pa9gWH1FspLfEXidDpOXS71h4q89hWDzRnLH0cK0+dCs5pCryq5w9aek
         WOMg==
X-Gm-Message-State: AOJu0Yw4WsmnDjSm7WY20ALvqgo6nNXm+3VWU7JzIXVLKuz7x/+keLeS
	zrx0fDopW9r3lFdQYsyPZqKmRrYE0NuvYxhflLl7CnNF19rC0qJlz9dzfi8rKQ==
X-Gm-Gg: AY/fxX5j18KEZDuB0X2JeeDFdjXW910R7V3uAMsa0QL8hiO32lljQYjo2ZT+6hYeZ5Q
	ldwVOq0TODXyXp1RAgJBWqIYaUIeSgXAlsQrJ7DlCH4WsWZPLagY9WuZkdBAyfUs7CVoiNWV9gp
	d3+KmJaPeBHeiaPA27hwfo8ByfTsOfowwICsSwfEZ9eIrbCLghnrwFqzzYLl4JIi86NjweAEy88
	64PKesNzfoFq/kmookwJ66bWv83CScHtFtrxYjO0BkPwSOO7CmmQVENiTWaLkIgWyJpv1X/RngL
	nuJaHpbI+OkYRNp8S7rv5OipXa2smody0sem/A73Ve5i4kO6oG7OxF7MTsZXwiNv1zGK7AtXmOS
	9K/jkHC3hFk7kloRVZLEv5rISYT6xymQOGBdsz5GMyokEt+6lwMidBPPYGF73roWXyTTYiF0IWE
	je0vo4r3SP80ZRwd5sSA==
X-Google-Smtp-Source: AGHT+IFQlMDXPGF6JkEfrsSZkr0iPQpLLp9+Q4J3NkaL0Ku5Sp5/SCkkbVHp+11Tvh++U794JyyK3A==
X-Received: by 2002:a05:600c:138f:b0:471:700:f281 with SMTP id 5b1f17b1804b1-47d7f09ab57mr27542695e9.25.1767701181814;
        Tue, 06 Jan 2026 04:06:21 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm41594405e9.7.2026.01.06.04.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:06:21 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip v2 05/13] pinctrl: renesas: rzg2l: Fix ISEL restore on resume
Date: Tue,  6 Jan 2026 12:06:02 +0000
Message-ID: <20260106120618.181104-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
References: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 12:06:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21365

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

[ Upstream commit 44bf66122c12ef6d3382a9b84b9be1802e5f0e95 ]

Commit 1d2da79708cb ("pinctrl: renesas: rzg2l: Avoid configuring ISEL in
gpio_irq_{en,dis}able*()") dropped the configuration of ISEL from
struct irq_chip::{irq_enable, irq_disable} APIs and moved it to
struct gpio_chip::irq::{child_to_parent_hwirq,
child_irq_domain_ops::free} APIs to fix spurious IRQs.

After commit 1d2da79708cb ("pinctrl: renesas: rzg2l: Avoid configuring ISEL
in gpio_irq_{en,dis}able*()"), ISEL was no longer configured properly on
resume. This is because the pinctrl resume code used
struct irq_chip::irq_enable  (called from rzg2l_gpio_irq_restore()) to
reconfigure the wakeup interrupts. Some drivers (e.g. Ethernet) may also
reconfigure non-wakeup interrupts on resume through their own code,
eventually calling struct irq_chip::irq_enable.

Fix this by adding ISEL configuration back into the
struct irq_chip::irq_enable API and on resume path for wakeup interrupts.

As struct irq_chip::irq_enable needs now to lock to update the ISEL,
convert the struct rzg2l_pinctrl::lock to a raw spinlock and replace the
locking API calls with the raw variants. Otherwise the lockdep reports
invalid wait context when probing the adv7511 module on RZ/G2L:

 [ BUG: Invalid wait context ]
 6.17.0-rc5-next-20250911-00001-gfcfac22533c9 #18 Not tainted
 -----------------------------
 (udev-worker)/165 is trying to lock:
 ffff00000e3664a8 (&pctrl->lock){....}-{3:3}, at: rzg2l_gpio_irq_enable+0x38/0x78
 other info that might help us debug this:
 context-{5:5}
 3 locks held by (udev-worker)/165:
 #0: ffff00000e890108 (&dev->mutex){....}-{4:4}, at: __driver_attach+0x90/0x1ac
 #1: ffff000011c07240 (request_class){+.+.}-{4:4}, at: __setup_irq+0xb4/0x6dc
 #2: ffff000011c070c8 (lock_class){....}-{2:2}, at: __setup_irq+0xdc/0x6dc
 stack backtrace:
 CPU: 1 UID: 0 PID: 165 Comm: (udev-worker) Not tainted 6.17.0-rc5-next-20250911-00001-gfcfac22533c9 #18 PREEMPT
 Hardware name: Renesas SMARC EVK based on r9a07g044l2 (DT)
 Call trace:
 show_stack+0x18/0x24 (C)
 dump_stack_lvl+0x90/0xd0
 dump_stack+0x18/0x24
 __lock_acquire+0xa14/0x20b4
 lock_acquire+0x1c8/0x354
 _raw_spin_lock_irqsave+0x60/0x88
 rzg2l_gpio_irq_enable+0x38/0x78
 irq_enable+0x40/0x8c
 __irq_startup+0x78/0xa4
 irq_startup+0x108/0x16c
 __setup_irq+0x3c0/0x6dc
 request_threaded_irq+0xec/0x1ac
 devm_request_threaded_irq+0x80/0x134
 adv7511_probe+0x928/0x9a4 [adv7511]
 i2c_device_probe+0x22c/0x3dc
 really_probe+0xbc/0x2a0
 __driver_probe_device+0x78/0x12c
 driver_probe_device+0x40/0x164
 __driver_attach+0x9c/0x1ac
 bus_for_each_dev+0x74/0xd0
 driver_attach+0x24/0x30
 bus_add_driver+0xe4/0x208
 driver_register+0x60/0x128
 i2c_register_driver+0x48/0xd0
 adv7511_init+0x5c/0x1000 [adv7511]
 do_one_initcall+0x64/0x30c
 do_init_module+0x58/0x23c
 load_module+0x1bcc/0x1d40
 init_module_from_file+0x88/0xc4
 idempotent_init_module+0x188/0x27c
 __arm64_sys_finit_module+0x68/0xac
 invoke_syscall+0x48/0x110
 el0_svc_common.constprop.0+0xc0/0xe0
 do_el0_svc+0x1c/0x28
 el0_svc+0x4c/0x160
 el0t_64_sync_handler+0xa0/0xe4
 el0t_64_sync+0x198/0x19c

Having ISEL configuration back into the struct irq_chip::irq_enable API
should be safe with respect to spurious IRQs, as in the probe case IRQs
are enabled anyway in struct gpio_chip::irq::child_to_parent_hwirq. No
spurious IRQs were detected on suspend/resume, boot, ethernet link
insert/remove tests (executed on RZ/G3S). Boot, ethernet link
insert/remove tests were also executed successfully on RZ/G2L.

Fixes: 1d2da79708cb ("pinctrl: renesas: rzg2l: Avoid configuring ISEL in gpio_irq_{en,dis}able*(")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250912095308.3603704-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 71 +++++++++++++++----------
 1 file changed, 44 insertions(+), 27 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index c7d6914098f8..7b22921e6840 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -358,7 +358,7 @@ struct rzg2l_pinctrl {
 	spinlock_t			bitmap_lock; /* protect tint_slot bitmap */
 	unsigned int			hwirq[RZG2L_TINT_MAX_INTERRUPT];
 
-	spinlock_t			lock; /* lock read/write registers */
+	raw_spinlock_t			lock; /* lock read/write registers */
 	struct mutex			mutex; /* serialize adding groups and functions */
 
 	struct rzg2l_pinctrl_pin_settings *settings;
@@ -542,7 +542,7 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 	unsigned long flags;
 	u32 reg;
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	/* Set pin to 'Non-use (Hi-Z input protection)'  */
 	reg = readw(pctrl->base + PM(off));
@@ -566,7 +566,7 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 
 	pctrl->data->pwpr_pfc_lock_unlock(pctrl, true);
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 };
 
 static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
@@ -884,10 +884,10 @@ static void rzg2l_rmw_pin_config(struct rzg2l_pinctrl *pctrl, u32 offset,
 		addr += 4;
 	}
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 	reg = readl(addr) & ~(mask << (bit * 8));
 	writel(reg | (val << (bit * 8)), addr);
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static int rzg2l_caps_to_pwr_reg(const struct rzg2l_register_offsets *regs, u32 caps)
@@ -1121,7 +1121,7 @@ static int rzg2l_write_oen(struct rzg2l_pinctrl *pctrl, unsigned int _pin, u8 oe
 	if (bit < 0)
 		return -EINVAL;
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 	val = readb(pctrl->base + oen_offset);
 	if (oen)
 		val &= ~BIT(bit);
@@ -1134,7 +1134,7 @@ static int rzg2l_write_oen(struct rzg2l_pinctrl *pctrl, unsigned int _pin, u8 oe
 	writeb(val, pctrl->base + oen_offset);
 	if (pctrl->data->hwcfg->oen_pwpr_lock)
 		writeb(pwpr & ~PWPR_REGWE_B, pctrl->base + regs->pwpr);
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
 }
@@ -1687,14 +1687,14 @@ static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	if (ret)
 		return ret;
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	/* Select GPIO mode in PMC Register */
 	reg8 = readb(pctrl->base + PMC(off));
 	reg8 &= ~BIT(bit);
 	pctrl->data->pmc_writeb(pctrl, reg8, PMC(off));
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
 }
@@ -1709,7 +1709,7 @@ static void rzg2l_gpio_set_direction(struct rzg2l_pinctrl *pctrl, u32 offset,
 	unsigned long flags;
 	u16 reg16;
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	reg16 = readw(pctrl->base + PM(off));
 	reg16 &= ~(PM_MASK << (bit * 2));
@@ -1717,7 +1717,7 @@ static void rzg2l_gpio_set_direction(struct rzg2l_pinctrl *pctrl, u32 offset,
 	reg16 |= (output ? PM_OUTPUT : PM_INPUT) << (bit * 2);
 	writew(reg16, pctrl->base + PM(off));
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static int rzg2l_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
@@ -1761,7 +1761,7 @@ static void rzg2l_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	unsigned long flags;
 	u8 reg8;
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	reg8 = readb(pctrl->base + P(off));
 
@@ -1770,7 +1770,7 @@ static void rzg2l_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	else
 		writeb(reg8 & ~BIT(bit), pctrl->base + P(off));
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static int rzg2l_gpio_direction_output(struct gpio_chip *chip,
@@ -2427,14 +2427,13 @@ static int rzg2l_gpio_get_gpioint(unsigned int virq, struct rzg2l_pinctrl *pctrl
 	return gpioint;
 }
 
-static void rzg2l_gpio_irq_endisable(struct rzg2l_pinctrl *pctrl,
-				     unsigned int hwirq, bool enable)
+static void __rzg2l_gpio_irq_endisable(struct rzg2l_pinctrl *pctrl,
+				       unsigned int hwirq, bool enable)
 {
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[hwirq];
 	u64 *pin_data = pin_desc->drv_data;
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(hwirq);
-	unsigned long flags;
 	void __iomem *addr;
 
 	addr = pctrl->base + ISEL(off);
@@ -2443,12 +2442,20 @@ static void rzg2l_gpio_irq_endisable(struct rzg2l_pinctrl *pctrl,
 		addr += 4;
 	}
 
-	spin_lock_irqsave(&pctrl->lock, flags);
 	if (enable)
 		writel(readl(addr) | BIT(bit * 8), addr);
 	else
 		writel(readl(addr) & ~BIT(bit * 8), addr);
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+}
+
+static void rzg2l_gpio_irq_endisable(struct rzg2l_pinctrl *pctrl,
+				     unsigned int hwirq, bool enable)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
+	__rzg2l_gpio_irq_endisable(pctrl, hwirq, enable);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static void rzg2l_gpio_irq_disable(struct irq_data *d)
@@ -2460,15 +2467,25 @@ static void rzg2l_gpio_irq_disable(struct irq_data *d)
 	gpiochip_disable_irq(gc, hwirq);
 }
 
-static void rzg2l_gpio_irq_enable(struct irq_data *d)
+static void __rzg2l_gpio_irq_enable(struct irq_data *d, bool lock)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl, gpio_chip);
 	unsigned int hwirq = irqd_to_hwirq(d);
 
 	gpiochip_enable_irq(gc, hwirq);
+	if (lock)
+		rzg2l_gpio_irq_endisable(pctrl, hwirq, true);
+	else
+		__rzg2l_gpio_irq_endisable(pctrl, hwirq, true);
 	irq_chip_enable_parent(d);
 }
 
+static void rzg2l_gpio_irq_enable(struct irq_data *d)
+{
+	__rzg2l_gpio_irq_enable(d, true);
+}
+
 static int rzg2l_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	return irq_chip_set_type_parent(d, type);
@@ -2614,11 +2631,11 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
 		 * This has to be atomically executed to protect against a concurrent
 		 * interrupt.
 		 */
-		spin_lock_irqsave(&pctrl->lock, flags);
+		raw_spin_lock_irqsave(&pctrl->lock, flags);
 		ret = rzg2l_gpio_irq_set_type(data, irqd_get_trigger_type(data));
 		if (!ret && !irqd_irq_disabled(data))
-			rzg2l_gpio_irq_enable(data);
-		spin_unlock_irqrestore(&pctrl->lock, flags);
+			__rzg2l_gpio_irq_enable(data, false);
+		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 		if (ret)
 			dev_crit(pctrl->dev, "Failed to set IRQ type for virq=%u\n", virq);
@@ -2948,7 +2965,7 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 				     "failed to enable GPIO clk\n");
 	}
 
-	spin_lock_init(&pctrl->lock);
+	raw_spin_lock_init(&pctrl->lock);
 	spin_lock_init(&pctrl->bitmap_lock);
 	mutex_init(&pctrl->mutex);
 	atomic_set(&pctrl->wakeup_path, 0);
@@ -3091,7 +3108,7 @@ static void rzg2l_pinctrl_pm_setup_pfc(struct  rzg2l_pinctrl *pctrl)
 	u32 nports = pctrl->data->n_port_pins / RZG2L_PINS_PER_PORT;
 	unsigned long flags;
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 	pctrl->data->pwpr_pfc_lock_unlock(pctrl, false);
 
 	/* Restore port registers. */
@@ -3136,7 +3153,7 @@ static void rzg2l_pinctrl_pm_setup_pfc(struct  rzg2l_pinctrl *pctrl)
 	}
 
 	pctrl->data->pwpr_pfc_lock_unlock(pctrl, true);
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static int rzg2l_pinctrl_suspend_noirq(struct device *dev)
@@ -3185,14 +3202,14 @@ static int rzg2l_pinctrl_resume_noirq(struct device *dev)
 
 	writeb(cache->qspi, pctrl->base + QSPI);
 	if (pctrl->data->hwcfg->oen_pwpr_lock) {
-		spin_lock_irqsave(&pctrl->lock, flags);
+		raw_spin_lock_irqsave(&pctrl->lock, flags);
 		pwpr = readb(pctrl->base + regs->pwpr);
 		writeb(pwpr | PWPR_REGWE_B, pctrl->base + regs->pwpr);
 	}
 	writeb(cache->oen, pctrl->base + pctrl->data->hwcfg->regs.oen);
 	if (pctrl->data->hwcfg->oen_pwpr_lock) {
 		writeb(pwpr & ~PWPR_REGWE_B, pctrl->base + regs->pwpr);
-		spin_unlock_irqrestore(&pctrl->lock, flags);
+		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 	}
 	for (u8 i = 0; i < 2; i++) {
 		if (regs->sd_ch)
-- 
2.43.0


