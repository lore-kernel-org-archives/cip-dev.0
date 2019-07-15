From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 15:17:25 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 6/6] arm64: dts: renesas:
	r8a774c0-cat874: add RTC support
In-Reply-To: <1563200245-30331-1-git-send-email-biju.das@bp.renesas.com>
References: <1563200245-30331-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563200245-30331-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 07e72397f722d3a522991dcba82ce2ddb8c3c6e1 upstream.

This patch adds Epson RX-8571 real time clock support.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
index 4333af8..f08778e 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
@@ -61,6 +61,19 @@
 	clock-frequency = <48000000>;
 };
 
+&i2c1 {
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	rtc at 32 {
+		compatible = "epson,rx8571";
+		reg = <0x32>;
+	};
+};
+
 &ohci0 {
 	dr_mode = "host";
 	status = "okay";
@@ -76,6 +89,12 @@
 };
 
 &pfc {
+
+	i2c1_pins: i2c1 {
+		groups = "i2c1_b";
+		function = "i2c1";
+	};
+
 	scif2_pins: scif2 {
 		groups = "scif2_data_a";
 		function = "scif2";
-- 
2.7.4
