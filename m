From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:39:17 +0100
Subject: [cip-dev] [PATCH 76/86] ARM: dts: r8a7745: Link PCI USB devices to
	USB PHY
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-77-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

Describe the PCI USB devices that are behind the PCI bridges, adding
necessary links to the USB PHY device.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit c3e35873e37b77581be942b7284e705e997014fc)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 6915a9c..9d2b8b1 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -703,6 +703,18 @@
 			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
 					 0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
 					 0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+
+			usb at 1,0 {
+				reg = <0x800 0 0 0 0>;
+				phys = <&usb0 0>;
+				phy-names = "usb";
+			};
+
+			usb at 2,0 {
+				reg = <0x1000 0 0 0 0>;
+				phys = <&usb0 0>;
+				phy-names = "usb";
+			};
 		};
 
 		pci1: pci at ee0d0000 {
@@ -725,6 +737,18 @@
 			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
 					 0x0800 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
 					 0x1000 0 0 2 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+
+			usb at 1,0 {
+				reg = <0x10800 0 0 0 0>;
+				phys = <&usb2 0>;
+				phy-names = "usb";
+			};
+
+			usb at 2,0 {
+				reg = <0x11000 0 0 0 0>;
+				phys = <&usb2 0>;
+				phy-names = "usb";
+			};
 		};
 
 		sdhi0: sd at ee100000 {
-- 
2.7.4
