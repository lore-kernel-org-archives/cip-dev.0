From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 15:01:46 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 06/12] phy: renesas: rcar-gen3-usb2:
	change a condition "dr_mode"
In-Reply-To: <1563199312-18842-1-git-send-email-biju.das@bp.renesas.com>
References: <1563199312-18842-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563199312-18842-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 73801b90a38ff1ee89ad38c925fa37fbcb421bfc upstream.

This patch changes a condition about dr_mode. If a device node has
any dr_mode ("host", "peripheral" or "otg"), this driver allows to
set "is_otg_channel" to true. Also, this patch keeps the dr_mode
value for future use.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 4d5cfe5..272c9ec 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -87,6 +87,7 @@ struct rcar_gen3_chan {
 	struct phy *phy;
 	struct regulator *vbus;
 	struct work_struct work;
+	enum usb_dr_mode dr_mode;
 	bool extcon_host;
 	bool uses_otg_pins;
 };
@@ -442,7 +443,8 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 			dev_err(dev, "No irq handler (%d)\n", irq);
 	}
 
-	if (of_usb_get_dr_mode_by_phy(dev->of_node, 0) == USB_DR_MODE_OTG) {
+	channel->dr_mode = of_usb_get_dr_mode_by_phy(dev->of_node, 0);
+	if (channel->dr_mode != USB_DR_MODE_UNKNOWN) {
 		int ret;
 
 		channel->uses_otg_pins = !of_property_read_bool(dev->of_node,
-- 
2.7.4
