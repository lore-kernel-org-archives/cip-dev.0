Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16043.1794916178333642852
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:49:38 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 265A140F63;
	Tue, 17 Nov 2026 11:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B081F000C4;
	Tue, 17 Nov 2026 11:49:36 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 10/34] i3c: renesas: Fix out-of-bounds access for newdevs mask
Date: Tue, 17 Nov 2026 13:48:56 +0200
Message-ID: <20261117114921.1485204-11-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
References: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:49:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24921
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 50dec95c9d1f1f82819bc898ef2b60fa83fd4ccd upstream.

When software initiates DAA (Dynamic Address Assignment), the controller
reports the result via the NRSPQP (Normal Response Queue Port Register).
The data length field of the response descriptor, which is accessible
through the NRSPQP register, indicates the number of devices remaining
after DAA. Consequently, when the bus is empty, this field contains the
maximum number of devices supported by the controller (8 for the Renesas
I3C controller).

Adjust the condition that computes the newly discovered devices bitmask
to prevent an out-of-bounds when the I3C bus is empty.

Fixes: e7218986319b ("i3c: renesas: Add suspend/resume support")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260713130545.568657-9-claudiu.beznea+ren=
esas@tuxon.dev
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesa=
s-i3c.c
index e11ef02b5282..30b204fd44ef 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -704,7 +704,11 @@ static int renesas_i3c_daa(struct i3c_master_control=
ler *m)
=20
 	renesas_i3c_wait_xfer(i3c, xfer);
=20
-	newdevs =3D GENMASK(i3c->maxdevs - cmd->rx_count - 1, 0);
+	if (cmd->rx_count >=3D i3c->maxdevs)
+		newdevs =3D 0;
+	else
+		newdevs =3D GENMASK(i3c->maxdevs - cmd->rx_count - 1, 0);
+
 	newdevs &=3D ~olddevs;
=20
 	for (pos =3D 0; pos < i3c->maxdevs; pos++) {
--=20
2.43.0

