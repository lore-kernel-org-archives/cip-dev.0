From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  6 Mar 2018 11:34:45 +0000
Subject: [cip-dev] [PATCH 5/7] ARM: dts: iwg20d-q7: Enable HS-USB
In-Reply-To: <1520336087-12870-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520336087-12870-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520336087-12870-6-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

Enable HS-USB device for the iWave G20D-Q7 carrier board based on
RZ/G1M.
Also disable the host mode support on usb otg port by default to avoid
pin conflicts.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 405b580227ff1ae8fde82a666a2a5c0391a7e64a)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/iwg20d-q7-common.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/iwg20d-q7-common.dtsi b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
index fbb5215..8f203c5 100644
--- a/arch/arm/boot/dts/iwg20d-q7-common.dtsi
+++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
@@ -59,6 +59,12 @@
 	};
 };
 
+&hsusb {
+	status = "okay";
+	pinctrl-0 = <&usb0_pins>;
+	pinctrl-names = "default";
+};
+
 &i2c2 {
 	pinctrl-0 = <&i2c2_pins>;
 	pinctrl-names = "default";
@@ -111,7 +117,6 @@
 };
 
 &pci0 {
-	status = "okay";
 	pinctrl-0 = <&usb0_pins>;
 	pinctrl-names = "default";
 };
-- 
2.7.4
