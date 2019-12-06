From: biju.das@bp.renesas.com (Biju Das)
Date: Fri,  6 Dec 2019 12:12:25 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 09/12] ARM: dts: r8a7744: add VIN dt
	support
In-Reply-To: <1575634348-10954-1-git-send-email-biju.das@bp.renesas.com>
References: <1575634348-10954-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1575634348-10954-10-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 10fabcb817c5e37aeb8a1b79a95468c8df45898c upstream.

Add VIN[012] support to SoC dt.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[biju: Removed reset and updated clk and power domain properties]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7744.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7744.dtsi b/arch/arm/boot/dts/r8a7744.dtsi
index 5fab84f..10cf55e 100644
--- a/arch/arm/boot/dts/r8a7744.dtsi
+++ b/arch/arm/boot/dts/r8a7744.dtsi
@@ -873,6 +873,36 @@
 			status = "disabled";
 		};
 
+		vin0: video at e6ef0000 {
+			compatible = "renesas,vin-r8a7744",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef0000 0 0x1000>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7744_CLK_VIN0>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		vin1: video at e6ef1000 {
+			compatible = "renesas,vin-r8a7744",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef1000 0 0x1000>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7744_CLK_VIN1>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		vin2: video at e6ef2000 {
+			compatible = "renesas,vin-r8a7744",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef2000 0 0x1000>;
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7744_CLK_VIN2>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		rcar_sound: sound at ec500000 {
 			reg = <0 0xec500000 0 0x1000>;
 
-- 
2.7.4
