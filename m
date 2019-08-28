From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 28 Aug 2019 09:48:23 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 05/17] phy: phy-rcar-gen2: Add support
	for r8a77470
In-Reply-To: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
References: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1566982115-11148-6-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit b7187e001a103f49ccb118bb2fb62ad31961b666 upstream.

This patch adds support for RZ/G1C (r8a77470) SoC. RZ/G1C SoC has a
PLL register shared between hsusb0 and hsusb1. Compared to other RZ/G1
and R-Car Gen2/3, USB Host needs to deassert the pll reset.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-and-Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
[Backported to 4.4 cip kernel]
---
 drivers/phy/phy-rcar-gen2.c | 130 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 118 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/phy-rcar-gen2.c b/drivers/phy/phy-rcar-gen2.c
index aa02b19..0817356 100644
--- a/drivers/phy/phy-rcar-gen2.c
+++ b/drivers/phy/phy-rcar-gen2.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2014 Renesas Solutions Corp.
  * Copyright (C) 2014 Cogent Embedded, Inc.
+ * Copyright (C) 2019 Renesas Electronics Corp.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -18,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/atomic.h>
+#include <linux/of_device.h>
 
 #define USBHS_LPSTS			0x02
 #define USBHS_UGCTRL			0x80
@@ -38,6 +40,8 @@
 #define USBHS_UGCTRL2_USB0SEL		0x00000030
 #define USBHS_UGCTRL2_USB0SEL_PCI	0x00000010
 #define USBHS_UGCTRL2_USB0SEL_HS_USB	0x00000030
+#define USBHS_UGCTRL2_USB0SEL_USB20	0x00000010
+#define USBHS_UGCTRL2_USB0SEL_HS_USB20	0x00000020
 
 /* USB General status register (UGSTS) */
 #define USBHS_UGSTS_LOCK		0x00000100 /* From technical update */
@@ -67,6 +71,11 @@ struct rcar_gen2_phy_driver {
 	struct rcar_gen2_channel *channels;
 };
 
+struct rcar_gen2_phy_data {
+	const struct phy_ops *gen2_phy_ops;
+	const u32 (*select_value)[PHYS_PER_CHANNEL];
+};
+
 static int rcar_gen2_phy_init(struct phy *p)
 {
 	struct rcar_gen2_phy *phy = phy_get_drvdata(p);
@@ -183,6 +192,60 @@ static int rcar_gen2_phy_power_off(struct phy *p)
 	return 0;
 }
 
