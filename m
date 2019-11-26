From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 26 Nov 2019 16:20:27 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 06/10] ARM: dts: r8a7744-iwg20m: Add
	eMMC support
In-Reply-To: <1574785231-56219-1-git-send-email-biju.das@bp.renesas.com>
References: <1574785231-56219-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574785231-56219-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 266d863eece3f0b1e333203f9efe8fa89e042b3b upstream.

Add eMMC support for iWave RZ/G1N Qseven System On Module.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7744-iwg20m.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7744-iwg20m.dtsi b/arch/arm/boot/dts/r8a7744-iwg20m.dtsi
index 6166ae0..1e57b1f 100644
--- a/arch/arm/boot/dts/r8a7744-iwg20m.dtsi
+++ b/arch/arm/boot/dts/r8a7744-iwg20m.dtsi
@@ -29,3 +29,20 @@
 &extal_clk {
 	clock-frequency = <20000000>;
 };
+
+&pfc {
+	mmcif0_pins: mmc {
+		groups = "mmc_data8_b", "mmc_ctrl";
+		function = "mmc";
+	};
+};
+
+&mmcif0 {
+	pinctrl-0 = <&mmcif0_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&reg_3p3v>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
-- 
2.7.4
