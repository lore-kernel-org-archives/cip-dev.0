From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:02:32 +0100
Subject: [cip-dev] [PATCH 4.19.y 01/60] dt-bindings: can: rcar_can: Add
	r8a774a1 support
In-Reply-To: <1566990211-24785-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566990211-24785-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566990211-24785-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 868b7c0f43e61f227bf3d7f7d6134bb3c67bb0e8 upstream.

Document RZ/G2M (r8a774a1) SoC specific bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/rcar_can.txt | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Documentation/devicetree/bindings/net/can/rcar_can.txt
index 94a7f33..f3b160c 100644
--- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
+++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
@@ -4,6 +4,7 @@ Renesas R-Car CAN controller Device Tree Bindings
 Required properties:
 - compatible: "renesas,can-r8a7743" if CAN controller is a part of R8A7743 SoC.
 	      "renesas,can-r8a7745" if CAN controller is a part of R8A7745 SoC.
+	      "renesas,can-r8a774a1" if CAN controller is a part of R8A774A1 SoC.
 	      "renesas,can-r8a7778" if CAN controller is a part of R8A7778 SoC.
 	      "renesas,can-r8a7779" if CAN controller is a part of R8A7779 SoC.
 	      "renesas,can-r8a7790" if CAN controller is a part of R8A7790 SoC.
@@ -16,15 +17,21 @@ Required properties:
 	      "renesas,rcar-gen1-can" for a generic R-Car Gen1 compatible device.
 	      "renesas,rcar-gen2-can" for a generic R-Car Gen2 or RZ/G1
 	      compatible device.
-	      "renesas,rcar-gen3-can" for a generic R-Car Gen3 compatible device.
+	      "renesas,rcar-gen3-can" for a generic R-Car Gen3 or RZ/G2
+	      compatible device.
 	      When compatible with the generic version, nodes must list the
 	      SoC-specific version corresponding to the platform first
 	      followed by the generic version.
 
 - reg: physical base address and size of the R-Car CAN register map.
 - interrupts: interrupt specifier for the sole interrupt.
-- clocks: phandles and clock specifiers for 3 CAN clock inputs.
-- clock-names: 3 clock input name strings: "clkp1", "clkp2", "can_clk".
+- clocks: phandles and clock specifiers for 2 CAN clock inputs for RZ/G2
+	  devices.
+	  phandles and clock specifiers for 3 CAN clock inputs for every other
+	  SoC.
+- clock-names: 2 clock input name strings for RZ/G2: "clkp1", "can_clk".
+	       3 clock input name strings for every other SoC: "clkp1", "clkp2",
+	       "can_clk".
 - pinctrl-0: pin control group to be used for this controller.
 - pinctrl-names: must be "default".
 
@@ -41,8 +48,9 @@ using the below properties:
 Optional properties:
 - renesas,can-clock-select: R-Car CAN Clock Source Select. Valid values are:
 			    <0x0> (default) : Peripheral clock (clkp1)
-			    <0x1> : Peripheral clock (clkp2)
-			    <0x3> : Externally input clock
+			    <0x1> : Peripheral clock (clkp2) (not supported by
+				    RZ/G2 devices)
+			    <0x3> : External input clock
 
 Example
 -------
-- 
2.7.4
