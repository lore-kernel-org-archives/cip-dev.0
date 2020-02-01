From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Sat,  1 Feb 2020 12:26:56 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 08/14] thermal: rcar_gen3_thermal: Add
	r8a774b1 support
In-Reply-To: <1580560022-26873-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580560022-26873-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1580560022-26873-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 1a005912410f5026d59620fdcd4340c1758ec0a3 upstream.

Add r8a774b1 specific compatible string.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1569248746-56718-1-git-send-email-biju.das at bp.renesas.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index c67147e..42ec69d 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -315,6 +315,10 @@ static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
 		.data = &rcar_gen3_ths_tj_1_m3_w,
 	},
 	{
+		.compatible = "renesas,r8a774b1-thermal",
+		.data = &rcar_gen3_ths_tj_1,
+	},
+	{
 		.compatible = "renesas,r8a7795-thermal",
 		.data = &rcar_gen3_ths_tj_1,
 	},
-- 
2.7.4
