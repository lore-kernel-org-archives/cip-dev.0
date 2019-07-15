From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:48:01 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 2/4] arm64: dts: renesas: r8a774c0: Add
	CAN nodes
In-Reply-To: <1563198483-8589-1-git-send-email-biju.das@bp.renesas.com>
References: <1563198483-8589-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563198483-8589-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 59c3a00d6d41f72d9993e3a33b6cf8a396efffc5 upstream.

Add the device nodes for both RZ/G2E CAN channels.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index 8678da4..064fbda 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -964,6 +964,30 @@
 			status = "disabled";
 		};
 
+		can0: can at e6c30000 {
+			compatible = "renesas,can-r8a774c0",
+				     "renesas,rcar-gen3-can";
+			reg = <0 0xe6c30000 0 0x1000>;
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 916>, <&can_clk>;
+			clock-names = "clkp1", "can_clk";
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 916>;
+			status = "disabled";
+		};
+
+		can1: can at e6c38000 {
+			compatible = "renesas,can-r8a774c0",
+				     "renesas,rcar-gen3-can";
+			reg = <0 0xe6c38000 0 0x1000>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 915>, <&can_clk>;
+			clock-names = "clkp1", "can_clk";
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 915>;
+			status = "disabled";
+		};
+
 		pwm0: pwm at e6e30000 {
 			compatible = "renesas,pwm-r8a774c0", "renesas,pwm-rcar";
 			reg = <0 0xe6e30000 0 0x8>;
-- 
2.7.4
