From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:05:28 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 56/57] ASoC: rsnd: do error check after
	rsnd_channel_normalization()
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-57-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 947ec14c7369a87625f03abaab5b3f4d33ac73ba upstream.

SSI need to use rsnd_channel_normalization() for TDM-split mode,
thus, channel check need to do after that.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/874l1aw39d.wl-kuninori.morimoto.gx at renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/ssi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index f6a7466..fc5d089 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -286,6 +286,11 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 	if (rsnd_ssi_is_multi_slave(mod, io))
 		return 0;
 
+	if (rsnd_runtime_is_tdm_split(io))
+		chan = rsnd_io_converted_chan(io);
+
+	chan = rsnd_channel_normalization(chan);
+
 	if (ssi->usrcnt > 0) {
 		if (ssi->rate != rate) {
 			dev_err(dev, "SSI parent/child should use same rate\n");
@@ -300,11 +305,6 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 		return 0;
 	}
 
-	if (rsnd_runtime_is_tdm_split(io))
-		chan = rsnd_io_converted_chan(io);
-
-	chan = rsnd_channel_normalization(chan);
-
 	main_rate = rsnd_ssi_clk_query(rdai, rate, chan, &idx);
 	if (!main_rate) {
 		dev_err(dev, "unsupported clock rate\n");
-- 
2.7.4
