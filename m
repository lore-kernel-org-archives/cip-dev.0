Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E289CA0EE8
	for <webhook@archiver.kernel.org>; Sun, 14 Sep 2025 19:54:21 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.16480.1757879659968957481
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Sep 2025 12:54:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: Pz3MeAndRkKOpzhKGLeMBg==
X-CSE-MsgGUID: UWxuFOB2SQe2xfNteyRp3w==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Sep 2025 04:54:17 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.12])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4D1124007CFD;
	Mon, 15 Sep 2025 04:54:16 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Ulrich Hecht <uli@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH RESEND 4.19.y-cip] gpio: rcar: Use raw_spinlock to protect register access
Date: Sun, 14 Sep 2025 20:54:15 +0100
Message-ID: <20250914195415.74725-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 14 Sep 2025 19:54:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20048

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

commit f02c41f87cfe61440c18bf77d1ef0a884b9ee2b5 upstream.

Use raw_spinlock in order to fix spurious messages about invalid context
when spinlock debugging is enabled. The lock is only used to serialize
register access.

    [    4.239592] =============================
    [    4.239595] [ BUG: Invalid wait context ]
    [    4.239599] 6.13.0-rc7-arm64-renesas-05496-gd088502a519f #35 Not tainted
    [    4.239603] -----------------------------
    [    4.239606] kworker/u8:5/76 is trying to lock:
    [    4.239609] ffff0000091898a0 (&p->lock){....}-{3:3}, at: gpio_rcar_config_interrupt_input_mode+0x34/0x164
    [    4.239641] other info that might help us debug this:
    [    4.239643] context-{5:5}
    [    4.239646] 5 locks held by kworker/u8:5/76:
    [    4.239651]  #0: ffff0000080fb148 ((wq_completion)async){+.+.}-{0:0}, at: process_one_work+0x190/0x62c
    [    4.250180] OF: /soc/sound@ec500000/ports/port@0/endpoint: Read of boolean property 'frame-master' with a value.
    [    4.254094]  #1: ffff80008299bd80 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work+0x1b8/0x62c
    [    4.254109]  #2: ffff00000920c8f8
    [    4.258345] OF: /soc/sound@ec500000/ports/port@1/endpoint: Read of boolean property 'bitclock-master' with a value.
    [    4.264803]  (&dev->mutex){....}-{4:4}, at: __device_attach_async_helper+0x3c/0xdc
    [    4.264820]  #3: ffff00000a50ca40 (request_class#2){+.+.}-{4:4}, at: __setup_irq+0xa0/0x690
    [    4.264840]  #4:
    [    4.268872] OF: /soc/sound@ec500000/ports/port@1/endpoint: Read of boolean property 'frame-master' with a value.
    [    4.273275] ffff00000a50c8c8 (lock_class){....}-{2:2}, at: __setup_irq+0xc4/0x690
    [    4.296130] renesas_sdhi_internal_dmac ee100000.mmc: mmc1 base at 0x00000000ee100000, max clock rate 200 MHz
    [    4.304082] stack backtrace:
    [    4.304086] CPU: 1 UID: 0 PID: 76 Comm: kworker/u8:5 Not tainted 6.13.0-rc7-arm64-renesas-05496-gd088502a519f #35
    [    4.304092] Hardware name: Renesas Salvator-X 2nd version board based on r8a77965 (DT)
    [    4.304097] Workqueue: async async_run_entry_fn
    [    4.304106] Call trace:
    [    4.304110]  show_stack+0x14/0x20 (C)
    [    4.304122]  dump_stack_lvl+0x6c/0x90
    [    4.304131]  dump_stack+0x14/0x1c
    [    4.304138]  __lock_acquire+0xdfc/0x1584
    [    4.426274]  lock_acquire+0x1c4/0x33c
    [    4.429942]  _raw_spin_lock_irqsave+0x5c/0x80
    [    4.434307]  gpio_rcar_config_interrupt_input_mode+0x34/0x164
    [    4.440061]  gpio_rcar_irq_set_type+0xd4/0xd8
    [    4.444422]  __irq_set_trigger+0x5c/0x178
    [    4.448435]  __setup_irq+0x2e4/0x690
    [    4.452012]  request_threaded_irq+0xc4/0x190
    [    4.456285]  devm_request_threaded_irq+0x7c/0xf4
    [    4.459398] ata1: link resume succeeded after 1 retries
    [    4.460902]  mmc_gpiod_request_cd_irq+0x68/0xe0
    [    4.470660]  mmc_start_host+0x50/0xac
    [    4.474327]  mmc_add_host+0x80/0xe4
    [    4.477817]  tmio_mmc_host_probe+0x2b0/0x440
    [    4.482094]  renesas_sdhi_probe+0x488/0x6f4
    [    4.486281]  renesas_sdhi_internal_dmac_probe+0x60/0x78
    [    4.491509]  platform_probe+0x64/0xd8
    [    4.495178]  really_probe+0xb8/0x2a8
    [    4.498756]  __driver_probe_device+0x74/0x118
    [    4.503116]  driver_probe_device+0x3c/0x154
    [    4.507303]  __device_attach_driver+0xd4/0x160
    [    4.511750]  bus_for_each_drv+0x84/0xe0
    [    4.515588]  __device_attach_async_helper+0xb0/0xdc
    [    4.520470]  async_run_entry_fn+0x30/0xd8
    [    4.524481]  process_one_work+0x210/0x62c
    [    4.528494]  worker_thread+0x1ac/0x340
    [    4.532245]  kthread+0x10c/0x110
    [    4.535476]  ret_from_fork+0x10/0x20

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250121135833.3769310-1-niklas.soderlund+renesas@ragnatech.se
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
[PL: manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi All,

This backport is intended to fix CVE-2025-21912 [0], as requested
[1] resending the patch as this patch has landed into 5.10-cip
via stable [2].

Note,
- This patch is already present in 6.1-cip [3] & 6.12-cip [4].

[0] https://nvd.nist.gov/vuln/detail/CVE-2025-21912
[1] https://lore.kernel.org/all/20250820141628.5014-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/?h=linux-5.10.y-cip&id=389891ac9f678baf68e13623ef1308493af4b074
[3] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/drivers/gpio/gpio-rcar.c?h=linux-6.1.y-cip&id=3e300913c42041e81c5b17a970c4e078086ff2d1
[4] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/drivers/gpio/gpio-rcar.c?h=linux-6.12.y-cip&id=b42c84f9e4ec5bc2885e7fd80c79ec0352f5d2af

Cheers, Prabhakar
---
 drivers/gpio/gpio-rcar.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index c8d526aed633a..f70dec0dfd830 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -42,7 +42,7 @@ struct gpio_rcar_bank_info {
 
 struct gpio_rcar_priv {
 	void __iomem *base;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct device *dev;
 	struct gpio_chip gpio_chip;
 	struct irq_chip irq_chip;
@@ -122,7 +122,7 @@ static void gpio_rcar_config_interrupt_input_mode(struct gpio_rcar_priv *p,
 	 * "Setting Level-Sensitive Interrupt Input Mode"
 	 */
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 
 	/* Configure postive or negative logic in POSNEG */
 	gpio_rcar_modify_bit(p, POSNEG, hwirq, !active_high_rising_edge);
@@ -141,7 +141,7 @@ static void gpio_rcar_config_interrupt_input_mode(struct gpio_rcar_priv *p,
 	if (!level_trigger)
 		gpio_rcar_write(p, INTCLR, BIT(hwirq));
 
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static int gpio_rcar_irq_set_type(struct irq_data *d, unsigned int type)
@@ -234,7 +234,7 @@ static void gpio_rcar_config_general_input_output_mode(struct gpio_chip *chip,
 	 * "Setting General Input Mode"
 	 */
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 
 	/* Configure postive logic in POSNEG */
 	gpio_rcar_modify_bit(p, POSNEG, gpio, false);
@@ -249,7 +249,7 @@ static void gpio_rcar_config_general_input_output_mode(struct gpio_chip *chip,
 	if (p->has_outdtsel && output)
 		gpio_rcar_modify_bit(p, OUTDTSEL, gpio, false);
 
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static int gpio_rcar_request(struct gpio_chip *chip, unsigned offset)
@@ -313,9 +313,9 @@ static void gpio_rcar_set(struct gpio_chip *chip, unsigned offset, int value)
 	struct gpio_rcar_priv *p = gpiochip_get_data(chip);
 	unsigned long flags;
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 	gpio_rcar_modify_bit(p, OUTDT, offset, value);
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static void gpio_rcar_set_multiple(struct gpio_chip *chip, unsigned long *mask,
@@ -329,12 +329,12 @@ static void gpio_rcar_set_multiple(struct gpio_chip *chip, unsigned long *mask,
 	if (!bankmask)
 		return;
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 	val = gpio_rcar_read(p, OUTDT);
 	val &= ~bankmask;
 	val |= (bankmask & bits[0]);
 	gpio_rcar_write(p, OUTDT, val);
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static int gpio_rcar_direction_output(struct gpio_chip *chip, unsigned offset,
@@ -448,7 +448,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	p->dev = dev;
-	spin_lock_init(&p->lock);
+	raw_spin_lock_init(&p->lock);
 
 	/* Get device configuration from DT node */
 	ret = gpio_rcar_parse_dt(p, &npins);
-- 
2.43.0


