From: biju.das@bp.renesas.com (Biju Das)
Date: Fri,  6 Dec 2019 12:12:20 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 04/12] ARM: dts: r8a7744: Add IRQC
	support
In-Reply-To: <1575634348-10954-1-git-send-email-biju.das@bp.renesas.com>
References: <1575634348-10954-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1575634348-10954-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 154a05f0c870e6c49753cda689d2209c0915996e upstream.

Describe the IRQC interrupt controller in the r8a7744 device tree.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[biju: Removed reset and updated clk and power domain properties]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7744.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7744.dtsi b/arch/arm/boot/dts/r8a7744.dtsi
index 4538689..1e7e410 100644
--- a/arch/arm/boot/dts/r8a7744.dtsi
+++ b/arch/arm/boot/dts/r8a7744.dtsi
@@ -271,6 +271,25 @@
 			reg = <0 0xe6160000 0 0x100>;
 		};
 
+		irqc: interrupt-controller at e61c0000 {
+			compatible = "renesas,irqc-r8a7744", "renesas,irqc";
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			reg = <0 0xe61c0000 0 0x200>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp4_clks R8A7744_CLK_IRQC>;
+			power-domains = <&cpg_clocks>;
+		};
+
 		icram0:	sram at e63a0000 {
 			compatible = "mmio-sram";
 			reg = <0 0xe63a0000 0 0x12000>;
-- 
2.7.4
