From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 15 May 2018 12:19:52 +0100
Subject: [cip-dev] [PATCH 2/7] drm: rcar-du: Add R8A7743 support
In-Reply-To: <1526383197-5913-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1526383197-5913-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1526383197-5913-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add support for the R8A7743 DU (which is very similar to the R8A7791 DU);
it has 1 DPAD (RGB) output and 1 LVDS output.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
(cherry picked from commit 36a46da90212ddeeb78c2f902caaca264d8496a9)
(removed .gen/added .encoder_type from/to rzg1_du_r8a7743_info)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index bb9cd35..eee90f5 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -35,6 +35,28 @@
  * Device Information
  */
 
+static const struct rcar_du_device_info rzg1_du_r8a7743_info = {
+	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
+		  | RCAR_DU_FEATURE_EXT_CTRL_REGS,
+	.num_crtcs = 2,
+	.routes = {
+		/*
+		 * R8A7743 has one RGB output and one LVDS output
+		 */
+		[RCAR_DU_OUTPUT_DPAD0] = {
+			.possible_crtcs = BIT(1) | BIT(0),
+			.encoder_type = DRM_MODE_ENCODER_NONE,
+			.port = 0,
+		},
+		[RCAR_DU_OUTPUT_LVDS0] = {
+			.possible_crtcs = BIT(0),
+			.encoder_type = DRM_MODE_ENCODER_LVDS,
+			.port = 1,
+		},
+	},
+	.num_lvds = 1,
+};
+
 static const struct rcar_du_device_info rcar_du_r8a7779_info = {
 	.features = 0,
 	.num_crtcs = 2,
@@ -130,6 +152,7 @@ static const struct rcar_du_device_info rcar_du_r8a7794_info = {
 };
 
 static const struct of_device_id rcar_du_of_table[] = {
+	{ .compatible = "renesas,du-r8a7743", .data = &rzg1_du_r8a7743_info },
 	{ .compatible = "renesas,du-r8a7779", .data = &rcar_du_r8a7779_info },
 	{ .compatible = "renesas,du-r8a7790", .data = &rcar_du_r8a7790_info },
 	{ .compatible = "renesas,du-r8a7791", .data = &rcar_du_r8a7791_info },
-- 
2.7.4
