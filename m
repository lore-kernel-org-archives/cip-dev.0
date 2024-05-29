Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06A5C25B7E
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:10:55 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.8632.1716970251095466801
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:10:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=q9I6KIta;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-421140314d5so14291055e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970249; x=1717575049; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZFnjVwRGScu41dlvZxly8tP4a85kgtzHL1tDwzU+lU=;
        b=q9I6KItaDewZA04C5zmfv8DdOxM+fEPvCmy1NpWwWs0r94FS9EsyEWUSZPxlW0e9TG
         Re9fSWAdX5qm95dbtEH0oNj7bzhfZEGbAfWy+iJ1OOeUfskE+QZZxnZxtd79WmQ3Df3Q
         /aSE/boIuD5SLteZm8FbY5PMi/aFGJDcfqTbT0FIF56JKBKw/rpT1Y/ytGViGtbs4Xjk
         QRUqpIt7+8b3KSL9F/UjYA4uM7CcgjBqUJHZYVfRobrzvBwQOxg5MfsN99lWHYEdMYWw
         4ZYWnb62DS0jJa/mn8kw4Ys1oMGth31fFSd99zEk3mB61nvRBZebQ6jgHMll1fHJ94VS
         sgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970249; x=1717575049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZFnjVwRGScu41dlvZxly8tP4a85kgtzHL1tDwzU+lU=;
        b=UfkFyekZZJsg23LZ9pshwVuInj10Z5by8i5G2hwLd/jctVtXU0hBVX6a6V6Yclt/y5
         21O+T0Qmy3WIPkudA8gq94PYnbORC7qPelKgvafIAdWQ4eS6WsoQHIGOedwYp3CAuOvt
         SmZp8ejdjmpdZEr5R31Uf7jtKwdzDPsQoJO1lMlcnla7hZQ8AYeH2uen15PTAxyiJIAq
         uAJ1ia9LfQ7n9l0HHMAiLT50Rg5+XFjNhNpx/52FER7uFjleGAQx/D59cyGnrKDxPDAW
         zfSp4/1bT30tjg3tFgtsErsC096B0w7bKpQFRLcg74nl1xLU+Xp7AiuibbTmS2doj277
         TIeA==
X-Gm-Message-State: AOJu0YxwknIff2wXkL05hlghLCz2jJjI04DbIoSw5EFmyCpBe9cOx/3a
	0/fwrXxy7JQSYBYuhtzRNvAPRtbQyFfRYhKUWZGyyPa1+CYOMpqENvzco1SlAyY=
X-Google-Smtp-Source: AGHT+IF76c0lC/ZWVVkTAkkZL4u5F83KmeUey8pGBBxqQ4+N6/Lcl3RlKLmpOi2GF0LHdz8e9yhG4Q==
X-Received: by 2002:a7b:c403:0:b0:420:e24b:dbc with SMTP id 5b1f17b1804b1-42108a0007cmr111802295e9.27.1716970249555;
        Wed, 29 May 2024 01:10:49 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:10:49 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 05/47] pinctrl: renesas: rzg2l: Add output enable support
Date: Wed, 29 May 2024 11:09:57 +0300
Message-Id: <20240529081039.639010-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:10:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15985

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 1bbc8ee40826164d16e32d377654c93ef48d1458 upstream.

Some of the Ethernet pins on RZ/G3S (but also valid for RZ/G2L) need to
have the direction of the IO buffer set as output for Ethernet to work
properly.  On RZ/G3S, these pins are P1_0/P7_0, P1_1/P7_1, and can have
the following Ethernet functions: TXC/TX_CLK or TX_CTL/TX_EN.

As the pins supporting output enable are SoC specific, and there is a
limited number of these pins (TXC/TX_CLK and/or TX_CTL/TX_EN), specify
output enable capable port limits in the platform-based configuration
data structure, to ensure proper validation.

The OEN support has been intantiated for RZ/G3S at the moment.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231207070700.4156557-7-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 87 ++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 4a649dc43946..6d0b10f77692 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -53,6 +53,7 @@
 #define PIN_CFG_FILCLKSEL		BIT(12)
 #define PIN_CFG_IOLH_C			BIT(13)
 #define PIN_CFG_SOFT_PS			BIT(14)
