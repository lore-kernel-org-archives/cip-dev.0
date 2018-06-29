From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:05 +0100
Subject: [cip-dev] [PATCH 04/86] clk: shmobile: rcar-gen2: Add RZ/G1E to
	pll0_mult_match list
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-5-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

RZ/G1E doesn't have the PLL0CR register, but uses a fixed multiplier
(depending on mode pins) and divider similar to R-Car E2. Add RZ/G1E
to pll0_mult_match list.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/clk/shmobile/clk-rcar-gen2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c b/drivers/clk/shmobile/clk-rcar-gen2.c
index a874c66..636070b 100644
--- a/drivers/clk/shmobile/clk-rcar-gen2.c
+++ b/drivers/clk/shmobile/clk-rcar-gen2.c
@@ -301,6 +301,7 @@ static const struct clk_div_table cpg_sd01_div_table[] = {
 static u32 cpg_mode __initdata;
 
 static const char * const pll0_mult_match[] = {
+	"renesas,r8a7745-cpg-clocks",
 	"renesas,r8a7792-cpg-clocks",
 	"renesas,r8a7794-cpg-clocks",
 	NULL
-- 
2.7.4
