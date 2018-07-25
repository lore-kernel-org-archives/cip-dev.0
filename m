From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 25 Jul 2018 14:06:33 +0100
Subject: [cip-dev] [PATCH] ARM: dts: r8a7745: add VIN dt support
Message-ID: <1532523993-32635-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add VIN[01] support to SoC dt. Also, add aliases.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 1a20f21899e7ae886675874b5b5fb03eb43ea69b)
(moved nodes to a better location to allow for better sorting.
updated clocks and power-domains properties. removed resets property)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
Hello Ben,

This patch depends on series "Add CAN support to iwg22d":
https://lists.cip-project.org/pipermail/cip-dev/2018-July/001403.html

and it applies on top of branch linux-4.4.y-cip, commit
4d769b2b8749e89dfc7ea179a44f652dcfbedb37 ("PM / OPP: Move error
message to debug level").

Thanks,
Fab

 arch/arm/boot/dts/r8a7745.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index c2e38ae..0335e45 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -30,6 +30,8 @@
 		spi1 = &msiof0;
 		spi2 = &msiof1;
 		spi3 = &msiof2;
+		vin0 = &vin0;
+		vin1 = &vin1;
 	};
 
 	/* External CAN clock */
@@ -878,6 +880,26 @@
 			status = "disabled";
 		};
 
+		vin0: video at e6ef0000 {
+			compatible = "renesas,vin-r8a7745",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef0000 0 0x1000>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7745_CLK_VIN0>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		vin1: video at e6ef1000 {
+			compatible = "renesas,vin-r8a7745",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef1000 0 0x1000>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7745_CLK_VIN1>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		pci0: pci at ee090000 {
 			compatible = "renesas,pci-r8a7745",
 				     "renesas,pci-rcar-gen2";
-- 
2.7.4
