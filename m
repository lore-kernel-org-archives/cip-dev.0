From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 14 Nov 2019 13:24:31 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 15/21] ARM: dts: iwg20d-q7-common: Move
	pciec node out of common dtsi
In-Reply-To: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
References: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573737877-11733-16-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit e0a39511dafd7e302a974f5cbdfc9c8afffa98d8 upstream.

PCIe is not populated by default on iWave RZ/G1N board. RZ/G1N board
is almost identical to RZ/G1M. In order to reuse the common dtsi for
both the boards, it is required to move pcie node from common dtsi
to board specific dts.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/iwg20d-q7-common.dtsi         | 4 ----
 arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts | 4 ++++
 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts         | 4 ++++
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/iwg20d-q7-common.dtsi b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
index 6920e3f..9abc25f 100644
--- a/arch/arm/boot/dts/iwg20d-q7-common.dtsi
+++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
@@ -163,10 +163,6 @@
 	clock-frequency = <100000000>;
 };
 
-&pciec {
-	status = "okay";
-};
-
 &pfc {
 	can0_pins: can0 {
 		groups = "can0_data_d";
diff --git a/arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts b/arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts
index d90eb84..b912909 100644
--- a/arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts
+++ b/arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts
@@ -17,3 +17,7 @@
 	model = "iW-RainboW-G20D-Q7 RZ/G1M based plus camera daughter board";
 	compatible = "iwave,g20d", "iwave,g20m", "renesas,r8a7743";
 };
+
+&pciec {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
index 6aa6b74..bf9ed98 100644
--- a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
+++ b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
@@ -16,3 +16,7 @@
 	model = "iWave Systems RainboW-G20D-Qseven board based on RZ/G1M";
 	compatible = "iwave,g20d", "iwave,g20m", "renesas,r8a7743";
 };
+
+&pciec {
+	status = "okay";
+};
-- 
2.7.4
