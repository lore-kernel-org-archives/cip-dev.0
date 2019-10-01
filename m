From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  1 Oct 2019 09:25:06 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 07/32] drm: rcar-du: Perform the
	initial CRTC setup from rcar_du_crtc_get()
In-Reply-To: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1569918331-6990-8-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit 0bb63534fdf3bc9a82bcfe9f5c6a9653b8b2a3f1 upstream.

The rcar_du_crtc_get() function is always immediately followed by a call
to rcar_du_crtc_setup(). Call the later from the former to simplify the
code, and add a comment to explain how the get and put calls are
balanced.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 107 +++++++++++++++++----------------
 1 file changed, 56 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 107cbf2..57cdc5f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -69,39 +69,6 @@ void rcar_du_crtc_dsysr_clr_set(struct rcar_du_crtc *rcrtc, u32 clr, u32 set)
 	rcar_du_write(rcdu, rcrtc->mmio_offset + DSYSR, rcrtc->dsysr);
 }
 
-static int rcar_du_crtc_get(struct rcar_du_crtc *rcrtc)
-{
-	int ret;
-
-	ret = clk_prepare_enable(rcrtc->clock);
-	if (ret < 0)
-		return ret;
-
-	ret = clk_prepare_enable(rcrtc->extclock);
-	if (ret < 0)
-		goto error_clock;
-
-	ret = rcar_du_group_get(rcrtc->group);
-	if (ret < 0)
-		goto error_group;
-
-	return 0;
-
-error_group:
-	clk_disable_unprepare(rcrtc->extclock);
-error_clock:
-	clk_disable_unprepare(rcrtc->clock);
-	return ret;
-}
-
-static void rcar_du_crtc_put(struct rcar_du_crtc *rcrtc)
-{
-	rcar_du_group_put(rcrtc->group);
-
-	clk_disable_unprepare(rcrtc->extclock);
-	clk_disable_unprepare(rcrtc->clock);
-}
-
 /* -----------------------------------------------------------------------------
  * Hardware Setup
  */
@@ -527,6 +494,51 @@ static void rcar_du_crtc_setup(struct rcar_du_crtc *rcrtc)
 	drm_crtc_vblank_on(&rcrtc->crtc);
 }
 
+static int rcar_du_crtc_get(struct rcar_du_crtc *rcrtc)
+{
+	int ret;
+
+	/*
+	 * Guard against double-get, as the function is called from both the
+	 * .atomic_enable() and .atomic_begin() handlers.
+	 */
+	if (rcrtc->initialized)
+		return 0;
+
+	ret = clk_prepare_enable(rcrtc->clock);
+	if (ret < 0)
+		return ret;
+
+	ret = clk_prepare_enable(rcrtc->extclock);
+	if (ret < 0)
+		goto error_clock;
+
+	ret = rcar_du_group_get(rcrtc->group);
+	if (ret < 0)
+		goto error_group;
+
+	rcar_du_crtc_setup(rcrtc);
+	rcrtc->initialized = true;
+
+	return 0;
+
+error_group:
+	clk_disable_unprepare(rcrtc->extclock);
+error_clock:
+	clk_disable_unprepare(rcrtc->clock);
+	return ret;
+}
+
+static void rcar_du_crtc_put(struct rcar_du_crtc *rcrtc)
+{
+	rcar_du_group_put(rcrtc->group);
+
+	clk_disable_unprepare(rcrtc->extclock);
+	clk_disable_unprepare(rcrtc->clock);
+
+	rcrtc->initialized = false;
+}
+
 static void rcar_du_crtc_start(struct rcar_du_crtc *rcrtc)
 {
 	bool interlaced;
@@ -625,16 +637,7 @@ static void rcar_du_crtc_atomic_enable(struct drm_crtc *crtc,
 {
 	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
 
-	/*
-	 * If the CRTC has already been setup by the .atomic_begin() handler we
-	 * can skip the setup stage.
-	 */
-	if (!rcrtc->initialized) {
-		rcar_du_crtc_get(rcrtc);
-		rcar_du_crtc_setup(rcrtc);
-		rcrtc->initialized = true;
-	}
-
+	rcar_du_crtc_get(rcrtc);
 	rcar_du_crtc_start(rcrtc);
 }
 
@@ -653,7 +656,6 @@ static void rcar_du_crtc_atomic_disable(struct drm_crtc *crtc,
 	}
 	spin_unlock_irq(&crtc->dev->event_lock);
 
-	rcrtc->initialized = false;
 	rcrtc->outputs = 0;
 }
 
@@ -666,14 +668,17 @@ static void rcar_du_crtc_atomic_begin(struct drm_crtc *crtc,
 
 	/*
 	 * If a mode set is in progress we can be called with the CRTC disabled.
-	 * We then need to first setup the CRTC in order to configure planes.
-	 * The .atomic_enable() handler will notice and skip the CRTC setup.
+	 * We thus need to first get and setup the CRTC in order to configure
+	 * planes. We must *not* put the CRTC in .atomic_flush(), as it must be
+	 * kept awake until the .atomic_enable() call that will follow. The get
+	 * operation in .atomic_enable() will in that case be a no-op, and the
+	 * CRTC will be put later in .atomic_disable().
+	 *
+	 * If a mode set is not in progress the CRTC is enabled, and the
+	 * following get call will be a no-op. There is thus no need to belance
+	 * it in .atomic_flush() either.
 	 */
-	if (!rcrtc->initialized) {
-		rcar_du_crtc_get(rcrtc);
-		rcar_du_crtc_setup(rcrtc);
-		rcrtc->initialized = true;
-	}
+	rcar_du_crtc_get(rcrtc);
 
 	if (rcar_du_has(rcrtc->group->dev, RCAR_DU_FEATURE_VSP1_SOURCE))
 		rcar_du_vsp_atomic_begin(rcrtc);
-- 
2.7.4
