Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263F6CCFA09
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 11:36:30 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18623.1762169774650115223
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Nov 2025 03:36:26 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: john.madieu.xa@bp.renesas.com)
X-CSE-ConnectionGUID: BMoLUpGqTTyk0WwuoujFGg==
X-CSE-MsgGUID: 9LRLyPjaQTmo3mdO2QT+Wg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Nov 2025 20:36:26 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.166])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D2F8C400942A;
	Mon,  3 Nov 2025 20:36:24 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Subject: [PATCH 6.1.y-cip 09/25] pinctrl: renesas: rzg2l: Unify OEN handling across RZ/{G2L,V2H,V2N}
Date: Mon,  3 Nov 2025 12:35:42 +0100
Message-ID: <20251103113608.36240-10-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
References: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Nov 2025 11:36:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20301

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit cd39805be85b8ff45b0ad2715d8de48dbe404cee ]

Unify the OEN handling on RZ/V2H(P) and RZ/V2N SoCs by reusing the existing
rzg2l_read_oen and rzg2l_write_oen functions from RZ/G2L. Add a
pin_to_oen_bit callback in rzg2l_pinctrl_data to look up per-pin OEN bit
positions, and introduce an oen_pwpr_lock flag in the hwcfg to manage PWPR
locking on SoCs that require it (RZ/V2H(P) family). Remove the hardcoded
PFC_OEN define and obsolete per-SoC OEN helpers.

Also drop redundant checks for the OEN offset in the suspend/resume paths,
as all supported SoCs now provide a valid offset through the `regs.oen`
field.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250806195555.1372317-6-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 68 ++++++++-----------------
 1 file changed, 22 insertions(+), 46 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 36f3452939f0..1f82d47fcedc 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -145,7 +145,6 @@
 #define SD_CH(off, ch)		((off) + (ch) * 4)
 #define ETH_POC(off, ch)	((off) + (ch) * 4)
 #define QSPI			(0x3008)
-#define PFC_OEN			(0x3C40) /* known on RZ/V2H(P) only */
 
 #define PVDD_2500		2	/* I/O domain voltage 2.5V */
 #define PVDD_1800		1	/* I/O domain voltage <= 1.8V */
