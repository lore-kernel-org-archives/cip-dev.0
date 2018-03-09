From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri,  9 Mar 2018 09:57:01 +0000
Subject: [cip-dev] [PATCH 1/4] usb: host: xhci-plat: Add r8a7743 support
In-Reply-To: <1520589424-15807-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520589424-15807-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520589424-15807-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch adds xhci r8a7743 driver support.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/usb/host/xhci-plat.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 7afd607..8e6ec16 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -53,7 +53,8 @@ static int xhci_plat_setup(struct usb_hcd *hcd)
 	int ret;
 
 	if (of_device_is_compatible(of_node, "renesas,xhci-r8a7790") ||
-	    of_device_is_compatible(of_node, "renesas,xhci-r8a7791")) {
+	    of_device_is_compatible(of_node, "renesas,xhci-r8a7791") ||
+	    of_device_is_compatible(of_node, "renesas,xhci-r8a7743")) {
 		ret = xhci_rcar_init_quirk(hcd);
 		if (ret)
 			return ret;
@@ -67,7 +68,8 @@ static int xhci_plat_start(struct usb_hcd *hcd)
 	struct device_node *of_node = hcd->self.controller->of_node;
 
 	if (of_device_is_compatible(of_node, "renesas,xhci-r8a7790") ||
-	    of_device_is_compatible(of_node, "renesas,xhci-r8a7791"))
+	    of_device_is_compatible(of_node, "renesas,xhci-r8a7791") ||
+	    of_device_is_compatible(of_node, "renesas,xhci-r8a7743"))
 		xhci_rcar_start(hcd);
 
 	return xhci_run(hcd);
@@ -267,6 +269,7 @@ static const struct of_device_id usb_xhci_of_match[] = {
 	{ .compatible = "xhci-platform" },
 	{ .compatible = "marvell,armada-375-xhci"},
 	{ .compatible = "marvell,armada-380-xhci"},
+	{ .compatible = "renesas,xhci-r8a7743"},
 	{ .compatible = "renesas,xhci-r8a7790"},
 	{ .compatible = "renesas,xhci-r8a7791"},
 	{ },
-- 
2.7.4
