From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri,  2 Mar 2018 11:44:48 +0000
Subject: [cip-dev] [PATCH 2/6] mmc: renesas_sdhi: Add r8a7743/5 support
In-Reply-To: <1519991092-4465-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1519991092-4465-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1519991092-4465-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

Add support for r8a7743/5 SoC.Renesas RZ/G1[ME] (R8A7743/5) SDHI
is identical to the R-Car Gen2 family.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit c16a854e4463078aedad601fac76341760a66dd1)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 354f4f3..e43aff4 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -73,6 +73,8 @@ static const struct of_device_id sh_mobile_sdhi_of_match[] = {
 	{ .compatible = "renesas,sdhi-r8a7740", .data = &sh_mobile_sdhi_of_cfg[0], },
 	{ .compatible = "renesas,sdhi-r8a7778", .data = &of_rcar_gen1_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7779", .data = &of_rcar_gen1_compatible, },
+	{ .compatible = "renesas,sdhi-r8a7743", .data = &of_rcar_gen2_compatible, },
+	{ .compatible = "renesas,sdhi-r8a7745", .data = &of_rcar_gen2_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7790", .data = &of_rcar_gen2_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7791", .data = &of_rcar_gen2_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7792", .data = &of_rcar_gen2_compatible, },
-- 
2.7.4
