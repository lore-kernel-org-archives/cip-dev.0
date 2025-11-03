Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A77CCF9F8
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 11:36:30 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18623.1762169774650115223
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Nov 2025 03:36:21 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: john.madieu.xa@bp.renesas.com)
X-CSE-ConnectionGUID: 9su2EfVHRjy9ZAFJiQdvlA==
X-CSE-MsgGUID: CpzqWB1ZQ9Cw+2JQLJhNNg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Nov 2025 20:36:20 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.166])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BBCF84009BCE;
	Mon,  3 Nov 2025 20:36:19 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Subject: [PATCH 6.1.y-cip 06/25] pinctrl: renesas: rzg2l: Parameterize OEN register offset
Date: Mon,  3 Nov 2025 12:35:39 +0100
Message-ID: <20251103113608.36240-7-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
References: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Nov 2025 11:36:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20298

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit 27c76cc93c6c2ee6c0d7fec6dedc1214a977e66f ]

Prepare for supporting SoCs with varying OEN register locations by
parameterizing the OEN offset in the rzg2l driver. Introduce an `oen`
field in the rzg2l_register_offsets structure and update rzg2l_read_oen(),
rzg2l_write_oen(), suspend/resume caching, and SoC hwcfg entries to use
this offset instead of the hard-coded ETH_MODE value.

As part of this change, rename the field `eth_mode` in the register cache
to `oen` to better reflect its general purpose and decouple the naming
from a specific register.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250806195555.1372317-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 29 +++++++++++++++----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 9b157eab986b..cc8a2cccf16f 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -145,7 +145,6 @@
 #define SD_CH(off, ch)		((off) + (ch) * 4)
 #define ETH_POC(off, ch)	((off) + (ch) * 4)
 #define QSPI			(0x3008)
-#define ETH_MODE		(0x3018)
 #define PFC_OEN			(0x3C40) /* known on RZ/V2H(P) only */
 
 #define PVDD_2500		2	/* I/O domain voltage 2.5V */
@@ -220,11 +219,13 @@ static const struct pin_config_item renesas_rzv2h_conf_items[] = {
  * @pwpr: PWPR register offset
  * @sd_ch: SD_CH register offset
  * @eth_poc: ETH_POC register offset
+ * @oen: OEN register offset
  */
 struct rzg2l_register_offsets {
 	u16 pwpr;
 	u16 sd_ch;
 	u16 eth_poc;
+	u16 oen;
 };
 
 /**
@@ -320,7 +321,7 @@ struct rzg2l_pinctrl_pin_settings {
  * @ien: IEN registers cache
  * @sd_ch: SD_CH registers cache
  * @eth_poc: ET_POC registers cache
- * @eth_mode: ETH_MODE register cache
+ * @oen: Output Enable register cache
  * @qspi: QSPI registers cache
  */
 struct rzg2l_pinctrl_reg_cache {
@@ -332,7 +333,7 @@ struct rzg2l_pinctrl_reg_cache {
 	u32	*ien[2];
 	u8	sd_ch[2];
 	u8	eth_poc[2];
-	u8	eth_mode;
+	u8	oen;
 	u8	qspi;
 };
 
@@ -1066,11 +1067,12 @@ static u32 rzg2l_read_oen(struct rzg2l_pinctrl *pctrl, unsigned int _pin)
 	if (bit < 0)
 		return 0;
 
-	return !(readb(pctrl->base + ETH_MODE) & BIT(bit));
+	return !(readb(pctrl->base + pctrl->data->hwcfg->regs.oen) & BIT(bit));
 }
 
 static int rzg2l_write_oen(struct rzg2l_pinctrl *pctrl, unsigned int _pin, u8 oen)
 {
+	u16 oen_offset = pctrl->data->hwcfg->regs.oen;
 	unsigned long flags;
 	int bit;
 	u8 val;
@@ -1080,12 +1082,12 @@ static int rzg2l_write_oen(struct rzg2l_pinctrl *pctrl, unsigned int _pin, u8 oe
 		return bit;
 
 	spin_lock_irqsave(&pctrl->lock, flags);
-	val = readb(pctrl->base + ETH_MODE);
+	val = readb(pctrl->base + oen_offset);
 	if (oen)
 		val &= ~BIT(bit);
 	else
 		val |= BIT(bit);
-	writeb(val, pctrl->base + ETH_MODE);
+	writeb(val, pctrl->base + oen_offset);
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
@@ -1119,11 +1121,12 @@ static u32 rzg3s_oen_read(struct rzg2l_pinctrl *pctrl, unsigned int _pin)
 	if (bit < 0)
 		return 0;
 
-	return !(readb(pctrl->base + ETH_MODE) & BIT(bit));
+	return !(readb(pctrl->base + pctrl->data->hwcfg->regs.oen) & BIT(bit));
 }
 
 static int rzg3s_oen_write(struct rzg2l_pinctrl *pctrl, unsigned int _pin, u8 oen)
 {
+	u16 oen_offset = pctrl->data->hwcfg->regs.oen;
 	unsigned long flags;
 	int bit;
 	u8 val;
@@ -1133,12 +1136,12 @@ static int rzg3s_oen_write(struct rzg2l_pinctrl *pctrl, unsigned int _pin, u8 oe
 		return bit;
 
 	spin_lock_irqsave(&pctrl->lock, flags);
-	val = readb(pctrl->base + ETH_MODE);
+	val = readb(pctrl->base + oen_offset);
 	if (oen)
 		val &= ~BIT(bit);
 	else
 		val |= BIT(bit);
-	writeb(val, pctrl->base + ETH_MODE);
+	writeb(val, pctrl->base + oen_offset);
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
@@ -3140,7 +3143,8 @@ static int rzg2l_pinctrl_suspend_noirq(struct device *dev)
 	}
 
 	cache->qspi = readb(pctrl->base + QSPI);
-	cache->eth_mode = readb(pctrl->base + ETH_MODE);
+	if (pctrl->data->hwcfg->regs.oen)
+		cache->oen = readb(pctrl->base + pctrl->data->hwcfg->regs.oen);
 
 	if (!atomic_read(&pctrl->wakeup_path))
 		clk_disable_unprepare(pctrl->clk);
@@ -3165,7 +3169,8 @@ static int rzg2l_pinctrl_resume_noirq(struct device *dev)
 	}
 
 	writeb(cache->qspi, pctrl->base + QSPI);
-	writeb(cache->eth_mode, pctrl->base + ETH_MODE);
+	if (pctrl->data->hwcfg->regs.oen)
+		writeb(cache->oen, pctrl->base + pctrl->data->hwcfg->regs.oen);
 	for (u8 i = 0; i < 2; i++) {
 		if (regs->sd_ch)
 			writeb(cache->sd_ch[i], pctrl->base + SD_CH(regs->sd_ch, i));
@@ -3217,6 +3222,7 @@ static const struct rzg2l_hwcfg rzg2l_hwcfg = {
 		.pwpr = 0x3014,
 		.sd_ch = 0x3000,
 		.eth_poc = 0x300c,
+		.oen = 0x3018,
 	},
 	.iolh_groupa_ua = {
 		/* 3v3 power source */
@@ -3232,6 +3238,7 @@ static const struct rzg2l_hwcfg rzg3s_hwcfg = {
 		.pwpr = 0x3000,
 		.sd_ch = 0x3004,
 		.eth_poc = 0x3010,
+		.oen = 0x3018,
 	},
 	.iolh_groupa_ua = {
 		/* 1v8 power source */
-- 
2.25.1


