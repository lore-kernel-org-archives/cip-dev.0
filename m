From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:30:00 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 15/23] clk: renesas: rcar-gen3: Support
	Z and Z2 clocks with high frequency parents
In-Reply-To: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
References: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563197408-59548-16-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

commit 71119b54a2e6d9345f22d9501c4d3c28b06f955a upstream.

Support Z and Z2 clocks with parent frequencies greater than UINT32_MAX Hz
(~4.29GHz).

The DIV_ROUND_CLOSEST_ULL() macro accepts a 64bit dividend and 32bit
divisor. This leads to truncation of the divisor, which is the Z or Z2
parent clock frequency in HZ, on platforms where frequency of that clock is
greater than UINT32_MAX Hz.

To resolve this problem the DIV64_U64_ROUND_CLOSEST() macro, which takes
on an unsigned 64bit dividend and divisor, is used.

An earlier version of this patch made use of the existing
DIV_ROUND_CLOSEST() macro, which accepts the prevailing type of the
dividend and divisor. However, this does not compile on 32bit systems, such
as i386 and mips, when called with the types used at this call site, an
unsigned long long dividend and unsigned long divisor.

This work is in preparation for supporting the Z2 clock on the
R-Car Gen3 E3 (r8a77990) SoC which has a 4.8GHz parent clock.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/renesas/rcar-gen3-cpg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index 01c1d8f..8b8cc22 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -137,8 +137,8 @@ static int cpg_z_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned int mult;
 	unsigned int i;
 
-	mult = DIV_ROUND_CLOSEST_ULL(rate * 32ULL * zclk->fixed_div,
-				     parent_rate);
+	mult = DIV64_U64_ROUND_CLOSEST(rate * 32ULL * zclk->fixed_div,
+				       parent_rate);
 	mult = clamp(mult, 1U, 32U);
 
 	if (readl(zclk->kick_reg) & CPG_FRQCRB_KICK)
-- 
2.7.4
