From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri,  6 Jul 2018 19:10:56 +0100
Subject: [cip-dev] [PATCH v2 86/86] ARM: dts: iwg22d-sodimm-dbhd-ca: Add
	HDMI video output
Message-ID: <1530900658-21832-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch enables the HDMI interface found on the expansion board.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 97b94d256d432ba9e1b37f9b21c3b285caf11de6)
(taken out interrupt support from hdmi at 39 node)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
Hello Ben,

We have now been seeing the same problem we saw when we worked on
bc4390d1a913f422c4e5ab8147e298f296dd0477 ("ARM: dts:
iwg20d-q7-dbcm-ca: Add HDMI video output"), therefore we are taking
out interrupt support as it appears commit
9183e45db7774716d056319c237a4185baba19c7 introduced the "connector"
data field with struct adv7511, but drm_connector_init was left
behind, and as such connector.dev is NULL, and that causes issues
to function adv7511_hpd_work, preventing HDMI hotplug from working
properly.

This patch replaces:
https://lists.cip-project.org/pipermail/cip-dev/2018-June/001361.html

We are sorry for any inconvenience this may cause to your process.

Thanks,
Fab

v1->v2:
* taken out interrupt support from hdmi at 39 node

 .../arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts
index f925388..fc0f559 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts
+++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts
@@ -20,6 +20,38 @@
 		serial4 = &scif5;
 		serial6 = &hscif2;
 	};
+
+	cec_clock: cec-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12000000>;
+	};
+
+	hdmi-out {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con: endpoint {
+				remote-endpoint = <&adv7511_out>;
+			};
+		};
+	};
+};
+
+&du {
+	pinctrl-0 = <&du0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	ports {
+		port at 0 {
+			endpoint {
+				remote-endpoint = <&adv7511_in>;
+			};
+		};
+	};
 };
 
 &hscif2 {
@@ -29,12 +61,63 @@
 	status = "okay";
 };
 
+&i2c1 {
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	hdmi at 39 {
+		compatible = "adi,adv7511w";
+		reg = <0x39>;
+		clocks = <&cec_clock>;
+		clock-names = "cec";
+		pd-gpios = <&gpio2 24 GPIO_ACTIVE_HIGH>;
+
+		adi,input-depth = <8>;
+		adi,input-colorspace = "rgb";
+		adi,input-clock = "1x";
+		adi,input-style = <1>;
+		adi,input-justification = "evenly";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				adv7511_in: endpoint {
+					remote-endpoint = <&du_out_rgb0>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+				adv7511_out: endpoint {
+					remote-endpoint = <&hdmi_con>;
+				};
+			};
+		};
+	};
+};
+
 &pfc {
+	du0_pins: du0 {
+		groups = "du0_rgb888", "du0_sync", "du0_disp", "du0_clk0_out";
+		function = "du0";
+	};
+
 	hscif2_pins: hscif2 {
 		groups = "hscif2_data";
 		function = "hscif2";
 	};
 
+	i2c1_pins: i2c1 {
+		groups = "i2c1_d";
+		function = "i2c1";
+	};
+
 	scif1_pins: scif1 {
 		groups = "scif1_data";
 		function = "scif1";
-- 
2.7.4
