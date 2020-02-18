From: marian-cristian.rotariu.rb@bp.renesas.com (Marian-Cristian Rotariu)
Date: Tue, 18 Feb 2020 14:05:19 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 22/23] arm64: dts: renesas: cat874:
	Enable USB3.0 host/peripheral device node
In-Reply-To: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <1582034720-5249-23-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit cf7b175ae4deee43e3408bece10246d6a54cbe4c upstream.

This patch enables USB3.0 host/peripheral device node for the cat874
board.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(fixed cherry-pick confict as patch has different context in upstream)
Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
index 5be3bad..6b48f87 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
@@ -297,6 +297,11 @@
 		groups = "ssi01239_ctrl", "ssi0_data";
 		function = "ssi";
 	};
+
+	usb30_pins: usb30 {
+		groups = "usb30", "usb30_id";
+		function = "usb30";
+	};
 };
 
 &rcar_sound {
@@ -370,3 +375,15 @@
 	renesas,no-otg-pins;
 	status = "okay";
 };
+
+&usb3_peri0 {
+	companion = <&xhci0>;
+	status = "okay";
+};
+
+&xhci0 {
+	pinctrl-0 = <&usb30_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
-- 
2.7.4
