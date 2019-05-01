From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed,  1 May 2019 11:22:20 +0100
Subject: [cip-dev] [PATCH 4.19.y 26/29] thermal: rcar_thermal: add R8A774C0
	support
In-Reply-To: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1556706143-11898-27-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit b8d3d11203afddf9e6c4e8b8ccecd401b6a8cc3e upstream.

Add thermal support for the RZ/G2E SoC (a.k.a. R8A774C0).

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/rcar_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 8df2ce9..8415700 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -113,6 +113,10 @@ static const struct of_device_id rcar_thermal_dt_ids[] = {
 		 .data = &rcar_gen2_thermal,
 	},
 	{
+		.compatible = "renesas,thermal-r8a774c0",
+		.data = &rcar_gen3_thermal,
+	},
+	{
 		.compatible = "renesas,thermal-r8a77995",
 		.data = &rcar_gen3_thermal,
 	},
-- 
2.7.4
