From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 20 Nov 2019 16:47:16 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 2/6] ARM: dts: r8a77470: Add watchdog
	support to SoC dtsi
In-Reply-To: <1574268440-33507-1-git-send-email-biju.das@bp.renesas.com>
References: <1574268440-33507-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574268440-33507-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit dc7bf8795d848890641387d98c5e1324d397e9c8 upstream.

This patch adds watchdog support to the r8a77470 SoC dtsi.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
[simon: moved node to preserve sort order]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[biju: updated power-domains and clocks property. removed resets property]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a77470.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
index 568f650..fc1333e 100644
--- a/arch/arm/boot/dts/r8a77470.dtsi
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -76,6 +76,15 @@
 		#size-cells = <2>;
 		ranges;
 
+		rwdt: watchdog at e6020000 {
+			compatible = "renesas,r8a77470-wdt",
+				     "renesas,rcar-gen2-wdt";
+			reg = <0 0xe6020000 0 0x0c>;
+			clocks = <&mstp4_clks R8A77470_CLK_RWDT>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		gpio0: gpio at e6050000 {
 			compatible = "renesas,gpio-r8a77470",
 				     "renesas,rcar-gen2-gpio";
-- 
2.7.4