+#define PIN_CFG_OEN			BIT(15)
 
 #define RZG2L_MPXED_COMMON_PIN_FUNCS(group) \
 					(PIN_CFG_IOLH_##group | \
@@ -105,6 +106,7 @@
 #define SD_CH(off, ch)		((off) + (ch) * 4)
 #define ETH_POC(off, ch)	((off) + (ch) * 4)
 #define QSPI			(0x3008)
+#define ETH_MODE		(0x3018)
 
 #define PVDD_2500		2	/* I/O domain voltage 2.5V */
 #define PVDD_1800		1	/* I/O domain voltage <= 1.8V */
@@ -166,6 +168,8 @@ enum rzg2l_iolh_index {
  * @iolh_groupb_oi: IOLH group B output impedance specific values
  * @drive_strength_ua: drive strength in uA is supported (otherwise mA is supported)
  * @func_base: base number for port function (see register PFC)
+ * @oen_max_pin: the maximum pin number supporting output enable
+ * @oen_max_port: the maximum port number supporting output enable
  */
 struct rzg2l_hwcfg {
 	const struct rzg2l_register_offsets regs;
@@ -175,6 +179,8 @@ struct rzg2l_hwcfg {
 	u16 iolh_groupb_oi[4];
 	bool drive_strength_ua;
 	u8 func_base;
+	u8 oen_max_pin;
+	u8 oen_max_port;
 };
 
 struct rzg2l_dedicated_configs {
@@ -778,6 +784,66 @@ static bool rzg2l_ds_is_supported(struct rzg2l_pinctrl *pctrl, u32 caps,
 	return false;
 }
 
+static bool rzg2l_oen_is_supported(u32 caps, u8 pin, u8 max_pin)
+{
+	if (!(caps & PIN_CFG_OEN))
+		return false;
+
+	if (pin > max_pin)
+		return false;
+
+	return true;
+}
+
+static u8 rzg2l_pin_to_oen_bit(u32 offset, u8 pin, u8 max_port)
+{
+	if (pin)
+		pin *= 2;
+
+	if (offset / RZG2L_PINS_PER_PORT == max_port)
+		pin += 1;
+
+	return pin;
+}
+
+static u32 rzg2l_read_oen(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pin)
+{
+	u8 max_port = pctrl->data->hwcfg->oen_max_port;
+	u8 max_pin = pctrl->data->hwcfg->oen_max_pin;
+	u8 bit;
+
+	if (!rzg2l_oen_is_supported(caps, pin, max_pin))
+		return 0;
+
+	bit = rzg2l_pin_to_oen_bit(offset, pin, max_port);
+
+	return !(readb(pctrl->base + ETH_MODE) & BIT(bit));
+}
+
+static int rzg2l_write_oen(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pin, u8 oen)
+{
+	u8 max_port = pctrl->data->hwcfg->oen_max_port;
+	u8 max_pin = pctrl->data->hwcfg->oen_max_pin;
+	unsigned long flags;
+	u8 val, bit;
+
+	if (!rzg2l_oen_is_supported(caps, pin, max_pin))
+		return -EINVAL;
+
+	bit = rzg2l_pin_to_oen_bit(offset, pin, max_port);
+
+	spin_lock_irqsave(&pctrl->lock, flags);
+	val = readb(pctrl->base + ETH_MODE);
+	if (oen)
+		val &= ~BIT(bit);
+	else
+		val |= BIT(bit);
+	writeb(val, pctrl->base + ETH_MODE);
+	spin_unlock_irqrestore(&pctrl->lock, flags);
+
+	return 0;
+}
+
 static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 				     unsigned int _pin,
 				     unsigned long *config)
@@ -815,6 +881,12 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 			return -EINVAL;
 		break;
 
+	case PIN_CONFIG_OUTPUT_ENABLE:
+		arg = rzg2l_read_oen(pctrl, cfg, _pin, bit);
+		if (!arg)
+			return -EINVAL;
+		break;
+
 	case PIN_CONFIG_POWER_SOURCE:
 		ret = rzg2l_get_power_source(pctrl, _pin, cfg);
 		if (ret < 0)
@@ -916,6 +988,13 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			rzg2l_rmw_pin_config(pctrl, IEN(off), bit, IEN_MASK, !!arg);
 			break;
 
+		case PIN_CONFIG_OUTPUT_ENABLE:
+			arg = pinconf_to_config_argument(_configs[i]);
+			ret = rzg2l_write_oen(pctrl, cfg, _pin, bit, !!arg);
+			if (ret)
+				return ret;
+			break;
+
 		case PIN_CONFIG_POWER_SOURCE:
 			settings.power_source = pinconf_to_config_argument(_configs[i]);
 			break;
@@ -1360,7 +1439,8 @@ static const u32 r9a07g043_gpio_configs[] = {
 static const u32 r9a08g045_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(4, 0x20, RZG3S_MPXED_PIN_FUNCS(A)),			/* P0  */
 	RZG2L_GPIO_PORT_PACK(5, 0x30, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
-								PIN_CFG_IO_VMC_ETH0)),	/* P1 */
+								PIN_CFG_IO_VMC_ETH0)) |
+				      PIN_CFG_OEN,					/* P1 */
 	RZG2L_GPIO_PORT_PACK(4, 0x31, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
 								PIN_CFG_IO_VMC_ETH0)),	/* P2 */
 	RZG2L_GPIO_PORT_PACK(4, 0x32, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
@@ -1370,7 +1450,8 @@ static const u32 r9a08g045_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(5, 0x21, RZG3S_MPXED_PIN_FUNCS(A)),			/* P5  */
 	RZG2L_GPIO_PORT_PACK(5, 0x22, RZG3S_MPXED_PIN_FUNCS(A)),			/* P6  */
 	RZG2L_GPIO_PORT_PACK(5, 0x34, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
-								PIN_CFG_IO_VMC_ETH1)),	/* P7 */
+								PIN_CFG_IO_VMC_ETH1)) |
+				      PIN_CFG_OEN,					/* P7 */
 	RZG2L_GPIO_PORT_PACK(5, 0x35, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
 								PIN_CFG_IO_VMC_ETH1)),	/* P8 */
 	RZG2L_GPIO_PORT_PACK(4, 0x36, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
@@ -1953,6 +2034,8 @@ static const struct rzg2l_hwcfg rzg3s_hwcfg = {
 	},
 	.drive_strength_ua = true,
 	.func_base = 1,
+	.oen_max_pin = 1, /* Pin 1 of P0 and P7 is the maximum OEN pin. */
+	.oen_max_port = 7, /* P7_1 is the maximum OEN port. */
 };
 
 static struct rzg2l_pinctrl_data r9a07g043_data = {
-- 
2.39.2


