From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 28 Aug 2019 09:48:24 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 06/17] phy: rcar-gen3-usb2: Add support
	for r8a77470
In-Reply-To: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
References: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1566982115-11148-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 5d8042e95fd471d0e342cf14f127194f1a867a01 upstream.

This patch adds support for r8a77470 (RZ/G1C). We can reuse this driver for
initializing timing/interrupt generation registers.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
[Backported to 4.4-cip kernel]
---
 drivers/phy/phy-rcar-gen3-usb2.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/phy-rcar-gen3-usb2.c b/drivers/phy/phy-rcar-gen3-usb2.c
index 2696152..355a671 100644
--- a/drivers/phy/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/phy-rcar-gen3-usb2.c
@@ -18,6 +18,7 @@
 #include <linux/of_address.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/of_device.h>
 
 /******* USB2.0 Host registers (original offset is +0x200) *******/
 #define USB2_INT_ENABLE		0x000
@@ -150,9 +151,22 @@ static struct phy_ops rcar_gen3_phy_usb2_ops = {
 	.owner		= THIS_MODULE,
 };
 
+static const struct phy_ops rz_g1c_phy_usb2_ops = {
+	.init		= rcar_gen3_phy_usb2_init,
+	.exit		= rcar_gen3_phy_usb2_exit,
+	.owner		= THIS_MODULE,
+};
+
 static const struct of_device_id rcar_gen3_phy_usb2_match_table[] = {
-	{ .compatible = "renesas,usb2-phy-r8a7795" },
-	{ }
+	{
+		.compatible = "renesas,usb2-phy-r8a77470",
+		.data = &rz_g1c_phy_usb2_ops,
+	},
+	{
+		.compatible = "renesas,usb2-phy-r8a7795",
+		.data = &rcar_gen3_phy_usb2_ops,
+	},
+	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, rcar_gen3_phy_usb2_match_table);
 
@@ -162,6 +176,7 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 	struct rcar_gen3_chan *channel;
 	struct phy_provider *provider;
 	struct resource *res;
+	const struct phy_ops *phy_usb2_ops;
 
 	if (!dev->of_node) {
 		dev_err(dev, "This driver needs device tree\n");
@@ -188,7 +203,11 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 	}
 
 	/* devm_phy_create() will call pm_runtime_enable(dev); */
-	channel->phy = devm_phy_create(dev, NULL, &rcar_gen3_phy_usb2_ops);
+	phy_usb2_ops = of_device_get_match_data(dev);
+	if (!phy_usb2_ops)
+		return -EINVAL;
+
+	channel->phy = devm_phy_create(dev, NULL, phy_usb2_ops);
 	if (IS_ERR(channel->phy)) {
 		dev_err(dev, "Failed to create USB2 PHY\n");
 		return PTR_ERR(channel->phy);
-- 
2.7.4
