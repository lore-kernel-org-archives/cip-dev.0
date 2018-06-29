From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:39:25 +0100
Subject: [cip-dev] [PATCH 84/86] drm: rcar-du: Add R8A7745 support
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-85-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add support for the R8A7745 DU (which is very similar to the R8A7794 DU);
it has 2 RGB outputs.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
(cherry picked from commit cdd90700157293dc7cb67d932b4f2fc44bd2a623)
(removed .gen and added .encoder_type to rzg1_du_r8a7745_info.)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index eee90f5..5187ed3 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -57,6 +57,28 @@ static const struct rcar_du_device_info rzg1_du_r8a7743_info = {
 	.num_lvds = 1,
 };
 
+static const struct rcar_du_device_info rzg1_du_r8a7745_info = {
+	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
+		  | RCAR_DU_FEATURE_EXT_CTRL_REGS,
+	.num_crtcs = 2,
+	.routes = {
+		/*
+		 * R8A7745 has two RGB outputs
+		 */
+		[RCAR_DU_OUTPUT_DPAD0] = {
+			.possible_crtcs = BIT(0),
+			.encoder_type = DRM_MODE_ENCODER_NONE,
+			.port = 0,
+		},
+		[RCAR_DU_OUTPUT_DPAD1] = {
+			.possible_crtcs = BIT(1),
+			.encoder_type = DRM_MODE_ENCODER_NONE,
+			.port = 1,
+		},
+	},
+	.num_lvds = 0,
+};
+
 static const struct rcar_du_device_info rcar_du_r8a7779_info = {
 	.features = 0,
 	.num_crtcs = 2,
@@ -153,6 +175,7 @@ static const struct rcar_du_device_info rcar_du_r8a7794_info = {
 
 static const struct of_device_id rcar_du_of_table[] = {
 	{ .compatible = "renesas,du-r8a7743", .data = &rzg1_du_r8a7743_info },
+	{ .compatible = "renesas,du-r8a7745", .data = &rzg1_du_r8a7745_info },
 	{ .compatible = "renesas,du-r8a7779", .data = &rcar_du_r8a7779_info },
 	{ .compatible = "renesas,du-r8a7790", .data = &rcar_du_r8a7790_info },
 	{ .compatible = "renesas,du-r8a7791", .data = &rcar_du_r8a7791_info },
-- 
2.7.4
