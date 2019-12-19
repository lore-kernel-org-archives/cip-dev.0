From: marian-cristian.rotariu.rb@bp.renesas.com (Marian-Cristian Rotariu)
Date: Thu, 19 Dec 2019 15:05:52 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 3/3] ARM: dts: r8a7744: Add DU support
In-Reply-To: <1576767952-15873-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1576767952-15873-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <1576767952-15873-4-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 5f152018d340d90c185ced8ef6230b7044ea5540 upstream.

Add du node to r8a7744 SoC DT. Boards that want to enable the DU
need to specify the output topology.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[marian: Removed reset and updated clk and power domain properties]
Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7744.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7744.dtsi b/arch/arm/boot/dts/r8a7744.dtsi
index 7902f7e..91e032a 100644
--- a/arch/arm/boot/dts/r8a7744.dtsi
+++ b/arch/arm/boot/dts/r8a7744.dtsi
@@ -1278,8 +1278,17 @@
 		};
 
 		du: display at feb00000 {
+			compatible = "renesas,du-r8a7744";
 			reg = <0 0xfeb00000 0 0x40000>,
 			      <0 0xfeb90000 0 0x1c>;
+			reg-names = "du", "lvds.0";
+			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A7744_CLK_DU0>,
+				 <&mstp7_clks R8A7744_CLK_DU1>,
+				 <&mstp7_clks R8A7744_CLK_LVDS0>;
+			clock-names = "du.0", "du.1", "lvds.0";
+			status = "disabled";
 
 			ports {
 				#address-cells = <1>;
@@ -1296,7 +1305,6 @@
 					};
 				};
 			};
-			/* placeholder */
 		};
 
 		cmt0: timer at ffca0000 {
-- 
2.7.4
