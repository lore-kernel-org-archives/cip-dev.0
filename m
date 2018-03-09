From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri,  9 Mar 2018 09:57:03 +0000
Subject: [cip-dev] [PATCH 3/4] ARM: dts: r8a7743: Add xhci support to SoC
	dtsi
In-Reply-To: <1520589424-15807-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520589424-15807-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520589424-15807-4-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add node for xhci. Boards DT files will enable it if needed.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit b6d3b649441936621c87b79bff8dd436e2397e3c)
(modified clocks and power-domains properties, removed resets property)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index a6f953b..822757e 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -843,6 +843,24 @@
 			status = "disabled";
 		};
 
+		/*
+		 * pci1 and xhci share the same phy, therefore only one of them
+		 * can be active at any one time. If both of them are enabled,
+		 * a race condition will determine who'll control the phy.
+		 * A firmware file is needed by the xhci driver in order for
+		 * USB 3.0 to work properly.
+		 */
+		xhci: usb at ee000000 {
+			compatible = "renesas,xhci-r8a7743";
+			reg = <0 0xee000000 0 0xc00>;
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A7743_CLK_SSUSB>;
+			power-domains = <&cpg_clocks>;
+			phys = <&usb2 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
 		clocks {
 			#address-cells = <2>;
 			#size-cells = <2>;
-- 
2.7.4
