From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 14:53:39 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 14/17] ARM: dts: r8a7744: Add CMT SoC
	specific support
In-Reply-To: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
References: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574175222-52858-15-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 90bcf80c37df5d76d953673717cdd5082776d98e upstream.

Add CMT[01] support to SoC DT.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[biju: removed resets property. Updated power-domains and clocks properties]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7744.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7744.dtsi b/arch/arm/boot/dts/r8a7744.dtsi
index 3f73784..1a4854a 100644
--- a/arch/arm/boot/dts/r8a7744.dtsi
+++ b/arch/arm/boot/dts/r8a7744.dtsi
@@ -850,6 +850,38 @@
 			/* placeholder */
 		};
 
+		cmt0: timer at ffca0000 {
+			compatible = "renesas,cmt-48-r8a7744",
+				     "renesas,cmt-48-gen2";
+			reg = <0 0xffca0000 0 0x1004>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp1_clks R8A7744_CLK_CMT0>;
+			clock-names = "fck";
+			power-domains = <&cpg_clocks>;
+			renesas,channels-mask = <0x60>;
+			status = "disabled";
+		};
+
+		cmt1: timer at e6130000 {
+			compatible = "renesas,cmt-48-r8a7744",
+				     "renesas,cmt-48-gen2";
+			reg = <0 0xe6130000 0 0x1004>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A7744_CLK_CMT1>;
+			clock-names = "fck";
+			power-domains = <&cpg_clocks>;
+			renesas,channels-mask = <0xff>;
+			status = "disabled";
+		};
+
 		clocks {
 			#address-cells = <2>;
 			#size-cells = <2>;
-- 
2.7.4
