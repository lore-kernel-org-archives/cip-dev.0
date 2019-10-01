From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  1 Oct 2019 09:25:11 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 12/32] drm: rcar-du: Simplify encoder
	registration
In-Reply-To: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1569918331-6990-13-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit 5aebc852af25d8e1bacee664a1e3abae13dab799 upstream.

Before the driver fully moved to drm_bridge and drm_panel, it was
necessary to parse DT and locate encoder and connector nodes. The
connector node is now unused and can be removed as a parameter to
rcar_du_encoder_init(). As a consequence rcar_du_encoders_init_one() can
be greatly simplified, removing most of the DT parsing.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c |  3 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.h |  3 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c     | 52 +++----------------------------
 3 files changed, 6 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
index 0ffa6d6..dc2750e 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
@@ -35,8 +35,7 @@ static const struct drm_encoder_funcs encoder_funcs = {
 
 int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 			 enum rcar_du_output output,
-			 struct device_node *enc_node,
-			 struct device_node *con_node)
+			 struct device_node *enc_node)
 {
 	struct rcar_du_encoder *renc;
 	struct drm_encoder *encoder;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.h b/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
index 2d2abca..6a00da2 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
@@ -32,7 +32,6 @@ struct rcar_du_encoder {
 
 int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 			 enum rcar_du_output output,
-			 struct device_node *enc_node,
-			 struct device_node *con_node);
+			 struct device_node *enc_node);
 
 #endif /* __RCAR_DU_ENCODER_H__ */
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 29a322d..4dc5e20 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -368,17 +368,10 @@ static int rcar_du_encoders_init_one(struct rcar_du_device *rcdu,
 				     enum rcar_du_output output,
 				     struct of_endpoint *ep)
 {
-	struct device_node *connector = NULL;
-	struct device_node *encoder = NULL;
-	struct device_node *ep_node = NULL;
-	struct device_node *entity_ep_node;
 	struct device_node *entity;
 	int ret;
 
-	/*
-	 * Locate the connected entity and infer its type from the number of
-	 * endpoints.
-	 */
+	/* Locate the connected entity and initialize the encoder. */
 	entity = of_graph_get_remote_port_parent(ep->local_node);
 	if (!entity) {
 		dev_dbg(rcdu->dev, "unconnected endpoint %pOF, skipping\n",
@@ -394,50 +387,13 @@ static int rcar_du_encoders_init_one(struct rcar_du_device *rcdu,
 		return -ENODEV;
 	}
 
-	entity_ep_node = of_graph_get_remote_endpoint(ep->local_node);
-
-	for_each_endpoint_of_node(entity, ep_node) {
-		if (ep_node == entity_ep_node)
-			continue;
-
-		/*
-		 * We've found one endpoint other than the input, this must
-		 * be an encoder. Locate the connector.
-		 */
-		encoder = entity;
-		connector = of_graph_get_remote_port_parent(ep_node);
-		of_node_put(ep_node);
-
-		if (!connector) {
-			dev_warn(rcdu->dev,
-				 "no connector for encoder %pOF, skipping\n",
-				 encoder);
-			of_node_put(entity_ep_node);
-			of_node_put(encoder);
-			return -ENODEV;
-		}
-
-		break;
-	}
-
-	of_node_put(entity_ep_node);
-
-	if (!encoder) {
-		dev_warn(rcdu->dev,
-			 "no encoder found for endpoint %pOF, skipping\n",
-			 ep->local_node);
-		of_node_put(entity);
-		return -ENODEV;
-	}
-
-	ret = rcar_du_encoder_init(rcdu, output, encoder, connector);
+	ret = rcar_du_encoder_init(rcdu, output, entity);
 	if (ret && ret != -EPROBE_DEFER)
 		dev_warn(rcdu->dev,
 			 "failed to initialize encoder %pOF on output %u (%d), skipping\n",
-			 encoder, output, ret);
+			 entity, output, ret);
 
-	of_node_put(encoder);
-	of_node_put(connector);
+	of_node_put(entity);
 
 	return ret;
 }
-- 
2.7.4
