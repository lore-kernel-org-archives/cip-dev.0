Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF0AC44512
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:59:40 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.90783.1783076373576051759
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:59:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=kdTAZTyG;
 spf=pass (domain: gmail.com, ip: 209.85.221.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-474bf35cccdso137051f8f.1
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076372; x=1783681172; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGRboTJeOEpfcJ0LZw1bw8w1gVIwD6M0x6BMCJE7+0w=;
        b=kdTAZTyGS2PP8oDwXRaCQNCYjH9ICWCVvUyiWh30G1aaHeehhUgaSC+8Y+CaBgyQyA
         k834gP9LupMlfV4RAEzoXJog7NUy+mZKjTxHVVpZMUbnlM7ZY3E4HV5TDUkOU1WX1dQa
         cKkr/BJ19rr4IPSNgr7rIL6WeC7UWUzL5g35hd10M4vUXWG3s8TGOB5KP/N58N39MOzd
         Z3Y/Atib8YHnlxwll7KQqJd198YVBs4CaXNn4tsB5vixONCRnInPFmffsK/naP95aerh
         u+1knK+VSKXVNd/jNJ9dIf4M34ffq6ke8VwqefA0Q1VmkZ50IEFC01muCKLKBR3bIxsj
         XVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076372; x=1783681172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gGRboTJeOEpfcJ0LZw1bw8w1gVIwD6M0x6BMCJE7+0w=;
        b=Bw31d4kJigD3w1kAMsgIXITIZ+1n2aFLRFilLX9lm3QLDU4GzI2+00wbbIBolenbdr
         fcmf7EjL2XWhNvaLHEXLGLzGpy4P5Zt7bYfi87Hiz+gryfEpvDjAwy0+myrDpA8kdaRH
         Yz3bYm4dSUz2ZFmkh7j3ZHIZtY5WIffBO0awCZrFteOMZoBBs4eW17P2OxY6IHybFiyh
         46TDndw+Rbugt+Saoq06Ox6LObxUtWkD6yuUGX9CpUIOqnVsDejqGQK9o/rTEabB56OK
         +kZecyeW/6TR4FO3DNoo3NtRw4A8REihhkBoMJbUywx6LwIBABRUm6LvYYZrjgVE33dp
         FCBA==
X-Gm-Message-State: AOJu0YxYlho9T6p0RgviY+f1LW4hScVmQSjHBerOA8gqNVwQkDK/tOrH
	pcl4LLfrtOae/TQXok1Y0ldVFpwUnPe1POQxEdDW35XWJVYXP/hc4g6D5AITKvQW
X-Gm-Gg: AfdE7ck5d4GQtsxWWMQDiKggPbXtcIWtxraysAFc6rU+TWelQIZx/vgf711rtNlQL8C
	ZG1AFC/9O0nfIdHncFUxgWLydx/SzGgSseBm3EslyON0KFkoktv/QJODp3aBXb5garzuSM5CO8O
	VgYT0iIPXF7tdnhm1jrg8aKO86vSsF36b754mq2EsRZToC68J1nkuVT2DWvdgJWY4P1eUVat4HC
	VC/Ytl5eBiTXCQ5yK6GfuKvXX41Z6XKysFPQajMCsDYmrFbo6pDKbHhGDRtfmrBhyFTozSyO3UT
	OxxAAE79TPT97EgdesKzFC2WfAGgf0Fai3uM0Us95I9lNmf59hp28l5WKfwOWnUGrokdZWiads9
	spMmTM2L9KT8NSnSgE7mH+kVlgfnTtDxNdSm/MggYaR1qfp7kYp727vkUZRcs1AH3jNuin0TZkf
	xc7nnTVS/N34aJGCSGvA35
X-Received: by 2002:a05:6000:2482:b0:475:f0d1:eb6c with SMTP id ffacd0b85a97d-4775cf541a7mr15727122f8f.57.1783076371709;
        Fri, 03 Jul 2026 03:59:31 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47998d81e86sm4838521f8f.16.2026.07.03.03.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:59:31 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 15/23] pinctrl: renesas: rzg2l: Add support for clone channel control
