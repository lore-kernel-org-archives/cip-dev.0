Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16106.1795706769727207146
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:26:09 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 24297636A0;
	Thu, 26 Nov 2026 15:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C6F1F000C0;
	Thu, 26 Nov 2026 15:26:07 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 07/11] ASoC: renesas: rz-ssi: Fix playback and capture
Date: Thu, 26 Nov 2026 17:25:49 +0200
Message-ID: <20261126152553.1298561-8-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152553.1298561-1-claudiu.beznea@tuxon.dev>
References: <20261126152553.1298561-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:26:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25145
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 82e3265487c018814b789e251fb8aee8e683674c upstream.

In the current codebase the rz_ssi_stream_get() is called at the beginnin=
g
of rz_ssi_dai_trigger() before rz_ssi_stream_init() is called.
Since rz_ssi_stream_init() sets the ssi->{playback, capture}->substream,
relying on it in rz_ssi_stream_get() is incorrect. Fix this by checking
substream->stream instead as the original code did.

Fixes: 53dfb2ad6fcf ("ASoC: renesas: rz-ssi: Simplify the logic in rz_ssi=
_stream_is_play()")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260213172434.3801015-1-claudiu.beznea.uj=
@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index d2dd2e4a4ccd..6e045dba2003 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -189,7 +189,7 @@ static inline bool rz_ssi_stream_is_play(struct snd_p=
cm_substream *substream)
 static inline struct rz_ssi_stream *
 rz_ssi_stream_get(struct rz_ssi_priv *ssi, struct snd_pcm_substream *sub=
stream)
 {
-	return (ssi->playback.substream =3D=3D substream) ? &ssi->playback : &s=
si->capture;
+	return (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) ? &ssi->pla=
yback : &ssi->capture;
 }
=20
 static inline bool rz_ssi_is_dma_enabled(struct rz_ssi_priv *ssi)
--=20
2.43.0

