Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84E4C433EF
	for <webhook@archiver.kernel.org>; Mon, 31 Jan 2022 12:19:14 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.31121.1643631553460782281
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Jan 2022 04:19:14 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,330,1635174000";
   d="scan'208";a="108231896"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 31 Jan 2022 21:19:13 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id ED2FF4347FEA;
	Mon, 31 Jan 2022 21:19:12 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 06/27] pinctrl: renesas: rzg2l: Add support to
 get/set pin config for GPIO port pins
Date: Mon, 31 Jan 2022 12:18:42 +0000
Message-Id: <20220131121903.8620-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Jan 2022 12:19:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7527

commit 7f13a4297be04a1d5e6f025a44531d3c85c02524 upstream.

Add support to get/set pin config for GPIO port pins.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20211110224622.16022-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 36 +++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 4465402367f9..a5c4bfb59692 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -106,6 +106,7 @@
 #define PM_OUTPUT		0x2
 
 #define RZG2L_PIN_ID_TO_PORT(id)	((id) / RZG2L_PINS_PER_PORT)
+#define RZG2L_PIN_ID_TO_PORT_OFFSET(id)	(RZG2L_PIN_ID_TO_PORT(id) + 0x10)
 #define RZG2L_PIN_ID_TO_PIN(id)		((id) % RZG2L_PINS_PER_PORT)
 
 struct rzg2l_dedicated_configs {
@@ -424,6 +425,23 @@ static int rzg2l_dt_node_to_map(struct pinctrl_dev *pctldev,
 	return ret;
 }
 
+static int rzg2l_validate_gpio_pin(struct rzg2l_pinctrl *pctrl,
+				   u32 cfg, u32 port, u8 bit)
+{
+	u8 pincount = RZG2L_GPIO_PORT_GET_PINCNT(cfg);
+	u32 port_index = RZG2L_GPIO_PORT_GET_INDEX(cfg);
+	u32 data;
+
+	if (bit >= pincount || port >= pctrl->data->n_port_pins)
+		return -EINVAL;
+
+	data = pctrl->data->port_pin_configs[port];
+	if (port_index != RZG2L_GPIO_PORT_GET_INDEX(data))
+		return -EINVAL;
+
+	return 0;
+}
+
 static u32 rzg2l_read_pin_config(struct rzg2l_pinctrl *pctrl, u32 offset,
 				 u8 bit, u32 mask)
 {
@@ -466,9 +484,9 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[_pin];
 	unsigned int *pin_data = pin->drv_data;
 	unsigned int arg = 0;
-	u32 port_offset = 0;
 	unsigned long flags;
 	void __iomem *addr;
+	u32 port_offset;
 	u32 cfg = 0;
 	u8 bit = 0;
 
@@ -479,6 +497,13 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 		port_offset = RZG2L_SINGLE_PIN_GET_PORT_OFFSET(*pin_data);
 		cfg = RZG2L_SINGLE_PIN_GET_CFGS(*pin_data);
 		bit = RZG2L_SINGLE_PIN_GET_BIT(*pin_data);
+	} else {
+		cfg = RZG2L_GPIO_PORT_GET_CFGS(*pin_data);
+		port_offset = RZG2L_PIN_ID_TO_PORT_OFFSET(_pin);
+		bit = RZG2L_PIN_ID_TO_PIN(_pin);
+
+		if (rzg2l_validate_gpio_pin(pctrl, *pin_data, RZG2L_PIN_ID_TO_PORT(_pin), bit))
+			return -EINVAL;
 	}
 
 	switch (param) {
@@ -525,9 +550,9 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[_pin];
 	unsigned int *pin_data = pin->drv_data;
 	enum pin_config_param param;
-	u32 port_offset = 0;
 	unsigned long flags;
 	void __iomem *addr;
+	u32 port_offset;
 	unsigned int i;
 	u32 cfg = 0;
 	u8 bit = 0;
@@ -539,6 +564,13 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 		port_offset = RZG2L_SINGLE_PIN_GET_PORT_OFFSET(*pin_data);
 		cfg = RZG2L_SINGLE_PIN_GET_CFGS(*pin_data);
 		bit = RZG2L_SINGLE_PIN_GET_BIT(*pin_data);
+	} else {
+		cfg = RZG2L_GPIO_PORT_GET_CFGS(*pin_data);
+		port_offset = RZG2L_PIN_ID_TO_PORT_OFFSET(_pin);
+		bit = RZG2L_PIN_ID_TO_PIN(_pin);
+
+		if (rzg2l_validate_gpio_pin(pctrl, *pin_data, RZG2L_PIN_ID_TO_PORT(_pin), bit))
+			return -EINVAL;
 	}
 
 	for (i = 0; i < num_configs; i++) {
-- 
2.17.1


