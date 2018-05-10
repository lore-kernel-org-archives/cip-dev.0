From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:34 +0100
Subject: [cip-dev] [PATCH  45/62] ARM: dts: r8a7743: Add TPU support
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-46-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Add TPU support to SoC DT.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit ba8f6bda525121e310cec7532bf218d0bace4ff1)
(updated clock and power-domains property. removed resets property)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 73c658b..c0e53ee 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -254,6 +254,15 @@
 			reg = <0 0xe6060000 0 0x250>;
 		};
 
+		tpu: pwm at e60f0000 {
+			compatible = "renesas,tpu-r8a7743", "renesas,tpu";
+			reg = <0 0xe60f0000 0 0x148>;
+			clocks = <&mstp3_clks R8A7743_CLK_TPU0>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		dmac0: dma-controller at e6700000 {
 			compatible = "renesas,rcar-dmac";
 			reg = <0 0xe6700000 0 0x20000>;
-- 
2.7.4
