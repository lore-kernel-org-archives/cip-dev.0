From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:04:33 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 01/57] ASoC: rsnd: add warning message
	to rsnd_kctrl_accept_runtime()
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jiada Wang <jiada_wang@mentor.com>

commit b5c088689847372794500f83b65673aaa8ca4d8d upstream.

Add warning message to rsnd_kctrl_accept_runtime(), when kctrl
update is rejected due to corresponding dai-link is idle.
So that user can notice the reason of kctrl update failure.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
[kuninori: adjust to upstream]
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index d23c2bb..36a369d 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1274,8 +1274,15 @@ int rsnd_kctrl_accept_anytime(struct rsnd_dai_stream *io)
 int rsnd_kctrl_accept_runtime(struct rsnd_dai_stream *io)
 {
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
+	struct rsnd_priv *priv = rsnd_io_to_priv(io);
+	struct device *dev = rsnd_priv_to_dev(priv);
+
+	if (!runtime) {
+		dev_warn(dev, "Can't update kctrl when idle\n");
+		return 0;
+	}
 
-	return !!runtime;
+	return 1;
 }
 
 struct rsnd_kctrl_cfg *rsnd_kctrl_init_m(struct rsnd_kctrl_cfg_m *cfg)
-- 
2.7.4
