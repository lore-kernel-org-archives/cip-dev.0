Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F39C433F5
	for <webhook@archiver.kernel.org>; Mon, 31 Jan 2022 12:19:15 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.31121.1643631553460782281
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Jan 2022 04:19:13 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,330,1635174000";
   d="scan'208";a="108231893"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 31 Jan 2022 21:19:12 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A47B94347FE1;
	Mon, 31 Jan 2022 21:19:11 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 05/27] pinctrl: renesas: rzg2l: Add helper
 functions to read/write pin config
Date: Mon, 31 Jan 2022 12:18:41 +0000
Message-Id: <20220131121903.8620-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Jan 2022 12:19:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7526

commit d1189991c823b50990291c8157b56fb141c47155 upstream.

Add helper functions to read/read modify write pin config.

Switch to use helper functions for pins supporting PIN_CONFIG_INPUT_ENABLE
capabilities.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20211110224622.16022-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 61 +++++++++++++++----------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index be9af717a497..4465402367f9 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -424,6 +424,39 @@ static int rzg2l_dt_node_to_map(struct pinctrl_dev *pctldev,
 	return ret;
 }
 
+static u32 rzg2l_read_pin_config(struct rzg2l_pinctrl *pctrl, u32 offset,
+				 u8 bit, u32 mask)
+{
+	void __iomem *addr = pctrl->base + offset;
+
+	/* handle _L/_H for 32-bit register read/write */
+	if (bit >= 4) {
+		bit -= 4;
+		addr += 4;
+	}
+
+	return (readl(addr) >> (bit * 8)) & mask;
+}
+
+static void rzg2l_rmw_pin_config(struct rzg2l_pinctrl *pctrl, u32 offset,
+				 u8 bit, u32 mask, u32 val)
+{
+	void __iomem *addr = pctrl->base + offset;
+	unsigned long flags;
+	u32 reg;
+
+	/* handle _L/_H for 32-bit register read/write */
+	if (bit >= 4) {
+		bit -= 4;
+		addr += 4;
+	}
+
+	spin_lock_irqsave(&pctrl->lock, flags);
+	reg = readl(addr) & ~(mask << (bit * 8));
+	writel(reg | (val << (bit * 8)), addr);
+	spin_unlock_irqrestore(&pctrl->lock, flags);
+}
+
 static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 				     unsigned int _pin,
 				     unsigned long *config)
@@ -432,8 +465,8 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 	enum pin_config_param param = pinconf_to_config_param(*config);
 	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[_pin];
 	unsigned int *pin_data = pin->drv_data;
-	u32 port_offset = 0, reg;
 	unsigned int arg = 0;
+	u32 port_offset = 0;
 	unsigned long flags;
 	void __iomem *addr;
 	u32 cfg = 0;
@@ -452,17 +485,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 	case PIN_CONFIG_INPUT_ENABLE:
 		if (!(cfg & PIN_CFG_IEN))
 			return -EINVAL;
-		spin_lock_irqsave(&pctrl->lock, flags);
-		/* handle _L/_H for 32-bit register read/write */
-		addr = pctrl->base + IEN(port_offset);
-		if (bit >= 4) {
-			bit -= 4;
-			addr += 4;
-		}
-
-		reg = readl(addr) & (IEN_MASK << (bit * 8));
-		arg = (reg >> (bit * 8)) & 0x1;
-		spin_unlock_irqrestore(&pctrl->lock, flags);
+		arg = rzg2l_read_pin_config(pctrl, IEN(port_offset), bit, IEN_MASK);
 		break;
 
 	case PIN_CONFIG_POWER_SOURCE: {
@@ -502,7 +525,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[_pin];
 	unsigned int *pin_data = pin->drv_data;
 	enum pin_config_param param;
-	u32 port_offset = 0, reg;
+	u32 port_offset = 0;
 	unsigned long flags;
 	void __iomem *addr;
 	unsigned int i;
@@ -528,17 +551,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			if (!(cfg & PIN_CFG_IEN))
 				return -EINVAL;
 
-			/* handle _L/_H for 32-bit register read/write */
-			addr = pctrl->base + IEN(port_offset);
-			if (bit >= 4) {
-				bit -= 4;
-				addr += 4;
-			}
-
-			spin_lock_irqsave(&pctrl->lock, flags);
-			reg = readl(addr) & ~(IEN_MASK << (bit * 8));
-			writel(reg | (arg << (bit * 8)), addr);
-			spin_unlock_irqrestore(&pctrl->lock, flags);
+			rzg2l_rmw_pin_config(pctrl, IEN(port_offset), bit, IEN_MASK, !!arg);
 			break;
 		}
 
-- 
2.17.1


