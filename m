From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Sat,  1 Feb 2020 12:26:51 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 03/14] dt-bindings: i2c: sh_mobile:
	Rename bindings documentation file
In-Reply-To: <1580560022-26873-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580560022-26873-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1580560022-26873-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

commit 23c2556d8fbec57e72e2c8fd8b7be2715c192b25 upstream.

Rename the bindings documentation file for sh_mobile I2C controller
from i2c-sh_mobile.txt to renesas,iic.txt.

This is part of an ongoing effort to name bindings documentation files for
Renesas IP blocks consistently, in line with the compat strings they
document.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
(dropped unsupported compatible strings. dropped updating MAINTAINERS
file since the entry didnt exist)
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/i2c/i2c-sh_mobile.txt      | 67 ----------------------
 .../devicetree/bindings/i2c/renesas,iic.txt        | 67 ++++++++++++++++++++++
 2 files changed, 67 insertions(+), 67 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/renesas,iic.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
deleted file mode 100644
index 392162a..0000000
--- a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
+++ /dev/null
@@ -1,67 +0,0 @@
-Device tree configuration for Renesas IIC (sh_mobile) driver
-
-Required properties:
-- compatible      :
-			- "renesas,iic-r8a73a4" (R-Mobile APE6)
-			- "renesas,iic-r8a7740" (R-Mobile A1)
-			- "renesas,iic-r8a7743" (RZ/G1M)
-			- "renesas,iic-r8a7745" (RZ/G1E)
-			- "renesas,iic-r8a774a1" (RZ/G2M)
-			- "renesas,iic-r8a774c0" (RZ/G2E)
-			- "renesas,iic-r8a7790" (R-Car H2)
-			- "renesas,iic-r8a7791" (R-Car M2-W)
-			- "renesas,iic-r8a7792" (R-Car V2H)
-			- "renesas,iic-r8a7793" (R-Car M2-N)
-			- "renesas,iic-r8a7794" (R-Car E2)
-			- "renesas,iic-r8a7795" (R-Car H3)
-			- "renesas,iic-r8a7796" (R-Car M3-W)
-			- "renesas,iic-r8a77965" (R-Car M3-N)
-			- "renesas,iic-r8a77990" (R-Car E3)
-			- "renesas,iic-sh73a0" (SH-Mobile AG5)
-			- "renesas,rcar-gen2-iic" (generic R-Car Gen2 or RZ/G1
-							compatible device)
-			- "renesas,rcar-gen3-iic" (generic R-Car Gen3 or RZ/G2
-							compatible device)
-			- "renesas,rmobile-iic" (generic device)
-
-			When compatible with a generic R-Car version, nodes
-			must list the SoC-specific version corresponding to
-			the platform first followed by the generic R-Car
-			version.
-
-			When compatible with "renesas,rmobile-iic" it should
-			be the last compatibility string listed.
-
-			The r8a77990 (R-Car E3) and r8a774c0 (RZ/G2E)
-			controllers are not considered compatible with
-			"renesas,rcar-gen3-iic" or "renesas,rmobile-iic"
-			due to the absence of automatic transmission registers.
-
-- reg             : address start and address range size of device
-- interrupts      : interrupt of device
-- clocks          : clock for device
-- #address-cells  : should be <1>
-- #size-cells     : should be <0>
-
-Optional properties:
-- clock-frequency : frequency of bus clock in Hz. Default 100kHz if unset.
-- dmas            : Must contain a list of two references to DMA
-		    specifiers, one for transmission, and one for
-		    reception.
-- dma-names       : Must contain a list of two DMA names, "tx" and "rx".
-
-
-Pinctrl properties might be needed, too. See there.
-
-Example:
-
-	iic0: i2c at e6500000 {
-		compatible = "renesas,iic-r8a7790", "renesas,rcar-gen2-iic",
-			     "renesas,rmobile-iic";
-		reg = <0 0xe6500000 0 0x425>;
-		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7790_CLK_IIC0>;
-		clock-frequency = <400000>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/i2c/renesas,iic.txt b/Documentation/devicetree/bindings/i2c/renesas,iic.txt
new file mode 100644
index 0000000..392162a
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/renesas,iic.txt
@@ -0,0 +1,67 @@
+Device tree configuration for Renesas IIC (sh_mobile) driver
+
+Required properties:
+- compatible      :
+			- "renesas,iic-r8a73a4" (R-Mobile APE6)
+			- "renesas,iic-r8a7740" (R-Mobile A1)
+			- "renesas,iic-r8a7743" (RZ/G1M)
+			- "renesas,iic-r8a7745" (RZ/G1E)
+			- "renesas,iic-r8a774a1" (RZ/G2M)
+			- "renesas,iic-r8a774c0" (RZ/G2E)
+			- "renesas,iic-r8a7790" (R-Car H2)
+			- "renesas,iic-r8a7791" (R-Car M2-W)
+			- "renesas,iic-r8a7792" (R-Car V2H)
+			- "renesas,iic-r8a7793" (R-Car M2-N)
+			- "renesas,iic-r8a7794" (R-Car E2)
+			- "renesas,iic-r8a7795" (R-Car H3)
+			- "renesas,iic-r8a7796" (R-Car M3-W)
+			- "renesas,iic-r8a77965" (R-Car M3-N)
+			- "renesas,iic-r8a77990" (R-Car E3)
+			- "renesas,iic-sh73a0" (SH-Mobile AG5)
+			- "renesas,rcar-gen2-iic" (generic R-Car Gen2 or RZ/G1
+							compatible device)
+			- "renesas,rcar-gen3-iic" (generic R-Car Gen3 or RZ/G2
+							compatible device)
+			- "renesas,rmobile-iic" (generic device)
+
+			When compatible with a generic R-Car version, nodes
+			must list the SoC-specific version corresponding to
+			the platform first followed by the generic R-Car
+			version.
+
+			When compatible with "renesas,rmobile-iic" it should
+			be the last compatibility string listed.
+
+			The r8a77990 (R-Car E3) and r8a774c0 (RZ/G2E)
+			controllers are not considered compatible with
+			"renesas,rcar-gen3-iic" or "renesas,rmobile-iic"
+			due to the absence of automatic transmission registers.
+
+- reg             : address start and address range size of device
+- interrupts      : interrupt of device
+- clocks          : clock for device
+- #address-cells  : should be <1>
+- #size-cells     : should be <0>
+
+Optional properties:
+- clock-frequency : frequency of bus clock in Hz. Default 100kHz if unset.
+- dmas            : Must contain a list of two references to DMA
+		    specifiers, one for transmission, and one for
+		    reception.
+- dma-names       : Must contain a list of two DMA names, "tx" and "rx".
+
+
+Pinctrl properties might be needed, too. See there.
+
+Example:
+
+	iic0: i2c at e6500000 {
+		compatible = "renesas,iic-r8a7790", "renesas,rcar-gen2-iic",
+			     "renesas,rmobile-iic";
+		reg = <0 0xe6500000 0 0x425>;
+		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_IIC0>;
+		clock-frequency = <400000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
-- 
2.7.4
