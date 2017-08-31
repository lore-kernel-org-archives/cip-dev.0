From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 31 Aug 2017 15:34:16 +0100
Subject: [cip-dev] [PATCH v2 11/18] ARM: dts: r8a7743: Link ARM GIC to clock
	and clock domain
In-Reply-To: <1504190063-61519-1-git-send-email-biju.das@bp.renesas.com>
References: <1504190063-61519-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1504190063-61519-12-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Link the ARM GIC to the INTC-SYS module clock, and add it to the SYSC
"always-on" PM Domain, so it can be power managed using that clock.

Note that currently the GIC-400 driver doesn't support module clocks nor
Runtime PM, so this must be handled as a critical clock.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 7add1da17ac8d5c4a2ecc967843ca5b55ce35fa6)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index c58f150..5230822 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -58,6 +58,9 @@
 			      <0 0xf1006000 0 0x2000>;
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) |
 						 IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&mstp4_clks R8A7743_CLK_INTC_SYS>;
+			clock-names = "clk";
+			power-domains = <&cpg_clocks>;
 		};
 
 		irqc: interrupt-controller at e61c0000 {
-- 
1.9.1
