From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 28 Aug 2019 09:48:22 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 04/17] dt-bindings: rcar-gen3-phy-usb2:
	Add r8a77470 support
In-Reply-To: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
References: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1566982115-11148-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit d6c4aee8d1218d5cd73ce5e6f27ac68ad8b9430b upstream.

Document RZ/G1C (R8A77470) SoC bindings.

For RZ/G1C, this driver is used to enable interrupt generation and
initializing timing registers which is part of phy_init code.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
[Dropped non r8a77470 related changes]
---
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
index affa0f7..c0cf9f4 100644
--- a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
+++ b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
@@ -1,10 +1,12 @@
 * Renesas R-Car generation 3 USB 2.0 PHY
 
 This file provides information on what the device node for the R-Car generation
-3 USB 2.0 PHY contains.
+3 and RZ/G1C USB 2.0 PHY contains.
 
 Required properties:
-- compatible: "renesas,usb2-phy-r8a7795" if the device is a part of an R8A7795
+- compatible: "renesas,usb2-phy-r8a77470" if the device is a part of an R8A77470
+	      SoC.
+	      "renesas,usb2-phy-r8a7795" if the device is a part of an R8A7795
 	      SoC.
 - reg: offset and length of the partial USB 2.0 Host register block.
 - reg-names: must be "usb2_host".
-- 
2.7.4
