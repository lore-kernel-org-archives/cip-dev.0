Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF31F506F4
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 14:59:35 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52440.1773673159009042004
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 07:59:34 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: ER0JBqTSRyK8SoYFnOzOXA==
X-CSE-MsgGUID: A5f6JrjDREiuc4xenToXFg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Mar 2026 23:59:33 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.53])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5F1C941B7814;
	Mon, 16 Mar 2026 23:59:32 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 09/35] phy: renesas: rcar-gen3-usb2: Add support for RZ/T2H SoC
Date: Mon, 16 Mar 2026 14:58:46 +0000
Message-ID: <20260316145915.8580-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 14:59:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22401

commit b725741f1c21e8507a58ae86c5a80ca383f96852 upstream.

Add initial support for the Renesas RZ/T2H SoC to the R-Car Gen3 USB2 PHY
driver. The RZ/T2H SoC requires configuration of additional
hardware-specific bits for proper VBUS level control and OTG operation.

Introduce the `vblvl_ctrl` flag in the SoC-specific driver data to enable
handling of VBUS level selection logic using `VBCTRL.VBLVL` bits. This is
required for managing the VBUS status detection and drive logic based on
SoC-specific needs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20250808215209.3692744-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 82 ++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index eca118e597e6..d039eca7d888 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -9,6 +9,8 @@
  * Copyright (C) 2014 Cogent Embedded, Inc.
  */
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/extcon-provider.h>
 #include <linux/interrupt.h>
@@ -69,13 +71,20 @@
 #define USB2_COMMCTRL_OTG_PERI		BIT(31)	/* 1 = Peripheral mode */
 
 /* OBINTSTA and OBINTEN */
+#define USB2_OBINTSTA_CLEAR		GENMASK(31, 0)
 #define USB2_OBINT_SESSVLDCHG		BIT(12)
 #define USB2_OBINT_IDDIGCHG		BIT(11)
+#define USB2_OBINT_VBSTAINT		BIT(3)
 #define USB2_OBINT_IDCHG_EN		BIT(0) /*  RZ/G2L specific */
 
 /* VBCTRL */
+#define USB2_VBCTRL_VBSTA_MASK		GENMASK(31, 28)
+#define USB2_VBCTRL_VBSTA_DEFAULT	2
+#define USB2_VBCTRL_VBLVL_MASK		GENMASK(23, 20)
+#define USB2_VBCTRL_VBLVL(m)		FIELD_PREP_CONST(USB2_VBCTRL_VBLVL_MASK, (m))
 #define USB2_VBCTRL_OCCLREN		BIT(16)
 #define USB2_VBCTRL_DRVVBUSSEL		BIT(8)
+#define USB2_VBCTRL_SIDDQREL		BIT(2)
 #define USB2_VBCTRL_VBOUT		BIT(0)
 
 /* LINECTRL1 */
@@ -88,6 +97,7 @@
 /* ADPCTRL */
 #define USB2_ADPCTRL_OTGSESSVLD		BIT(20)
 #define USB2_ADPCTRL_IDDIG		BIT(19)
+#define USB2_ADPCTRL_VBUSVALID		BIT(18)
 #define USB2_ADPCTRL_IDPULLUP		BIT(5)	/* 1 = ID sampling is enabled */
 #define USB2_ADPCTRL_DRVVBUS		BIT(4)
 
@@ -137,6 +147,7 @@ struct rcar_gen3_phy_drv_data {
 	bool no_adp_ctrl;
 	bool init_bus;
 	bool utmi_ctrl;
+	bool vblvl_ctrl;
 	u32 obint_enable_bits;
 };
 
@@ -200,7 +211,7 @@ static void rcar_gen3_enable_vbus_ctrl(struct rcar_gen3_chan *ch, int vbus)
 	u32 val;
 
 	dev_vdbg(ch->dev, "%s: %08x, %d\n", __func__, val, vbus);
