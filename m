From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:08 +0100
Subject: [cip-dev] [PATCH  19/62] ARM: dts: r8a7743: add VIN dt support
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-20-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Add VIN[012] support to SoC dt. Also, add aliases.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 001b32ae64dbf780d89fbc258c3f1007ee7b34e8)
(updated clocks and power-domains property. removed resets property)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index fccd70c..9724609 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -32,6 +32,9 @@
 		spi1 = &msiof0;
 		spi2 = &msiof1;
 		spi3 = &msiof2;
+		vin0 = &vin0;
+		vin1 = &vin1;
+		vin2 = &vin2;
 	};
 
 	cpus {
@@ -1330,6 +1333,36 @@
 			};
 		};
 
+		vin0: video at e6ef0000 {
+			compatible = "renesas,vin-r8a7743",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef0000 0 0x1000>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7743_CLK_VIN0>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		vin1: video at e6ef1000 {
+			compatible = "renesas,vin-r8a7743",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef1000 0 0x1000>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7743_CLK_VIN1>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		vin2: video at e6ef2000 {
+			compatible = "renesas,vin-r8a7743",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef2000 0 0x1000>;
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7743_CLK_VIN2>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		can0: can at e6e80000 {
 			compatible = "renesas,can-r8a7743",
 				     "renesas,rcar-gen2-can";
-- 
2.7.4
