Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16112.1795706763412909027
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:26:03 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6932A63699;
	Thu, 26 Nov 2026 15:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D427F1F000C0;
	Thu, 26 Nov 2026 15:26:00 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 03/11] ASoC: renesas: rz-ssi: Simplify the logic in rz_ssi_stream_is_play()
Date: Thu, 26 Nov 2026 17:25:45 +0200
Message-ID: <20261126152553.1298561-4-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152553.1298561-1-claudiu.beznea@tuxon.dev>
References: <20261126152553.1298561-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:26:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25141
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 53dfb2ad6fcff111f58aa506afbbf6fd82f32cb1 upstream.

The code in rz_ssi_stream_is_play() checks whether substream->stream is
different from SNDRV_PCM_STREAM_PLAYBACK and returns the capture
struct rz_ssi_stream in that case. The logic is easier to follow if
substream->stream is compared directly against SNDRV_PCM_STREAM_CAPTURE
and return the capture struct rz_ssi_stream.

Use the conditional operator to simplify the code.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260119195252.3362486-2-claudiu.beznea.uj=
@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 38398994e5f3..1068e3a82d97 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -189,12 +189,7 @@ static inline bool rz_ssi_stream_is_play(struct snd_=
pcm_substream *substream)
 static inline struct rz_ssi_stream *
 rz_ssi_stream_get(struct rz_ssi_priv *ssi, struct snd_pcm_substream *sub=
stream)
 {
-	struct rz_ssi_stream *stream =3D &ssi->playback;
-
-	if (substream->stream !=3D SNDRV_PCM_STREAM_PLAYBACK)
-		stream =3D &ssi->capture;
-
-	return stream;
+	return (ssi->playback.substream =3D=3D substream) ? &ssi->playback : &s=
si->capture;
 }
=20
 static inline bool rz_ssi_is_dma_enabled(struct rz_ssi_priv *ssi)
--=20
2.43.0

