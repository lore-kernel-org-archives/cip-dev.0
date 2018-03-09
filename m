From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri,  9 Mar 2018 09:57:02 +0000
Subject: [cip-dev] [PATCH 2/4] dt-bindings: usb-xhci: Document r8a7743
	support
In-Reply-To: <1520589424-15807-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520589424-15807-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520589424-15807-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Document r8a7743 xhci support. The driver will use the fallback
compatible string "renesas,rcar-gen2-xhci", therefore no driver
change is needed.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 5fd29937dec4b64aa91a3207742cd8c720cd0595)
(removed "renesas,rcar-gen2-xhci" fallback compatible string)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/usb/usb-xhci.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index 86f67f0..fce0320 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -3,8 +3,8 @@ USB xHCI controllers
 Required properties:
   - compatible: should be one of "generic-xhci",
     "marvell,armada-375-xhci", "marvell,armada-380-xhci",
-    "renesas,xhci-r8a7790", "renesas,xhci-r8a7791" (deprecated:
-    "xhci-platform").
+    "renesas,xhci-r8a7790", "renesas,xhci-r8a7791", "renesas,xhci-r8a7743"
+    (deprecated: "xhci-platform").
   - reg: should contain address and length of the standard XHCI
     register set for the device.
   - interrupts: one XHCI interrupt should be described here.
-- 
2.7.4
