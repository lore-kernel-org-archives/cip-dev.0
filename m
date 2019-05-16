From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 16 May 2019 10:39:28 +0100
Subject: [cip-dev] [PATCH v2 16/52] soc: renesas: rcar-rst: Add support for
	RZ/G1C
In-Reply-To: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557999604-1117-17-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit a3a9033f1193842c6e0b518db196ade0f882cf78 upstream.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

---
v1->v2:
* No change
---
 Documentation/devicetree/bindings/reset/renesas,rst.txt | 1 +
 drivers/soc/renesas/rcar-rst.c                          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/renesas,rst.txt b/Documentation/devicetree/bindings/reset/renesas,rst.txt
index fff2e8e..fb5f68e 100644
--- a/Documentation/devicetree/bindings/reset/renesas,rst.txt
+++ b/Documentation/devicetree/bindings/reset/renesas,rst.txt
@@ -8,6 +8,7 @@ Required properties:
 		Examples with soctypes are:
 		  - "renesas,r8a7743-rst" (RZ/G1M)
 		  - "renesas,r8a7745-rst" (RZ/G1E)
+		  - "renesas,r8a77470-rst" (RZ/G1C)
 		  - "renesas,r8a7790-rst" (R-Car H2)
 		  - "renesas,r8a7791-rst" (R-Car M2-W)
 		  - "renesas,r8a7792-rst" (R-Car V2H
diff --git a/drivers/soc/renesas/rcar-rst.c b/drivers/soc/renesas/rcar-rst.c
index 0622006..caaa029 100644
--- a/drivers/soc/renesas/rcar-rst.c
+++ b/drivers/soc/renesas/rcar-rst.c
@@ -34,6 +34,7 @@ static const struct of_device_id rcar_rst_matches[] __initconst = {
 	/* RZ/G is handled like R-Car Gen2 */
 	{ .compatible = "renesas,r8a7743-rst", .data = &rcar_rst_gen2 },
 	{ .compatible = "renesas,r8a7745-rst", .data = &rcar_rst_gen2 },
+	{ .compatible = "renesas,r8a77470-rst", .data = &rcar_rst_gen2 },
 	/* R-Car Gen2 */
 	{ .compatible = "renesas,r8a7790-rst", .data = &rcar_rst_gen2 },
 	{ .compatible = "renesas,r8a7791-rst", .data = &rcar_rst_gen2 },
-- 
2.7.4
