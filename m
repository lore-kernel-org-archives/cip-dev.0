From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 17 Sep 2019 14:08:00 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip v2 32/32] arm64: dts: renesas:
	hihope-common: Add HDMI support
In-Reply-To: <1568725680-32730-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1568725680-32730-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1568725680-32730-33-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 89d6adc63f859b45eb961d86a451e38b679143a5 upstream.

Add HDMI support to the HiHope RZ/G2[MN] mother board common
dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/hihope-common.dtsi | 61 ++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/hihope-common.dtsi b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
index b6f9b13..23fd022 100644
--- a/arch/arm64/boot/dts/renesas/hihope-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
@@ -17,6 +17,17 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	hdmi0-out {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi0_con: endpoint {
+				remote-endpoint = <&rcar_dw_hdmi0_out>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -78,6 +89,30 @@
 		states = <3300000 1
 			  1800000 0>;
 	};
+
+	x302_clk: x302-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <33000000>;
+	};
+
+	x304_clk: x304-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+};
+
+&du {
+	clocks = <&cpg CPG_MOD 724>,
+		 <&cpg CPG_MOD 723>,
+		 <&cpg CPG_MOD 722>,
+		 <&versaclock5 1>,
+		 <&x302_clk>,
+		 <&versaclock5 2>;
+	clock-names = "du.0", "du.1", "du.2",
+		      "dclkin.0", "dclkin.1", "dclkin.2";
+	status = "okay";
 };
 
 &ehci0 {
@@ -105,11 +140,37 @@
 	};
 };
 
+&hdmi0 {
+	status = "okay";
+
+	ports {
+		port at 1 {
+			reg = <1>;
+			rcar_dw_hdmi0_out: endpoint {
+				remote-endpoint = <&hdmi0_con>;
+			};
+		};
+	};
+};
+
 &hsusb {
 	dr_mode = "otg";
 	status = "okay";
 };
 
+&i2c4 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	versaclock5: clock-generator at 6a {
+		compatible = "idt,5p49v5923";
+		reg = <0x6a>;
+		#clock-cells = <1>;
+		clocks = <&x304_clk>;
+		clock-names = "xin";
+	};
+};
+
 &ohci0 {
 	status = "okay";
 };
-- 
2.7.4
