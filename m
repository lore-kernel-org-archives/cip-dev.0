From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 17 Sep 2019 14:07:48 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip v2 20/32] drm: rcar-du: Store V4L2
	fourcc in rcar_du_format_info structure
In-Reply-To: <1568725680-32730-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1568725680-32730-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1568725680-32730-21-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit d8a4ef2542cddfd843896662a624494a01ee59a7 upstream.

The mapping between DRM and V4L2 fourcc's is stored in two separate
tables in rcar_du_vsp.c. In order to make it reusable to implement
writeback support, move it to the rcar_du_format_info structure.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 25 +++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_kms.h |  1 +
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c | 45 +++++------------------------------
 3 files changed, 32 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index c5428c3..d2094ae 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -37,60 +37,70 @@
 static const struct rcar_du_format_info rcar_du_format_infos[] = {
 	{
 		.fourcc = DRM_FORMAT_RGB565,
+		.v4l2 = V4L2_PIX_FMT_RGB565,
 		.bpp = 16,
 		.planes = 1,
 		.pnmr = PnMR_SPIM_TP | PnMR_DDDF_16BPP,
 		.edf = PnDDCR4_EDF_NONE,
 	}, {
 		.fourcc = DRM_FORMAT_ARGB1555,
+		.v4l2 = V4L2_PIX_FMT_ARGB555,
 		.bpp = 16,
 		.planes = 1,
 		.pnmr = PnMR_SPIM_ALP | PnMR_DDDF_ARGB,
 		.edf = PnDDCR4_EDF_NONE,
 	}, {
 		.fourcc = DRM_FORMAT_XRGB1555,
+		.v4l2 = V4L2_PIX_FMT_XRGB555,
 		.bpp = 16,
 		.planes = 1,
 		.pnmr = PnMR_SPIM_ALP | PnMR_DDDF_ARGB,
 		.edf = PnDDCR4_EDF_NONE,
 	}, {
 		.fourcc = DRM_FORMAT_XRGB8888,
+		.v4l2 = V4L2_PIX_FMT_XBGR32,
 		.bpp = 32,
 		.planes = 1,
 		.pnmr = PnMR_SPIM_TP | PnMR_DDDF_16BPP,
 		.edf = PnDDCR4_EDF_RGB888,
 	}, {
 		.fourcc = DRM_FORMAT_ARGB8888,
+		.v4l2 = V4L2_PIX_FMT_ABGR32,
 		.bpp = 32,
 		.planes = 1,
 		.pnmr = PnMR_SPIM_ALP | PnMR_DDDF_16BPP,
 		.edf = PnDDCR4_EDF_ARGB8888,
 	}, {
 		.fourcc = DRM_FORMAT_UYVY,
+		.v4l2 = V4L2_PIX_FMT_UYVY,
 		.bpp = 16,
 		.planes = 1,
 		.pnmr = PnMR_SPIM_TP_OFF | PnMR_DDDF_YC,
 		.edf = PnDDCR4_EDF_NONE,
 	}, {
 		.fourcc = DRM_FORMAT_YUYV,
+		.v4l2 = V4L2_PIX_FMT_YUYV,
 		.bpp = 16,
 		.planes = 1,
 		.pnmr = PnMR_SPIM_TP_OFF | PnMR_DDDF_YC,
 		.edf = PnDDCR4_EDF_NONE,
 	}, {
 		.fourcc = DRM_FORMAT_NV12,
+		.v4l2 = V4L2_PIX_FMT_NV12M,
 		.bpp = 12,
 		.planes = 2,
 		.pnmr = PnMR_SPIM_TP_OFF | PnMR_DDDF_YC,
 		.edf = PnDDCR4_EDF_NONE,
 	}, {
 		.fourcc = DRM_FORMAT_NV21,
+		.v4l2 = V4L2_PIX_FMT_NV21M,
 		.bpp = 12,
 		.planes = 2,
 		.pnmr = PnMR_SPIM_TP_OFF | PnMR_DDDF_YC,
 		.edf = PnDDCR4_EDF_NONE,
 	}, {
 		.fourcc = DRM_FORMAT_NV16,
+		.v4l2 = V4L2_PIX_FMT_NV16M,
 		.bpp = 16,
 		.planes = 2,
 		.pnmr = PnMR_SPIM_TP_OFF | PnMR_DDDF_YC,
@@ -102,62 +112,77 @@ static const struct rcar_du_format_info rcar_du_format_infos[] = {
 	 */
 	{
 		.fourcc = DRM_FORMAT_RGB332,
+		.v4l2 = V4L2_PIX_FMT_RGB332,
 		.bpp = 8,
 		.planes = 1,
 	}, {
 		.fourcc = DRM_FORMAT_ARGB4444,
+		.v4l2 = V4L2_PIX_FMT_ARGB444,
 		.bpp = 16,
 		.planes = 1,
 	}, {
 		.fourcc = DRM_FORMAT_XRGB4444,
+		.v4l2 = V4L2_PIX_FMT_XRGB444,
 		.bpp = 16,
 		.planes = 1,
 	}, {
 		.fourcc = DRM_FORMAT_BGR888,
+		.v4l2 = V4L2_PIX_FMT_RGB24,
 		.bpp = 24,
 		.planes = 1,
 	}, {
 		.fourcc = DRM_FORMAT_RGB888,
+		.v4l2 = V4L2_PIX_FMT_BGR24,
 		.bpp = 24,
 		.planes = 1,
 	}, {
 		.fourcc = DRM_FORMAT_BGRA8888,
+		.v4l2 = V4L2_PIX_FMT_ARGB32,
 		.bpp = 32,
 		.planes = 1,
 	}, {
 		.fourcc = DRM_FORMAT_BGRX8888,
+		.v4l2 = V4L2_PIX_FMT_XRGB32,
 		.bpp = 32,
 		.planes = 1,
 	}, {
 		.fourcc = DRM_FORMAT_YVYU,
+		.v4l2 = V4L2_PIX_FMT_YVYU,
 		.bpp = 16,
 		.planes = 1,
 	}, {
 		.fourcc = DRM_FORMAT_NV61,
+		.v4l2 = V4L2_PIX_FMT_NV61M,
 		.bpp = 16,
 		.planes = 2,
 	}, {
 		.fourcc = DRM_FORMAT_YUV420,
+		.v4l2 = V4L2_PIX_FMT_YUV420M,
 		.bpp = 12,
 		.planes = 3,
 	}, {
 		.fourcc = DRM_FORMAT_YVU420,
+		.v4l2 = V4L2_PIX_FMT_YVU420M,
 		.bpp = 12,
 		.planes = 3,
 	}, {
 		.fourcc = DRM_FORMAT_YUV422,
+		.v4l2 = V4L2_PIX_FMT_YUV422M,
 		.bpp = 16,
 		.planes = 3,
 	}, {
 		.fourcc = DRM_FORMAT_YVU422,
+		.v4l2 = V4L2_PIX_FMT_YVU422M,
 		.bpp = 16,
 		.planes = 3,
 	}, {
 		.fourcc = DRM_FORMAT_YUV444,
+		.v4l2 = V4L2_PIX_FMT_YUV444M,
 		.bpp = 24,
 		.planes = 3,
 	}, {
 		.fourcc = DRM_FORMAT_YVU444,
+		.v4l2 = V4L2_PIX_FMT_YVU444M,
 		.bpp = 24,
 		.planes = 3,
 	},
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.h b/drivers/gpu/drm/rcar-du/rcar_du_kms.h
index 07951d5..d0134b2 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.h
@@ -23,6 +23,7 @@ struct rcar_du_device;
 
 struct rcar_du_format_info {
 	u32 fourcc;
+	u32 v4l2;
 	unsigned int bpp;
 	unsigned int planes;
 	unsigned int pnmr;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
index a042f11..e325c965 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
@@ -115,8 +115,7 @@ void rcar_du_vsp_atomic_flush(struct rcar_du_crtc *crtc)
 	vsp1_du_atomic_flush(crtc->vsp->vsp, crtc->vsp_pipe, &cfg);
 }
 
-/* Keep the two tables in sync. */
-static const u32 formats_kms[] = {
+static const u32 rcar_du_vsp_formats[] = {
 	DRM_FORMAT_RGB332,
 	DRM_FORMAT_ARGB4444,
 	DRM_FORMAT_XRGB4444,
@@ -145,41 +144,13 @@ static const u32 formats_kms[] = {
 	DRM_FORMAT_YVU444,
 };
 
-static const u32 formats_v4l2[] = {
-	V4L2_PIX_FMT_RGB332,
-	V4L2_PIX_FMT_ARGB444,
-	V4L2_PIX_FMT_XRGB444,
-	V4L2_PIX_FMT_ARGB555,
-	V4L2_PIX_FMT_XRGB555,
-	V4L2_PIX_FMT_RGB565,
-	V4L2_PIX_FMT_RGB24,
-	V4L2_PIX_FMT_BGR24,
-	V4L2_PIX_FMT_ARGB32,
-	V4L2_PIX_FMT_XRGB32,
-	V4L2_PIX_FMT_ABGR32,
-	V4L2_PIX_FMT_XBGR32,
-	V4L2_PIX_FMT_UYVY,
-	V4L2_PIX_FMT_VYUY,
-	V4L2_PIX_FMT_YUYV,
-	V4L2_PIX_FMT_YVYU,
-	V4L2_PIX_FMT_NV12M,
-	V4L2_PIX_FMT_NV21M,
-	V4L2_PIX_FMT_NV16M,
-	V4L2_PIX_FMT_NV61M,
-	V4L2_PIX_FMT_YUV420M,
-	V4L2_PIX_FMT_YVU420M,
-	V4L2_PIX_FMT_YUV422M,
-	V4L2_PIX_FMT_YVU422M,
-	V4L2_PIX_FMT_YUV444M,
-	V4L2_PIX_FMT_YVU444M,
-};
-
 static void rcar_du_vsp_plane_setup(struct rcar_du_vsp_plane *plane)
 {
 	struct rcar_du_vsp_plane_state *state =
 		to_rcar_vsp_plane_state(plane->plane.state);
 	struct rcar_du_crtc *crtc = to_rcar_crtc(state->state.crtc);
 	struct drm_framebuffer *fb = plane->plane.state->fb;
+	const struct rcar_du_format_info *format;
 	struct vsp1_du_atomic_config cfg = {
 		.pixelformat = 0,
 		.pitch = fb->pitches[0],
@@ -202,12 +173,8 @@ static void rcar_du_vsp_plane_setup(struct rcar_du_vsp_plane *plane)
 		cfg.mem[i] = sg_dma_address(state->sg_tables[i].sgl)
 			   + fb->offsets[i];
 
-	for (i = 0; i < ARRAY_SIZE(formats_kms); ++i) {
-		if (formats_kms[i] == state->format->fourcc) {
-			cfg.pixelformat = formats_v4l2[i];
-			break;
-		}
-	}
+	format = rcar_du_format_info(state->format->fourcc);
+	cfg.pixelformat = format->v4l2;
 
 	vsp1_du_atomic_update(plane->vsp->vsp, crtc->vsp_pipe,
 			      plane->index, &cfg);
@@ -405,8 +372,8 @@ int rcar_du_vsp_init(struct rcar_du_vsp *vsp, struct device_node *np,
 
 		ret = drm_universal_plane_init(rcdu->ddev, &plane->plane, crtcs,
 					       &rcar_du_vsp_plane_funcs,
-					       formats_kms,
-					       ARRAY_SIZE(formats_kms),
+					       rcar_du_vsp_formats,
+					       ARRAY_SIZE(rcar_du_vsp_formats),
 					       NULL, type, NULL);
 		if (ret < 0)
 			return ret;
-- 
2.7.4
