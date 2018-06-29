From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:44 +0100
Subject: [cip-dev] [PATCH 43/86] gpio: rcar: add gen[123] fallback
	compatibility strings
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-44-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

Add fallback compatibility string for R-Car Gen 1, 2 and 3.

In the case of Renesas R-Car hardware we know that there are generations of
SoCs, f.e. Gen 1 and 2. But beyond that its not clear what the relationship
between IP blocks might be. For example, I believe that r8a7790 is older
than r8a7791 but that doesn't imply that the latter is a descendant of the
former or vice versa.

We can, however, by examining the documentation and behaviour of the
hardware at run-time observe that the current driver implementation appears
to be compatible with the IP blocks on SoCs within a given generation.

For the above reasons and convenience when enabling new SoCs a
per-generation fallback compatibility string scheme being adopted for
drivers for Renesas SoCs.

Also deprecate renesas,gpio-rcar as its name is more generic than its
implementation.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
(cherry picked from commit dbd1dad2ab8ffca57e0aa386df0d7ec621c26ca8)
(taken out R-Car Gen3 support)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 .../devicetree/bindings/gpio/renesas,gpio-rcar.txt         | 14 ++++++++++----
 drivers/gpio/gpio-rcar.c                                   |  6 ++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
index 046fef9..68eb3a8 100644
--- a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
+++ b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
@@ -2,7 +2,7 @@
 
 Required Properties:
 
-  - compatible: should contain one of the following.
+  - compatible: should contain one or more of the following:
     - "renesas,gpio-r8a7743": for R8A7743 (RZ/G1M) compatible GPIO controller.
     - "renesas,gpio-r8a7745": for R8A7745 (RZ/G1E) compatible GPIO controller.
     - "renesas,gpio-r8a7778": for R8A7778 (R-Mobile M1) compatible GPIO controller.
@@ -12,7 +12,13 @@ Required Properties:
     - "renesas,gpio-r8a7793": for R8A7793 (R-Car M2-N) compatible GPIO controller.
     - "renesas,gpio-r8a7794": for R8A7794 (R-Car E2) compatible GPIO controller.
     - "renesas,gpio-r8a7795": for R8A7795 (R-Car H3) compatible GPIO controller.
-    - "renesas,gpio-rcar": for generic R-Car GPIO controller.
+    - "renesas,rcar-gen1-gpio": for a generic R-Car Gen1 GPIO controller.
+    - "renesas,rcar-gen2-gpio": for a generic R-Car Gen2 or RZ/G1 GPIO controller.
+    - "renesas,gpio-rcar": deprecated.
+
+    When compatible with the generic version nodes must list the
+    SoC-specific version corresponding to the platform first followed by
+    the generic version.
 
   - reg: Base address and length of each memory resource used by the GPIO
     controller hardware module.
@@ -42,7 +48,7 @@ interrupt-controller/interrupts.txt.
 Example: R8A7779 (R-Car H1) GPIO controller nodes
 
 	gpio0: gpio at ffc40000 {
-		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7779", "renesas,rcar-gen1-gpio";
 		reg = <0xffc40000 0x2c>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 141 0x4>;
@@ -54,7 +60,7 @@ Example: R8A7779 (R-Car H1) GPIO controller nodes
 	};
 	...
 	gpio6: gpio at ffc46000 {
-		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7779", "renesas,rcar-gen1-gpio";
 		reg = <0xffc46000 0x2c>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 147 0x4>;
diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 9555cd8..c0fd5a5 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -392,6 +392,12 @@ static const struct of_device_id gpio_rcar_of_table[] = {
 		/* Gen3 GPIO is identical to Gen2. */
 		.data = &gpio_rcar_info_gen2,
 	}, {
+		.compatible = "renesas,rcar-gen1-gpio",
+		.data = &gpio_rcar_info_gen1,
+	}, {
+		.compatible = "renesas,rcar-gen2-gpio",
+		.data = &gpio_rcar_info_gen2,
+	}, {
 		.compatible = "renesas,gpio-rcar",
 		.data = &gpio_rcar_info_gen1,
 	}, {
-- 
2.7.4
