From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 15:01:49 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 09/12] phy: rcar-gen3-usb2: Add support
	for r8a77470
In-Reply-To: <1563199312-18842-1-git-send-email-biju.das@bp.renesas.com>
References: <1563199312-18842-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563199312-18842-10-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 5d8042e95fd471d0e342cf14f127194f1a867a01 upstream.

This patch adds support for r8a77470 (RZ/G1C). We can reuse this driver for
initializing timing/interrupt generation registers.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/renesas/Kconfig              |  2 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 39 +++++++++++++++++++++++++++-----
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/renesas/Kconfig b/drivers/phy/renesas/Kconfig
index 4bd390c..7bc62d2 100644
--- a/drivers/phy/renesas/Kconfig
+++ b/drivers/phy/renesas/Kconfig
@@ -18,7 +18,7 @@ config PHY_RCAR_GEN3_PCIE
 config PHY_RCAR_GEN3_USB2
 	tristate "Renesas R-Car generation 3 USB 2.0 PHY driver"
 	depends on ARCH_RENESAS
-	depends on EXTCON
+	depends on EXTCON || !EXTCON # if EXTCON=m, this cannot be built-in
 	depends on USB_SUPPORT
 	select GENERIC_PHY
 	select USB_COMMON
diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 685d56c..37cb619 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -396,6 +396,12 @@ static const struct phy_ops rcar_gen3_phy_usb2_ops = {
 	.owner		= THIS_MODULE,
 };
 
+static const struct phy_ops rz_g1c_phy_usb2_ops = {
+	.init		= rcar_gen3_phy_usb2_init,
+	.exit		= rcar_gen3_phy_usb2_exit,
+	.owner		= THIS_MODULE,
+};
+
 static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, void *_ch)
 {
 	struct rcar_gen3_chan *ch = _ch;
@@ -414,11 +420,27 @@ static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, void *_ch)
 }
 
 static const struct of_device_id rcar_gen3_phy_usb2_match_table[] = {
-	{ .compatible = "renesas,usb2-phy-r8a7795" },
-	{ .compatible = "renesas,usb2-phy-r8a7796" },
-	{ .compatible = "renesas,usb2-phy-r8a77965" },
-	{ .compatible = "renesas,rcar-gen3-usb2-phy" },
-	{ }
+	{
+		.compatible = "renesas,usb2-phy-r8a77470",
+		.data = &rz_g1c_phy_usb2_ops,
+	},
+	{
+		.compatible = "renesas,usb2-phy-r8a7795",
+		.data = &rcar_gen3_phy_usb2_ops,
+	},
+	{
+		.compatible = "renesas,usb2-phy-r8a7796",
+		.data = &rcar_gen3_phy_usb2_ops,
+	},
+	{
+		.compatible = "renesas,usb2-phy-r8a77965",
+		.data = &rcar_gen3_phy_usb2_ops,
+	},
+	{
+		.compatible = "renesas,rcar-gen3-usb2-phy",
+		.data = &rcar_gen3_phy_usb2_ops,
+	},
+	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, rcar_gen3_phy_usb2_match_table);
 
@@ -434,6 +456,7 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 	struct rcar_gen3_chan *channel;
 	struct phy_provider *provider;
 	struct resource *res;
+	const struct phy_ops *phy_usb2_ops;
 	int irq, ret = 0;
 
 	if (!dev->of_node) {
@@ -484,7 +507,11 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 	 * And then, phy-core will manage runtime pm for this device.
 	 */
 	pm_runtime_enable(dev);
-	channel->phy = devm_phy_create(dev, NULL, &rcar_gen3_phy_usb2_ops);
+	phy_usb2_ops = of_device_get_match_data(dev);
+	if (!phy_usb2_ops)
+		return -EINVAL;
+
+	channel->phy = devm_phy_create(dev, NULL, phy_usb2_ops);
 	if (IS_ERR(channel->phy)) {
 		dev_err(dev, "Failed to create USB2 PHY\n");
 		ret = PTR_ERR(channel->phy);
-- 
2.7.4
