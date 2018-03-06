From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  6 Mar 2018 11:34:44 +0000
Subject: [cip-dev] [PATCH 4/7] ARM: dts: r8a7743: Add HS-USB device node
In-Reply-To: <1520336087-12870-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520336087-12870-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520336087-12870-5-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

Define the R8A7743 generic part of the HS-USB device node. It is up to the
board file to enable the device.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 4b4a3b1c33b7a389d90624683d8f1a8d1dc2affa)
(modified clocks, power-domains properties and removed resets property)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 1b17a20..1237746 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -1185,6 +1185,19 @@
 			};
 		};
 
+		hsusb: usb at e6590000 {
+			compatible = "renesas,usbhs-r8a7743",
+				     "renesas,rcar-gen2-usbhs";
+			reg = <0 0xe6590000 0 0x100>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A7743_CLK_HSUSB>;
+			power-domains = <&cpg_clocks>;
+			renesas,buswait = <4>;
+			phys = <&usb0 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
 		usbphy: usb-phy at e6590100 {
 			compatible = "renesas,usb-phy-r8a7743",
 				     "renesas,rcar-gen2-usb-phy";
-- 
2.7.4