@@ -254,6 +253,7 @@ enum rzg2l_iolh_index {
  * @iolh_groupb_oi: IOLH group B output impedance specific values
  * @tint_start_index: the start index for the TINT interrupts
  * @drive_strength_ua: drive strength in uA is supported (otherwise mA is supported)
+ * @oen_pwpr_lock: flag indicating if the OEN register is locked by PWPR
  * @func_base: base number for port function (see register PFC)
  * @oen_max_pin: the maximum pin number supporting output enable
  * @oen_max_port: the maximum port number supporting output enable
@@ -266,6 +266,7 @@ struct rzg2l_hwcfg {
 	u16 iolh_groupb_oi[4];
 	u16 tint_start_index;
 	bool drive_strength_ua;
+	bool oen_pwpr_lock;
 	u8 func_base;
 	u8 oen_max_pin;
 	u8 oen_max_port;
@@ -1076,10 +1077,11 @@ static u32 rzg2l_read_oen(struct rzg2l_pinctrl *pctrl, unsigned int _pin)
 
 static int rzg2l_write_oen(struct rzg2l_pinctrl *pctrl, unsigned int _pin, u8 oen)
 {
+	const struct rzg2l_register_offsets *regs = &pctrl->data->hwcfg->regs;
 	u16 oen_offset = pctrl->data->hwcfg->regs.oen;
 	unsigned long flags;
+	u8 val, pwpr;
 	int bit;
-	u8 val;
 
 	if (!pctrl->data->pin_to_oen_bit)
 		return -EINVAL;
@@ -1094,7 +1096,13 @@ static int rzg2l_write_oen(struct rzg2l_pinctrl *pctrl, unsigned int _pin, u8 oe
 		val &= ~BIT(bit);
 	else
 		val |= BIT(bit);
+	if (pctrl->data->hwcfg->oen_pwpr_lock) {
+		pwpr = readb(pctrl->base + regs->pwpr);
+		writeb(pwpr | PWPR_REGWE_B, pctrl->base + regs->pwpr);
+	}
 	writeb(val, pctrl->base + oen_offset);
+	if (pctrl->data->hwcfg->oen_pwpr_lock)
+		writeb(pwpr & ~PWPR_REGWE_B, pctrl->base + regs->pwpr);
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
@@ -1185,7 +1193,7 @@ static int rzv2h_bias_param_to_hw(enum pin_config_param param)
 	return -EINVAL;
 }
 
-static u8 rzv2h_pin_to_oen_bit(struct rzg2l_pinctrl *pctrl, unsigned int _pin)
+static int rzv2h_pin_to_oen_bit(struct rzg2l_pinctrl *pctrl, unsigned int _pin)
 {
 	static const char * const pin_names[] = { "ET0_TXC_TXCLK", "ET1_TXC_TXCLK",
 						  "XSPI0_RESET0N", "XSPI0_CS0N",
@@ -1199,41 +1207,7 @@ static u8 rzv2h_pin_to_oen_bit(struct rzg2l_pinctrl *pctrl, unsigned int _pin)
 	}
 
 	/* Should not happen. */
-	return 0;
-}
-
-static u32 rzv2h_oen_read(struct rzg2l_pinctrl *pctrl, unsigned int _pin)
-{
-	u8 bit;
-
-	bit = rzv2h_pin_to_oen_bit(pctrl, _pin);
-
-	return !(readb(pctrl->base + PFC_OEN) & BIT(bit));
-}
-
-static int rzv2h_oen_write(struct rzg2l_pinctrl *pctrl, unsigned int _pin, u8 oen)
-{
-	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
-	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
-	unsigned long flags;
-	u8 val, bit;
-	u8 pwpr;
-
-	bit = rzv2h_pin_to_oen_bit(pctrl, _pin);
-	spin_lock_irqsave(&pctrl->lock, flags);
-	val = readb(pctrl->base + PFC_OEN);
-	if (oen)
-		val &= ~BIT(bit);
-	else
-		val |= BIT(bit);
-
-	pwpr = readb(pctrl->base + regs->pwpr);
-	writeb(pwpr | PWPR_REGWE_B, pctrl->base + regs->pwpr);
-	writeb(val, pctrl->base + PFC_OEN);
-	writeb(pwpr & ~PWPR_REGWE_B, pctrl->base + regs->pwpr);
-	spin_unlock_irqrestore(&pctrl->lock, flags);
-
-	return 0;
+	return -EINVAL;
 }
 
 static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
@@ -3116,8 +3090,7 @@ static int rzg2l_pinctrl_suspend_noirq(struct device *dev)
 	}
 
 	cache->qspi = readb(pctrl->base + QSPI);
-	if (pctrl->data->hwcfg->regs.oen)
-		cache->oen = readb(pctrl->base + pctrl->data->hwcfg->regs.oen);
+	cache->oen = readb(pctrl->base + pctrl->data->hwcfg->regs.oen);
 
 	if (!atomic_read(&pctrl->wakeup_path))
 		clk_disable_unprepare(pctrl->clk);
@@ -3142,8 +3115,7 @@ static int rzg2l_pinctrl_resume_noirq(struct device *dev)
 	}
 
 	writeb(cache->qspi, pctrl->base + QSPI);
-	if (pctrl->data->hwcfg->regs.oen)
-		writeb(cache->oen, pctrl->base + pctrl->data->hwcfg->regs.oen);
+	writeb(cache->oen, pctrl->base + pctrl->data->hwcfg->regs.oen);
 	for (u8 i = 0; i < 2; i++) {
 		if (regs->sd_ch)
 			writeb(cache->sd_ch[i], pctrl->base + SD_CH(regs->sd_ch, i));
@@ -3243,8 +3215,10 @@ static const struct rzg2l_hwcfg rzg3s_hwcfg = {
 static const struct rzg2l_hwcfg rzv2h_hwcfg = {
 	.regs = {
 		.pwpr = 0x3c04,
+		.oen = 0x3c40,
 	},
 	.tint_start_index = 17,
+	.oen_pwpr_lock = true,
 };
 
 static struct rzg2l_pinctrl_data r9a07g043_data = {
@@ -3341,8 +3315,9 @@ static struct rzg2l_pinctrl_data r9a09g056_data = {
 #endif
 	.pwpr_pfc_lock_unlock = &rzv2h_pwpr_pfc_lock_unlock,
 	.pmc_writeb = &rzv2h_pmc_writeb,
-	.oen_read = &rzv2h_oen_read,
-	.oen_write = &rzv2h_oen_write,
+	.pin_to_oen_bit = &rzv2h_pin_to_oen_bit,
+	.oen_read = &rzg2l_read_oen,
+	.oen_write = &rzg2l_write_oen,
 	.hw_to_bias_param = &rzv2h_hw_to_bias_param,
 	.bias_param_to_hw = &rzv2h_bias_param_to_hw,
 };
@@ -3365,8 +3340,9 @@ static struct rzg2l_pinctrl_data r9a09g057_data = {
 #endif
 	.pwpr_pfc_lock_unlock = &rzv2h_pwpr_pfc_lock_unlock,
 	.pmc_writeb = &rzv2h_pmc_writeb,
-	.oen_read = &rzv2h_oen_read,
-	.oen_write = &rzv2h_oen_write,
+	.pin_to_oen_bit = &rzv2h_pin_to_oen_bit,
+	.oen_read = &rzg2l_read_oen,
+	.oen_write = &rzg2l_write_oen,
 	.hw_to_bias_param = &rzv2h_hw_to_bias_param,
 	.bias_param_to_hw = &rzv2h_bias_param_to_hw,
 };
-- 
2.25.1


