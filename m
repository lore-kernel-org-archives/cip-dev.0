Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1436ECCFA08
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 11:36:30 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18623.1762169774650115223
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Nov 2025 03:36:23 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: john.madieu.xa@bp.renesas.com)
X-CSE-ConnectionGUID: ZCuS1i0SQn2V0AHPD02nHA==
X-CSE-MsgGUID: rHuG6oT/RKK7FDGANFe/eA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Nov 2025 20:36:22 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.166])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6F1CA400942A;
	Mon,  3 Nov 2025 20:36:21 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Subject: [PATCH 6.1.y-cip 07/25] pinctrl: renesas: rzg2l: Unify OEN access by making pin-to-bit mapping configurable
Date: Mon,  3 Nov 2025 12:35:40 +0100
Message-ID: <20251103113608.36240-8-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
References: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Nov 2025 11:36:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20299

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit a3455a0c24834eaa20f032b214d53b1607d60073 ]

Refactor the RZG2L pinctrl driver to support reuse of the common
rzg2l_read_oen() and rzg2l_write_oen() helpers across SoCs with
different output-enable (OEN) bit mappings.

Introduce a new `pin_to_oen_bit` callback in `struct rzg2l_pinctrl_data`
to allow SoCs to provide custom logic for mapping a pin to its OEN bit.
Update the generic OEN read/write paths to use this callback when present.

With this change, SoCs like RZ/G3S can reuse the common OEN handling
code by simply supplying their own `pin_to_oen_bit` implementation.
The previously duplicated `rzg3s_oen_read()` and `rzg3s_oen_write()`
functions are now removed.

This improves maintainability and prepares the driver for supporting
future SoCs with minimal duplication.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250806195555.1372317-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 54 +++++++------------------
 1 file changed, 15 insertions(+), 39 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index cc8a2cccf16f..30e2346c7109 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -295,6 +295,7 @@ struct rzg2l_pinctrl_data {
 #endif
 	void (*pwpr_pfc_lock_unlock)(struct rzg2l_pinctrl *pctrl, bool lock);
 	void (*pmc_writeb)(struct rzg2l_pinctrl *pctrl, u8 val, u16 offset);
+	int (*pin_to_oen_bit)(struct rzg2l_pinctrl *pctrl, unsigned int _pin);
 	u32 (*oen_read)(struct rzg2l_pinctrl *pctrl, unsigned int _pin);
 	int (*oen_write)(struct rzg2l_pinctrl *pctrl, unsigned int _pin, u8 oen);
 	int (*hw_to_bias_param)(unsigned int val);
@@ -1063,7 +1064,10 @@ static u32 rzg2l_read_oen(struct rzg2l_pinctrl *pctrl, unsigned int _pin)
 {
 	int bit;
 
-	bit = rzg2l_pin_to_oen_bit(pctrl, _pin);
+	if (!pctrl->data->pin_to_oen_bit)
+		return 0;
+
+	bit = pctrl->data->pin_to_oen_bit(pctrl, _pin);
 	if (bit < 0)
 		return 0;
 
@@ -1077,9 +1081,12 @@ static int rzg2l_write_oen(struct rzg2l_pinctrl *pctrl, unsigned int _pin, u8 oe
 	int bit;
 	u8 val;
 
-	bit = rzg2l_pin_to_oen_bit(pctrl, _pin);
+	if (!pctrl->data->pin_to_oen_bit)
+		return -EINVAL;
+
+	bit = pctrl->data->pin_to_oen_bit(pctrl, _pin);
 	if (bit < 0)
-		return bit;
+		return -EINVAL;
 
 	spin_lock_irqsave(&pctrl->lock, flags);
 	val = readb(pctrl->base + oen_offset);
@@ -1113,40 +1120,6 @@ static int rzg3s_pin_to_oen_bit(struct rzg2l_pinctrl *pctrl, unsigned int _pin)
 	return bit;
 }
 
-static u32 rzg3s_oen_read(struct rzg2l_pinctrl *pctrl, unsigned int _pin)
-{
-	int bit;
-
-	bit = rzg3s_pin_to_oen_bit(pctrl, _pin);
-	if (bit < 0)
-		return 0;
-
-	return !(readb(pctrl->base + pctrl->data->hwcfg->regs.oen) & BIT(bit));
-}
-
-static int rzg3s_oen_write(struct rzg2l_pinctrl *pctrl, unsigned int _pin, u8 oen)
-{
-	u16 oen_offset = pctrl->data->hwcfg->regs.oen;
-	unsigned long flags;
-	int bit;
-	u8 val;
-
-	bit = rzg3s_pin_to_oen_bit(pctrl, _pin);
-	if (bit < 0)
-		return bit;
-
-	spin_lock_irqsave(&pctrl->lock, flags);
-	val = readb(pctrl->base + oen_offset);
-	if (oen)
-		val &= ~BIT(bit);
-	else
-		val |= BIT(bit);
-	writeb(val, pctrl->base + oen_offset);
-	spin_unlock_irqrestore(&pctrl->lock, flags);
-
-	return 0;
-}
-
 static int rzg2l_hw_to_bias_param(unsigned int bias)
 {
 	switch (bias) {
@@ -3288,6 +3261,7 @@ static struct rzg2l_pinctrl_data r9a07g043_data = {
 #endif
 	.pwpr_pfc_lock_unlock = &rzg2l_pwpr_pfc_lock_unlock,
 	.pmc_writeb = &rzg2l_pmc_writeb,
+	.pin_to_oen_bit = &rzg2l_pin_to_oen_bit,
 	.oen_read = &rzg2l_read_oen,
 	.oen_write = &rzg2l_write_oen,
 	.hw_to_bias_param = &rzg2l_hw_to_bias_param,
@@ -3305,6 +3279,7 @@ static struct rzg2l_pinctrl_data r9a07g044_data = {
 	.hwcfg = &rzg2l_hwcfg,
 	.pwpr_pfc_lock_unlock = &rzg2l_pwpr_pfc_lock_unlock,
 	.pmc_writeb = &rzg2l_pmc_writeb,
+	.pin_to_oen_bit = &rzg2l_pin_to_oen_bit,
 	.oen_read = &rzg2l_read_oen,
 	.oen_write = &rzg2l_write_oen,
 	.hw_to_bias_param = &rzg2l_hw_to_bias_param,
@@ -3321,8 +3296,9 @@ static struct rzg2l_pinctrl_data r9a08g045_data = {
 	.hwcfg = &rzg3s_hwcfg,
 	.pwpr_pfc_lock_unlock = &rzg2l_pwpr_pfc_lock_unlock,
 	.pmc_writeb = &rzg2l_pmc_writeb,
-	.oen_read = &rzg3s_oen_read,
-	.oen_write = &rzg3s_oen_write,
+	.pin_to_oen_bit = &rzg3s_pin_to_oen_bit,
+	.oen_read = &rzg2l_read_oen,
+	.oen_write = &rzg2l_write_oen,
 	.hw_to_bias_param = &rzg2l_hw_to_bias_param,
 	.bias_param_to_hw = &rzg2l_bias_param_to_hw,
 };
-- 
2.25.1


