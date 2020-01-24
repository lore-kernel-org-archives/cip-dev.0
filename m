From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Fri, 24 Jan 2020 09:08:18 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 08/10] dt-bindings: usb-xhci: Document
	r8a7744 support
In-Reply-To: <1579856900-21381-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1579856900-21381-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1579856900-21381-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 2cfe8f864d0e2504dc2f68f0b04668d877f7c7b4 upstream.

Document r8a7744 xhci support. The driver will use the fallback
compatible string "renesas,rcar-gen2-xhci", therefore no driver
change is needed.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/usb/usb-xhci.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index fce0320..bf5192b 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -3,7 +3,8 @@ USB xHCI controllers
 Required properties:
   - compatible: should be one of "generic-xhci",
     "marvell,armada-375-xhci", "marvell,armada-380-xhci",
-    "renesas,xhci-r8a7790", "renesas,xhci-r8a7791", "renesas,xhci-r8a7743"
+    "renesas,xhci-r8a7790", "renesas,xhci-r8a7791", "renesas,xhci-r8a7743",
+    "renesas,xhci-r8a7744"
     (deprecated: "xhci-platform").
   - reg: should contain address and length of the standard XHCI
     register set for the device.
-- 
2.7.4
