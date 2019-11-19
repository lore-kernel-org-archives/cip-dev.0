From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 14:53:31 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 06/17] ARM: dts: r8a7744: Add Ethernet
	AVB support
In-Reply-To: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
References: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574175222-52858-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit d94369fe69fd235e2109331c41f28dcfcfac28eb upstream.

Add Ethernet AVB support for R8A7744 SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[biju: removed resets property. Updated power-domains and clocks properties]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7744.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7744.dtsi b/arch/arm/boot/dts/r8a7744.dtsi
index 3e125f6..b0c4be2 100644
--- a/arch/arm/boot/dts/r8a7744.dtsi
+++ b/arch/arm/boot/dts/r8a7744.dtsi
@@ -349,10 +349,15 @@
 		};
 
 		avb: ethernet at e6800000 {
+			compatible = "renesas,etheravb-r8a7744",
+				     "renesas,etheravb-rcar-gen2";
 			reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7744_CLK_ETHERAVB>;
+			power-domains = <&cpg_clocks>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			/* placeholder */
+			status = "disabled";
 		};
 
 		scifb1: serial at e6c30000 {
-- 
2.7.4