Date: Fri,  3 Jul 2026 11:59:06 +0100
Message-ID: <20260703105923.251255-16-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:59:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23434

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit c590b377dcc0c382fb6d969483e551789a24540e ]

The RZ/G3L SoC has some IP such as I2C ch{2,3},SCIF ch{3,4,5},
RSPI ch{1,2} and RSCI ch{1,2,3} need to control the clone channel for
proper operation. As per the RZ/G3L hardware manual, the clone channel
setting is to be done before the mux setting.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260430093422.74812-8-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 181 ++++++++++++++++++++++++
 1 file changed, 181 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 780e4c86a7c2..c8528f6277cc 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -11,12 +11,14 @@
 #include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/regmap.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
 
@@ -152,6 +154,18 @@
 	 FIELD_PREP_CONST(VARIABLE_PIN_CFG_PORT_MASK, (port)) | \
 	 FIELD_PREP_CONST(PIN_CFG_MASK, (cfg)))
 
+#define RZG3L_CLONE_CHANNEL_PIN_MASK	GENMASK(31, 24)
+#define RZG3L_CLONE_CHANNEL_PORT_MASK	GENMASK(23, 19)
+#define RZG3L_CLONE_CHANNEL_BIT_MASK	GENMASK(12, 9)
+#define RZG3L_CLONE_CHANNEL_VAL_MASK	BIT(8)
+#define RZG3L_CLONE_CHANNEL_PFC_MASK	GENMASK(7, 0)
+#define RZG3L_CLONE_CHANNEL_DATA(port, pins, bit, val, pfc) \
+	(FIELD_PREP_CONST(RZG3L_CLONE_CHANNEL_PIN_MASK, (pins)) | \
+	 FIELD_PREP_CONST(RZG3L_CLONE_CHANNEL_PORT_MASK, (port)) | \
+	 FIELD_PREP_CONST(RZG3L_CLONE_CHANNEL_BIT_MASK, (bit)) | \
+	 FIELD_PREP_CONST(RZG3L_CLONE_CHANNEL_VAL_MASK, (val)) | \
+	 FIELD_PREP_CONST(RZG3L_CLONE_CHANNEL_PFC_MASK, (pfc)))
+
 #define P(off)			(0x0000 + (off))
 #define PM(off)			(0x0100 + (off) * 2)
 #define PMC(off)		(0x0200 + (off))
