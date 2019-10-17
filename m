From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:05:07 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 35/57] ASoC: rsnd: tidyup registering
	method for rsnd_kctrl_new()
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-36-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 9c698e8481a15237a5b1db5f8391dd66d59e42a4 upstream.

Current rsnd dvc.c is using flags to avoid duplicating register for
MIXer case. OTOH, commit e894efef9ac7 ("ASoC: core: add support to card
rebind") allows to rebind sound card without rebinding all drivers.

Because of above patch and dvc.c flags, it can't re-register kctrl if
only sound card was rebinded, because dvc is keeping old flags.
(Of course it will be no problem if rsnd driver also be rebinded,
but it is not purpose of above patch).

This patch checks current card registered kctrl when registering.
In MIXer case, it can avoid duplicate register if card already has same
kctrl. In rebind case, it can re-register kctrl because card registered
kctl had been removed when unbinding.

This patch is updated version of commit b918f1bc7f1ce ("ASoC: rsnd: DVC
kctrl sets once")

Reported-by: Nguyen Viet Dung <dung.nguyen.aj@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Nguyen Viet Dung <dung.nguyen.aj@renesas.com>
Cc: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/core.c | 12 ++++++++++++
 sound/soc/sh/rcar/dvc.c  |  8 --------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 2697046..4a88c97 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1470,6 +1470,18 @@ int rsnd_kctrl_new(struct rsnd_mod *mod,
 	};
 	int ret;
 
+	/*
+	 * 1) Avoid duplicate register (ex. MIXer case)
+	 * 2) re-register if card was rebinded
+	 */
+	list_for_each_entry(kctrl, &card->controls, list) {
+		struct rsnd_kctrl_cfg *c = kctrl->private_data;
+
+		if (strcmp(kctrl->id.name, name) == 0 &&
+		    c->mod == mod)
+			return 0;
+	}
+
 	if (size > RSND_MAX_CHANNELS)
 		return -EINVAL;
 
diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index d65f24b..27c3761 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -40,11 +40,8 @@ struct rsnd_dvc {
 	struct rsnd_kctrl_cfg_s ren;	/* Ramp Enable */
 	struct rsnd_kctrl_cfg_s rup;	/* Ramp Rate Up */
 	struct rsnd_kctrl_cfg_s rdown;	/* Ramp Rate Down */
-	u32 flags;
 };
 
-#define KCTRL_INITIALIZED	(1 << 0)
-
 #define rsnd_dvc_get(priv, id) ((struct rsnd_dvc *)(priv->dvc) + id)
 #define rsnd_dvc_nr(priv) ((priv)->dvc_nr)
 
@@ -227,9 +224,6 @@ static int rsnd_dvc_pcm_new(struct rsnd_mod *mod,
 	int channels = rsnd_rdai_channels_get(rdai);
 	int ret;
 
-	if (rsnd_flags_has(dvc, KCTRL_INITIALIZED))
-		return 0;
-
 	/* Volume */
 	ret = rsnd_kctrl_new_m(mod, io, rtd,
 			is_play ?
@@ -285,8 +279,6 @@ static int rsnd_dvc_pcm_new(struct rsnd_mod *mod,
 	if (ret < 0)
 		return ret;
 
-	rsnd_flags_set(dvc, KCTRL_INITIALIZED);
-
 	return 0;
 }
 
-- 
2.7.4
