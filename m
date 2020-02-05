From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Wed,  5 Feb 2020 20:38:40 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 14/35] arm64: dts: renesas: r8a774b1:
	Add HDMI encoder instance
In-Reply-To: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1580935141-1173-15-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 3a02555a4d06519aae74c8732287ed5378a9848f upstream.

Add the HDMI encoder to the R8A774B1 DT in disabled state.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/1570029619-43238-4-git-send-email-biju.das at bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
index 2fc9f8d..a2e6059 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
@@ -1430,7 +1430,16 @@
 		};
 
 		hdmi0: hdmi at fead0000 {
+			compatible = "renesas,r8a774b1-hdmi",
+				     "renesas,rcar-gen3-hdmi";
 			reg = <0 0xfead0000 0 0x10000>;
+			interrupts = <GIC_SPI 389 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 729>,
+				 <&cpg CPG_CORE R8A774B1_CLK_HDMI>;
+			clock-names = "iahb", "isfr";
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 729>;
+			status = "disabled";
 
 			ports {
 				#address-cells = <1>;
@@ -1439,11 +1448,16 @@
 				port at 0 {
 					reg = <0>;
 					dw_hdmi0_in: endpoint {
+						remote-endpoint = <&du_out_hdmi0>;
 					};
 				};
 				port at 1 {
 					reg = <1>;
 				};
+				port at 2 {
+					/* HDMI sound */
+					reg = <2>;
+				};
 			};
 		};
 
@@ -1473,6 +1487,7 @@
 				port at 1 {
 					reg = <1>;
 					du_out_hdmi0: endpoint {
+						remote-endpoint = <&dw_hdmi0_in>;
 					};
 				};
 				port at 2 {
-- 
2.7.4
