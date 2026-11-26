Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16110.1795706758936462089
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:25:58 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B84E4434F2;
	Thu, 26 Nov 2026 15:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A3F1F000CF;
	Thu, 26 Nov 2026 15:25:56 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 01/11] ASoC: renesas: rz-ssi: Add a check for negative sample_space
Date: Thu, 26 Nov 2026 17:25:43 +0200
Message-ID: <20261126152553.1298561-2-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152553.1298561-1-claudiu.beznea@tuxon.dev>
References: <20261126152553.1298561-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:26:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25139
Content-Type: text/plain; charset="utf-8"

From: Dan Carpenter <dan.carpenter@linaro.org>

commit 82a0a3e6f8c02b3236b55e784a083fa4ee07c321 upstream.

My static checker rule complains about this code.  The concern is that
if "sample_space" is negative then the "sample_space >=3D runtime->channe=
ls"
condition will not work as intended because it will be type promoted to a
high unsigned int value.

strm->fifo_sample_size is SSI_FIFO_DEPTH (32).  The SSIFSR_TDC_MASK is
0x3f.  Without any further context it does seem like a reasonable warning
and it can't hurt to add a check for negatives.

Cc: stable@vger.kernel.org
Fixes: 03e786bd4341 ("ASoC: sh: Add RZ/G2L SSIF-2 driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/e07c3dc5-d885-4b04-a742-71f42243f4fd@stanl=
ey.mountain
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 0c2dbc7528f2..0c3146d92691 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -571,6 +571,8 @@ static int rz_ssi_pio_send(struct rz_ssi_priv *ssi, s=
truct rz_ssi_stream *strm)
 	sample_space =3D strm->fifo_sample_size;
 	ssifsr =3D rz_ssi_reg_readl(ssi, SSIFSR);
 	sample_space -=3D (ssifsr >> SSIFSR_TDC_SHIFT) & SSIFSR_TDC_MASK;
+	if (sample_space < 0)
+		return -EINVAL;
=20
 	/* Only add full frames at a time */
 	while (frames_left && (sample_space >=3D runtime->channels)) {
--=20
2.43.0

