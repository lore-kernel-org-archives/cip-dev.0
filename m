From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Fri, 24 Jan 2020 09:08:13 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 03/10] ARM: dts: r8a7744: Add TPU support
In-Reply-To: <1579856900-21381-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1579856900-21381-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1579856900-21381-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit eb83d144978e9f21aaa1372d75b50f3eec22ed48 upstream.

Add TPU support to SoC DT.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(updated clock and power-domains property. removed resets property)
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7744.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7744.dtsi b/arch/arm/boot/dts/r8a7744.dtsi
index 79c71ef..425915a 100644
--- a/arch/arm/boot/dts/r8a7744.dtsi
+++ b/arch/arm/boot/dts/r8a7744.dtsi
@@ -260,6 +260,15 @@
 			reg = <0 0xe6060000 0 0x250>;
 		};
 
+		tpu: pwm at e60f0000 {
+			compatible = "renesas,tpu-r8a7744", "renesas,tpu";
+			reg = <0 0xe60f0000 0 0x148>;
+			clocks = <&mstp3_clks R8A7744_CLK_TPU0>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		apmu at e6152000 {
 			compatible = "renesas,r8a7744-apmu", "renesas,apmu";
 			reg = <0 0xe6152000 0 0x188>;
-- 
2.7.4
