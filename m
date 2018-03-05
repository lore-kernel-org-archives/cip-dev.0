From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  5 Mar 2018 11:39:08 +0000
Subject: [cip-dev] [PATCH 04/10] ARM: dts: r8a7743: Add internal PCI bridge
	nodes
In-Reply-To: <1520249954-29357-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520249954-29357-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520249954-29357-5-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

Add device nodes for the r8a7743 internal PCI bridge devices.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 46d9cf5202fd8cd266748779c1a941aaeff0dcad)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 50 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 8515abf..d90310c 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -1184,6 +1184,56 @@
 						     "scifa5";
 			};
 		};
+
+		pci0: pci at ee090000 {
+			compatible = "renesas,pci-r8a7743",
+				     "renesas,pci-rcar-gen2";
+			device_type = "pci";
+			reg = <0 0xee090000 0 0xc00>,
+			      <0 0xee080000 0 0x1100>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A7743_CLK_USB_EHCI>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+
+			bus-range = <0 0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges = <0x02000000 0 0xee080000 0 0xee080000 0
+				  0x00010000>;
+			interrupt-map-mask = <0xff00 0 0 0x7>;
+			interrupt-map = <
+			    0x0000 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
+			    0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
+			    0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
+			>;
+		};
+
+		pci1: pci at ee0d0000 {
+			compatible = "renesas,pci-r8a7743",
+				     "renesas,pci-rcar-gen2";
+			device_type = "pci";
+			reg = <0 0xee0d0000 0 0xc00>,
+			      <0 0xee0c0000 0 0x1100>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A7743_CLK_USB_EHCI>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+
+			bus-range = <1 1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges = <0x02000000 0 0xee0c0000 0 0xee0c0000 0
+				  0x00010000>;
+			interrupt-map-mask = <0xff00 0 0 0x7>;
+			interrupt-map = <
+			    0x0000 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
+			    0x0800 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
+			    0x1000 0 0 2 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
+			>;
+		};
 	};
 
 	/* External root clock */
-- 
2.7.4
