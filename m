From: biju.das@bp.renesas.com (Biju Das)
Date: Tue,  8 Aug 2017 10:50:23 +0100
Subject: [cip-dev] [PATCH  09/14] ARM: dts: r8a7743: add Ether support
In-Reply-To: <1502185828-45443-1-git-send-email-biju.das@bp.renesas.com>
References: <1502185828-45443-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1502185828-45443-10-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the generic R8A7743 part of the Ether device node.

Based on the original (and large) patch by Dmitry Shifrin
<dmitry.shifrin@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 75f97fb45e6297e3fbaf837fc30850cf724c8f83)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>

Conflicts:
	arch/arm/boot/dts/r8a7743.dtsi
---
 arch/arm/boot/dts/r8a7743.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index d687e47..88406e32 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -361,6 +361,18 @@
 		status = "disabled";
 	};
 
+	ether: ethernet at ee700000 {
+		compatible = "renesas,ether-r8a7743";
+		reg = <0 0xee700000 0 0x400>;
+		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7743_CLK_ETHER>;
+		power-domains = <&cpg_clocks>;
+		phy-mode = "rmii";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
1.9.1
