Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCC0D41167
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 10:37:23 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32632.1768473436029544274
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 02:37:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=EiDgr7Nv;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64d1ef53cf3so1111377a12.0
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 02:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768473434; x=1769078234; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1h5kPO6ISOGWH8GNvBO/AGIIoUmW/3EUEgNUDve1t+s=;
        b=EiDgr7NvgkJpZHbWhp7KRGokZu+SHEWue3eo+FVFk/jG8wV83svHjDsdkDSpjDOdTm
         H7m1DzVxGec6nVbZxf2PdKM0jsZc1kvayqrVMCNnkx285ldDl6ZyjMc8WdKHJ9zYm1U7
         CH6rAmVTSMABiq71uIN+hLbj3z4Gu/A3vkSHr620A8rof1N4tfJo89bMKcacoRorNaMd
         cveL1BVA1vGTyG9IVC6B/VPXttZTM2gyNJnc1UPzNZJhp1XcmwhG/KQcVKZ/LQLlRNMH
         uf+rw8+SKhfN9fmLNpjMrN+V0conDSbCGUh6ef37hy275EOzOAYqaxcE6syGGLSpHrnN
         AGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768473434; x=1769078234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1h5kPO6ISOGWH8GNvBO/AGIIoUmW/3EUEgNUDve1t+s=;
        b=nuEXUSqwwCno0Icloz9lcPRPaFvMWCW9nhaoKNiRqDbcOzXB+SS4IXUpZnAQ+ffXG+
         6bG13NXCUoJ5sj99VqpWjBkxqgs1etZpeaKOO5QKLh4aXeRlo/+JxEpeDEy+GVsWlaaF
         2hbF8t7X45D/4Ciy0tc1c57ze8oBHDaMKTN2WLo1HS1jMSXx6Un/Si4WIMju7u3H97Ap
         PY+seN21gNw0SMVb8m5Ypvd91N4xqfRWI7j/U1l4MJq088MzttfWioAqqpmX2EHlTmh7
         3tWOkg6FJ9wBmQMtuQc9tn03GZ+4SCADVMxyG41Knw0yi0GwN7NYWLQkgE64ITC+QXCt
         U6MA==
X-Gm-Message-State: AOJu0YxHn9ULwhrYhZYG+egbcpEwDyxZNIP9NA6IWHS4BG85CCt/kww3
	bBnXCmPWkcegf9eQaHudhoRZomaQCCYUW41+R1x2TI/XhDBjxrYeHF8oanIuOs+3AqU=
X-Gm-Gg: AY/fxX4GClOL4T9BH/Z51NprxUQCDDLtJUitWyVTetW/SgFR6Yu95dmc8syRr4143AS
	OF6rYJ+QB54oaA4xQtIM+JeVY1+wFJOhELJ+cMBJYZUEp9XWZCsSjSbj1yT7ilSdrwfJZavGZSD
	zgPQ5Ik2klu0DGS1i1PnqVYjY0jC+IyHEKZJ4tfhDEz/s1L4WBQBpcmtrurICI++fSdF09p48us
	JA8syKW6ILROsDXtdbXOavc1gstOeG8ditU61QVao2Jbp6x1H14KffbChxzS1F8qC5c9chX+hwW
	mR1QJco9Ihb+2FcxvT6YaKySux/Q/Uh1hDJjFeizIuCrLCBxzzCNjQ0FhRm2sFNfWqV82qWQAkQ
	x8T800ZfilD/9iXQAKCEG0YvfGGowVm6Kqi0k/2rhAZa5z5z5yXJQu/gUom7kX0/2U6FSfsKMf6
	oRIIPksNiXWhRwIE7sj1EEvh6fqnr4GtKFImmEXWu1fPe8HNOcWi/Q2kKTnDstHejVvQ==
X-Received: by 2002:a17:907:5ce:b0:b83:9767:c8ba with SMTP id a640c23a62f3a-b876775c257mr395711166b.17.1768473434198;
        Thu, 15 Jan 2026 02:37:14 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86ebfd007fsm1555780666b.31.2026.01.15.02.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 02:37:13 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip] pinctrl: renesas: rzg2l: Fix ISEL restore on resume
