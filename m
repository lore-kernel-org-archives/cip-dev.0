From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 27 Nov 2019 13:46:40 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 02/22] mmc: sh_mobile_sdhi: don't use
	array for DT configs
In-Reply-To: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
References: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574862420-42606-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 13bbd8af65895c524c27850495fadf23449f9f3d upstream.

We won't access an index based array to get our DT config, but create
separate structs instead. So, remove the array which only wastes memory.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index f59fff2..ebeaab6 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -65,10 +65,8 @@ struct sh_mobile_sdhi_of_data {
 	int taps_num;
 };
 
-static const struct sh_mobile_sdhi_of_data sh_mobile_sdhi_of_cfg[] = {
-	{
-		.tmio_flags = TMIO_MMC_HAS_IDLE_WAIT,
-	},
+static const struct sh_mobile_sdhi_of_data of_default_cfg = {
+	.tmio_flags = TMIO_MMC_HAS_IDLE_WAIT,
 };
 
 static const struct sh_mobile_sdhi_of_data of_rcar_gen1_compatible = {
@@ -121,9 +119,9 @@ static const struct sh_mobile_sdhi_of_data of_rcar_gen3_compatible = {
 static const struct of_device_id sh_mobile_sdhi_of_match[] = {
 	{ .compatible = "renesas,sdhi-shmobile" },
 	{ .compatible = "renesas,sdhi-sh7372" },
-	{ .compatible = "renesas,sdhi-sh73a0", .data = &sh_mobile_sdhi_of_cfg[0], },
-	{ .compatible = "renesas,sdhi-r8a73a4", .data = &sh_mobile_sdhi_of_cfg[0], },
-	{ .compatible = "renesas,sdhi-r8a7740", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,sdhi-sh73a0", .data = &of_default_cfg, },
+	{ .compatible = "renesas,sdhi-r8a73a4", .data = &of_default_cfg, },
+	{ .compatible = "renesas,sdhi-r8a7740", .data = &of_default_cfg, },
 	{ .compatible = "renesas,sdhi-r8a7778", .data = &of_rcar_gen1_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7779", .data = &of_rcar_gen1_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7743", .data = &of_rcar_gen2_compatible, },
-- 
2.7.4
