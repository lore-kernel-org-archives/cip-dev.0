From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:05:13 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 41/57] ASoC: rsnd: fixup MIX kctrl
	registration
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-42-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 7aea8a9d71d54f449f49e20324df06341cc18395 upstream.

Renesas sound device has many IPs and many situations.
If platform/board uses MIXer, situation will be more complex.
To avoid duplicate DVC kctrl registration when MIXer was used,
it had original flags.
But it was issue when sound card was re-binded, because
no one can't cleanup this flags then.

To solve this issue, commit 9c698e8481a15237a ("ASoC: rsnd: tidyup
registering method for rsnd_kctrl_new()") checks registered
card->controls, because if card was re-binded, these were cleanuped
automatically. This patch could solve re-binding issue.
But, it start to avoid MIX kctrl.

To solve these issues, we need below.
To avoid card re-binding issue: check registered card->controls
To avoid duplicate DVC registration: check registered rsnd_kctrl_cfg
To allow multiple MIX registration: check registered rsnd_kctrl_cfg
This patch do it.

Fixes: 9c698e8481a15237a ("ASoC: rsnd: tidyup registering method for rsnd_kctrl_new()")
Reported-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-By: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index c0b7d85..5e044ee 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1520,14 +1520,14 @@ int rsnd_kctrl_new(struct rsnd_mod *mod,
 	int ret;
 
 	/*
-	 * 1) Avoid duplicate register (ex. MIXer case)
-	 * 2) re-register if card was rebinded
+	 * 1) Avoid duplicate register for DVC with MIX case
+	 * 2) Allow duplicate register for MIX
+	 * 3) re-register if card was rebinded
 	 */
 	list_for_each_entry(kctrl, &card->controls, list) {
 		struct rsnd_kctrl_cfg *c = kctrl->private_data;
 
-		if (strcmp(kctrl->id.name, name) == 0 &&
-		    c->mod == mod)
+		if (c == cfg)
 			return 0;
 	}
 
-- 
2.7.4
