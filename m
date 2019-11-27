From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 27 Nov 2019 13:46:54 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 16/22] mmc: renesas_sdhi: implement
	R-Car Gen[123] fallback compatibility strings
In-Reply-To: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
References: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574862420-42606-17-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

commit d6dc425ae595e14026beac3720e43edd70215dc8 upstream.

Implement fallback compatibility strings for R-Car Gen 1, 2 and 3.

In the case of Renesas R-Car hardware we know that there are generations of
SoCs, f.e. Gen 1 and 2. But beyond that its not clear what the relationship
between IP blocks might be. For example, I believe that r8a7790 is older
than r8a7791 but that doesn't imply that the latter is a descendant of the
former or vice versa.

We can, however, by examining the documentation and behaviour of the
hardware at run-time observe that the current driver implementation appears
to be compatible with the IP blocks on SoCs within a given generation.

For the above reasons and convenience when enabling new SoCs a
per-generation fallback compatibility string scheme is being adopted for
drivers for Renesas SoCs.

Also, improve readability by listing the shmobile fallback compatibility
string after the more-specific compatibility strings they provide a
fallback for.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[biju: Removed R-Car Gen3 devices]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_sys_dmac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 84bb945..77f3af4 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -75,7 +75,6 @@ static const struct renesas_sdhi_of_data of_rcar_gen3_compatible = {
 };
 
 static const struct of_device_id renesas_sdhi_sys_dmac_of_match[] = {
-	{ .compatible = "renesas,sdhi-shmobile" },
 	{ .compatible = "renesas,sdhi-sh73a0", .data = &of_default_cfg, },
 	{ .compatible = "renesas,sdhi-r8a73a4", .data = &of_default_cfg, },
 	{ .compatible = "renesas,sdhi-r8a7740", .data = &of_default_cfg, },
@@ -88,6 +87,9 @@ static const struct of_device_id renesas_sdhi_sys_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r8a7792", .data = &of_rcar_gen2_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7793", .data = &of_rcar_gen2_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7794", .data = &of_rcar_gen2_compatible, },
+	{ .compatible = "renesas,rcar-gen1-sdhi", .data = &of_rcar_gen1_compatible, },
+	{ .compatible = "renesas,rcar-gen2-sdhi", .data = &of_rcar_gen2_compatible, },
+	{ .compatible = "renesas,sdhi-shmobile" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, renesas_sdhi_sys_dmac_of_match);
-- 
2.7.4