Date: Thu, 15 Jan 2026 12:37:10 +0200
Message-ID: <20260115103710.133165-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 10:37:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21622

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 44bf66122c12ef6d3382a9b84b9be1802e5f0e95 upstream.

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
[claudiu.beznea: fixed conflicts:
 - dropped code unavailable on v5.10 CIP
 - kept code from v5.10 CIP on merge conflicts
 - manually adjusted the remaining  untouched
   spin_lock_irqsave()/spin_unlock_irqrestore() with
   raw_spin_lock_irqsave()/raw_spin_unlock_irqrestore()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Hi,

The v6.1 CIP variant of this patch was already integrated at [1].
The patch was backported in v6.12 stable at [2].
Please consider this patch as well as it is necessary for the Renesas
RZ/G3S SoC.

Thank you,
Claudiu

[1] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/drivers/pinctrl/renesas/pinctrl-rzg2l.c?h=linux-6.1.y-cip&id=9c6a8dccc2af82f74d6401d5c13f4039bbad02eb
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.12.y&id=f8bb150f228f4c1500632a81e91e6ad99df5c90c

 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 63 ++++++++++++++++---------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 7e6ff6617c93..bcdbf1362fa3 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -307,7 +307,7 @@ struct rzg2l_pinctrl {
 	spinlock_t			bitmap_lock;
 	unsigned int			hwirq[RZG2L_TINT_MAX_INTERRUPT];
 
-	spinlock_t			lock; /* lock read/write registers */
+	raw_spinlock_t			lock; /* lock read/write registers */
 	struct mutex			mutex; /* serialize adding groups and functions */
 
 	struct rzg2l_pinctrl_pin_settings *settings;
@@ -462,7 +462,7 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 	unsigned long flags;
 	u32 reg;
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	/* Set pin to 'Non-use (Hi-Z input protection)'  */
 	reg = readw(pctrl->base + PM(off));
@@ -490,7 +490,7 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 	reg = readb(pctrl->base + PMC(off));
 	writeb(reg | BIT(pin), pctrl->base + PMC(off));
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 };
 
 static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
@@ -821,10 +821,10 @@ static void rzg2l_rmw_pin_config(struct rzg2l_pinctrl *pctrl, u32 offset,
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
@@ -1056,14 +1056,14 @@ static int rzg2l_write_oen(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8
 
 	bit = rzg2l_pin_to_oen_bit(offset, pin, max_port);
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 	val = readb(pctrl->base + ETH_MODE);
 	if (oen)
 		val &= ~BIT(bit);
 	else
 		val |= BIT(bit);
 	writeb(val, pctrl->base + ETH_MODE);
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
 }
@@ -1400,14 +1400,14 @@ static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	if (ret)
 		return ret;
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	/* Select GPIO mode in PMC Register */
 	reg8 = readb(pctrl->base + PMC(off));
 	reg8 &= ~BIT(bit);
 	writeb(reg8, pctrl->base + PMC(off));
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
 }
@@ -1422,7 +1422,7 @@ static void rzg2l_gpio_set_direction(struct rzg2l_pinctrl *pctrl, u32 offset,
 	unsigned long flags;
 	u16 reg16;
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	reg16 = readw(pctrl->base + PM(off));
 	reg16 &= ~(PM_MASK << (bit * 2));
@@ -1430,7 +1430,7 @@ static void rzg2l_gpio_set_direction(struct rzg2l_pinctrl *pctrl, u32 offset,
 	reg16 |= (output ? PM_OUTPUT : PM_INPUT) << (bit * 2);
 	writew(reg16, pctrl->base + PM(off));
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static int rzg2l_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
@@ -1474,7 +1474,7 @@ static void rzg2l_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	unsigned long flags;
 	u8 reg8;
 
-	spin_lock_irqsave(&pctrl->lock, flags);
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	reg8 = readb(pctrl->base + P(off));
 
@@ -1483,7 +1483,7 @@ static void rzg2l_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	else
 		writeb(reg8 & ~BIT(bit), pctrl->base + P(off));
 
-	spin_unlock_irqrestore(&pctrl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static int rzg2l_gpio_direction_output(struct gpio_chip *chip,
@@ -1865,14 +1865,13 @@ static int rzg2l_gpio_get_gpioint(unsigned int virq, struct rzg2l_pinctrl *pctrl
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
@@ -1881,12 +1880,20 @@ static void rzg2l_gpio_irq_endisable(struct rzg2l_pinctrl *pctrl,
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
@@ -1898,15 +1905,25 @@ static void rzg2l_gpio_irq_disable(struct irq_data *d)
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
@@ -2069,11 +2086,11 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
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
@@ -2393,7 +2410,7 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 				     "failed to enable GPIO clk\n");
 	}
 
-	spin_lock_init(&pctrl->lock);
+	raw_spin_lock_init(&pctrl->lock);
 	spin_lock_init(&pctrl->bitmap_lock);
 	mutex_init(&pctrl->mutex);
 	atomic_set(&pctrl->wakeup_path, 0);
-- 
2.43.0


