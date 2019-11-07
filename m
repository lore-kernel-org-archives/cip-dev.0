From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:32:51 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 82/83] ARM: dts: r8a77470: Add SDHI1
	support
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-83-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit 0485da788028ecd525291974c8efe2d072607476 upstream.

Althought interface SDHI1 found on the RZ/G1C SoC (a.k.a.
r8a77470) is compatible with the R-Car Gen3 ones, its OF
compatibility is restricted to the SoC specific compatible
string to avoid confusion, as from a more generic perspective
the RZ/G1C is sharing the most similarities with the R-Car
Gen2 family of SoCs, and there is a combination of R-Car
Gen2 compatible SDHI IPs and R-Car Gen3 compatible SDHI IP
on this specific chip.
This patch adds the SoC specific part of SDHI1 support, and
since SDHI1 comes with internal DMA, its DT node looks fairly
different from SDHI0 and SDHI2.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
[ Removed reset and updated clk and power domain properties ]
---
 arch/arm/boot/dts/r8a77470.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
index f8fccd4..757c935 100644
--- a/arch/arm/boot/dts/r8a77470.dtsi
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -669,6 +669,16 @@
 			status = "disabled";
 		};
 
+		sdhi1: sd at ee300000 {
+			compatible = "renesas,sdhi-mmc-r8a77470";
+			reg = <0 0xee300000 0 0x2000>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A77470_CLK_SDHI1>;
+			max-frequency = <156000000>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		sdhi2: sd at ee160000 {
 			compatible = "renesas,sdhi-r8a77470",
 				     "renesas,rcar-gen2-sdhi";
-- 
2.7.4
