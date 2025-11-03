Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96252CCFA0C
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 11:38:40 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18661.1762169900237480921
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Nov 2025 03:38:35 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: john.madieu.xa@bp.renesas.com)
X-CSE-ConnectionGUID: hVaoRiJPS5qymgtJ/4zKtw==
X-CSE-MsgGUID: c10yMp8zR9ydynzJdb3AYA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 03 Nov 2025 20:38:35 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.166])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 54474419FC18;
	Mon,  3 Nov 2025 20:38:34 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Subject: [PATCH 6.12.y-cip 09/22] pinctrl: renesas: rzg2l: Drop oen_read and oen_write callbacks
Date: Mon,  3 Nov 2025 12:37:53 +0100
Message-ID: <20251103113817.36331-10-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103113817.36331-1-john.madieu.xa@bp.renesas.com>
References: <20251103113817.36331-1-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Nov 2025 11:38:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20327

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit 560c633d378a0cf34afcd66c99321d6306a7e937 ]

Remove oen_read and oen_write callbacks from rzg2l_pinctrl_data as
all SoCs now use the same rzg2l_read_oen() and rzg2l_write_oen()
functions directly.

Change rzg2l_read_oen() return type to int for proper error reporting
and update callers to handle errors consistently.

This simplifies the code by removing redundant callbacks and ensures
uniform OEN handling across all supported SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250806195555.1372317-8-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit 560c633d378a0cf34afcd66c99321d6306a7e937)
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 35 +++++++------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 0968069aab5a..2a87d0352fc1 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -298,8 +298,6 @@ struct rzg2l_pinctrl_data {
 	void (*pwpr_pfc_lock_unlock)(struct rzg2l_pinctrl *pctrl, bool lock);
 	void (*pmc_writeb)(struct rzg2l_pinctrl *pctrl, u8 val, u16 offset);
 	int (*pin_to_oen_bit)(struct rzg2l_pinctrl *pctrl, unsigned int _pin);
-	u32 (*oen_read)(struct rzg2l_pinctrl *pctrl, unsigned int _pin);
-	int (*oen_write)(struct rzg2l_pinctrl *pctrl, unsigned int _pin, u8 oen);
 	int (*hw_to_bias_param)(unsigned int val);
 	int (*bias_param_to_hw)(enum pin_config_param param);
 };
@@ -1087,16 +1085,16 @@ static int rzg2l_pin_to_oen_bit(struct rzg2l_pinctrl *pctrl, unsigned int _pin)
 	return -EINVAL;
 }
 
-static u32 rzg2l_read_oen(struct rzg2l_pinctrl *pctrl, unsigned int _pin)
+static int rzg2l_read_oen(struct rzg2l_pinctrl *pctrl, unsigned int _pin)
 {
 	int bit;
 
 	if (!pctrl->data->pin_to_oen_bit)
-		return 0;
+		return -EOPNOTSUPP;
 
 	bit = pctrl->data->pin_to_oen_bit(pctrl, _pin);
 	if (bit < 0)
-		return 0;
+		return -EINVAL;
 
 	return !(readb(pctrl->base + pctrl->data->hwcfg->regs.oen) & BIT(bit));
 }
