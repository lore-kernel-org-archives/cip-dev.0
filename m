From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 22 Mar 2019 09:56:21 +0000
Subject: [cip-dev] [PATCH 5/5] arm64: dts: renesas: r8a774c0: Add watchdog
	support
In-Reply-To: <1553248581-64466-1-git-send-email-biju.das@bp.renesas.com>
References: <1553248581-64466-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553248581-64466-6-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Add watchdog support to the RZ/G2E (a.k.a. R8A774C0) SoC
specific device tree.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 8d68821ced28391551b5e2014de4b1bf461b667e)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index e98f209..96a71e3 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -114,6 +114,16 @@
 		#size-cells = <2>;
 		ranges;
 
+		rwdt: watchdog at e6020000 {
+			compatible = "renesas,r8a774c0-wdt",
+				     "renesas,rcar-gen3-wdt";
+			reg = <0 0xe6020000 0 0x0c>;
+			clocks = <&cpg CPG_MOD 402>;
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 402>;
+			status = "disabled";
+		};
+
 		gpio0: gpio at e6050000 {
 			compatible = "renesas,gpio-r8a774c0",
 				     "renesas,rcar-gen3-gpio";
-- 
2.7.4
