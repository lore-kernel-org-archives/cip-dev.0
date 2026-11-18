Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.941.1795020118454578116
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 08:41:58 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=4qsa=jh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DCEF862BF5;
	Wed, 18 Nov 2026 16:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D9F1F000C4;
	Wed, 18 Nov 2026 16:41:56 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [RESEND PATCH 6.12.y-cip 06/35] i3c: renesas: Reconfigure the DATBAS register on re-attach
Date: Wed, 18 Nov 2026 18:41:17 +0200
Message-ID: <20261118164146.3040784-7-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
References: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 16:42:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24969
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 1364afd3e2e76e007a2c07ec95704d56980226f0 upstream.

During re-attach, the device may change its position in the i3c->addrs[]
array. As a result, it may use a different Device Address Table Basic
Register (DATBAS), which needs to be reconfigured.

Reconfigure the DATBAS register on re-attach. Along with it update
software caches.

Fixes: d028219a9f14 ("i3c: master: Add basic driver for the Renesas I3C c=
ontroller")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260713130545.568657-5-claudiu.beznea+ren=
esas@tuxon.dev
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesa=
s-i3c.c
index fb2e74403162..51542cf4ff1e 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -907,10 +907,26 @@ static int renesas_i3c_reattach_i3c_dev(struct i3c_=
dev_desc *dev,
 	struct i3c_master_controller *m =3D i3c_dev_get_master(dev);
 	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
 	struct renesas_i3c_i2c_dev_data *data =3D i3c_dev_get_master_data(dev);
+	int pos;
+
+	pos =3D renesas_i3c_get_free_pos(i3c);
+
+	if (data->index > pos && pos >=3D 0) {
+		renesas_writel(i3c->regs, DATBAS(data->index), 0);
+		i3c->addrs[data->index] =3D 0;
+		i3c->free_pos |=3D BIT(data->index);
+
+		data->index =3D pos;
+		i3c->free_pos &=3D ~BIT(data->index);
+	}
=20
 	i3c->addrs[data->index] =3D dev->info.dyn_addr ? dev->info.dyn_addr :
 							dev->info.static_addr;
=20
+	renesas_writel(i3c->regs, DATBAS(data->index),
+		       DATBAS_DVSTAD(dev->info.static_addr) |
+		       datbas_dvdyad_with_parity(i3c->addrs[data->index]));
+
 	return 0;
 }
=20
--=20
2.43.0