+static int rz_g1c_phy_power_on(struct phy *p)
+{
+	struct rcar_gen2_phy *phy = phy_get_drvdata(p);
+	struct rcar_gen2_phy_driver *drv = phy->channel->drv;
+	void __iomem *base = drv->base;
+	unsigned long flags;
+	u32 value;
+
+	spin_lock_irqsave(&drv->lock, flags);
+
+	/* Power on USBHS PHY */
+	value = readl(base + USBHS_UGCTRL);
+	value &= ~USBHS_UGCTRL_PLLRESET;
+	writel(value, base + USBHS_UGCTRL);
+
+	/* As per the data sheet wait 340 micro sec for power stable */
+	udelay(340);
+
+	if (phy->select_value == USBHS_UGCTRL2_USB0SEL_HS_USB20) {
+		value = readw(base + USBHS_LPSTS);
+		value |= USBHS_LPSTS_SUSPM;
+		writew(value, base + USBHS_LPSTS);
+	}
+
+	spin_unlock_irqrestore(&drv->lock, flags);
+
+	return 0;
+}
+
+static int rz_g1c_phy_power_off(struct phy *p)
+{
+	struct rcar_gen2_phy *phy = phy_get_drvdata(p);
+	struct rcar_gen2_phy_driver *drv = phy->channel->drv;
+	void __iomem *base = drv->base;
+	unsigned long flags;
+	u32 value;
+
+	spin_lock_irqsave(&drv->lock, flags);
+	/* Power off USBHS PHY */
+	if (phy->select_value == USBHS_UGCTRL2_USB0SEL_HS_USB20) {
+		value = readw(base + USBHS_LPSTS);
+		value &= ~USBHS_LPSTS_SUSPM;
+		writew(value, base + USBHS_LPSTS);
+	}
+
+	value = readl(base + USBHS_UGCTRL);
+	value |= USBHS_UGCTRL_PLLRESET;
+	writel(value, base + USBHS_UGCTRL);
+
+	spin_unlock_irqrestore(&drv->lock, flags);
+
+	return 0;
+}
+
 static const struct phy_ops rcar_gen2_phy_ops = {
 	.init		= rcar_gen2_phy_init,
 	.exit		= rcar_gen2_phy_exit,
@@ -191,12 +254,55 @@ static const struct phy_ops rcar_gen2_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
+static const struct phy_ops rz_g1c_phy_ops = {
+	.init		= rcar_gen2_phy_init,
+	.exit		= rcar_gen2_phy_exit,
+	.power_on	= rz_g1c_phy_power_on,
+	.power_off	= rz_g1c_phy_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static const u32 pci_select_value[][PHYS_PER_CHANNEL] = {
+	[0]	= { USBHS_UGCTRL2_USB0SEL_PCI, USBHS_UGCTRL2_USB0SEL_HS_USB },
+	[2]	= { USBHS_UGCTRL2_USB2SEL_PCI, USBHS_UGCTRL2_USB2SEL_USB30 },
+};
+
+static const u32 usb20_select_value[][PHYS_PER_CHANNEL] = {
+	{ USBHS_UGCTRL2_USB0SEL_USB20, USBHS_UGCTRL2_USB0SEL_HS_USB20 },
+};
+
+static const struct rcar_gen2_phy_data rcar_gen2_usb_phy_data = {
+	.gen2_phy_ops = &rcar_gen2_phy_ops,
+	.select_value = pci_select_value,
+};
+
+static const struct rcar_gen2_phy_data rz_g1c_usb_phy_data = {
+	.gen2_phy_ops = &rz_g1c_phy_ops,
+	.select_value = usb20_select_value,
+};
+
 static const struct of_device_id rcar_gen2_phy_match_table[] = {
-	{ .compatible = "renesas,usb-phy-r8a7790" },
-	{ .compatible = "renesas,usb-phy-r8a7791" },
-	{ .compatible = "renesas,usb-phy-r8a7794" },
-	{ .compatible = "renesas,rcar-gen2-usb-phy" },
-	{ }
+	{
+		.compatible = "renesas,usb-phy-r8a77470",
+		.data = &rz_g1c_usb_phy_data,
+	},
+	{
+		.compatible = "renesas,usb-phy-r8a7790",
+		.data = &rcar_gen2_usb_phy_data,
+	},
+	{
+		.compatible = "renesas,usb-phy-r8a7791",
+		.data = &rcar_gen2_usb_phy_data,
+	},
+	{
+		.compatible = "renesas,usb-phy-r8a7794",
+		.data = &rcar_gen2_usb_phy_data,
+	},
+	{
+		.compatible = "renesas,rcar-gen2-usb-phy",
+		.data = &rcar_gen2_usb_phy_data,
+	},
+	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, rcar_gen2_phy_match_table);
 
@@ -227,11 +333,6 @@ static const u32 select_mask[] = {
 	[2]	= USBHS_UGCTRL2_USB2SEL,
 };
 
-static const u32 select_value[][PHYS_PER_CHANNEL] = {
-	[0]	= { USBHS_UGCTRL2_USB0SEL_PCI, USBHS_UGCTRL2_USB0SEL_HS_USB },
-	[2]	= { USBHS_UGCTRL2_USB2SEL_PCI, USBHS_UGCTRL2_USB2SEL_USB30 },
-};
-
 static int rcar_gen2_phy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -241,6 +342,7 @@ static int rcar_gen2_phy_probe(struct platform_device *pdev)
 	struct resource *res;
 	void __iomem *base;
 	struct clk *clk;
+	const struct rcar_gen2_phy_data *data;
 	int i = 0;
 
 	if (!dev->of_node) {
@@ -269,6 +371,10 @@ static int rcar_gen2_phy_probe(struct platform_device *pdev)
 	drv->clk = clk;
 	drv->base = base;
 
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
 	drv->num_channels = of_get_child_count(dev->of_node);
 	drv->channels = devm_kcalloc(dev, drv->num_channels,
 				     sizeof(struct rcar_gen2_channel),
@@ -298,10 +404,10 @@ static int rcar_gen2_phy_probe(struct platform_device *pdev)
 
 			phy->channel = channel;
 			phy->number = n;
-			phy->select_value = select_value[channel_num][n];
+			phy->select_value = data->select_value[channel_num][n];
 
 			phy->phy = devm_phy_create(dev, NULL,
-						   &rcar_gen2_phy_ops);
+						   data->gen2_phy_ops);
 			if (IS_ERR(phy->phy)) {
 				dev_err(dev, "Failed to create PHY\n");
 				of_node_put(np);
-- 
2.7.4
