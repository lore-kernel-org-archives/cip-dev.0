From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:02:33 +0100
Subject: [cip-dev] [PATCH 4.19.y 02/60] dt-bindings: can: rcar_can: Fix
	RZ/G2 CAN clocks
In-Reply-To: <1566990211-24785-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566990211-24785-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566990211-24785-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit e6aacf9a52e0b013835c7e33538bcdf0703bbe2e upstream.

According to the latest information, the clock options for CAN on RZ/G2
are the same as the ones available on R-Car Gen3

Fixes: 868b7c0f43e6 ("dt-bindings: can: rcar_can: Add r8a774a1 support")
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/net/can/rcar_can.txt | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Documentation/devicetree/bindings/net/can/rcar_can.txt
index f3b160c..a7b01bf 100644
--- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
+++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
@@ -25,13 +25,8 @@ Required properties:
 
 - reg: physical base address and size of the R-Car CAN register map.
 - interrupts: interrupt specifier for the sole interrupt.
-- clocks: phandles and clock specifiers for 2 CAN clock inputs for RZ/G2
-	  devices.
-	  phandles and clock specifiers for 3 CAN clock inputs for every other
-	  SoC.
-- clock-names: 2 clock input name strings for RZ/G2: "clkp1", "can_clk".
-	       3 clock input name strings for every other SoC: "clkp1", "clkp2",
-	       "can_clk".
+- clocks: phandles and clock specifiers for 3 CAN clock inputs.
+- clock-names: 3 clock input name strings: "clkp1", "clkp2", and "can_clk".
 - pinctrl-0: pin control group to be used for this controller.
 - pinctrl-names: must be "default".
 
@@ -48,8 +43,7 @@ using the below properties:
 Optional properties:
 - renesas,can-clock-select: R-Car CAN Clock Source Select. Valid values are:
 			    <0x0> (default) : Peripheral clock (clkp1)
-			    <0x1> : Peripheral clock (clkp2) (not supported by
-				    RZ/G2 devices)
+			    <0x1> : Peripheral clock (clkp2)
 			    <0x3> : External input clock
 
 Example
-- 
2.7.4
