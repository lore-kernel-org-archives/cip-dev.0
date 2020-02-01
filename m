From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Sat,  1 Feb 2020 12:26:49 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 01/14] dt-bindings: i2c: rcar: Rename
	bindings documentation file
In-Reply-To: <1580560022-26873-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580560022-26873-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1580560022-26873-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

commit 4e4521f76ff96f83561555f76c50d25314320d10 upstream.

Rename the bindings documentation file for R-Car I2C controller
from i2c-rcar.txt to renesas,i2c.txt.

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
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt | 60 ----------------------
 .../devicetree/bindings/i2c/renesas,i2c.txt        | 60 ++++++++++++++++++++++
 2 files changed, 60 insertions(+), 60 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-rcar.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/renesas,i2c.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
deleted file mode 100644
index c6367d0..0000000
--- a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
+++ /dev/null
@@ -1,60 +0,0 @@
-I2C for R-Car platforms
-
-Required properties:
-- compatible:
-	"renesas,i2c-r8a7743" if the device is a part of a R8A7743 SoC.
-	"renesas,i2c-r8a7745" if the device is a part of a R8A7745 SoC.
-	"renesas,i2c-r8a774a1" if the device is a part of a R8A774A1 SoC.
-	"renesas,i2c-r8a774c0" if the device is a part of a R8A774C0 SoC.
-	"renesas,i2c-r8a7778" if the device is a part of a R8A7778 SoC.
-	"renesas,i2c-r8a7779" if the device is a part of a R8A7779 SoC.
-	"renesas,i2c-r8a7790" if the device is a part of a R8A7790 SoC.
-	"renesas,i2c-r8a7791" if the device is a part of a R8A7791 SoC.
-	"renesas,i2c-r8a7792" if the device is a part of a R8A7792 SoC.
-	"renesas,i2c-r8a7793" if the device is a part of a R8A7793 SoC.
-	"renesas,i2c-r8a7794" if the device is a part of a R8A7794 SoC.
-	"renesas,i2c-r8a7795" if the device is a part of a R8A7795 SoC.
-	"renesas,i2c-r8a7796" if the device is a part of a R8A7796 SoC.
-	"renesas,i2c-r8a77965" if the device is a part of a R8A77965 SoC.
-	"renesas,i2c-r8a77970" if the device is a part of a R8A77970 SoC.
-	"renesas,i2c-r8a77980" if the device is a part of a R8A77980 SoC.
-	"renesas,i2c-r8a77990" if the device is a part of a R8A77990 SoC.
-	"renesas,i2c-r8a77995" if the device is a part of a R8A77995 SoC.
-	"renesas,rcar-gen1-i2c" for a generic R-Car Gen1 compatible device.
-	"renesas,rcar-gen2-i2c" for a generic R-Car Gen2 or RZ/G1 compatible
-				device.
-	"renesas,rcar-gen3-i2c" for a generic R-Car Gen3 or RZ/G2 compatible
-				device.
-	"renesas,i2c-rcar" (deprecated)
-
-	When compatible with the generic version, nodes must list the
-	SoC-specific version corresponding to the platform first followed
-	by the generic version.
-
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- interrupts: interrupt specifier.
-
-Optional properties:
-- clock-frequency: desired I2C bus clock frequency in Hz. The absence of this
-  property indicates the default frequency 100 kHz.
-- clocks: clock specifier.
-- dmas: Must contain a list of two references to DMA specifiers, one for
-  transmission, and one for reception.
-- dma-names: Must contain a list of two DMA names, "tx" and "rx".
-
-- i2c-scl-falling-time-ns: see i2c.txt
-- i2c-scl-internal-delay-ns: see i2c.txt
-- i2c-scl-rising-time-ns: see i2c.txt
-
-Examples :
-
-i2c0: i2c at e6508000 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	compatible = "renesas,i2c-r8a7791", "renesas,rcar-gen2-i2c";
-	reg = <0 0xe6508000 0 0x40>;
-	interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&mstp9_clks R8A7791_CLK_I2C0>;
-	clock-frequency = <400000>;
-};
diff --git a/Documentation/devicetree/bindings/i2c/renesas,i2c.txt b/Documentation/devicetree/bindings/i2c/renesas,i2c.txt
new file mode 100644
index 0000000..c6367d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/renesas,i2c.txt
@@ -0,0 +1,60 @@
+I2C for R-Car platforms
+
+Required properties:
+- compatible:
+	"renesas,i2c-r8a7743" if the device is a part of a R8A7743 SoC.
+	"renesas,i2c-r8a7745" if the device is a part of a R8A7745 SoC.
+	"renesas,i2c-r8a774a1" if the device is a part of a R8A774A1 SoC.
+	"renesas,i2c-r8a774c0" if the device is a part of a R8A774C0 SoC.
+	"renesas,i2c-r8a7778" if the device is a part of a R8A7778 SoC.
+	"renesas,i2c-r8a7779" if the device is a part of a R8A7779 SoC.
+	"renesas,i2c-r8a7790" if the device is a part of a R8A7790 SoC.
+	"renesas,i2c-r8a7791" if the device is a part of a R8A7791 SoC.
+	"renesas,i2c-r8a7792" if the device is a part of a R8A7792 SoC.
+	"renesas,i2c-r8a7793" if the device is a part of a R8A7793 SoC.
+	"renesas,i2c-r8a7794" if the device is a part of a R8A7794 SoC.
+	"renesas,i2c-r8a7795" if the device is a part of a R8A7795 SoC.
+	"renesas,i2c-r8a7796" if the device is a part of a R8A7796 SoC.
+	"renesas,i2c-r8a77965" if the device is a part of a R8A77965 SoC.
+	"renesas,i2c-r8a77970" if the device is a part of a R8A77970 SoC.
+	"renesas,i2c-r8a77980" if the device is a part of a R8A77980 SoC.
+	"renesas,i2c-r8a77990" if the device is a part of a R8A77990 SoC.
+	"renesas,i2c-r8a77995" if the device is a part of a R8A77995 SoC.
+	"renesas,rcar-gen1-i2c" for a generic R-Car Gen1 compatible device.
+	"renesas,rcar-gen2-i2c" for a generic R-Car Gen2 or RZ/G1 compatible
+				device.
+	"renesas,rcar-gen3-i2c" for a generic R-Car Gen3 or RZ/G2 compatible
+				device.
+	"renesas,i2c-rcar" (deprecated)
+
+	When compatible with the generic version, nodes must list the
+	SoC-specific version corresponding to the platform first followed
+	by the generic version.
+
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: interrupt specifier.
+
+Optional properties:
+- clock-frequency: desired I2C bus clock frequency in Hz. The absence of this
+  property indicates the default frequency 100 kHz.
+- clocks: clock specifier.
+- dmas: Must contain a list of two references to DMA specifiers, one for
+  transmission, and one for reception.
+- dma-names: Must contain a list of two DMA names, "tx" and "rx".
+
+- i2c-scl-falling-time-ns: see i2c.txt
+- i2c-scl-internal-delay-ns: see i2c.txt
+- i2c-scl-rising-time-ns: see i2c.txt
+
+Examples :
+
+i2c0: i2c at e6508000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "renesas,i2c-r8a7791", "renesas,rcar-gen2-i2c";
+	reg = <0 0xe6508000 0 0x40>;
+	interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&mstp9_clks R8A7791_CLK_I2C0>;
+	clock-frequency = <400000>;
+};
-- 
2.7.4
