From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 14:53:42 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 17/17] ARM: dts: iwg20d-q7-common: Move
	cmt/rwdt node out of RZ/G1M SOM
In-Reply-To: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
References: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574175222-52858-18-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit b72ce26cb73afd042d65f737971f560a491e1275 upstream.

The iWave RZ/G1N board is almost identical to RZ/G1M. cmt and rwdt modules
are SoC specific and should be part of board dts rather than SoM dtsi. By
moving these nodes to the common dtsi it allows cmt and rwdt to be enabled
on both of these boards with less lines of code.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/iwg20d-q7-common.dtsi | 9 +++++++++
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi   | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/iwg20d-q7-common.dtsi b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
index 9abc25f..011dbab 100644
--- a/arch/arm/boot/dts/iwg20d-q7-common.dtsi
+++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
@@ -119,6 +119,10 @@
 	status = "okay";
 };
 
+&cmt0 {
+	status = "okay";
+};
+
 &hsusb {
 	status = "okay";
 	pinctrl-0 = <&usb0_pins>;
@@ -227,6 +231,11 @@
 	};
 };
 
+&rwdt {
+	timeout-sec = <60>;
+	status = "okay";
+};
+
 &scif0 {
 	pinctrl-0 = <&scif0_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
index d364685..75a8ca5 100644
--- a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
+++ b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
@@ -34,10 +34,6 @@
 	};
 };
 
-&cmt0 {
-	status = "okay";
-};
-
 &extal_clk {
 	clock-frequency = <20000000>;
 };
@@ -91,11 +87,6 @@
 	};
 };
 
-&rwdt {
-	timeout-sec = <60>;
-	status = "okay";
-};
-
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
 	pinctrl-names = "default";
-- 
2.7.4
