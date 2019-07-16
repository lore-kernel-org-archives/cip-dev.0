From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 16 Jul 2019 07:42:20 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 4/5] ARM: dts: r8a77470: Add QSPI support
In-Reply-To: <1563259341-37180-1-git-send-email-biju.das@bp.renesas.com>
References: <1563259341-37180-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563259341-37180-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit b6239d4219643bd1ac1d0b5a0faedf69cd2a2bfa upstream.

Add QSPI[01] support to the RZ/G1C SoC specific device tree.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a77470.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
index 8cc15e6..a10afa2 100644
--- a/arch/arm/boot/dts/r8a77470.dtsi
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -287,6 +287,36 @@
 			status = "disabled";
 		};
 
+		qspi0: spi at e6b10000 {
+			compatible = "renesas,qspi-r8a77470", "renesas,qspi";
+			reg = <0 0xe6b10000 0 0x2c>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A77470_CLK_QUAD_SPI0>;
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
+		qspi1: spi at ee200000 {
+			compatible = "renesas,qspi-r8a77470", "renesas,qspi";
+			reg = <0 0xee200000 0 0x2c>;
+			interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A77470_CLK_QUAD_SPI1>;
+			dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
+			       <&dmac1 0xd1>, <&dmac1 0xd2>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		scif0: serial at e6e60000 {
 			compatible = "renesas,scif-r8a77470", "renesas,scif";
 			reg = <0 0xe6e60000 0 0x40>;
-- 
2.7.4
