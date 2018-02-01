From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  1 Feb 2018 13:46:27 +0000
Subject: [cip-dev] [PATCH 5/7] i2c: sh_mobile: Add per-Generation fallback
	bindings
In-Reply-To: <1517492789-44830-1-git-send-email-biju.das@bp.renesas.com>
References: <1517492789-44830-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1517492789-44830-6-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

Add per-Generation fallback bindings for R-Car SoCs.

This is in keeping with the compatibility string scheme is being adopted
for drivers for Renesas SoCs.

Also, improve readability by listing the rmobile fallback compatibility
string after the more-specific compatibility strings they provide a
fallback for.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
(cherry picked from commit b880ccaf1742c28e91534ad7820c4405c04dabf9)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
---
 Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt | 17 ++++++++++++++---
 drivers/i2c/busses/i2c-sh_mobile.c                      |  4 +++-
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
index 214f94c..7716acc 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
@@ -1,8 +1,7 @@
 Device tree configuration for Renesas IIC (sh_mobile) driver
 
 Required properties:
-- compatible      : "renesas,iic-<soctype>". "renesas,rmobile-iic" as fallback
-		     Examples with soctypes are:
+- compatible      :
 			- "renesas,iic-r8a73a4" (R-Mobile APE6)
 			- "renesas,iic-r8a7740" (R-Mobile A1)
 			- "renesas,iic-r8a7790" (R-Car H2)
@@ -12,6 +11,17 @@ Required properties:
 			- "renesas,iic-r8a7794" (R-Car E2)
 			- "renesas,iic-r8a7795" (R-Car H3)
 			- "renesas,iic-sh73a0" (SH-Mobile AG5)
+			- "renesas,rcar-gen2-iic" (generic R-Car Gen2 compatible device)
+			- "renesas,rcar-gen3-iic" (generic R-Car Gen3 compatible device)
+			- "renesas,rmobile-iic" (generic device)
+
+			When compatible with a generic R-Car version, nodes
+			must list the SoC-specific version corresponding to
+			the platform first followed by the generic R-Car
+			version.
+
+			renesas,rmobile-iic must always follow.
+
 - reg             : address start and address range size of device
 - interrupts      : interrupt of device
 - clocks          : clock for device
@@ -31,7 +41,8 @@ Pinctrl properties might be needed, too. See there.
 Example:
 
 	iic0: i2c at e6500000 {
-		compatible = "renesas,iic-r8a7790", "renesas,rmobile-iic";
+		compatible = "renesas,iic-r8a7790", "renesas,rcar-gen2-iic",
+			     "renesas,rmobile-iic";
 		reg = <0 0xe6500000 0 0x425>;
 		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_IIC0>;
diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 7d2bd3e..3eb5167 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -828,7 +828,6 @@ static const struct sh_mobile_dt_config r8a7740_dt_config = {
 };
 
 static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
-	{ .compatible = "renesas,rmobile-iic", .data = &default_dt_config },
 	{ .compatible = "renesas,iic-r8a73a4", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7740", .data = &r8a7740_dt_config },
 	{ .compatible = "renesas,iic-r8a7790", .data = &fast_clock_dt_config },
@@ -836,8 +835,11 @@ static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
 	{ .compatible = "renesas,iic-r8a7792", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7793", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7794", .data = &fast_clock_dt_config },
+	{ .compatible = "renesas,rcar-gen2-iic", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7795", .data = &fast_clock_dt_config },
+	{ .compatible = "renesas,rcar-gen3-iic", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-sh73a0", .data = &fast_clock_dt_config },
+	{ .compatible = "renesas,rmobile-iic", .data = &default_dt_config },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sh_mobile_i2c_dt_ids);
-- 
2.7.4
