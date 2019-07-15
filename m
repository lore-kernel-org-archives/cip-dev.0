From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 15:01:47 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 07/12] phy: renesas: rcar-gen3-usb2:
	add is_otg_channel to use "role" sysfs
In-Reply-To: <1563199312-18842-1-git-send-email-biju.das@bp.renesas.com>
References: <1563199312-18842-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563199312-18842-8-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 979b519c7a1bff56a212bf80cc04ae9b4131ea43 upstream.

Even if a board doesn't have otg pins connection, this hardware can
change the role by a register setting. So, this patch adds
"is_otg_channel" for it.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 272c9ec..16481cfd 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -89,9 +89,21 @@ struct rcar_gen3_chan {
 	struct work_struct work;
 	enum usb_dr_mode dr_mode;
 	bool extcon_host;
+	bool is_otg_channel;
 	bool uses_otg_pins;
 };
 
+/*
+ * Combination about is_otg_channel and uses_otg_pins:
+ *
+ * Parameters				|| Behaviors
+ * is_otg_channel	| uses_otg_pins	|| irqs		| role sysfs
+ * ---------------------+---------------++--------------+------------
+ * true			| true		|| enabled	| enabled
+ * true                 | false		|| disabled	| enabled
+ * false                | any		|| disabled	| disabled
+ */
+
 static void rcar_gen3_phy_usb2_work(struct work_struct *work)
 {
 	struct rcar_gen3_chan *ch = container_of(work, struct rcar_gen3_chan,
@@ -247,7 +259,7 @@ static ssize_t role_store(struct device *dev, struct device_attribute *attr,
 	bool is_b_device;
 	enum phy_mode cur_mode, new_mode;
 
-	if (!ch->uses_otg_pins || !ch->phy->init_count)
+	if (!ch->is_otg_channel || !ch->phy->init_count)
 		return -EIO;
 
 	if (!strncmp(buf, "host", strlen("host")))
@@ -285,7 +297,7 @@ static ssize_t role_show(struct device *dev, struct device_attribute *attr,
 {
 	struct rcar_gen3_chan *ch = dev_get_drvdata(dev);
 
-	if (!ch->uses_otg_pins || !ch->phy->init_count)
+	if (!ch->is_otg_channel || !ch->phy->init_count)
 		return -EIO;
 
 	return sprintf(buf, "%s\n", rcar_gen3_is_host(ch) ? "host" :
@@ -323,7 +335,7 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
 	writel(USB2_OC_TIMSET_INIT, usb2_base + USB2_OC_TIMSET);
 
 	/* Initialize otg part */
-	if (channel->uses_otg_pins)
+	if (channel->is_otg_channel)
 		rcar_gen3_init_otg(channel);
 
 	return 0;
@@ -447,6 +459,7 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 	if (channel->dr_mode != USB_DR_MODE_UNKNOWN) {
 		int ret;
 
+		channel->is_otg_channel = true;
 		channel->uses_otg_pins = !of_property_read_bool(dev->of_node,
 							"renesas,no-otg-pins");
 		channel->extcon = devm_extcon_dev_allocate(dev,
@@ -490,7 +503,7 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 		dev_err(dev, "Failed to register PHY provider\n");
 		ret = PTR_ERR(provider);
 		goto error;
-	} else if (channel->uses_otg_pins) {
+	} else if (channel->is_otg_channel) {
 		int ret;
 
 		ret = device_create_file(dev, &dev_attr_role);
@@ -510,7 +523,7 @@ static int rcar_gen3_phy_usb2_remove(struct platform_device *pdev)
 {
 	struct rcar_gen3_chan *channel = platform_get_drvdata(pdev);
 
-	if (channel->uses_otg_pins)
+	if (channel->is_otg_channel)
 		device_remove_file(&pdev->dev, &dev_attr_role);
 
 	pm_runtime_disable(&pdev->dev);
-- 
2.7.4