@@ -315,6 +329,8 @@ struct rzg2l_pinctrl_data {
 	const struct rzg2l_dedicated_configs *dedicated_pins;
 	unsigned int n_port_pins;
 	unsigned int n_dedicated_pins;
+	const u32 *clone_channel_data;
+	unsigned int n_clone_channel_data;
 	const struct rzg2l_hwcfg *hwcfg;
 	const u64 *variable_pin_cfg;
 	unsigned int n_variable_pin_cfg;
@@ -352,6 +368,7 @@ struct rzg2l_pinctrl_pin_settings {
  * @smt: SMT registers cache
  * @sr: SR registers cache
  * @nod: NOD registers cache
+ * @clone: Clone register cache
  * @sd_ch: SD_CH registers cache
  * @eth_poc: ET_POC registers cache
  * @other_poc: OTHER_POC register cache
@@ -369,6 +386,7 @@ struct rzg2l_pinctrl_reg_cache {
 	u32	*smt[2];
 	u32	*sr[2];
 	u32	*nod[2];
+	u32	clone;
 	u8	sd_ch[2];
 	u8	eth_poc[2];
 	u8	oen;
@@ -387,6 +405,8 @@ struct rzg2l_pinctrl {
 
 	struct clk			*clk;
 
+	struct regmap			*syscon;
+
 	struct gpio_chip		gpio_chip;
 	struct pinctrl_gpio_range	gpio_range;
 	DECLARE_BITMAP(tint_slot, RZG2L_TINT_MAX_INTERRUPT);
@@ -400,6 +420,7 @@ struct rzg2l_pinctrl {
 	struct rzg2l_pinctrl_reg_cache	*cache;
 	struct rzg2l_pinctrl_reg_cache	*dedicated_cache;
 	atomic_t			wakeup_path;
+	u32				clone_offset;
 };
 
 static const u16 available_ps[] = { 1800, 2500, 3300 };
@@ -625,6 +646,45 @@ static int rzg2l_validate_pin(struct rzg2l_pinctrl *pctrl,
 	return 0;
 }
 
+static int rzg2l_pinctrl_set_clone_mode(struct rzg2l_pinctrl *pctrl,
+					u8 port, u8 pin, u8 func)
+{
+	unsigned int i;
+
+	if (!pctrl->data->clone_channel_data)
+		return 0;
+
+	switch (func) {
+	case 2:
+	case 4 ... 7:
+		break;
+	default:
+		return 0;
+	}
+
+	for (i = 0; i < pctrl->data->n_clone_channel_data; i++) {
+		u32 pin_data = pctrl->data->clone_channel_data[i];
+		unsigned int pin_func_mask = FIELD_GET(RZG3L_CLONE_CHANNEL_PFC_MASK, pin_data);
+		unsigned int pin_mask = FIELD_GET(RZG3L_CLONE_CHANNEL_PIN_MASK, pin_data);
+		u32 bit, val;
+
+		if (!(pin_func_mask & BIT(func)) ||
+		    FIELD_GET(RZG3L_CLONE_CHANNEL_PORT_MASK, pin_data) != port)
+			continue;
+
+		if (!(pin_mask & BIT(pin)))
+			continue;
+
+		bit = FIELD_GET(RZG3L_CLONE_CHANNEL_BIT_MASK, pin_data);
+		val = FIELD_GET(RZG3L_CLONE_CHANNEL_VAL_MASK, pin_data);
+
+		return regmap_update_bits(pctrl->syscon, pctrl->clone_offset,
+					  BIT(bit), val << bit);
+	}
+
+	return 0;
+}
+
 static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 				       u8 pin, u8 off, u8 func)
 {
@@ -700,6 +760,10 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 		func = psel_val[i] - hwcfg->func_base;
 		dev_dbg(pctrl->dev, "port:%u pin: %u off:%x PSEL:%u\n", port, pin, off, func);
 
+		ret = rzg2l_pinctrl_set_clone_mode(pctrl, port, pin, func);
+		if (ret)
+			return ret;
+
 		rzg2l_pinctrl_set_pfc_mode(pctrl, pin, off, func);
 	}
 
@@ -2637,6 +2701,97 @@ static const struct rzg2l_dedicated_configs rzg3l_dedicated_pins[] = {
 	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD)) },
 };
 
