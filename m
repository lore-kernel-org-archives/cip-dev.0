From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 28 Aug 2019 09:48:20 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 02/17] dt-bindings: phy: rcar-gen2: Add
	r8a77470 support
In-Reply-To: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
References: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1566982115-11148-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit f56511d0080ce33a17f7192a3f43d65e614da5cf upstream.

Add USB PHY support for r8a77470 SoC. Renesas RZ/G1C (R8A77470)
USB PHY is similar to the R-Car Gen2 family, but has the below
feature compared to other RZ/G1 and R-Car Gen2/3 SoCs

It has a shared pll reset for usbphy0/usbphy1 and this register
reside in usbphy0 block.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
[Reworked clocks and power-domains properties]
---
 .../devicetree/bindings/phy/rcar-gen2-phy.txt      | 47 +++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt b/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
index f38f42b..35c51d8 100644
--- a/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
+++ b/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
@@ -7,6 +7,7 @@ Required properties:
 - compatible: "renesas,usb-phy-r8a7743" if the device is a part of R8A7743 SoC.
 	      "renesas,usb-phy-r8a7744" if the device is a part of R8A7744 SoC.
 	      "renesas,usb-phy-r8a7745" if the device is a part of R8A7745 SoC.
+	      "renesas,usb-phy-r8a77470" if the device is a part of R8A77470 SoC.
 	      "renesas,usb-phy-r8a7790" if the device is a part of R8A7790 SoC.
 	      "renesas,usb-phy-r8a7791" if the device is a part of R8A7791 SoC.
 	      "renesas,usb-phy-r8a7794" if the device is a part of R8A7794 SoC.
@@ -29,7 +30,7 @@ channels. These subnodes must contain the following properties:
 - #phy-cells: see phy-bindings.txt in the same directory, must be <1>.
 
 The phandle's argument in the PHY specifier is the USB controller selector for
-the USB channel; see the selector meanings below:
+the USB channel other than r8a77470 SoC; see the selector meanings below:
 
 +-----------+---------------+---------------+
 |\ Selector |               |               |
@@ -40,6 +41,16 @@ the USB channel; see the selector meanings below:
 | 2         | PCI EHCI/OHCI | xHCI          |
 +-----------+---------------+---------------+
 
+For r8a77470 SoC;see the selector meaning below:
+
++-----------+---------------+---------------+
+|\ Selector |               |               |
++ --------- +       0       |       1       |
+| Channel  \|               |               |
++-----------+---------------+---------------+
+| 0         | EHCI/OHCI     | HS-USB        |
++-----------+---------------+---------------+
+
 Example (Lager board):
 
 	usb-phy at e6590100 {
@@ -59,3 +70,37 @@ Example (Lager board):
 			#phy-cells = <1>;
 		};
 	};
+
+Example (iWave RZ/G1C sbc):
+
+	usbphy0: usb-phy0 at e6590100 {
+		compatible = "renesas,usb-phy-r8a77470",
+			     "renesas,rcar-gen2-usb-phy";
+		reg = <0 0xe6590100 0 0x100>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&mstp7_clks R8A77470_CLK_USBHS0>;
+		clock-names = "usbhs";
+		power-domains = <&cpg_clocks>;
+
+		usb0: usb-channel at 0 {
+			reg = <0>;
+			#phy-cells = <1>;
+		};
+	};
+
+	usbphy1: usb-phy at e6598100 {
+		compatible = "renesas,usb-phy-r8a77470",
+			     "renesas,rcar-gen2-usb-phy";
+		reg = <0 0xe6598100 0 0x100>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&mstp7_clks R8A77470_CLK_USBHS1>;
+		clock-names = "usbhs";
+		power-domains = <&cpg_clocks>;
+
+		usb1: usb-channel at 0 {
+			reg = <0>;
+			#phy-cells = <1>;
+		};
+	};
-- 
2.7.4
