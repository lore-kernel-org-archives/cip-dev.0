From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  5 Mar 2018 11:39:12 +0000
Subject: [cip-dev] [PATCH 08/10] ARM: dts: r8a7743: Link PCI USB devices to
	USB PHY
In-Reply-To: <1520249954-29357-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520249954-29357-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520249954-29357-9-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

Describe the PCI USB devices that are behind the PCI bridges, adding
necessary links to the USB PHY device.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 96963454655c10663f1bc2eea57ac734cab171a7)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index be8881a..1b17a20 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -1229,6 +1229,18 @@
 			    0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
 			    0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
 			>;
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
@@ -1254,6 +1266,18 @@
 			    0x0800 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
 			    0x1000 0 0 2 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
 			>;
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
 	};
 
-- 
2.7.4