+static const u32 r9a08g046_clone_channel_data[] = {
+	/* I2C ch2 Bit:0 Value:0 PFC:4 */
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PG, GENMASK(7, 6), 0, 0, BIT(4)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PH, GENMASK(3, 2), 0, 0, BIT(4)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PK, GENMASK(1, 0), 0, 0, BIT(4)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PA, GENMASK(5, 4) | GENMASK(1, 0), 0, 0, BIT(4)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PB, GENMASK(5, 4) | GENMASK(1, 0), 0, 0, BIT(4)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PC, GENMASK(1, 0), 0, 0, BIT(4)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PD, GENMASK(7, 6) | GENMASK(3, 2), 0, 0, BIT(4)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PE, GENMASK(7, 6) | GENMASK(3, 2), 0, 0, BIT(4)),
+	/* I2C ch2 Bit:0 Value:1 PFC:4 */
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P5, GENMASK(5, 4) | GENMASK(1, 0), 0, 1, BIT(4)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P6, GENMASK(6, 5) | GENMASK(2, 1), 0, 1, BIT(4)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P8, GENMASK(5, 4) | GENMASK(1, 0), 0, 1, BIT(4)),
+	/* I2C ch3 Bit:1 Value:0 PFC:4 */
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PF, GENMASK(1, 0), 1, 0, BIT(4)),
+	/* I2C ch3 Bit:1 Value:1 PFC:4 */
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P2, GENMASK(1, 0), 1, 1, BIT(4)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P5, BIT(6) | GENMASK(3, 2), 1, 1, BIT(4)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P6, GENMASK(4, 3) | BIT(0), 1, 1, BIT(4)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P7, GENMASK(7, 6), 1, 1, BIT(4)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P8, GENMASK(3, 2), 1, 1, BIT(4)),
+	/* SCIF ch3 Bit:4 Value:0 PFC:{6,7} */
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PG, GENMASK(6, 4), 4, 0, BIT(6)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PH, GENMASK(5, 3), 4, 0, BIT(7)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PA, GENMASK(4, 2), 4, 0, BIT(7)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PB, GENMASK(5, 3), 4, 0, BIT(7)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PD, GENMASK(2, 0), 4, 0, BIT(7)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PE, GENMASK(3, 1), 4, 0, BIT(7)),
+	/* SCIF ch3 Bit:4 Value:1 PFC:7 */
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P5, GENMASK(2, 0), 4, 1, BIT(7)),
+	/* SCIF ch4 Bit:5 Value:0 PFC:7 */
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PK, GENMASK(2, 0), 5, 0, BIT(7)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PA, GENMASK(7, 5), 5, 0, BIT(7)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PB, GENMASK(7, 6), 5, 0, BIT(7)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PC, BIT(0), 5, 0, BIT(7)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PD, GENMASK(5, 3), 5, 0, BIT(7)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PE, GENMASK(6, 4), 5, 0, BIT(7)),
+	/* SCIF ch4 Bit:5 Value:1 PFC:7 */
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P5, GENMASK(5, 3), 5, 1, BIT(7)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P6, GENMASK(4, 2), 5, 1, BIT(7)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P7, GENMASK(7, 5), 5, 1, BIT(7)),
+	/* SCIF ch5 Bit:6 Value:0 PFC:7 */
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PE, BIT(7), 6, 0, BIT(7)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PF, GENMASK(1, 0), 6, 0, BIT(7)),
+	/* SCIF ch5 Bit:6 Value:1 PFC:7 */
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P5, BIT(6), 6, 1, BIT(7)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P6, GENMASK(6, 5) | GENMASK(1, 0), 6, 1, BIT(7)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P7, GENMASK(4, 2) | BIT(0), 6, 1, BIT(7)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P8, GENMASK(2, 0), 6, 1, BIT(7)),
+	/* RSPI ch1 Bit:8 Value:0 PFC:2 */
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PH, GENMASK(5, 0), 8, 0, BIT(2)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PD, GENMASK(7, 5), 8, 0, BIT(2)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PE, GENMASK(3, 0), 8, 0, BIT(2)),
+	/* RSPI ch1 Bit:8 Value:1 PFC:2 */
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P5, GENMASK(6, 0), 8, 1, BIT(2)),
+	/* RSPI ch2 Bit:9 Value:0 PFC:2 */
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PE, GENMASK(7, 4), 9, 0, BIT(2)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PF, GENMASK(2, 0), 9, 0, BIT(2)),
+	/* RSPI ch2 Bit:9 Value:1 PFC:2 */
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P6, GENMASK(6, 0), 9, 1, BIT(2)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P7, BIT(7), 9, 1, BIT(2)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P8, GENMASK(5, 0), 9, 1, BIT(2)),
+	/* RSCI ch1 Bit:12 Value:0 PFC:{5,6} shared pins based on RSCI mode */
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PG, GENMASK(3, 0), 12, 0, GENMASK(6, 5)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PA, GENMASK(3, 0), 12, 0, GENMASK(6, 5)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PB, GENMASK(7, 6), 12, 0, GENMASK(6, 5)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PC, GENMASK(1, 0), 12, 0, GENMASK(6, 5)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PD, GENMASK(7, 4), 12, 0, GENMASK(6, 5)),
+	/* RSCI ch1 Bit:12 Value:1 PFC:{5,6} shared pins based on RSCI mode */
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P5, GENMASK(3, 0), 12, 1, GENMASK(6, 5)),
+	/* RSCI ch2 Bit:13 Value:0 PFC:{5,6} shared pins based on RSCI mode */
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PH, GENMASK(3, 0), 13, 0, GENMASK(6, 5)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PK, GENMASK(3, 0), 13, 0, GENMASK(6, 5)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PA, GENMASK(7, 4), 13, 0, GENMASK(6, 5)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PD, GENMASK(3, 0), 13, 0, GENMASK(6, 5)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PE, GENMASK(3, 0), 13, 0, GENMASK(6, 5)),
+	/* RSCI ch2 Bit:13 Value:1 PFC:{5,6} shared pins based on RSCI mode */
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P5, GENMASK(6, 4), 13, 1, GENMASK(6, 5)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P6, GENMASK(6, 5) | BIT(0), 13, 1, GENMASK(6, 5)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P7, GENMASK(7, 6) | GENMASK(1, 0), 13, 1, GENMASK(6, 5)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P8, GENMASK(1, 0), 13, 1, GENMASK(6, 5)),
+	/* RSCI ch3 Bit:14 Value:0 PFC:{5,6} shared pins based on RSCI mode */
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PE, GENMASK(7, 6), 14, 0, GENMASK(6, 5)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_PF, GENMASK(1, 0), 14, 0, GENMASK(6, 5)),
+	/* RSCI ch3 Bit:14 Value:1 PFC:{5,6} shared pins based on RSCI mode */
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P6, GENMASK(4, 1), 14, 1, GENMASK(6, 5)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P7, GENMASK(5, 2), 14, 1, GENMASK(6, 5)),
+	RZG3L_CLONE_CHANNEL_DATA(RZG3L_P8, GENMASK(5, 2), 14, 1, GENMASK(6, 5)),
+};
+
 static int rzg2l_gpio_get_gpioint(unsigned int virq, struct rzg2l_pinctrl *pctrl)
 {
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[virq];
@@ -3233,6 +3388,16 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 				     "failed to enable GPIO clk\n");
 	}
 
