From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Thu, 16 Jan 2020 15:11:17 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 07/12] arm64: dts: renesas: r8a774c0:
	Add missing assigned-clocks for CAN[01]
In-Reply-To: <1579187482-4626-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1579187482-4626-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1579187482-4626-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit e8efd2a8e20a9d7a7bd701950254a0ae04a8ce27 upstream.

Define "assigned-clocks" and "assigned-clock-rates" properties
for CAN[01] DT nodes, as required by the dt-bindings.

Fixes: 036bc85c1d06ef0a ("arm64: dts: renesas: r8a774c0: Add clkp2 clock to CAN nodes")
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index cb1b71d..438844f 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -975,6 +975,8 @@
 				 <&cpg CPG_CORE R8A774C0_CLK_CANFD>,
 				 <&can_clk>;
 			clock-names = "clkp1", "clkp2", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A774C0_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
 			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
 			resets = <&cpg 916>;
 			status = "disabled";
@@ -989,6 +991,8 @@
 				 <&cpg CPG_CORE R8A774C0_CLK_CANFD>,
 				 <&can_clk>;
 			clock-names = "clkp1", "clkp2", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A774C0_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
 			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
 			resets = <&cpg 915>;
 			status = "disabled";
-- 
2.7.4
