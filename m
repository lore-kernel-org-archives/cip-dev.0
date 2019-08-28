From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 14:31:57 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip v2 10/57] thermal: rcar_gen3_thermal:
	Add r8a774a1 support
In-Reply-To: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566999164-27898-11-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 1d9e6cf3c8537c14ad979a9c02ce4e674e5f50e8 upstream.

Add r8a774a1 specific compatible string.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 704c8ad..393ed96 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -318,6 +318,7 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
 }
 
 static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
+	{ .compatible = "renesas,r8a774a1-thermal", },
 	{ .compatible = "renesas,r8a7795-thermal", },
 	{ .compatible = "renesas,r8a7796-thermal", },
 	{ .compatible = "renesas,r8a77965-thermal", },
-- 
2.7.4
