From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Nov 2019 13:00:45 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 15/17] ARM: dts: r8a77470: Add SDHI0
	support
In-Reply-To: <1574341247-46652-1-git-send-email-biju.das@bp.renesas.com>
References: <1574341247-46652-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574341247-46652-16-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit 15aa5a95e820e8183aa34535131e7c97789b8504 upstream.

RZ/G1C comes with two different types of IP for the SDHI
interfaces, SDHI0 and SDHI2 share the same IP type, and
such an IP is also compatible with the one found in R-Car
Gen2. SDHI1 IP on the other hand is compatible with R-Car
Gen3 with internal DMA.
This patch completes the SDHI support of the R-Car Gen2
compatible IPs, including fixing the max-frequency
definition of SDHI2, as it turns out there is a bug in
Section 1.3.9 of the RZ/G1C Hardware User's Manual (Rev.
1.00 Oct. 2017).

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[biju: Removed reset and updated clk and power domain properties]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a77470.dtsi | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
index 603a57c..ca184f4 100644
--- a/arch/arm/boot/dts/r8a77470.dtsi
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -664,6 +664,20 @@
 			status = "disabled";
 		};
 
+		sdhi0: sd at ee100000 {
+			compatible = "renesas,sdhi-r8a77470",
+				     "renesas,rcar-gen2-sdhi";
+			reg = <0 0xee100000 0 0x328>;
+			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A77470_CLK_SDHI0>;
+			dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
+			       <&dmac1 0xcd>, <&dmac1 0xce>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <156000000>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		sdhi2: sd at ee160000 {
 			compatible = "renesas,sdhi-r8a77470",
 				     "renesas,rcar-gen2-sdhi";
@@ -673,7 +687,7 @@
 			dmas = <&dmac0 0xd3>, <&dmac0 0xd4>,
 			       <&dmac1 0xd3>, <&dmac1 0xd4>;
 			dma-names = "tx", "rx", "tx", "rx";
-			max-frequency = <97500000>;
+			max-frequency = <78000000>;
 			power-domains = <&cpg_clocks>;
 			status = "disabled";
 		};
-- 
2.7.4
