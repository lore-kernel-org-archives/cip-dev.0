From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Mar 2019 14:24:14 +0000
Subject: [cip-dev] [PATCH 16/18] soc: renesas: rcar-rst: Add support for
	RZ/G2M
In-Reply-To: <1553178256-6293-1-git-send-email-biju.das@bp.renesas.com>
References: <1553178256-6293-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553178256-6293-17-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 3116d859e7b15d3740afd44c975cdb34a4c1246e)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/reset/renesas,rst.txt | 1 +
 drivers/soc/renesas/Kconfig                             | 6 +++---
 drivers/soc/renesas/rcar-rst.c                          | 4 +++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/renesas,rst.txt b/Documentation/devicetree/bindings/reset/renesas,rst.txt
index 67e83b0..e4fe0ab 100644
--- a/Documentation/devicetree/bindings/reset/renesas,rst.txt
+++ b/Documentation/devicetree/bindings/reset/renesas,rst.txt
@@ -18,6 +18,7 @@ Required properties:
 		  - "renesas,r8a7743-rst" (RZ/G1M)
 		  - "renesas,r8a7745-rst" (RZ/G1E)
 		  - "renesas,r8a77470-rst" (RZ/G1C)
+		  - "renesas,r8a774a1-rst" (RZ/G2M)
 		  - "renesas,r8a7778-reset-wdt" (R-Car M1A)
 		  - "renesas,r8a7779-reset-wdt" (R-Car H1)
 		  - "renesas,r8a7790-rst" (R-Car H2)
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index e50e77c..163e666 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -3,9 +3,9 @@ config SOC_RENESAS
 	default y if ARCH_RENESAS
 	select SOC_BUS
 	select RST_RCAR if ARCH_RCAR_GEN1 || ARCH_RCAR_GEN2 || \
-			   ARCH_R8A7795 || ARCH_R8A7796 || ARCH_R8A77965 || \
-			   ARCH_R8A77970 || ARCH_R8A77980 || ARCH_R8A77990 || \
-			   ARCH_R8A77995
+			   ARCH_R8A774A1 || ARCH_R8A7795 || ARCH_R8A7796 || \
+			   ARCH_R8A77965 || ARCH_R8A77970 || ARCH_R8A77980 || \
+			   ARCH_R8A77990 || ARCH_R8A77995
 	select SYSC_R8A7743 if ARCH_R8A7743
 	select SYSC_R8A7745 if ARCH_R8A7745
 	select SYSC_R8A77470 if ARCH_R8A77470
diff --git a/drivers/soc/renesas/rcar-rst.c b/drivers/soc/renesas/rcar-rst.c
index d9c1034..a447873 100644
--- a/drivers/soc/renesas/rcar-rst.c
+++ b/drivers/soc/renesas/rcar-rst.c
@@ -41,10 +41,12 @@ static const struct rst_config rcar_rst_gen3 __initconst = {
 };
 
 static const struct of_device_id rcar_rst_matches[] __initconst = {
-	/* RZ/G is handled like R-Car Gen2 */
+	/* RZ/G1 is handled like R-Car Gen2 */
 	{ .compatible = "renesas,r8a7743-rst", .data = &rcar_rst_gen2 },
 	{ .compatible = "renesas,r8a7745-rst", .data = &rcar_rst_gen2 },
 	{ .compatible = "renesas,r8a77470-rst", .data = &rcar_rst_gen2 },
+	/* RZ/G2 is handled like R-Car Gen3 */
+	{ .compatible = "renesas,r8a774a1-rst", .data = &rcar_rst_gen3 },
 	/* R-Car Gen1 */
 	{ .compatible = "renesas,r8a7778-reset-wdt", .data = &rcar_rst_gen1 },
 	{ .compatible = "renesas,r8a7779-reset-wdt", .data = &rcar_rst_gen1 },
-- 
2.7.4
