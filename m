From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:03:14 +0100
Subject: [cip-dev] [PATCH 4.19.y 43/60] arm64: dts: renesas: r8a774a1: Add
	IPMMU device nodes
In-Reply-To: <1566990211-24785-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566990211-24785-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566990211-24785-44-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 8f507babc617050e7502849d008ddab548efa9c1 upstream.

Add r8a774a1 IPMMU nodes.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 73 +++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index 02620c8..8589122 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -642,6 +642,79 @@
 			dma-channels = <16>;
 		};
 
+		ipmmu_ds0: mmu at e6740000 {
+			compatible = "renesas,ipmmu-r8a774a1";
+			reg = <0 0xe6740000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 0>;
+			power-domains = <&sysc 32>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_ds1: mmu at e7740000 {
+			compatible = "renesas,ipmmu-r8a774a1";
+			reg = <0 0xe7740000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 1>;
+			power-domains = <&sysc 32>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_hc: mmu at e6570000 {
+			compatible = "renesas,ipmmu-r8a774a1";
+			reg = <0 0xe6570000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 2>;
+			power-domains = <&sysc 32>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_mm: mmu at e67b0000 {
+			compatible = "renesas,ipmmu-r8a774a1";
+			reg = <0 0xe67b0000 0 0x1000>;
+			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&sysc 32>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_mp: mmu at ec670000 {
+			compatible = "renesas,ipmmu-r8a774a1";
+			reg = <0 0xec670000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 4>;
+			power-domains = <&sysc 32>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_pv0: mmu at fd800000 {
+			compatible = "renesas,ipmmu-r8a774a1";
+			reg = <0 0xfd800000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 5>;
+			power-domains = <&sysc 32>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_pv1: mmu at fd950000 {
+			compatible = "renesas,ipmmu-r8a774a1";
+			reg = <0 0xfd950000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 6>;
+			power-domains = <&sysc 32>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_vc0: mmu at fe6b0000 {
+			compatible = "renesas,ipmmu-r8a774a1";
+			reg = <0 0xfe6b0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 8>;
+			power-domains = <&sysc 14>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_vi0: mmu at febd0000 {
+			compatible = "renesas,ipmmu-r8a774a1";
+			reg = <0 0xfebd0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 9>;
+			power-domains = <&sysc 32>;
+			#iommu-cells = <1>;
+		};
+
 		avb: ethernet at e6800000 {
 			compatible = "renesas,etheravb-r8a774a1",
 				     "renesas,etheravb-rcar-gen3";
-- 
2.7.4
