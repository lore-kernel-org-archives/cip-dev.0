From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 13 May 2019 16:36:49 +0100
Subject: [cip-dev] [PATCH 4.4.y 24/52] dt-bindings: gpio: rcar: Add
	gpio-reserved-ranges support
In-Reply-To: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557761837-24993-25-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit c0f6afad46a8ed2c0a2053ec720b1e6da80cf69a upstream.

Update the DT bindings documentation with the optional gpio-reserved-ranges
properties.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
[fab: reworked example to make it fit v4.4 implementation]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 .../devicetree/bindings/gpio/renesas,gpio-rcar.txt | 43 +++++++++++++---------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
index 68eb3a8..7163b19e 100644
--- a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
+++ b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
@@ -30,7 +30,7 @@ Required Properties:
   - #gpio-cells: Should be 2. The first cell is the GPIO number and the second
     cell specifies GPIO flags, as defined in <dt-bindings/gpio/gpio.h>. Only the
     GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW flags are supported.
-  - gpio-ranges: Range of pins managed by the GPIO controller.
+  - gpio-ranges: See gpio.txt.
 
 Optional properties:
 
@@ -38,35 +38,42 @@ Optional properties:
     mandatory if the hardware implements a controllable functional clock for
     the GPIO instance.
 
-Please refer to gpio.txt in this directory for details of gpio-ranges property
-and the common GPIO bindings used by client devices.
+  - gpio-reserved-ranges: See gpio.txt.
+
+Please refer to gpio.txt in this directory for the common GPIO bindings used by
+client devices.
 
 The GPIO controller also acts as an interrupt controller. It uses the default
 two cells specifier as described in Documentation/devicetree/bindings/
 interrupt-controller/interrupts.txt.
 
-Example: R8A7779 (R-Car H1) GPIO controller nodes
+Example: R8A77470 (RZ/G1C) GPIO controller nodes
 
-	gpio0: gpio at ffc40000 {
-		compatible = "renesas,gpio-r8a7779", "renesas,rcar-gen1-gpio";
-		reg = <0xffc40000 0x2c>;
-		interrupt-parent = <&gic>;
-		interrupts = <0 141 0x4>;
+	gpio0: gpio at e6050000 {
+		compatible = "renesas,gpio-r8a77470",
+			     "renesas,rcar-gen2-gpio";
+		reg = <0 0xe6050000 0 0x50>;
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
-		gpio-ranges = <&pfc 0 0 32>;
-		interrupt-controller;
+		gpio-ranges = <&pfc 0 0 23>;
 		#interrupt-cells = <2>;
+		interrupt-controller;
+		clocks = <&mstp9_clks R8A77470_CLK_GPIO0>;
+		power-domains = <&cpg_clocks>;
 	};
 	...
-	gpio6: gpio at ffc46000 {
-		compatible = "renesas,gpio-r8a7779", "renesas,rcar-gen1-gpio";
-		reg = <0xffc46000 0x2c>;
-		interrupt-parent = <&gic>;
-		interrupts = <0 147 0x4>;
+	gpio3: gpio at e6053000 {
+		compatible = "renesas,gpio-r8a77470",
+			     "renesas,rcar-gen2-gpio";
+		reg = <0 0xe6053000 0 0x50>;
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
-		gpio-ranges = <&pfc 0 192 9>;
-		interrupt-controller;
+		gpio-ranges = <&pfc 0 96 30>;
+		gpio-reserved-ranges = <17 10>;
 		#interrupt-cells = <2>;
+		interrupt-controller;
+		clocks = <&mstp9_clks R8A77470_CLK_GPIO3>;
+		power-domains = <&cpg_clocks>;
 	};
-- 
2.7.4
