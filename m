From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 18 Dec 2019 11:33:27 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 17/39] soc: renesas: rcar-rst: Add
	support for RZ/G2N
In-Reply-To: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1576668829-59767-18-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 26405045e73b184900ad43206eeda7bee1cedee1 upstream.

Add support for RZ/G2N (R8A774B1) to the R-Car RST driver.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Link: https://lore.kernel.org/r/1568881036-4404-5-git-send-email-biju.das at bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[Biju: Refactored for 4.19-cip kernel]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/soc/renesas/Kconfig    | 7 ++++---
 drivers/soc/renesas/rcar-rst.c | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index aed8794..f3727aa 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -3,9 +3,10 @@ config SOC_RENESAS
 	default y if ARCH_RENESAS
 	select SOC_BUS
 	select RST_RCAR if ARCH_RCAR_GEN1 || ARCH_RCAR_GEN2 || \
-			   ARCH_R8A774A1 || ARCH_R8A774C0 || ARCH_R8A7795 || \
-			   ARCH_R8A7796 || ARCH_R8A77965 || ARCH_R8A77970 || \
-			   ARCH_R8A77980 || ARCH_R8A77990 || ARCH_R8A77995
+			   ARCH_R8A774A1 || ARCH_R8A774B1 || ARCH_R8A774C0 || \
+			   ARCH_R8A7795 || ARCH_R8A7796 || ARCH_R8A77965 || \
+			   ARCH_R8A77970 || ARCH_R8A77980 || ARCH_R8A77990 || \
+			   ARCH_R8A77995
 	select SYSC_R8A7743 if ARCH_R8A7743
 	select SYSC_R8A7745 if ARCH_R8A7745
 	select SYSC_R8A77470 if ARCH_R8A77470
diff --git a/drivers/soc/renesas/rcar-rst.c b/drivers/soc/renesas/rcar-rst.c
index d5e31f4..6c17ec5 100644
--- a/drivers/soc/renesas/rcar-rst.c
+++ b/drivers/soc/renesas/rcar-rst.c
@@ -47,6 +47,7 @@ static const struct of_device_id rcar_rst_matches[] __initconst = {
 	{ .compatible = "renesas,r8a77470-rst", .data = &rcar_rst_gen2 },
 	/* RZ/G2 is handled like R-Car Gen3 */
 	{ .compatible = "renesas,r8a774a1-rst", .data = &rcar_rst_gen3 },
+	{ .compatible = "renesas,r8a774b1-rst", .data = &rcar_rst_gen3 },
 	{ .compatible = "renesas,r8a774c0-rst", .data = &rcar_rst_gen3 },
 	/* R-Car Gen1 */
 	{ .compatible = "renesas,r8a7778-reset-wdt", .data = &rcar_rst_gen1 },
-- 
2.7.4
