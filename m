Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15787.1794915981146457799
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:46:21 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id ECC0B411C6;
	Tue, 17 Nov 2026 11:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1EE21F000C4;
	Tue, 17 Nov 2026 11:46:19 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 15/69] i3c: master: renesas: Fix memory leak in renesas_i3c_i3c_xfers()
Date: Tue, 17 Nov 2026 13:44:59 +0200
Message-ID: <20261117114553.1484215-16-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:46:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24856
Content-Type: text/plain; charset="utf-8"

From: Felix Gu <ustc.gu@gmail.com>

commit d7665c3b4f575251e449e2656879392346ca612b upstream.

The xfer structure allocated by renesas_i3c_alloc_xfer() was never freed
in the renesas_i3c_i3c_xfers() function. Use the __free(kfree) cleanup
attribute to automatically free the memory when the variable goes out of
scope.

Fixes: d028219a9f14 ("i3c: master: Add basic driver for the Renesas I3C c=
ontroller")
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Link: https://patch.msgid.link/20260406-renesas-v3-1-4b724d7708f4@gmail.c=
om
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
[claudiu.beznea: moved xfer allocation to the declarations section to
 avoid "ISO C90 forbids mixed declarations and code" warning]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesa=
s-i3c.c
index 2560efbac566..93dcf077ae28 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -8,6 +8,7 @@
=20
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/err.h>
@@ -824,16 +825,15 @@ static int renesas_i3c_priv_xfers(struct i3c_dev_de=
sc *dev, struct i3c_priv_xfer
 	struct i3c_master_controller *m =3D i3c_dev_get_master(dev);
 	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
 	struct renesas_i3c_i2c_dev_data *data =3D i3c_dev_get_master_data(dev);
-	struct renesas_i3c_xfer *xfer;
+	struct renesas_i3c_xfer *xfer __free(kfree) =3D renesas_i3c_alloc_xfer(=
i3c, 1);
 	int i;
=20
-	/* Enable I3C bus. */
-	renesas_i3c_bus_enable(m, true);
-
-	xfer =3D renesas_i3c_alloc_xfer(i3c, 1);
 	if (!xfer)
 		return -ENOMEM;
=20
+	/* Enable I3C bus. */
+	renesas_i3c_bus_enable(m, true);
+
 	init_completion(&xfer->comp);
=20
 	for (i =3D 0; i < i3c_nxfers; i++) {
--=20
2.43.0

