From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 16 Sep 2019 16:50:25 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 11/32] drm: rcar-du: dw-hdmi: Reject
	modes with a too high clock frequency
In-Reply-To: <1568649046-17420-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1568649046-17420-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1568649046-17420-12-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit f41cb153e6faf0d1f4bbe0b0f15aa20de1e43e90 upstream.

Implement a .mode_valid() handler in the R-Car glue layer to reject
modes with an unsupported clock frequency.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c b/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
index 76210ae..8e6abe8 100644
--- a/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
+++ b/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
@@ -39,6 +39,20 @@ static const struct rcar_hdmi_phy_params rcar_hdmi_phy_params[] = {
 	{ ~0UL,      0x0000, 0x0000, 0x0000 },
 };
 
+static enum drm_mode_status
+rcar_hdmi_mode_valid(struct drm_connector *connector,
+		     const struct drm_display_mode *mode)
+{
+	/*
+	 * The maximum supported clock frequency is 297 MHz, as shown in the PHY
+	 * parameters table.
+	 */
+	if (mode->clock > 297000)
+		return MODE_CLOCK_HIGH;
+
+	return MODE_OK;
+}
+
 static int rcar_hdmi_phy_configure(struct dw_hdmi *hdmi,
 				   const struct dw_hdmi_plat_data *pdata,
 				   unsigned long mpixelclock)
@@ -63,6 +77,7 @@ static int rcar_hdmi_phy_configure(struct dw_hdmi *hdmi,
 }
 
 static const struct dw_hdmi_plat_data rcar_dw_hdmi_plat_data = {
+	.mode_valid = rcar_hdmi_mode_valid,
 	.configure_phy	= rcar_hdmi_phy_configure,
 };
 
-- 
2.7.4
