From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 28 Aug 2019 09:48:19 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 01/17] dt-bindings: phy: rcar-gen2: Add
	r8a7744 support
In-Reply-To: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
References: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1566982115-11148-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit b3da72593e14511967a5f96f5e329b022239a90e upstream.

Add USB PHY support for r8a7744 SoC. Renesas RZ/G1N (R8A7744)
USB PHY is identical to the R-Car Gen2 family.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt b/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
index 75abc6d..f38f42b 100644
--- a/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
+++ b/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
@@ -5,6 +5,7 @@ This file provides information on what the device node for the R-Car generation
 
 Required properties:
 - compatible: "renesas,usb-phy-r8a7743" if the device is a part of R8A7743 SoC.
+	      "renesas,usb-phy-r8a7744" if the device is a part of R8A7744 SoC.
 	      "renesas,usb-phy-r8a7745" if the device is a part of R8A7745 SoC.
 	      "renesas,usb-phy-r8a7790" if the device is a part of R8A7790 SoC.
 	      "renesas,usb-phy-r8a7791" if the device is a part of R8A7791 SoC.
-- 
2.7.4
