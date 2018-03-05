From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  5 Mar 2018 11:39:09 +0000
Subject: [cip-dev] [PATCH 05/10] phy: rcar-gen2: Add r8a7743/5 support
In-Reply-To: <1520249954-29357-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520249954-29357-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520249954-29357-6-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

Add USB PHY support for r8a7743/5 SoC. Renesas RZ/G1[ME] (R8A7743/5)
USB PHY is identical to the R-Car Gen2 family.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
(cherry picked from commit f7da4e6d29539bad2c29dd8ccb4ac628fe19f82b)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt b/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
index d564ba4..883b915 100644
--- a/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
+++ b/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
@@ -4,7 +4,9 @@ This file provides information on what the device node for the R-Car generation
 2 USB PHY contains.
 
 Required properties:
-- compatible: "renesas,usb-phy-r8a7790" if the device is a part of R8A7790 SoC.
+- compatible: "renesas,usb-phy-r8a7743" if the device is a part of R8A7743 SoC.
+	      "renesas,usb-phy-r8a7745" if the device is a part of R8A7745 SoC.
+	      "renesas,usb-phy-r8a7790" if the device is a part of R8A7790 SoC.
 	      "renesas,usb-phy-r8a7791" if the device is a part of R8A7791 SoC.
 	      "renesas,usb-phy-r8a7794" if the device is a part of R8A7794 SoC.
 - reg: offset and length of the register block.
-- 
2.7.4
