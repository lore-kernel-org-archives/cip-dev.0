From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 15:01:50 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 10/12] phy: renesas: rcar-gen3-usb2:
	Use pdev's device pointer on dev_vdbg()
In-Reply-To: <1563199312-18842-1-git-send-email-biju.das@bp.renesas.com>
References: <1563199312-18842-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563199312-18842-11-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 92fec1c27caa7b6f2a70566625425190e14c2204 upstream.

To implement multiple phy instances in the future, this patch uses
pdev's device pointer on dev_vdbg() instead of the phy's device
pointer.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 37cb619..40378da 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -83,6 +83,7 @@
 
 struct rcar_gen3_chan {
 	void __iomem *base;
+	struct device *dev;	/* platform_device's device */
 	struct extcon_dev *extcon;
 	struct phy *phy;
 	struct regulator *vbus;
@@ -123,7 +124,7 @@ static void rcar_gen3_set_host_mode(struct rcar_gen3_chan *ch, int host)
 	void __iomem *usb2_base = ch->base;
 	u32 val = readl(usb2_base + USB2_COMMCTRL);
 
-	dev_vdbg(&ch->phy->dev, "%s: %08x, %d\n", __func__, val, host);
+	dev_vdbg(ch->dev, "%s: %08x, %d\n", __func__, val, host);
 	if (host)
 		val &= ~USB2_COMMCTRL_OTG_PERI;
 	else
@@ -136,7 +137,7 @@ static void rcar_gen3_set_linectrl(struct rcar_gen3_chan *ch, int dp, int dm)
 	void __iomem *usb2_base = ch->base;
 	u32 val = readl(usb2_base + USB2_LINECTRL1);
 
-	dev_vdbg(&ch->phy->dev, "%s: %08x, %d, %d\n", __func__, val, dp, dm);
+	dev_vdbg(ch->dev, "%s: %08x, %d, %d\n", __func__, val, dp, dm);
 	val &= ~(USB2_LINECTRL1_DP_RPD | USB2_LINECTRL1_DM_RPD);
 	if (dp)
 		val |= USB2_LINECTRL1_DP_RPD;
@@ -150,7 +151,7 @@ static void rcar_gen3_enable_vbus_ctrl(struct rcar_gen3_chan *ch, int vbus)
 	void __iomem *usb2_base = ch->base;
 	u32 val = readl(usb2_base + USB2_ADPCTRL);
 
-	dev_vdbg(&ch->phy->dev, "%s: %08x, %d\n", __func__, val, vbus);
+	dev_vdbg(ch->dev, "%s: %08x, %d\n", __func__, val, vbus);
 	if (vbus)
 		val |= USB2_ADPCTRL_DRVVBUS;
 	else
@@ -410,7 +411,7 @@ static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, void *_ch)
 	irqreturn_t ret = IRQ_NONE;
 
 	if (status & USB2_OBINT_BITS) {
-		dev_vdbg(&ch->phy->dev, "%s: %08x\n", __func__, status);
+		dev_vdbg(ch->dev, "%s: %08x\n", __func__, status);
 		writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTSTA);
 		rcar_gen3_device_recognition(ch);
 		ret = IRQ_HANDLED;
@@ -529,6 +530,7 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, channel);
 	phy_set_drvdata(channel->phy, channel);
+	channel->dev = dev;
 
 	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 	if (IS_ERR(provider)) {
-- 
2.7.4
