From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 29 Jan 2020 14:29:59 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 06/12] arm64: dts: renesas: r8a774b1:
	Add PCIe device nodes
In-Reply-To: <1580308205-20435-1-git-send-email-biju.das@bp.renesas.com>
References: <1580308205-20435-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1580308205-20435-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit b3ddadfa28315c6417866eac35a3aee67fc06aa3 upstream.

This patch adds PCIe{0,1} device nodes for R8A774B1 SoC.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Link: https://lore.kernel.org/r/1570178133-21532-7-git-send-email-fabrizio.castro at bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi | 42 +++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
index aede2b3..2e6bca7 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
@@ -811,19 +811,57 @@
 		};
 
 		pciec0: pcie at fe000000 {
+			compatible = "renesas,pcie-r8a774b1",
+				     "renesas,pcie-rcar-gen3";
 			reg = <0 0xfe000000 0 0x80000>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			bus-range = <0x00 0xff>;
-			/* placeholder */
+			device_type = "pci";
+			ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000
+				  0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000
+				  0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
+				  0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
+			/* Map all possible DDR as inbound ranges */
+			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000>;
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 319>, <&pcie_bus_clk>;
+			clock-names = "pcie", "pcie_bus";
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 319>;
+			status = "disabled";
 		};
 
 		pciec1: pcie at ee800000 {
+			compatible = "renesas,pcie-r8a774b1",
+				     "renesas,pcie-rcar-gen3";
 			reg = <0 0xee800000 0 0x80000>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			bus-range = <0x00 0xff>;
-			/* placeholder */
+			device_type = "pci";
+			ranges = <0x01000000 0 0x00000000 0 0xee900000 0 0x00100000
+				  0x02000000 0 0xeea00000 0 0xeea00000 0 0x00200000
+				  0x02000000 0 0xc0000000 0 0xc0000000 0 0x08000000
+				  0x42000000 0 0xc8000000 0 0xc8000000 0 0x08000000>;
+			/* Map all possible DDR as inbound ranges */
+			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000>;
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 318>, <&pcie_bus_clk>;
+			clock-names = "pcie", "pcie_bus";
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 318>;
+			status = "disabled";
 		};
 
 		hdmi0: hdmi at fead0000 {
-- 
2.7.4
