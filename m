Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F8DC27C53
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:14:57 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.8670.1716970487925023718
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:14:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Ne1jG+JP;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4210c9d1df6so15290675e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970486; x=1717575286; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6Lv4Yj/Fr9dJ3XpL8LW1wvZIcZVh6+d7KnyUjftLjk=;
        b=Ne1jG+JPJq8idWG0WJNsJHha1RfpUnb1cXqtEAqaKjWtsDISZUKu8nf6dqM07A7yIa
         N7/cgjDjkGpeSgQVE7o7Ezs9MPiPQC9DtII3FyKKHIKtRq85SWxtZEW0OcWfzARSCSQQ
         dHYbn0Lj/Z17o22xGeDt2fPTKSOtkUXmI+4EGI6rKlPj092EIybiyKDJuatsE7CmLfjH
         mKnc/tWis6N0LFn2rVdXbXc28Qh8YJOxayZiUUG2ZpoJgEf8emfrngKut1S1s+zgdQtQ
         wb3Sa50pfP4HlO14lKfZVG8VBC2sep9uzyCv8+lGsUk8pX18nDqrjJyOhwtucAjpLVRt
         zwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970486; x=1717575286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6Lv4Yj/Fr9dJ3XpL8LW1wvZIcZVh6+d7KnyUjftLjk=;
        b=ML419ALdJWhDZn6/L4I8U17yUoFRjySAgpiIcEbu/GwtOdDdJ49rpnaXQQCQvmn4Q+
         JBFGpGV3ePaF7UkLN/xZCtMcxMl6bixzqTggbHLXBggZqBEgw4poVBUyZ75ygoJVOXCm
         OBv9AmFF65vW11nqtDL/XFHuhZWlF9j6FfuNv0VoaX7TAovrDoYUtNq8LRqnAEuayHQb
         Y+OEjnCE4iyn1faQrNhhWDXPpkHr8r5HqkxEe2PXjGCzDSaqSjWYmn6TdmGgjCSIszyL
         zLt2mM+0M4JMSmOtm82uK4oosZ2XzhELGxF6AS1D3p8kFhNEOlI/3M/b16+ZSU5epZJT
         jrRQ==
X-Gm-Message-State: AOJu0YyfqrhpcYZM7dQ9LOZ0MtiuCEqGoeR7kMjTN/EjGqc4HQYjOwqq
	fMW9vIBuxEui6AttLXyw3AfxSHk5DilZEpAEQh8Oweia7Eum3IT9K1sP4OX/1DA=
X-Google-Smtp-Source: AGHT+IHcOh28XyX83cn/bRf6jCUMJKK+dJavewFAxn44fcH4IyZV4SYbt8KPEhOc2zlrSI01Glxaxw==
X-Received: by 2002:a05:600c:3502:b0:41e:ae29:c807 with SMTP id 5b1f17b1804b1-42108a02fc5mr111804275e9.29.1716970486400;
        Wed, 29 May 2024 01:14:46 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:14:46 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 05/33] pinctrl: renesas: rzg2l: Add output enable support
Date: Wed, 29 May 2024 11:14:06 +0300
Message-Id: <20240529081434.639519-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:14:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16033

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
index 38d319cebaf6..188284e70636 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -56,6 +56,7 @@
 #define PIN_CFG_FILCLKSEL		BIT(12)
 #define PIN_CFG_IOLH_C			BIT(13)
 #define PIN_CFG_SOFT_PS			BIT(14)
+#define PIN_CFG_OEN			BIT(15)
 
 #define RZG2L_MPXED_COMMON_PIN_FUNCS(group) \
 					(PIN_CFG_IOLH_##group | \
@@ -108,6 +109,7 @@
 #define SD_CH(off, ch)		((off) + (ch) * 4)
 #define ETH_POC(off, ch)	((off) + (ch) * 4)
 #define QSPI			(0x3008)
+#define ETH_MODE		(0x3018)
 
 #define PVDD_2500		2	/* I/O domain voltage 2.5V */
 #define PVDD_1800		1	/* I/O domain voltage <= 1.8V */
@@ -169,6 +171,8 @@ enum rzg2l_iolh_index {
  * @iolh_groupb_oi: IOLH group B output impedance specific values
  * @drive_strength_ua: drive strength in uA is supported (otherwise mA is supported)
  * @func_base: base number for port function (see register PFC)
+ * @oen_max_pin: the maximum pin number supporting output enable
+ * @oen_max_port: the maximum port number supporting output enable
  */
 struct rzg2l_hwcfg {
 	const struct rzg2l_register_offsets regs;
@@ -178,6 +182,8 @@ struct rzg2l_hwcfg {
 	u16 iolh_groupb_oi[4];
 	bool drive_strength_ua;
 	u8 func_base;
+	u8 oen_max_pin;
+	u8 oen_max_port;
 };
 
 struct rzg2l_dedicated_configs {
@@ -781,6 +787,66 @@ static bool rzg2l_ds_is_supported(struct rzg2l_pinctrl *pctrl, u32 caps,
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
@@ -818,6 +884,12 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
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
@@ -919,6 +991,13 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
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
@@ -1363,7 +1442,8 @@ static const u32 r9a07g043_gpio_configs[] = {
 static const u32 r9a08g045_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(4, 0x20, RZG3S_MPXED_PIN_FUNCS(A)),			/* P0  */
 	RZG2L_GPIO_PORT_PACK(5, 0x30, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
-								PIN_CFG_IO_VMC_ETH0)),	/* P1 */
+								PIN_CFG_IO_VMC_ETH0)) |
+				      PIN_CFG_OEN,					/* P1 */
 	RZG2L_GPIO_PORT_PACK(4, 0x31, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
 								PIN_CFG_IO_VMC_ETH0)),	/* P2 */
 	RZG2L_GPIO_PORT_PACK(4, 0x32, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
@@ -1373,7 +1453,8 @@ static const u32 r9a08g045_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(5, 0x21, RZG3S_MPXED_PIN_FUNCS(A)),			/* P5  */
 	RZG2L_GPIO_PORT_PACK(5, 0x22, RZG3S_MPXED_PIN_FUNCS(A)),			/* P6  */
 	RZG2L_GPIO_PORT_PACK(5, 0x34, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
-								PIN_CFG_IO_VMC_ETH1)),	/* P7 */
+								PIN_CFG_IO_VMC_ETH1)) |
+				      PIN_CFG_OEN,					/* P7 */
 	RZG2L_GPIO_PORT_PACK(5, 0x35, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
 								PIN_CFG_IO_VMC_ETH1)),	/* P8 */
 	RZG2L_GPIO_PORT_PACK(4, 0x36, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
@@ -1955,6 +2036,8 @@ static const struct rzg2l_hwcfg rzg3s_hwcfg = {
 	},
 	.drive_strength_ua = true,
 	.func_base = 1,
+	.oen_max_pin = 1, /* Pin 1 of P0 and P7 is the maximum OEN pin. */
+	.oen_max_port = 7, /* P7_1 is the maximum OEN port. */
 };
 
 static struct rzg2l_pinctrl_data r9a07g043_data = {
-- 
2.39.2


