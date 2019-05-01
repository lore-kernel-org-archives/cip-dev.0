From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed,  1 May 2019 11:22:01 +0100
Subject: [cip-dev] [PATCH 4.19.y 07/29] media: rcar-vin: Add support for
	R-Car R8A77990
In-Reply-To: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1556706143-11898-8-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

commit fad6d6dd4e091992eda85364125299c9ff261111 upstream.

Add R-Car E3 R8A77990 SoC to the rcar-vin supported ones.
Based on the experimental patch from Magnus Damm.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Hans Verkuil <hansverk@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
[fab: taken out "renesas,vin-r8a77990"]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/media/platform/rcar-vin/rcar-core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/media/platform/rcar-vin/rcar-core.c b/drivers/media/platform/rcar-vin/rcar-core.c
index ce09799..fe03007 100644
--- a/drivers/media/platform/rcar-vin/rcar-core.c
+++ b/drivers/media/platform/rcar-vin/rcar-core.c
@@ -1085,6 +1085,22 @@ static const struct rvin_info rcar_info_r8a77970 = {
 	.routes = rcar_info_r8a77970_routes,
 };
 
+static const struct rvin_group_route rcar_info_r8a77990_routes[] = {
+	{ .csi = RVIN_CSI40, .channel = 0, .vin = 4, .mask = BIT(0) | BIT(3) },
+	{ .csi = RVIN_CSI40, .channel = 0, .vin = 5, .mask = BIT(2) },
+	{ .csi = RVIN_CSI40, .channel = 1, .vin = 4, .mask = BIT(2) },
+	{ .csi = RVIN_CSI40, .channel = 1, .vin = 5, .mask = BIT(1) | BIT(3) },
+	{ /* Sentinel */ }
+};
+
+static const struct rvin_info rcar_info_r8a77990 = {
+	.model = RCAR_GEN3,
+	.use_mc = true,
+	.max_width = 4096,
+	.max_height = 4096,
+	.routes = rcar_info_r8a77990_routes,
+};
+
 static const struct rvin_group_route rcar_info_r8a77995_routes[] = {
 	{ /* Sentinel */ }
 };
-- 
2.7.4
