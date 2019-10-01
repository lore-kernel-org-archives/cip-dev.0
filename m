From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  1 Oct 2019 09:25:08 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 09/32] drm: rcar-du: Add r8a774c0
	device support
In-Reply-To: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1569918331-6990-10-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 939ef2a586e5f7bce4e4465cfd5afe7758fb9f74 upstream.

Add support for the RZ/G2E (R8A774C0) SoC to the R-Car DU driver.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 5380f0e..708ebd9 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -110,6 +110,32 @@ static const struct rcar_du_device_info rcar_du_r8a774a1_info = {
 	.dpll_mask =  BIT(1),
 };
 
+static const struct rcar_du_device_info rcar_du_r8a774c0_info = {
+	.gen = 3,
+	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
+		  | RCAR_DU_FEATURE_VSP1_SOURCE,
+	.channels_mask = BIT(1) | BIT(0),
+	.routes = {
+		/*
+		 * R8A774C0 has one RGB output and two LVDS outputs
+		 */
+		[RCAR_DU_OUTPUT_DPAD0] = {
+			.possible_crtcs = BIT(0) | BIT(1),
+			.port = 0,
+		},
+		[RCAR_DU_OUTPUT_LVDS0] = {
+			.possible_crtcs = BIT(0),
+			.port = 1,
+		},
+		[RCAR_DU_OUTPUT_LVDS1] = {
+			.possible_crtcs = BIT(1),
+			.port = 2,
+		},
+	},
+	.num_lvds = 2,
+	.lvds_clk_mask =  BIT(1) | BIT(0),
+};
+
 static const struct rcar_du_device_info rcar_du_r8a7779_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_INTERLACED
@@ -348,6 +374,7 @@ static const struct of_device_id rcar_du_of_table[] = {
 	{ .compatible = "renesas,du-r8a7743", .data = &rzg1_du_r8a7743_info },
 	{ .compatible = "renesas,du-r8a7745", .data = &rzg1_du_r8a7745_info },
 	{ .compatible = "renesas,du-r8a774a1", .data = &rcar_du_r8a774a1_info },
+	{ .compatible = "renesas,du-r8a774c0", .data = &rcar_du_r8a774c0_info },
 	{ .compatible = "renesas,du-r8a7779", .data = &rcar_du_r8a7779_info },
 	{ .compatible = "renesas,du-r8a7790", .data = &rcar_du_r8a7790_info },
 	{ .compatible = "renesas,du-r8a7791", .data = &rcar_du_r8a7791_info },
-- 
2.7.4
