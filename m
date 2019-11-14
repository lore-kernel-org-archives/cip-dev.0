From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 14 Nov 2019 13:24:19 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 03/21] soc: renesas: rcar-rst: Add
	support for RZ/G1N
In-Reply-To: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
References: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573737877-11733-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 547276c6799913898550a9c4806310d590a3cb9e upstream.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/rcar-rst.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/renesas/rcar-rst.c b/drivers/soc/renesas/rcar-rst.c
index caaa029..8eaf736 100644
--- a/drivers/soc/renesas/rcar-rst.c
+++ b/drivers/soc/renesas/rcar-rst.c
@@ -33,6 +33,7 @@ static const struct rst_config rcar_rst_gen2 __initconst = {
 static const struct of_device_id rcar_rst_matches[] __initconst = {
 	/* RZ/G is handled like R-Car Gen2 */
 	{ .compatible = "renesas,r8a7743-rst", .data = &rcar_rst_gen2 },
+	{ .compatible = "renesas,r8a7744-rst", .data = &rcar_rst_gen2 },
 	{ .compatible = "renesas,r8a7745-rst", .data = &rcar_rst_gen2 },
 	{ .compatible = "renesas,r8a77470-rst", .data = &rcar_rst_gen2 },
 	/* R-Car Gen2 */
-- 
2.7.4
