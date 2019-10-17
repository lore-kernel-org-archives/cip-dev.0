From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:04:57 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 25/57] ASoC: rsnd: remove endpoint
	bidirectional check
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-26-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit c8b222bf110ccb54d787f695fb3eb2fb6b723903 upstream.

DTC commit df536831d02c ("checks: add graph binding checks")
is checking endpoint bidirectional, and it is upstreamed to linux by
commit 50aafd60898a ("scripts/dtc: Update to upstream version
v1.4.6-21-g84e414b0b5bc").
Let's remove own bidirectional check

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/ssi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 81d3864..65cd629 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -1095,11 +1095,7 @@ void rsnd_ssi_parse_hdmi_connection(struct rsnd_priv *priv,
 				    int dai_i)
 {
 	struct rsnd_dai *rdai = rsnd_rdai_get(priv, dai_i);
-	struct device_node *remote_ep;
-
-	remote_ep = of_graph_get_remote_endpoint(endpoint);
-	if (!remote_ep)
-		return;
+	struct device_node *remote_ep = of_graph_get_remote_endpoint(endpoint);
 
 	__rsnd_ssi_parse_hdmi_connection(priv, &rdai->playback, remote_ep);
 	__rsnd_ssi_parse_hdmi_connection(priv, &rdai->capture,  remote_ep);
-- 
2.7.4
