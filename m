Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16099.1795706760645624030
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:26:00 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6AFF6416EA;
	Thu, 26 Nov 2026 15:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C261F000EB;
	Thu, 26 Nov 2026 15:25:58 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 02/11] ASoC: renesas: rz-ssi: Use guard() for spin locks
Date: Thu, 26 Nov 2026 17:25:44 +0200
Message-ID: <20261126152553.1298561-3-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152553.1298561-1-claudiu.beznea@tuxon.dev>
References: <20261126152553.1298561-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:26:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25140
Content-Type: text/plain; charset="utf-8"

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 7d083666123a425ba9f81dff1a52955b1f226540 upstream.

Clean up the code using guard() for spin locks.
Merely code refactoring, and no behavior change.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Message-ID: <87frcx1yp5.wl-kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 0c3146d92691..38398994e5f3 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -206,24 +206,18 @@ static void rz_ssi_set_substream(struct rz_ssi_stre=
am *strm,
 				 struct snd_pcm_substream *substream)
 {
 	struct rz_ssi_priv *ssi =3D strm->priv;
-	unsigned long flags;
=20
-	spin_lock_irqsave(&ssi->lock, flags);
+	guard(spinlock_irqsave)(&ssi->lock);
+
 	strm->substream =3D substream;
-	spin_unlock_irqrestore(&ssi->lock, flags);
 }
=20
 static bool rz_ssi_stream_is_valid(struct rz_ssi_priv *ssi,
 				   struct rz_ssi_stream *strm)
 {
-	unsigned long flags;
-	bool ret;
-
-	spin_lock_irqsave(&ssi->lock, flags);
-	ret =3D strm->substream && strm->substream->runtime;
-	spin_unlock_irqrestore(&ssi->lock, flags);
+	guard(spinlock_irqsave)(&ssi->lock);
=20
-	return ret;
+	return strm->substream && strm->substream->runtime;
 }
=20
 static inline bool rz_ssi_is_stream_running(struct rz_ssi_stream *strm)
--=20
2.43.0

