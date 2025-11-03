Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9321BCCFA08
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 11:38:40 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18662.1762169901935752604
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Nov 2025 03:38:34 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: john.madieu.xa@bp.renesas.com)
X-CSE-ConnectionGUID: bYrqzWoUQGOqPF8zkPRkaw==
X-CSE-MsgGUID: mFobm1zzRg2fy8a9u7zaew==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 03 Nov 2025 20:38:33 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.166])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 99900419FC18;
	Mon,  3 Nov 2025 20:38:32 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Subject: [PATCH 6.12.y-cip 08/22] pinctrl: renesas: rzg2l: Add PFC_OEN support for RZ/G3E SoC
Date: Mon,  3 Nov 2025 12:37:52 +0100
Message-ID: <20251103113817.36331-9-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103113817.36331-1-john.madieu.xa@bp.renesas.com>
References: <20251103113817.36331-1-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Nov 2025 11:38:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20326

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit 54ac76e13ace31cf732bf5261811ef5af67022b7 ]

Add support for configuring the PFC_OEN register on the RZ/G3E SoC to
enable output-enable control for specific pins. On this SoC, certain
pins such as TXC_TXCLK need to support switching between input and
output modes depending on the PHY interface mode (e.g., MII vs RGMII).
This functionality maps to the 'output-enable' property in the device
tree and requires explicit control via the PFC_OEN register.

This change updates the r9a09g047_variable_pin_cfg array to mark PB1, PE1,
PL0, PL1, PL2, and PL4 with the PIN_CFG_OEN flag to indicate output-enable
support. A new helper, rzg3e_pin_to_oen_bit(), is introduced to map these
pin names to their respective OEN bit positions, and the corresponding
callbacks are wired into the RZ/G3E SoC configuration using the generic
rzg2l_read_oen() and rzg2l_write_oen() accessors. Additionally, the GPIO
configuration for the PB, PE, and PL ports is updated to use the variable
port pack macro, enabling per-pin configuration necessary for OEN handling.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250806195555.1372317-7-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 61 +++++++++++++++++++++----
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 9c7eeab5b4a4..0968069aab5a 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -397,6 +397,14 @@ static const u64 r9a09g047_variable_pin_cfg[] = {
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PA, 5, RZV2H_MPXED_PIN_FUNCS),
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PA, 6, RZV2H_MPXED_PIN_FUNCS),
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PA, 7, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PB, 0, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PB, 1, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_OEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PB, 2, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PB, 3, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PB, 4, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PB, 5, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PB, 6, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PB, 7, RZV2H_MPXED_PIN_FUNCS),
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PD, 0, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_IEN),
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PD, 1, RZV2H_MPXED_PIN_FUNCS),
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PD, 2, RZV2H_MPXED_PIN_FUNCS),
@@ -405,6 +413,14 @@ static const u64 r9a09g047_variable_pin_cfg[] = {
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PD, 5, RZV2H_MPXED_PIN_FUNCS),
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PD, 6, RZV2H_MPXED_PIN_FUNCS),
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PD, 7, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PE, 0, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PE, 1, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_OEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PE, 2, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PE, 3, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PE, 4, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PE, 5, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PE, 6, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PE, 7, RZV2H_MPXED_PIN_FUNCS),
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PG, 0, RZV2H_MPXED_PIN_FUNCS),
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PG, 1, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_IEN),
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PG, 2, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_IEN),
@@ -424,6 +440,14 @@ static const u64 r9a09g047_variable_pin_cfg[] = {
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PJ, 2, RZV2H_MPXED_PIN_FUNCS),
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PJ, 3, RZV2H_MPXED_PIN_FUNCS),
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PJ, 4, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PL, 0, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_OEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PL, 1, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_OEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PL, 2, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_OEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PL, 3, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PL, 4, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_OEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PL, 5, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PL, 6, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PL, 7, RZV2H_MPXED_PIN_FUNCS),
 };
 
 static const u64 r9a09g057_variable_pin_cfg[] = {
@@ -1195,23 +1219,39 @@ static int rzv2h_bias_param_to_hw(enum pin_config_param param)
 	return -EINVAL;
 }
 
