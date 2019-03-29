From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Mar 2019 08:32:36 +0000
Subject: [cip-dev] [PATCH 4.19.y 3/4] arm64: dts: renesas: r8a774c0-cat874:
	Add pciec0 support
In-Reply-To: <1553848357-30592-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1553848357-30592-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1553848357-30592-4-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

Silicon Linux CAT 874 board has 2GB DDR memory. Update the dma-ranges
mapping for pciec0 node. Also declare pcie bus clock, since it is
generated on the CAT874 main board.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit aaf6c75c0458122600a20db9d41a0350f0a8dff8)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
index 477a56b..96ee0d2c 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
@@ -56,6 +56,15 @@
 	clock-frequency = <48000000>;
 };
 
+&pcie_bus_clk {
+	clock-frequency = <100000000>;
+};
+
+&pciec0 {
+	/* Map all possible DDR as inbound ranges */
+	dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000>;
+};
+
 &pfc {
 	scif2_pins: scif2 {
 		groups = "scif2_data_a";
-- 
2.7.4
