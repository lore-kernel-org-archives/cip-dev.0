From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 14:31:51 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip v2 04/57] dt-bindings:
	rcar-gen3-phy-usb3: Add r8a774a1 support
In-Reply-To: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566999164-27898-5-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit fcd0eec4f54f1a8627a2d7fcbaaeed18261276a4 upstream.

Document RZ/G2M (R8A774A1) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt
index 47dd296..9d98266 100644
--- a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt
+++ b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt
@@ -1,20 +1,22 @@
 * Renesas R-Car generation 3 USB 3.0 PHY
 
 This file provides information on what the device node for the R-Car generation
-3 USB 3.0 PHY contains.
+3 and RZ/G2 USB 3.0 PHY contain.
 If you want to enable spread spectrum clock (ssc), you should use USB_EXTAL
 instead of USB3_CLK. However, if you don't want to these features, you don't
 need this driver.
 
 Required properties:
-- compatible: "renesas,r8a7795-usb3-phy" if the device is a part of an R8A7795
+- compatible: "renesas,r8a774a1-usb3-phy" if the device is a part of an R8A774A1
+	      SoC.
+	      "renesas,r8a7795-usb3-phy" if the device is a part of an R8A7795
 	      SoC.
 	      "renesas,r8a7796-usb3-phy" if the device is a part of an R8A7796
 	      SoC.
 	      "renesas,r8a77965-usb3-phy" if the device is a part of an
 	      R8A77965 SoC.
-	      "renesas,rcar-gen3-usb3-phy" for a generic R-Car Gen3 compatible
-	      device.
+	      "renesas,rcar-gen3-usb3-phy" for a generic R-Car Gen3 or RZ/G2
+	      compatible device.
 
 	      When compatible with the generic version, nodes must list the
 	      SoC-specific version corresponding to the platform first
-- 
2.7.4
