From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 14:32:38 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip v2 51/57] arm64: dts: renesas:
	r8a774a1: Add CAN nodes
In-Reply-To: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566999164-27898-52-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Chris Paterson <chris.paterson2@renesas.com>

commit b823d65f3380e9d7dd19c8e015dd7f22a0a09957 upstream.

Add the device nodes for both RZ/G2M CAN channels.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index 012cbb6..a4817a0 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -873,6 +873,30 @@
 			status = "disabled";
 		};
 
+		can0: can at e6c30000 {
+			compatible = "renesas,can-r8a774a1",
+				     "renesas,rcar-gen3-can";
+			reg = <0 0xe6c30000 0 0x1000>;
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 916>, <&can_clk>;
+			clock-names = "clkp1", "can_clk";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 916>;
+			status = "disabled";
+		};
+
+		can1: can at e6c38000 {
+			compatible = "renesas,can-r8a774a1",
+				     "renesas,rcar-gen3-can";
+			reg = <0 0xe6c38000 0 0x1000>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 915>, <&can_clk>;
+			clock-names = "clkp1", "can_clk";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 915>;
+			status = "disabled";
+		};
+
 		pwm0: pwm at e6e30000 {
 			compatible = "renesas,pwm-r8a774a1", "renesas,pwm-rcar";
 			reg = <0 0xe6e30000 0 0x8>;
-- 
2.7.4
