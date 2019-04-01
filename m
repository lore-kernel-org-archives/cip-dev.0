From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  1 Apr 2019 10:58:10 +0100
Subject: [cip-dev] [PATCH 4.19.y 11/17] clk: renesas: r8a774c0: Correct
	parent clock of DU
In-Reply-To: <1554112696-20706-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1554112696-20706-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1554112696-20706-12-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit d9286d9743b6e8cfbf1a13f8db84e9c65c0b09c7 upstream.

According to the RZ/G Series, 2nd Generation Hardware Manual Rev 0.61,
the parent clock of the DU module clocks on RZ/G2E is S1D1.

Fixes: 906e0a4a6d1ef2d3 ("clk: renesas: cpg-mssr: Add r8a774c0 support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/clk/renesas/r8a774c0-cpg-mssr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/r8a774c0-cpg-mssr.c b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
index 28bcc81..4f3111b 100644
--- a/drivers/clk/renesas/r8a774c0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
@@ -175,8 +175,8 @@ static const struct mssr_mod_clk r8a774c0_mod_clks[] __initconst = {
 	DEF_MOD("ehci0",		 703,	R8A774C0_CLK_S3D4),
 	DEF_MOD("hsusb",		 704,	R8A774C0_CLK_S3D4),
 	DEF_MOD("csi40",		 716,	R8A774C0_CLK_CSI0),
-	DEF_MOD("du1",			 723,	R8A774C0_CLK_S2D1),
-	DEF_MOD("du0",			 724,	R8A774C0_CLK_S2D1),
+	DEF_MOD("du1",			 723,	R8A774C0_CLK_S1D1),
+	DEF_MOD("du0",			 724,	R8A774C0_CLK_S1D1),
 	DEF_MOD("lvds",			 727,	R8A774C0_CLK_S2D1),
 
 	DEF_MOD("vin5",			 806,	R8A774C0_CLK_S1D2),
-- 
2.7.4
