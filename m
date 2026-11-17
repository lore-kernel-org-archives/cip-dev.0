Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16046.1794916183240586087
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:49:43 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A824062472;
	Tue, 17 Nov 2026 11:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6782B1F000C4;
	Tue, 17 Nov 2026 11:49:41 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 13/34] i3c: renesas: Follow a unified pattern for transfer and command initialization
Date: Tue, 17 Nov 2026 13:48:59 +0200
Message-ID: <20261117114921.1485204-14-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
References: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:49:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24924
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 234a26e6febcf789d9f6779d67c01e3d0c1df5bc upstream.

Follow a unified pattern for transfer and command initialization across
the driver. This keeps the code cleaner and easier to follow. Also, in
some cases the I3C device was enabled before the transfer data structure
was even allocated.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260713130545.568657-12-claudiu.beznea+re=
nesas@tuxon.dev
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesa=
s-i3c.c
index 297bcad0ceef..fa686b538b46 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -664,6 +664,10 @@ static int renesas_i3c_daa(struct i3c_master_control=
ler *m)
 	if (!xfer)
 		return -ENOMEM;
=20
+	init_completion(&xfer->comp);
+	cmd =3D xfer->cmds;
+	cmd->rx_count =3D 0;
+
 	/* Enable I3C bus. */
 	renesas_i3c_bus_enable(m, true);
=20
@@ -685,10 +689,6 @@ static int renesas_i3c_daa(struct i3c_master_control=
ler *m)
 		renesas_writel(i3c->regs, DATBAS(pos), datbas_dvdyad_with_parity(ret))=
;
 	}
=20
-	init_completion(&xfer->comp);
-	cmd =3D xfer->cmds;
-	cmd->rx_count =3D 0;
-
 	ret =3D renesas_i3c_get_free_pos(i3c);
 	if (ret < 0)
 		return ret;
@@ -780,13 +780,13 @@ static int renesas_i3c_send_ccc_cmd(struct i3c_mast=
er_controller *m,
 	if (!xfer)
 		return -ENOMEM;
=20
-	renesas_i3c_bus_enable(m, true);
-
 	init_completion(&xfer->comp);
 	cmd =3D xfer->cmds;
 	cmd->rnw =3D ccc->rnw;
 	cmd->cmd0 =3D 0;
=20
+	renesas_i3c_bus_enable(m, true);
+
 	/* Calculate the command descriptor. */
 	switch (ccc->id) {
 	case I3C_CCC_SETDASA:
@@ -836,15 +836,15 @@ static int renesas_i3c_priv_xfers(struct i3c_dev_de=
sc *dev, struct i3c_priv_xfer
 	struct renesas_i3c_i2c_dev_data *data =3D i3c_dev_get_master_data(dev);
 	int i;
=20
-	/* Enable I3C bus. */
-	renesas_i3c_bus_enable(m, true);
-
 	struct renesas_i3c_xfer *xfer __free(kfree) =3D renesas_i3c_alloc_xfer(=
i3c, 1);
 	if (!xfer)
 		return -ENOMEM;
=20
 	init_completion(&xfer->comp);
=20
+	/* Enable I3C bus. */
+	renesas_i3c_bus_enable(m, true);
+
 	for (i =3D 0; i < i3c_nxfers; i++) {
 		struct renesas_i3c_cmd *cmd =3D xfer->cmds;
=20
@@ -965,12 +965,12 @@ static int renesas_i3c_i2c_xfers(struct i2c_dev_des=
c *dev,
 	if (!xfer)
 		return -ENOMEM;
=20
-	renesas_i3c_bus_enable(m, false);
-
 	init_completion(&xfer->comp);
 	xfer->is_i2c_xfer =3D true;
 	cmd =3D xfer->cmds;
=20
+	renesas_i3c_bus_enable(m, false);
+
 	if (!(renesas_readl(i3c->regs, BCST) & BCST_BFREF)) {
 		cmd->err =3D -EBUSY;
 		return cmd->err;
--=20
2.43.0

