From: marian-cristian.rotariu.rb@bp.renesas.com (Marian-Cristian Rotariu)
Date: Tue, 18 Feb 2020 14:05:20 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 23/23] arm64: dts: renesas: cat874:
	Enable usb role switch support
In-Reply-To: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <1582034720-5249-24-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit ec0a286a339e0fff8666d48ccce48263488e64fb upstream.

This patch enables TI HD3SS3220 device and support usb role switch
for the CAT 874 platform.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
index 6b48f87..c99b1de 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
@@ -181,6 +181,31 @@
 	status = "okay";
 	clock-frequency = <100000>;
 
+	hd3ss3220 at 47 {
+		compatible = "ti,hd3ss3220";
+		reg = <0x47>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+		connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					reg = <1>;
+					hd3ss3220_ep: endpoint {
+						remote-endpoint = <&usb3_role_switch>;
+					};
+				};
+			};
+		};
+	};
+
 	tda19988: tda19988 at 70 {
 		compatible = "nxp,tda998x";
 		reg = <0x70>;
@@ -379,6 +404,13 @@
 &usb3_peri0 {
 	companion = <&xhci0>;
 	status = "okay";
+	usb-role-switch;
+
+	port {
+		usb3_role_switch: endpoint {
+			remote-endpoint = <&hd3ss3220_ep>;
+		};
+	};
 };
 
 &xhci0 {
-- 
2.7.4
