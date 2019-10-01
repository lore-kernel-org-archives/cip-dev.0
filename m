From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  1 Oct 2019 09:25:12 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 13/32] drm: rcar-du: lvds: Don't fail
	probe if output is not connected on D3/E3
In-Reply-To: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1569918331-6990-14-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit 6e1f8557818f3c2476404ba1d4a5157b823b79f0 upstream.

On the D3 and E3 SoCs the LVDS encoder has an extended internal PLL and
supplies a clock to the DU. That clock is used not only for the LVDS
outputs but also for the DPAD output. The LVDS encoder thus needs to be
available to the DU even when its output is disabled. Don't fail probe
in that case on D3 and E3.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_lvds.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
index 694a627..8b08d61 100644
--- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
@@ -544,7 +544,10 @@ static int rcar_lvds_attach(struct drm_bridge *bridge)
 		return drm_bridge_attach(bridge->encoder, lvds->next_bridge,
 					 bridge);
 
-	/* Otherwise we have a panel, create a connector. */
+	/* Otherwise if we have a panel, create a connector. */
+	if (!lvds->panel)
+		return 0;
+
 	ret = drm_connector_init(bridge->dev, connector, &rcar_lvds_conn_funcs,
 				 DRM_MODE_CONNECTOR_LVDS);
 	if (ret < 0)
@@ -592,7 +595,8 @@ static int rcar_lvds_parse_dt(struct rcar_lvds *lvds)
 	local_output = of_graph_get_endpoint_by_regs(lvds->dev->of_node, 1, 0);
 	if (!local_output) {
 		dev_dbg(lvds->dev, "unconnected port at 1\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto done;
 	}
 
 	/*
@@ -642,6 +646,15 @@ static int rcar_lvds_parse_dt(struct rcar_lvds *lvds)
 	of_node_put(remote_input);
 	of_node_put(remote);
 
+	/*
+	 * On D3/E3 the LVDS encoder provides a clock to the DU, which can be
+	 * used for the DPAD output even when the LVDS output is not connected.
+	 * Don't fail probe in that case as the DU will need the bridge to
+	 * control the clock.
+	 */
+	if (lvds->info->quirks & RCAR_LVDS_QUIRK_EXT_PLL)
+		return ret == -ENODEV ? 0 : ret;
+
 	return ret;
 }
 
-- 
2.7.4
