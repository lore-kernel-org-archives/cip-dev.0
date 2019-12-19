From: marian-cristian.rotariu.rb@bp.renesas.com (Marian-Cristian Rotariu)
Date: Thu, 19 Dec 2019 15:05:51 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 2/3] drm: rcar-du: Add R8A7744 support
In-Reply-To: <1576767952-15873-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1576767952-15873-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <1576767952-15873-3-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 5dc34af19c98171174f563a4b9f79a902bf665b4 upstream.

Add support for the R8A7744 DU (which is very similar to the R8A7743 DU);
it has 1 DPAD (RGB) output and 1 LVDS output.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 5187ed3..edb9c3f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -41,7 +41,7 @@ static const struct rcar_du_device_info rzg1_du_r8a7743_info = {
 	.num_crtcs = 2,
 	.routes = {
 		/*
-		 * R8A7743 has one RGB output and one LVDS output
+		 * R8A774[34] has one RGB output and one LVDS output
 		 */
 		[RCAR_DU_OUTPUT_DPAD0] = {
 			.possible_crtcs = BIT(1) | BIT(0),
@@ -175,6 +175,7 @@ static const struct rcar_du_device_info rcar_du_r8a7794_info = {
 
 static const struct of_device_id rcar_du_of_table[] = {
 	{ .compatible = "renesas,du-r8a7743", .data = &rzg1_du_r8a7743_info },
+	{ .compatible = "renesas,du-r8a7744", .data = &rzg1_du_r8a7743_info },
 	{ .compatible = "renesas,du-r8a7745", .data = &rzg1_du_r8a7745_info },
 	{ .compatible = "renesas,du-r8a7779", .data = &rcar_du_r8a7779_info },
 	{ .compatible = "renesas,du-r8a7790", .data = &rcar_du_r8a7790_info },
-- 
2.7.4
