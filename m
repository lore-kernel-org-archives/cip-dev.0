From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu,  8 Mar 2018 17:28:06 +0000
Subject: [cip-dev] [PATCH 1/4] spi: sh-msiof: Add R-Car Gen 2 and 3 fallback
	bindings
In-Reply-To: <1520530089-4988-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520530089-4988-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520530089-4988-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

In the case of Renesas R-Car hardware we know that there are generations of
SoCs, e.g. Gen 2 and Gen 3. But beyond that it's not clear what the
relationship between IP blocks might be. For example, I believe that
r8a7790 is older than r8a7791 but that doesn't imply that the latter is a
descendant of the former or vice versa.

We can, however, by examining the documentation and behaviour of the
hardware at run-time observe that the current driver implementation appears
to be compatible with the IP blocks on SoCs within a given generation.

For the above reasons and convenience when enabling new SoCs a
per-generation fallback compatibility string scheme is being adopted for
drivers for Renesas SoCs.

Also:
* Deprecate renesas,sh-msiof. It seems poorly named as it is only
  compatible with SH-Mobile. It also appears unused in mainline.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
(cherry picked from commit 4286db8456f4fa0c6af2b6b9abc5991a7e7da69c)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
(cherry picked from commit 77f252646eb0ec1e78847fe5725c98ee9e70b39e)
(removed "renesas,rcar-gen3-msiof")
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/spi/sh-msiof.txt | 18 ++++++++++++------
 drivers/spi/spi-sh-msiof.c                         |  3 ++-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index 705075d..ef65d54 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -1,15 +1,20 @@
 Renesas MSIOF spi controller
 
 Required properties:
-- compatible           : "renesas,msiof-<soctype>" for SoCs,
-			 "renesas,sh-msiof" for SuperH, or
-			 "renesas,sh-mobile-msiof" for SH Mobile series.
-			 Examples with soctypes are:
-			 "renesas,msiof-r8a7790" (R-Car H2)
+- compatible           : "renesas,msiof-r8a7790" (R-Car H2)
 			 "renesas,msiof-r8a7791" (R-Car M2-W)
 			 "renesas,msiof-r8a7792" (R-Car V2H)
 			 "renesas,msiof-r8a7793" (R-Car M2-N)
 			 "renesas,msiof-r8a7794" (R-Car E2)
+			 "renesas,sh-mobile-msiof" (generic SH-Mobile compatibile device)
+			 "renesas,rcar-gen2-msiof" (generic R-Car Gen2 compatible device)
+			 "renesas,sh-msiof"      (deprecated)
+
+			 When compatible with the generic version, nodes
+			 must list the SoC-specific version corresponding
+			 to the platform first followed by the generic
+			 version.
+
 - reg                  : A list of offsets and lengths of the register sets for
 			 the device.
 			 If only one register set is present, it is to be used
@@ -59,7 +64,8 @@ Documentation/devicetree/bindings/pinctrl/renesas,*.
 Example:
 
 	msiof0: spi at e6e20000 {
-		compatible = "renesas,msiof-r8a7791";
+		compatible = "renesas,msiof-r8a7791",
+			     "renesas,rcar-gen2-msiof";
 		reg = <0 0xe6e20000 0 0x0064>;
 		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7791_CLK_MSIOF0>;
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 3de39bd..e190b33 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -974,13 +974,14 @@ static const struct sh_msiof_chipdata r8a779x_data = {
 };
 
 static const struct of_device_id sh_msiof_match[] = {
-	{ .compatible = "renesas,sh-msiof",        .data = &sh_data },
 	{ .compatible = "renesas,sh-mobile-msiof", .data = &sh_data },
 	{ .compatible = "renesas,msiof-r8a7790",   .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7791",   .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7792",   .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7793",   .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7794",   .data = &r8a779x_data },
+	{ .compatible = "renesas,rcar-gen2-msiof", .data = &r8a779x_data },
+	{ .compatible = "renesas,sh-msiof",        .data = &sh_data }, // Deprecated
 	{},
 };
 MODULE_DEVICE_TABLE(of, sh_msiof_match);
-- 
2.7.4