+	if (pctrl->data->clone_channel_data) {
+		struct device_node *np = pctrl->dev->of_node;
+
+		pctrl->syscon = syscon_regmap_lookup_by_phandle_args(np, "renesas,clonech",
+								     1, &pctrl->clone_offset);
+		if (IS_ERR(pctrl->syscon))
+			return dev_err_probe(pctrl->dev, PTR_ERR(pctrl->syscon),
+					     "Failed to parse renesas,clonech\n");
+	}
+
 	raw_spin_lock_init(&pctrl->lock);
 	spin_lock_init(&pctrl->bitmap_lock);
 	mutex_init(&pctrl->mutex);
@@ -3522,6 +3687,14 @@ static int rzg2l_pinctrl_suspend_noirq(struct device *dev)
 	if (regs->other_poc)
 		cache->other_poc = readb(pctrl->base + regs->other_poc);
 
+	if (pctrl->syscon) {
+		int ret;
+
+		ret = regmap_read(pctrl->syscon, pctrl->clone_offset, &cache->clone);
+		if (ret)
+			return ret;
+	}
+
 	if (!atomic_read(&pctrl->wakeup_path))
 		clk_disable_unprepare(pctrl->clk);
 	else
@@ -3539,6 +3712,12 @@ static int rzg2l_pinctrl_resume_noirq(struct device *dev)
 	unsigned long flags;
 	int ret;
 
+	if (pctrl->syscon) {
+		ret = regmap_write(pctrl->syscon, pctrl->clone_offset, cache->clone);
+		if (ret)
+			return ret;
+	}
+
 	if (!atomic_read(&pctrl->wakeup_path)) {
 		ret = clk_prepare_enable(pctrl->clk);
 		if (ret)
@@ -3753,6 +3932,8 @@ static struct rzg2l_pinctrl_data r9a08g046_data = {
 	.dedicated_pins = rzg3l_dedicated_pins,
 	.n_port_pins = ARRAY_SIZE(r9a08g046_gpio_configs) * RZG2L_PINS_PER_PORT,
 	.n_dedicated_pins = ARRAY_SIZE(rzg3l_dedicated_pins),
+	.clone_channel_data = r9a08g046_clone_channel_data,
+	.n_clone_channel_data = ARRAY_SIZE(r9a08g046_clone_channel_data),
 	.hwcfg = &rzg3l_hwcfg,
 	.pwpr_pfc_lock_unlock = &rzg2l_pwpr_pfc_lock_unlock,
 	.pmc_writeb = &rzg2l_pmc_writeb,
-- 
2.43.0


