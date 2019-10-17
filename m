From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:04:48 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 16/57] ASoC: add for_each_dpcm_fe()
	macro
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-17-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit d2e24d64652bf9d272e5496ae8a562bc64facff3 upstream.

To be more readable code, this patch adds
new for_each_dpcm_fe() macro, and replace existing code to it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 include/sound/soc-dpcm.h | 3 +++
 sound/soc/soc-pcm.c      | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index 9bb92f1..f130de6 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -103,6 +103,9 @@ struct snd_soc_dpcm_runtime {
 	int trigger_pending; /* trigger cmd + 1 if pending, 0 if not */
 };
 
+#define for_each_dpcm_fe(be, stream, dpcm)				\
+	list_for_each_entry(dpcm, &(be)->dpcm[stream].fe_clients, list_fe)
+
 /* can this BE stop and free */
 int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
 		struct snd_soc_pcm_runtime *be, int stream);
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 06eedb5..14132f6 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1255,7 +1255,7 @@ static void dpcm_be_reparent(struct snd_soc_pcm_runtime *fe,
 
 	be_substream = snd_soc_dpcm_get_substream(be, stream);
 
-	list_for_each_entry(dpcm, &be->dpcm[stream].fe_clients, list_fe) {
+	for_each_dpcm_fe(be, stream, dpcm) {
 		if (dpcm->fe == fe)
 			continue;
 
@@ -3223,7 +3223,7 @@ int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
 	struct snd_soc_dpcm *dpcm;
 	int state;
 
-	list_for_each_entry(dpcm, &be->dpcm[stream].fe_clients, list_fe) {
+	for_each_dpcm_fe(be, stream, dpcm) {
 
 		if (dpcm->fe == fe)
 			continue;
@@ -3250,7 +3250,7 @@ int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
 	struct snd_soc_dpcm *dpcm;
 	int state;
 
-	list_for_each_entry(dpcm, &be->dpcm[stream].fe_clients, list_fe) {
+	for_each_dpcm_fe(be, stream, dpcm) {
 
 		if (dpcm->fe == fe)
 			continue;
-- 
2.7.4