@@ -1110,7 +1108,7 @@ static int rzg2l_write_oen(struct rzg2l_pinctrl *pctrl, unsigned int _pin, u8 oe
 	int bit;
 
 	if (!pctrl->data->pin_to_oen_bit)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	bit = pctrl->data->pin_to_oen_bit(pctrl, _pin);
 	if (bit < 0)
@@ -1293,11 +1291,10 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 	case PIN_CONFIG_OUTPUT_ENABLE:
 		if (!(cfg & PIN_CFG_OEN))
 			return -EINVAL;
-		if (!pctrl->data->oen_read)
-			return -EOPNOTSUPP;
-		arg = pctrl->data->oen_read(pctrl, _pin);
-		if (!arg)
-			return -EINVAL;
+		ret = rzg2l_read_oen(pctrl, _pin);
+		if (ret < 0)
+			return ret;
+		arg = ret;
 		break;
 
 	case PIN_CONFIG_POWER_SOURCE:
@@ -1456,9 +1453,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 		case PIN_CONFIG_OUTPUT_ENABLE:
 			if (!(cfg & PIN_CFG_OEN))
 				return -EINVAL;
-			if (!pctrl->data->oen_write)
-				return -EOPNOTSUPP;
-			ret = pctrl->data->oen_write(pctrl, _pin, !!arg);
+			ret = rzg2l_write_oen(pctrl, _pin, !!arg);
 			if (ret)
 				return ret;
 			break;
@@ -3293,8 +3288,6 @@ static struct rzg2l_pinctrl_data r9a07g043_data = {
 	.pwpr_pfc_lock_unlock = &rzg2l_pwpr_pfc_lock_unlock,
 	.pmc_writeb = &rzg2l_pmc_writeb,
 	.pin_to_oen_bit = &rzg2l_pin_to_oen_bit,
-	.oen_read = &rzg2l_read_oen,
-	.oen_write = &rzg2l_write_oen,
 	.hw_to_bias_param = &rzg2l_hw_to_bias_param,
 	.bias_param_to_hw = &rzg2l_bias_param_to_hw,
 };
@@ -3311,8 +3304,6 @@ static struct rzg2l_pinctrl_data r9a07g044_data = {
 	.pwpr_pfc_lock_unlock = &rzg2l_pwpr_pfc_lock_unlock,
 	.pmc_writeb = &rzg2l_pmc_writeb,
 	.pin_to_oen_bit = &rzg2l_pin_to_oen_bit,
-	.oen_read = &rzg2l_read_oen,
-	.oen_write = &rzg2l_write_oen,
 	.hw_to_bias_param = &rzg2l_hw_to_bias_param,
 	.bias_param_to_hw = &rzg2l_bias_param_to_hw,
 };
@@ -3328,8 +3319,6 @@ static struct rzg2l_pinctrl_data r9a08g045_data = {
 	.pwpr_pfc_lock_unlock = &rzg2l_pwpr_pfc_lock_unlock,
 	.pmc_writeb = &rzg2l_pmc_writeb,
 	.pin_to_oen_bit = &rzg3s_pin_to_oen_bit,
-	.oen_read = &rzg2l_read_oen,
-	.oen_write = &rzg2l_write_oen,
 	.hw_to_bias_param = &rzg2l_hw_to_bias_param,
 	.bias_param_to_hw = &rzg2l_bias_param_to_hw,
 };
@@ -3352,8 +3341,6 @@ static struct rzg2l_pinctrl_data r9a09g047_data = {
 	.pwpr_pfc_lock_unlock = &rzv2h_pwpr_pfc_lock_unlock,
 	.pmc_writeb = &rzv2h_pmc_writeb,
 	.pin_to_oen_bit = &rzg3e_pin_to_oen_bit,
-	.oen_read = &rzg2l_read_oen,
-	.oen_write = &rzg2l_write_oen,
 	.hw_to_bias_param = &rzv2h_hw_to_bias_param,
 	.bias_param_to_hw = &rzv2h_bias_param_to_hw,
 };
@@ -3376,8 +3363,6 @@ static struct rzg2l_pinctrl_data r9a09g056_data = {
 	.pwpr_pfc_lock_unlock = &rzv2h_pwpr_pfc_lock_unlock,
 	.pmc_writeb = &rzv2h_pmc_writeb,
 	.pin_to_oen_bit = &rzv2h_pin_to_oen_bit,
-	.oen_read = &rzg2l_read_oen,
-	.oen_write = &rzg2l_write_oen,
 	.hw_to_bias_param = &rzv2h_hw_to_bias_param,
 	.bias_param_to_hw = &rzv2h_bias_param_to_hw,
 };
@@ -3401,8 +3386,6 @@ static struct rzg2l_pinctrl_data r9a09g057_data = {
 	.pwpr_pfc_lock_unlock = &rzv2h_pwpr_pfc_lock_unlock,
 	.pmc_writeb = &rzv2h_pmc_writeb,
 	.pin_to_oen_bit = &rzv2h_pin_to_oen_bit,
-	.oen_read = &rzg2l_read_oen,
-	.oen_write = &rzg2l_write_oen,
 	.hw_to_bias_param = &rzv2h_hw_to_bias_param,
 	.bias_param_to_hw = &rzv2h_bias_param_to_hw,
 };
-- 
2.25.1


