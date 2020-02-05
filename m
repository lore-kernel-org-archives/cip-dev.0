From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Wed,  5 Feb 2020 20:38:38 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 12/35] drm: rcar-du: Add R8A774B1
	support
In-Reply-To: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1580935141-1173-13-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 47968ea96af335b56a0db6c305146e720363558c upstream.

Add support for the R8A774B1 DU (which is very similar to the R8A77965 DU
except that it lacks TCON and CMM); it has one RGB output, one LVDS output
and one HDMI output.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index d22b381..d881a27 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -109,6 +109,35 @@ static const struct rcar_du_device_info rcar_du_r8a774a1_info = {
 	.dpll_mask =  BIT(1),
 };
 
+static const struct rcar_du_device_info rcar_du_r8a774b1_info = {
+	.gen = 3,
+	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
+		  | RCAR_DU_FEATURE_VSP1_SOURCE
+		  | RCAR_DU_FEATURE_INTERLACED
+		  | RCAR_DU_FEATURE_TVM_SYNC,
+	.channels_mask = BIT(3) | BIT(1) | BIT(0),
+	.routes = {
+		/*
+		 * R8A774B1 has one RGB output, one LVDS output and one HDMI
+		 * output.
+		 */
+		[RCAR_DU_OUTPUT_DPAD0] = {
+			.possible_crtcs = BIT(2),
+			.port = 0,
+		},
+		[RCAR_DU_OUTPUT_HDMI0] = {
+			.possible_crtcs = BIT(1),
+			.port = 1,
+		},
+		[RCAR_DU_OUTPUT_LVDS0] = {
+			.possible_crtcs = BIT(0),
+			.port = 2,
+		},
+	},
+	.num_lvds = 1,
+	.dpll_mask =  BIT(1),
+};
+
 static const struct rcar_du_device_info rcar_du_r8a774c0_info = {
 	.gen = 3,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
@@ -365,6 +394,7 @@ static const struct of_device_id rcar_du_of_table[] = {
 	{ .compatible = "renesas,du-r8a7743", .data = &rzg1_du_r8a7743_info },
 	{ .compatible = "renesas,du-r8a7745", .data = &rzg1_du_r8a7745_info },
 	{ .compatible = "renesas,du-r8a774a1", .data = &rcar_du_r8a774a1_info },
+	{ .compatible = "renesas,du-r8a774b1", .data = &rcar_du_r8a774b1_info },
 	{ .compatible = "renesas,du-r8a774c0", .data = &rcar_du_r8a774c0_info },
 	{ .compatible = "renesas,du-r8a7779", .data = &rcar_du_r8a7779_info },
 	{ .compatible = "renesas,du-r8a7790", .data = &rcar_du_r8a7790_info },
-- 
2.7.4
