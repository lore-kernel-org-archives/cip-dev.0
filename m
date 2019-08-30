From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 30 Aug 2019 08:31:57 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 4/5] arm64: dts: renesas:
	hihope-common: Add pincontrol support to scif2/scif clock
In-Reply-To: <1567150318-36833-1-git-send-email-biju.das@bp.renesas.com>
References: <1567150318-36833-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1567150318-36833-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 871c13a443de63c18c26f5ad725da58fc8e19f13 upstream.

This patch adds pincontrol support to scif2/scif clock.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/hihope-common.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/hihope-common.dtsi b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
index 5baf532..de206b7 100644
--- a/arch/arm64/boot/dts/renesas/hihope-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
@@ -24,7 +24,25 @@
 	clock-frequency = <32768>;
 };
 
+&pfc {
+	pinctrl-0 = <&scif_clk_pins>;
+	pinctrl-names = "default";
+
+	scif2_pins: scif2 {
+		groups = "scif2_data_a";
+		function = "scif2";
+	};
+
+	scif_clk_pins: scif_clk {
+		groups = "scif_clk_a";
+		function = "scif_clk";
+	};
+};
+
 &scif2 {
+	pinctrl-0 = <&scif2_pins>;
+	pinctrl-names = "default";
+
 	status = "okay";
 };
 
-- 
2.7.4
