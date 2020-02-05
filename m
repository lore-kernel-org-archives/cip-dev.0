From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Wed,  5 Feb 2020 20:38:53 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 27/35] dt-bindings: usb: renesas_usbhs:
	Rename bindings documentation file
In-Reply-To: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1580935141-1173-28-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

commit 59d7d4c5178d18b58414194271ad85e30ecaff92 upstream.

For consistency with the naming of (most) other documentation files for DT
bindings for Renesas IP blocks rename the Renesas USBHS documentation file
from renesas-usbhs.txt to renesas,usbhs.txt.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
(dropped unsupported compatiable strings)
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/usb/renesas,usbhs.txt      | 52 ++++++++++++++++++++++
 .../devicetree/bindings/usb/renesas_usbhs.txt      | 52 ----------------------
 2 files changed, 52 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,usbhs.txt
 delete mode 100644 Documentation/devicetree/bindings/usb/renesas_usbhs.txt

diff --git a/Documentation/devicetree/bindings/usb/renesas,usbhs.txt b/Documentation/devicetree/bindings/usb/renesas,usbhs.txt
new file mode 100644
index 0000000..8126486
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/renesas,usbhs.txt
@@ -0,0 +1,52 @@
+Renesas Electronics USBHS driver
+
+Required properties:
+  - compatible: Must contain one or more of the following:
+
+	- "renesas,usbhs-r8a7743" for r8a7743 (RZ/G1M) compatible device
+	- "renesas,usbhs-r8a7745" for r8a7745 (RZ/G1E) compatible device
+	- "renesas,usbhs-r8a774a1" for r8a774a1 (RZ/G2M) compatible device
+	- "renesas,usbhs-r8a774c0" for r8a774c0 (RZ/G2E) compatible device
+	- "renesas,usbhs-r8a7790" for r8a7790 (R-Car H2) compatible device
+	- "renesas,usbhs-r8a7791" for r8a7791 (R-Car M2-W) compatible device
+	- "renesas,usbhs-r8a7792" for r8a7792 (R-Car V2H) compatible device
+	- "renesas,usbhs-r8a7793" for r8a7793 (R-Car M2-N) compatible device
+	- "renesas,usbhs-r8a7794" for r8a7794 (R-Car E2) compatible device
+	- "renesas,usbhs-r8a7795" for r8a7795 (R-Car H3) compatible device
+	- "renesas,usbhs-r8a7796" for r8a7796 (R-Car M3-W) compatible device
+	- "renesas,usbhs-r8a77965" for r8a77965 (R-Car M3-N) compatible device
+	- "renesas,usbhs-r8a77995" for r8a77995 (R-Car D3) compatible device
+	- "renesas,usbhs-r7s72100" for r7s72100 (RZ/A1) compatible device
+	- "renesas,rcar-gen2-usbhs" for R-Car Gen2 or RZ/G1 compatible devices
+	- "renesas,rcar-gen3-usbhs" for R-Car Gen3 or RZ/G2 compatible devices
+	- "renesas,rza1-usbhs" for RZ/A1 compatible device
+
+	When compatible with the generic version, nodes must list the
+	SoC-specific version corresponding to the platform first followed
+	by the generic version.
+
+  - reg: Base address and length of the register for the USBHS
+  - interrupts: Interrupt specifier for the USBHS
+  - clocks: A list of phandle + clock specifier pairs.
+	    - In case of "renesas,rcar-gen3-usbhs", two clocks are required.
+	      First clock should be peripheral and second one should be host.
+	    - In case of except above, one clock is required. First clock
+	      should be peripheral.
+
+Optional properties:
+  - renesas,buswait: Integer to use BUSWAIT register
+  - renesas,enable-gpio: A gpio specifier to check GPIO determining if USB
+			 function should be enabled
+  - phys: phandle + phy specifier pair
+  - phy-names: must be "usb"
+  - dmas: Must contain a list of references to DMA specifiers.
+  - dma-names : named "ch%d", where %d is the channel number ranging from zero
+                to the number of channels (DnFIFOs) minus one.
+
+Example:
+	usbhs: usb at e6590000 {
+		compatible = "renesas,usbhs-r8a7790", "renesas,rcar-gen2-usbhs";
+		reg = <0 0xe6590000 0 0x100>;
+		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
+	};
diff --git a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
deleted file mode 100644
index 8126486..0000000
--- a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-Renesas Electronics USBHS driver
-
-Required properties:
-  - compatible: Must contain one or more of the following:
-
-	- "renesas,usbhs-r8a7743" for r8a7743 (RZ/G1M) compatible device
-	- "renesas,usbhs-r8a7745" for r8a7745 (RZ/G1E) compatible device
-	- "renesas,usbhs-r8a774a1" for r8a774a1 (RZ/G2M) compatible device
-	- "renesas,usbhs-r8a774c0" for r8a774c0 (RZ/G2E) compatible device
-	- "renesas,usbhs-r8a7790" for r8a7790 (R-Car H2) compatible device
-	- "renesas,usbhs-r8a7791" for r8a7791 (R-Car M2-W) compatible device
-	- "renesas,usbhs-r8a7792" for r8a7792 (R-Car V2H) compatible device
-	- "renesas,usbhs-r8a7793" for r8a7793 (R-Car M2-N) compatible device
-	- "renesas,usbhs-r8a7794" for r8a7794 (R-Car E2) compatible device
-	- "renesas,usbhs-r8a7795" for r8a7795 (R-Car H3) compatible device
-	- "renesas,usbhs-r8a7796" for r8a7796 (R-Car M3-W) compatible device
-	- "renesas,usbhs-r8a77965" for r8a77965 (R-Car M3-N) compatible device
-	- "renesas,usbhs-r8a77995" for r8a77995 (R-Car D3) compatible device
-	- "renesas,usbhs-r7s72100" for r7s72100 (RZ/A1) compatible device
-	- "renesas,rcar-gen2-usbhs" for R-Car Gen2 or RZ/G1 compatible devices
-	- "renesas,rcar-gen3-usbhs" for R-Car Gen3 or RZ/G2 compatible devices
-	- "renesas,rza1-usbhs" for RZ/A1 compatible device
-
-	When compatible with the generic version, nodes must list the
-	SoC-specific version corresponding to the platform first followed
-	by the generic version.
-
-  - reg: Base address and length of the register for the USBHS
-  - interrupts: Interrupt specifier for the USBHS
-  - clocks: A list of phandle + clock specifier pairs.
-	    - In case of "renesas,rcar-gen3-usbhs", two clocks are required.
-	      First clock should be peripheral and second one should be host.
-	    - In case of except above, one clock is required. First clock
-	      should be peripheral.
-
-Optional properties:
-  - renesas,buswait: Integer to use BUSWAIT register
-  - renesas,enable-gpio: A gpio specifier to check GPIO determining if USB
-			 function should be enabled
-  - phys: phandle + phy specifier pair
-  - phy-names: must be "usb"
-  - dmas: Must contain a list of references to DMA specifiers.
-  - dma-names : named "ch%d", where %d is the channel number ranging from zero
-                to the number of channels (DnFIFOs) minus one.
-
-Example:
-	usbhs: usb at e6590000 {
-		compatible = "renesas,usbhs-r8a7790", "renesas,rcar-gen2-usbhs";
-		reg = <0 0xe6590000 0 0x100>;
-		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
-	};
-- 
2.7.4
