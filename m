From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Wed,  5 Feb 2020 20:38:57 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 31/35] dt-bindings: usb: renesas_gen3:
	Rename bindings documentation file to reflect IP block
In-Reply-To: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1580935141-1173-32-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

commit 92b8608691bf129b1137be46a3a0058bcacc97a9 upstream.

For consistency with the naming of (most) other documentation files for DT
bindings for Renesas IP blocks rename the Renesas USB3.0 peripheral
documentation file from renesas,usb3.txt to renesas,usb3-peri.txt

This refines a recent rename from renesas_usb3.txt to renesas,usb3.txt.
The motivation is to more accurately reflect the IP block documented in
this file.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas Sderlund <niklas.soderlund+renesas@ragnatech.se>
Link: https://lore.kernel.org/r/20190809213710.31783-1-horms+renesas at verge.net.au
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(dropped unsupported compatiable strings)
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/usb/renesas,usb3-peri.txt  | 40 ++++++++++++++++++++++
 .../devicetree/bindings/usb/renesas_usb3.txt       | 40 ----------------------
 2 files changed, 40 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,usb3-peri.txt
 delete mode 100644 Documentation/devicetree/bindings/usb/renesas_usb3.txt

diff --git a/Documentation/devicetree/bindings/usb/renesas,usb3-peri.txt b/Documentation/devicetree/bindings/usb/renesas,usb3-peri.txt
new file mode 100644
index 0000000..9551e8c
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/renesas,usb3-peri.txt
@@ -0,0 +1,40 @@
+Renesas Electronics USB3.0 Peripheral driver
+
+Required properties:
+  - compatible: Must contain one of the following:
+	- "renesas,r8a774a1-usb3-peri"
+	- "renesas,r8a774c0-usb3-peri"
+	- "renesas,r8a7795-usb3-peri"
+	- "renesas,r8a7796-usb3-peri"
+	- "renesas,r8a77965-usb3-peri"
+	- "renesas,rcar-gen3-usb3-peri" for a generic R-Car Gen3 or RZ/G2
+	  compatible device
+
+    When compatible with the generic version, nodes must list the
+    SoC-specific version corresponding to the platform first
+    followed by the generic version.
+
+  - reg: Base address and length of the register for the USB3.0 Peripheral
+  - interrupts: Interrupt specifier for the USB3.0 Peripheral
+  - clocks: clock phandle and specifier pair
+
+Optional properties:
+  - phys: phandle + phy specifier pair
+  - phy-names: must be "usb"
+
+Example of R-Car H3 ES1.x:
+	usb3_peri0: usb at ee020000 {
+		compatible = "renesas,r8a7795-usb3-peri",
+			     "renesas,rcar-gen3-usb3-peri";
+		reg = <0 0xee020000 0 0x400>;
+		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg CPG_MOD 328>;
+	};
+
+	usb3_peri1: usb at ee060000 {
+		compatible = "renesas,r8a7795-usb3-peri",
+			     "renesas,rcar-gen3-usb3-peri";
+		reg = <0 0xee060000 0 0x400>;
+		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg CPG_MOD 327>;
+	};
diff --git a/Documentation/devicetree/bindings/usb/renesas_usb3.txt b/Documentation/devicetree/bindings/usb/renesas_usb3.txt
deleted file mode 100644
index 9551e8c..0000000
--- a/Documentation/devicetree/bindings/usb/renesas_usb3.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-Renesas Electronics USB3.0 Peripheral driver
-
-Required properties:
-  - compatible: Must contain one of the following:
-	- "renesas,r8a774a1-usb3-peri"
-	- "renesas,r8a774c0-usb3-peri"
-	- "renesas,r8a7795-usb3-peri"
-	- "renesas,r8a7796-usb3-peri"
-	- "renesas,r8a77965-usb3-peri"
-	- "renesas,rcar-gen3-usb3-peri" for a generic R-Car Gen3 or RZ/G2
-	  compatible device
-
-    When compatible with the generic version, nodes must list the
-    SoC-specific version corresponding to the platform first
-    followed by the generic version.
-
-  - reg: Base address and length of the register for the USB3.0 Peripheral
-  - interrupts: Interrupt specifier for the USB3.0 Peripheral
-  - clocks: clock phandle and specifier pair
-
-Optional properties:
-  - phys: phandle + phy specifier pair
-  - phy-names: must be "usb"
-
-Example of R-Car H3 ES1.x:
-	usb3_peri0: usb at ee020000 {
-		compatible = "renesas,r8a7795-usb3-peri",
-			     "renesas,rcar-gen3-usb3-peri";
-		reg = <0 0xee020000 0 0x400>;
-		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 328>;
-	};
-
-	usb3_peri1: usb at ee060000 {
-		compatible = "renesas,r8a7795-usb3-peri",
-			     "renesas,rcar-gen3-usb3-peri";
-		reg = <0 0xee060000 0 0x400>;
-		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 327>;
-	};
-- 
2.7.4