-	if (ch->phy_data->no_adp_ctrl) {
+	if (ch->phy_data->no_adp_ctrl || ch->phy_data->vblvl_ctrl) {
 		if (ch->vbus)
 			regulator_hardware_enable(ch->vbus, vbus);
 
@@ -283,6 +294,16 @@ static void rcar_gen3_init_from_a_peri_to_a_host(struct rcar_gen3_chan *ch)
 
 static bool rcar_gen3_check_id(struct rcar_gen3_chan *ch)
 {
+	if (ch->phy_data->vblvl_ctrl) {
+		bool vbus_valid;
+		bool device;
+
+		device = !!(readl(ch->base + USB2_ADPCTRL) & USB2_ADPCTRL_IDDIG);
+		vbus_valid = !!(readl(ch->base + USB2_ADPCTRL) & USB2_ADPCTRL_VBUSVALID);
+
+		return !(device && !vbus_valid);
+	}
+
 	if (!ch->uses_otg_pins)
 		return (ch->dr_mode == USB_DR_MODE_HOST) ? false : true;
 
@@ -418,11 +439,20 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
 	writel(val, usb2_base + USB2_LINECTRL1);
 
 	if (!ch->phy_data->no_adp_ctrl) {
-		val = readl(usb2_base + USB2_VBCTRL);
-		val &= ~USB2_VBCTRL_OCCLREN;
-		writel(val | USB2_VBCTRL_DRVVBUSSEL, usb2_base + USB2_VBCTRL);
-		val = readl(usb2_base + USB2_ADPCTRL);
-		writel(val | USB2_ADPCTRL_IDPULLUP, usb2_base + USB2_ADPCTRL);
+		if (ch->phy_data->vblvl_ctrl) {
+			val = readl(usb2_base + USB2_VBCTRL);
+			val = (val & ~USB2_VBCTRL_VBLVL_MASK) | USB2_VBCTRL_VBLVL(2);
+			writel(val, usb2_base + USB2_VBCTRL);
+			val = readl(usb2_base + USB2_ADPCTRL);
+			writel(val | USB2_ADPCTRL_IDPULLUP | USB2_ADPCTRL_DRVVBUS,
+			       usb2_base + USB2_ADPCTRL);
+		} else {
+			val = readl(usb2_base + USB2_VBCTRL);
+			val &= ~USB2_VBCTRL_OCCLREN;
+			writel(val | USB2_VBCTRL_DRVVBUSSEL, usb2_base + USB2_VBCTRL);
+			val = readl(usb2_base + USB2_ADPCTRL);
+			writel(val | USB2_ADPCTRL_IDPULLUP, usb2_base + USB2_ADPCTRL);
+		}
 	}
 	mdelay(20);
 
@@ -432,6 +462,23 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
 	rcar_gen3_device_recognition(ch);
 }
 
+static void rcar_gen3_configure_vblvl_ctrl(struct rcar_gen3_chan *ch)
+{
+	void __iomem *usb2_base = ch->base;
+	u32 val;
+
+	if (!ch->phy_data->vblvl_ctrl)
+		return;
+
+	val = readl(usb2_base + USB2_VBCTRL);
+	if ((val & USB2_VBCTRL_VBSTA_MASK) ==
+	    FIELD_PREP_CONST(USB2_VBCTRL_VBSTA_MASK, USB2_VBCTRL_VBSTA_DEFAULT))
+		val &= ~USB2_VBCTRL_VBLVL_MASK;
+	else
+		val |= USB2_VBCTRL_VBLVL(USB2_VBCTRL_VBSTA_DEFAULT);
+	writel(val, usb2_base + USB2_VBCTRL);
+}
+
 static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, void *_ch)
 {
 	struct rcar_gen3_chan *ch = _ch;
@@ -449,8 +496,12 @@ static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, void *_ch)
 		status = readl(usb2_base + USB2_OBINTSTA);
 		if (status & ch->phy_data->obint_enable_bits) {
 			dev_vdbg(dev, "%s: %08x\n", __func__, status);
-			writel(ch->phy_data->obint_enable_bits, usb2_base + USB2_OBINTSTA);
+			if (ch->phy_data->vblvl_ctrl)
+				writel(USB2_OBINTSTA_CLEAR, usb2_base + USB2_OBINTSTA);
+			else
+				writel(ch->phy_data->obint_enable_bits, usb2_base + USB2_OBINTSTA);
 			rcar_gen3_device_recognition(ch);
+			rcar_gen3_configure_vblvl_ctrl(ch);
 			ret = IRQ_HANDLED;
 		}
 	}
@@ -483,6 +534,13 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
 	if (rphy->int_enable_bits)
 		rcar_gen3_init_otg(channel);
 
+	if (channel->phy_data->vblvl_ctrl) {
+		/* SIDDQ mode release */
+		writel(readl(usb2_base + USB2_VBCTRL) | USB2_VBCTRL_SIDDQREL,
+		       usb2_base + USB2_VBCTRL);
+		udelay(250);
+	}
+
 	if (channel->phy_data->utmi_ctrl) {
 		val = readl(usb2_base + USB2_REGEN_CG_CTRL) | USB2_REGEN_CG_CTRL_UPHY_WEN;
 		writel(val, usb2_base + USB2_REGEN_CG_CTRL);
@@ -612,6 +670,12 @@ static const struct rcar_gen3_phy_drv_data rz_g3s_phy_usb2_data = {
 	.obint_enable_bits = USB2_OBINT_IDCHG_EN,
 };
 
+static const struct rcar_gen3_phy_drv_data rz_t2h_phy_usb2_data = {
+	.phy_usb2_ops = &rcar_gen3_phy_usb2_ops,
+	.vblvl_ctrl = true,
+	.obint_enable_bits = USB2_OBINT_IDCHG_EN | USB2_OBINT_VBSTAINT,
+};
+
 static const struct rcar_gen3_phy_drv_data rz_v2h_phy_usb2_data = {
 	.phy_usb2_ops = &rcar_gen3_phy_usb2_ops,
 	.no_adp_ctrl = true,
@@ -644,6 +708,10 @@ static const struct of_device_id rcar_gen3_phy_usb2_match_table[] = {
 		.compatible = "renesas,usb2-phy-r9a09g057",
 		.data = &rz_v2h_phy_usb2_data,
 	},
+	{
+		.compatible = "renesas,usb2-phy-r9a09g077",
+		.data = &rz_t2h_phy_usb2_data,
+	},
 	{
 		.compatible = "renesas,rzg2l-usb2-phy",
 		.data = &rz_g2l_phy_usb2_data,
-- 
2.43.0


