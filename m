Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16113.1795706764434448431
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:26:04 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D181F63681;
	Thu, 26 Nov 2026 15:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C8C1F000C0;
	Thu, 26 Nov 2026 15:26:02 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 04/11] ASoC: renesas: rz-ssi: Drop unnecessary if condition
Date: Thu, 26 Nov 2026 17:25:46 +0200
Message-ID: <20261126152553.1298561-5-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152553.1298561-1-claudiu.beznea@tuxon.dev>
References: <20261126152553.1298561-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:26:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25142
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 9e0e337cc6c7f30a5986dd44dac5c0a0e30d971f upstream.

The is_stopped variable can be initialized directly at declaration,
removing the need for an extra if condition. Drop the if condition and
initialize is_stopped at declaration.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260119195252.3362486-3-claudiu.beznea.uj=
@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 1068e3a82d97..568c6a892ffc 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -615,7 +615,8 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *da=
ta)
 		return IRQ_HANDLED; /* Left over TX/RX interrupt */
=20
 	if (irq =3D=3D ssi->irq_int) { /* error or idle */
-		bool is_stopped =3D false;
+		bool is_stopped =3D !!(ssisr & (SSISR_RUIRQ | SSISR_ROIRQ |
+					      SSISR_TUIRQ | SSISR_TOIRQ));
 		int i, count;
=20
 		if (rz_ssi_is_dma_enabled(ssi))
@@ -623,9 +624,6 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *da=
ta)
 		else
 			count =3D 1;
=20
-		if (ssisr & (SSISR_RUIRQ | SSISR_ROIRQ | SSISR_TUIRQ | SSISR_TOIRQ))
-			is_stopped =3D true;
-
 		if (ssi->capture.substream && is_stopped) {
 			if (ssisr & SSISR_RUIRQ)
 				strm_capture->uerr_num++;
--=20
2.43.0

