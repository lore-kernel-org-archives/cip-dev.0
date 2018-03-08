From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu,  8 Mar 2018 17:54:38 +0000
Subject: [cip-dev] [PATCH 2/3] ARM: dts: r8a7743: Add QSPI support
In-Reply-To: <1520531679-9452-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520531679-9452-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520531679-9452-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add the DT node for the QSPI interface to the SoC dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 450c03718e971880ae067dc5f94a86f961acd6c3)
(changed clocks and power-domains property, removed resets property)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 0cdfb6b..a6f953b 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -28,6 +28,7 @@
 		i2c6 = &iic0;
 		i2c7 = &iic1;
 		i2c8 = &iic3;
+		spi0 = &qspi;
 		spi1 = &msiof0;
 		spi2 = &msiof1;
 		spi3 = &msiof2;
@@ -782,6 +783,21 @@
 			status = "disabled";
 		};
 
+		qspi: spi at e6b10000 {
+			compatible = "renesas,qspi-r8a7743", "renesas,qspi";
+			reg = <0 0xe6b10000 0 0x2c>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7743_CLK_QSPI_MOD>;
+			dmas = <&dmac0 0x17>, <&dmac0 0x18>,
+			       <&dmac1 0x17>, <&dmac1 0x18>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		msiof0: spi at e6e20000 {
 			compatible = "renesas,msiof-r8a7743",
 				     "renesas,rcar-gen2-msiof";
-- 
2.7.4
