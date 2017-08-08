From: biju.das@bp.renesas.com (Biju Das)
Date: Tue,  8 Aug 2017 10:50:24 +0100
Subject: [cip-dev] [PATCH  10/14] ARM: dts: r8a7743: add IRQC support
In-Reply-To: <1502185828-45443-1-git-send-email-biju.das@bp.renesas.com>
References: <1502185828-45443-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1502185828-45443-11-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Describe the IRQC interrupt controller in the R8A7743 device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit ef0ca50774495c4ca4d1211252c8ee5af5136187)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>

Conflicts:
	arch/arm/boot/dts/r8a7743.dtsi
---
 arch/arm/boot/dts/r8a7743.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 88406e32..64182bf 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -56,6 +56,25 @@
 				    IRQ_TYPE_LEVEL_LOW)>;
 	};
 
+	irqc: interrupt-controller at e61c0000 {
+		compatible = "renesas,irqc-r8a7743", "renesas,irqc";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0 0xe61c0000 0 0x200>;
+		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks R8A7743_CLK_IRQC>;
+		power-domains = <&cpg_clocks>;
+	};
+
 	dmac0: dma-controller at e6700000 {
 		compatible = "renesas,rcar-dmac";
 		reg = <0 0xe6700000 0 0x20000>;
-- 
1.9.1