-static int rzv2h_pin_to_oen_bit(struct rzg2l_pinctrl *pctrl, unsigned int _pin)
+static int rzg2l_pin_names_to_oen_bit(struct rzg2l_pinctrl *pctrl, unsigned int _pin,
+				      const char * const pin_names[], unsigned int count)
 {
-	static const char * const pin_names[] = { "ET0_TXC_TXCLK", "ET1_TXC_TXCLK",
-						  "XSPI0_RESET0N", "XSPI0_CS0N",
-						  "XSPI0_CKN", "XSPI0_CKP" };
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[_pin];
 	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(pin_names); i++) {
+	for (i = 0; i < count; i++) {
 		if (!strcmp(pin_desc->name, pin_names[i]))
 			return i;
 	}
 
-	/* Should not happen. */
 	return -EINVAL;
 }
 
+static int rzv2h_pin_to_oen_bit(struct rzg2l_pinctrl *pctrl, unsigned int _pin)
+{
+	static const char * const pin_names[] = {
+		"ET0_TXC_TXCLK", "ET1_TXC_TXCLK", "XSPI0_RESET0N",
+		"XSPI0_CS0N", "XSPI0_CKN", "XSPI0_CKP"
+	};
+
+	return rzg2l_pin_names_to_oen_bit(pctrl, _pin, pin_names, ARRAY_SIZE(pin_names));
+}
+
+static int rzg3e_pin_to_oen_bit(struct rzg2l_pinctrl *pctrl, unsigned int _pin)
+{
+	static const char * const pin_names[] = {
+		"PB1", "PE1", "PL4", "PL1", "PL2", "PL0"
+	};
+
+	return rzg2l_pin_names_to_oen_bit(pctrl, _pin, pin_names, ARRAY_SIZE(pin_names));
+}
+
 static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 				     unsigned int _pin,
 				     unsigned long *config)
@@ -2001,17 +2041,17 @@ static const u64 r9a09g047_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(6, 0x28, RZV2H_MPXED_PIN_FUNCS),	/* P8 */
 	0x0,
 	RZG2L_GPIO_PORT_PACK_VARIABLE(8, 0x2a),			/* PA */
-	RZG2L_GPIO_PORT_PACK(8, 0x2b, RZV2H_MPXED_PIN_FUNCS),	/* PB */
+	RZG2L_GPIO_PORT_PACK_VARIABLE(8, 0x2b),			/* PB */
 	RZG2L_GPIO_PORT_PACK(3, 0x2c, RZV2H_MPXED_PIN_FUNCS),	/* PC */
 	RZG2L_GPIO_PORT_PACK_VARIABLE(8, 0x2d),			/* PD */
-	RZG2L_GPIO_PORT_PACK(8, 0x2e, RZV2H_MPXED_PIN_FUNCS),	/* PE */
+	RZG2L_GPIO_PORT_PACK_VARIABLE(8, 0x2e),			/* PE */
 	RZG2L_GPIO_PORT_PACK(3, 0x2f, RZV2H_MPXED_PIN_FUNCS),	/* PF */
 	RZG2L_GPIO_PORT_PACK_VARIABLE(8, 0x30),			/* PG */
 	RZG2L_GPIO_PORT_PACK_VARIABLE(6, 0x31),			/* PH */
 	0x0,
 	RZG2L_GPIO_PORT_PACK_VARIABLE(5, 0x33),			/* PJ */
 	RZG2L_GPIO_PORT_PACK(4, 0x34, RZV2H_MPXED_PIN_FUNCS),	/* PK */
-	RZG2L_GPIO_PORT_PACK(8, 0x35, RZV2H_MPXED_PIN_FUNCS),	/* PL */
+	RZG2L_GPIO_PORT_PACK_VARIABLE(8, 0x35),			/* PL */
 	RZG2L_GPIO_PORT_PACK(8, 0x36, RZV2H_MPXED_PIN_FUNCS),	/* PM */
 	0x0,
 	0x0,
@@ -3311,6 +3351,9 @@ static struct rzg2l_pinctrl_data r9a09g047_data = {
 #endif
 	.pwpr_pfc_lock_unlock = &rzv2h_pwpr_pfc_lock_unlock,
 	.pmc_writeb = &rzv2h_pmc_writeb,
+	.pin_to_oen_bit = &rzg3e_pin_to_oen_bit,
+	.oen_read = &rzg2l_read_oen,
+	.oen_write = &rzg2l_write_oen,
 	.hw_to_bias_param = &rzv2h_hw_to_bias_param,
 	.bias_param_to_hw = &rzv2h_bias_param_to_hw,
 };
-- 
2.25.1


