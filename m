Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F15C43219
	for <webhook@archiver.kernel.org>; Mon, 31 Jan 2022 12:19:12 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.31205.1643631550808452343
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Jan 2022 04:19:11 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,330,1635174000";
   d="scan'208";a="108906284"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 31 Jan 2022 21:19:11 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4E4984347FCA;
	Mon, 31 Jan 2022 21:19:10 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 04/27] pinctrl: renesas: rzg2l: Rename
 RZG2L_SINGLE_PIN_GET_PORT macro
Date: Mon, 31 Jan 2022 12:18:40 +0000
Message-Id: <20220131121903.8620-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Jan 2022 12:19:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7525

commit c76629a63b9c7cc52bb661aa36081c0c87780c3b upstream.

Rename RZG2L_SINGLE_PIN_GET_PORT -> RZG2L_SINGLE_PIN_GET_PORT_OFFSET.

Also, rename port -> port_offset in rzg2l_pinctrl_pinconf_set/get for
readability.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20211110224622.16022-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 20b2af889ca9..be9af717a497 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -77,7 +77,7 @@
 #define RZG2L_SINGLE_PIN		BIT(31)
 #define RZG2L_SINGLE_PIN_PACK(p, b, f)	(RZG2L_SINGLE_PIN | \
 					 ((p) << 24) | ((b) << 20) | (f))
-#define RZG2L_SINGLE_PIN_GET_PORT(x)	(((x) & GENMASK(30, 24)) >> 24)
+#define RZG2L_SINGLE_PIN_GET_PORT_OFFSET(x)	(((x) & GENMASK(30, 24)) >> 24)
 #define RZG2L_SINGLE_PIN_GET_BIT(x)	(((x) & GENMASK(22, 20)) >> 20)
 #define RZG2L_SINGLE_PIN_GET_CFGS(x)	((x) & GENMASK(19, 0))
 
@@ -432,10 +432,10 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 	enum pin_config_param param = pinconf_to_config_param(*config);
 	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[_pin];
 	unsigned int *pin_data = pin->drv_data;
+	u32 port_offset = 0, reg;
 	unsigned int arg = 0;
 	unsigned long flags;
 	void __iomem *addr;
-	u32 port = 0, reg;
 	u32 cfg = 0;
 	u8 bit = 0;
 
@@ -443,7 +443,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 		return -EINVAL;
 
 	if (*pin_data & RZG2L_SINGLE_PIN) {
-		port = RZG2L_SINGLE_PIN_GET_PORT(*pin_data);
+		port_offset = RZG2L_SINGLE_PIN_GET_PORT_OFFSET(*pin_data);
 		cfg = RZG2L_SINGLE_PIN_GET_CFGS(*pin_data);
 		bit = RZG2L_SINGLE_PIN_GET_BIT(*pin_data);
 	}
@@ -454,7 +454,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 			return -EINVAL;
 		spin_lock_irqsave(&pctrl->lock, flags);
 		/* handle _L/_H for 32-bit register read/write */
-		addr = pctrl->base + IEN(port);
+		addr = pctrl->base + IEN(port_offset);
 		if (bit >= 4) {
 			bit -= 4;
 			addr += 4;
@@ -502,9 +502,9 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[_pin];
 	unsigned int *pin_data = pin->drv_data;
 	enum pin_config_param param;
+	u32 port_offset = 0, reg;
 	unsigned long flags;
 	void __iomem *addr;
-	u32 port = 0, reg;
 	unsigned int i;
 	u32 cfg = 0;
 	u8 bit = 0;
@@ -513,7 +513,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 		return -EINVAL;
 
 	if (*pin_data & RZG2L_SINGLE_PIN) {
-		port = RZG2L_SINGLE_PIN_GET_PORT(*pin_data);
+		port_offset = RZG2L_SINGLE_PIN_GET_PORT_OFFSET(*pin_data);
 		cfg = RZG2L_SINGLE_PIN_GET_CFGS(*pin_data);
 		bit = RZG2L_SINGLE_PIN_GET_BIT(*pin_data);
 	}
@@ -529,7 +529,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 				return -EINVAL;
 
 			/* handle _L/_H for 32-bit register read/write */
-			addr = pctrl->base + IEN(port);
+			addr = pctrl->base + IEN(port_offset);
 			if (bit >= 4) {
 				bit -= 4;
 				addr += 4;
-- 
2.17.1


