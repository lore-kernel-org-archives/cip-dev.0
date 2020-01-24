From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Fri, 24 Jan 2020 09:08:17 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 07/10] usb: host: xhci-plat: Add r8a7744
	support
In-Reply-To: <1579856900-21381-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1579856900-21381-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1579856900-21381-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch adds xhci r8a7744 driver support.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/usb/host/xhci-plat.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 8f80da4..e7f00da 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -54,7 +54,8 @@ static int xhci_plat_setup(struct usb_hcd *hcd)
 
 	if (of_device_is_compatible(of_node, "renesas,xhci-r8a7790") ||
 	    of_device_is_compatible(of_node, "renesas,xhci-r8a7791") ||
-	    of_device_is_compatible(of_node, "renesas,xhci-r8a7743")) {
+	    of_device_is_compatible(of_node, "renesas,xhci-r8a7743") ||
+	    of_device_is_compatible(of_node, "renesas,xhci-r8a7744")) {
 		ret = xhci_rcar_init_quirk(hcd);
 		if (ret)
 			return ret;
@@ -69,7 +70,8 @@ static int xhci_plat_start(struct usb_hcd *hcd)
 
 	if (of_device_is_compatible(of_node, "renesas,xhci-r8a7790") ||
 	    of_device_is_compatible(of_node, "renesas,xhci-r8a7791") ||
-	    of_device_is_compatible(of_node, "renesas,xhci-r8a7743"))
+	    of_device_is_compatible(of_node, "renesas,xhci-r8a7743") ||
+	    of_device_is_compatible(of_node, "renesas,xhci-r8a7744"))
 		xhci_rcar_start(hcd);
 
 	return xhci_run(hcd);
@@ -270,6 +272,7 @@ static const struct of_device_id usb_xhci_of_match[] = {
 	{ .compatible = "marvell,armada-375-xhci"},
 	{ .compatible = "marvell,armada-380-xhci"},
 	{ .compatible = "renesas,xhci-r8a7743"},
+	{ .compatible = "renesas,xhci-r8a7744"},
 	{ .compatible = "renesas,xhci-r8a7790"},
 	{ .compatible = "renesas,xhci-r8a7791"},
 	{ },
-- 
2.7.4
