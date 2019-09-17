From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 17 Sep 2019 14:07:47 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip v2 19/32] drm: rcar-du: Add support for
	missing pixel formats
In-Reply-To: <1568725680-32730-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1568725680-32730-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1568725680-32730-20-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

commit 0f35b25b87923394cd9048a199d05e994fbf8bae upstream.

This patch supports pixel format of RGB332, ARGB4444, XRGB4444,
BGR888, RGB888, BGRA8888, BGRX8888 and YVYU.
VYUY pixel format is not supported by H/W specification.

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[Reordered formats with RGB first]
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 0386b45..c5428c3 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -101,6 +101,38 @@ static const struct rcar_du_format_info rcar_du_format_infos[] = {
 	 * associated .pnmr or .edf settings.
 	 */
 	{
+		.fourcc = DRM_FORMAT_RGB332,
+		.bpp = 8,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_ARGB4444,
+		.bpp = 16,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_XRGB4444,
+		.bpp = 16,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_BGR888,
+		.bpp = 24,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_RGB888,
+		.bpp = 24,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_BGRA8888,
+		.bpp = 32,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_BGRX8888,
+		.bpp = 32,
+		.planes = 1,
+	}, {
+		.fourcc = DRM_FORMAT_YVYU,
+		.bpp = 16,
+		.planes = 1,
+	}, {
 		.fourcc = DRM_FORMAT_NV61,
 		.bpp = 16,
 		.planes = 2,
-- 
2.7.4
