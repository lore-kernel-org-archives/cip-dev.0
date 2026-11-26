Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16117.1795706767993976239
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:26:08 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 693BF6369A;
	Thu, 26 Nov 2026 15:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B551F000C0;
	Thu, 26 Nov 2026 15:26:05 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 06/11] ASoC: renesas: rz-ssi: Drop goto label
Date: Thu, 26 Nov 2026 17:25:48 +0200
Message-ID: <20261126152553.1298561-7-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152553.1298561-1-claudiu.beznea@tuxon.dev>
References: <20261126152553.1298561-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:26:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25144
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit cafadbf430f4b2f3ca4158de48ef6ba4d97fbf17 upstream.

There is no need to jump to a label just to return. Return directly
instead.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260119195252.3362486-5-claudiu.beznea.uj=
@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 1d93dbfb5149..d2dd2e4a4ccd 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -892,7 +892,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substrea=
m *substream, int cmd,
 		for (i =3D 0; i < num_transfer; i++) {
 			ret =3D strm->transfer(ssi, strm);
 			if (ret)
-				goto done;
+				return ret;
 		}
=20
 		ret =3D rz_ssi_start(ssi, strm);
@@ -908,7 +908,6 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substrea=
m *substream, int cmd,
 		break;
 	}
=20
-done:
 	return ret;
 }
=20
--=20
2.43.0

