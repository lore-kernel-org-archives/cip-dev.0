From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  1 Feb 2018 13:46:24 +0000
Subject: [cip-dev] [PATCH 2/7] i2c: rcar: Add per-Generation fallback
	bindings
In-Reply-To: <1517492789-44830-1-git-send-email-biju.das@bp.renesas.com>
References: <1517492789-44830-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1517492789-44830-3-git-send-email-biju.das@bp.renesas.com>
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
* Deprecate renesas,i2c-rcar. It seems poorly named as it is only
  compatible with R-Car Gen 1. It also appears unused in mainline.
* Add some text to describe per-SoC bindings

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
(cherry picked from commit ad4a8dc3fec6485b18654d1090ef8012fcfc37b8)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>

 Conflicts:
	Documentation/devicetree/bindings/i2c/i2c-rcar.txt
	drivers/i2c/busses/i2c-rcar.c
---
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt | 30 ++++++++++++++--------
 drivers/i2c/busses/i2c-rcar.c                      |  5 +++-
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
index dea14f7..e26f224 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
@@ -1,16 +1,24 @@
 I2C for R-Car platforms
 
 Required properties:
-- compatible: Must be one of
-	"renesas,i2c-rcar"
-	"renesas,i2c-r8a7778"
-	"renesas,i2c-r8a7779"
-	"renesas,i2c-r8a7790"
-	"renesas,i2c-r8a7791"
-	"renesas,i2c-r8a7792"
-	"renesas,i2c-r8a7793"
-	"renesas,i2c-r8a7794"
-	"renesas,i2c-r8a7795"
+- compatible:
+	"renesas,i2c-r8a7778" if the device is a part of a R8A7778 SoC.
+	"renesas,i2c-r8a7779" if the device is a part of a R8A7779 SoC.
+	"renesas,i2c-r8a7790" if the device is a part of a R8A7790 SoC.
+	"renesas,i2c-r8a7791" if the device is a part of a R8A7791 SoC.
+	"renesas,i2c-r8a7792" if the device is a part of a R8A7792 SoC.
+	"renesas,i2c-r8a7793" if the device is a part of a R8A7793 SoC.
+	"renesas,i2c-r8a7794" if the device is a part of a R8A7794 SoC.
+	"renesas,i2c-r8a7795" if the device is a part of a R8A7795 SoC.
+	"renesas,rcar-gen1-i2c" for a generic R-Car Gen1 compatible device.
+	"renesas,rcar-gen2-i2c" for a generic R-Car Gen2 compatible device.
+	"renesas,rcar-gen3-i2c" for a generic R-Car Gen3 compatible device.
+	"renesas,i2c-rcar" (deprecated)
+
+	When compatible with the generic version, nodes must list the
+	SoC-specific version corresponding to the platform first followed
+	by the generic version.
+
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: interrupt specifier.
@@ -25,7 +33,7 @@ Examples :
 i2c0: i2c at e6508000 {
 	#address-cells = <1>;
 	#size-cells = <0>;
-	compatible = "renesas,i2c-r8a7791";
+	compatible = "renesas,i2c-r8a7791", "renesas,rcar-gen2-i2c";
 	reg = <0 0xe6508000 0 0x40>;
 	interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
 	clocks = <&mstp9_clks R8A7791_CLK_I2C0>;
diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 599c0d7..aa3730d 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -618,7 +618,6 @@ static const struct i2c_algorithm rcar_i2c_algo = {
 };
 
 static const struct of_device_id rcar_i2c_dt_ids[] = {
-	{ .compatible = "renesas,i2c-rcar", .data = (void *)I2C_RCAR_GEN1 },
 	{ .compatible = "renesas,i2c-r8a7778", .data = (void *)I2C_RCAR_GEN1 },
 	{ .compatible = "renesas,i2c-r8a7779", .data = (void *)I2C_RCAR_GEN1 },
 	{ .compatible = "renesas,i2c-r8a7790", .data = (void *)I2C_RCAR_GEN2 },
@@ -627,6 +626,10 @@ static const struct of_device_id rcar_i2c_dt_ids[] = {
 	{ .compatible = "renesas,i2c-r8a7793", .data = (void *)I2C_RCAR_GEN2 },
 	{ .compatible = "renesas,i2c-r8a7794", .data = (void *)I2C_RCAR_GEN2 },
 	{ .compatible = "renesas,i2c-r8a7795", .data = (void *)I2C_RCAR_GEN3 },
+	{ .compatible = "renesas,i2c-rcar", .data = (void *)I2C_RCAR_GEN1 },	/* Deprecated */
+	{ .compatible = "renesas,rcar-gen1-i2c", .data = (void *)I2C_RCAR_GEN1 },
+	{ .compatible = "renesas,rcar-gen2-i2c", .data = (void *)I2C_RCAR_GEN2 },
+	{ .compatible = "renesas,rcar-gen3-i2c", .data = (void *)I2C_RCAR_GEN3 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rcar_i2c_dt_ids);
-- 
2.7.4
