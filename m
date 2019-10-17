From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:05:15 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 43/57] ASoC: rsnd: fixup TDM Split mode
	check for CTU
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-44-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 2264cf2e5db99cdff995592bf80ab6dea567ea91 upstream.

Renesas sound card need to judge that whether it is using
"TDM Split mode". To judge it and for other purpose, it has
rsnd_parse_connect_simple() and rsnd_parse_connect_graph(),
but these are using different judgement policy for
TDM Split mode.
It is pointless and confusable.
This patch add new rsnd_parse_tdm_split_mode() and use common
judgement policy for simple-card/audio-graph.

Without this patch, CTU will be judged as TDM Split mode
on audio-graph card.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/core.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index d53f245..f7f9d9e 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1025,7 +1025,7 @@ static const struct snd_soc_dai_ops rsnd_soc_dai_ops = {
 	.prepare	= rsnd_soc_dai_prepare,
 };
 
-static void rsnd_parse_connect_simple(struct rsnd_priv *priv,
+static void rsnd_parse_tdm_split_mode(struct rsnd_priv *priv,
 				      struct rsnd_dai_stream *io,
 				      struct device_node *dai_np)
 {
@@ -1038,9 +1038,6 @@ static void rsnd_parse_connect_simple(struct rsnd_priv *priv,
 	if (!ssiu_np)
 		return;
 
-	if (!rsnd_io_to_mod_ssi(io))
-		return;
-
 	/*
 	 * This driver assumes that it is TDM Split mode
 	 * if it includes ssiu node
@@ -1065,12 +1062,21 @@ static void rsnd_parse_connect_simple(struct rsnd_priv *priv,
 	}
 }
 
+static void rsnd_parse_connect_simple(struct rsnd_priv *priv,
+				      struct rsnd_dai_stream *io,
+				      struct device_node *dai_np)
+{
+	if (!rsnd_io_to_mod_ssi(io))
+		return;
+
+	rsnd_parse_tdm_split_mode(priv, io, dai_np);
+}
+
 static void rsnd_parse_connect_graph(struct rsnd_priv *priv,
 				     struct rsnd_dai_stream *io,
 				     struct device_node *endpoint)
 {
 	struct device *dev = rsnd_priv_to_dev(priv);
-	struct device_node *remote_port = of_graph_get_remote_port(endpoint);
 	struct device_node *remote_node = of_graph_get_remote_port_parent(endpoint);
 
 	if (!rsnd_io_to_mod_ssi(io))
@@ -1088,14 +1094,7 @@ static void rsnd_parse_connect_graph(struct rsnd_priv *priv,
 		dev_dbg(dev, "%s connected to HDMI1\n", io->name);
 	}
 
-	/*
-	 * This driver assumes that it is TDM Split mode
-	 * if remote node has multi endpoint
-	 */
-	if (of_get_child_count(remote_port) > 1) {
-		rsnd_flags_set(io, RSND_STREAM_TDM_SPLIT);
-		dev_dbg(dev, "%s is part of TDM Split\n", io->name);
-	}
+	rsnd_parse_tdm_split_mode(priv, io, endpoint);
 }
 
 void rsnd_parse_connect_common(struct rsnd_dai *rdai,
-- 
2.7.4
