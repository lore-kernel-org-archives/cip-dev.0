Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.934.1795020113166138279
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 08:41:53 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=4qsa=jh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 59D8040B2E;
	Wed, 18 Nov 2026 16:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAF01F000C4;
	Wed, 18 Nov 2026 16:41:51 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [RESEND PATCH 6.12.y-cip 02/35] i3c: master: renesas: Use __free(kfree) for xfer cleanup in renesas_i3c_send_ccc_cmd()
Date: Wed, 18 Nov 2026 18:41:13 +0200
Message-ID: <20261118164146.3040784-3-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
References: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 16:41:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24965
Content-Type: text/plain; charset="utf-8"

From: Felix Gu <ustc.gu@gmail.com>

commit 57c91ca3dd87e58d635ecbcf9635aaead2f2b1de upstream.

Use __free(kfree) for automatic cleanup, matching the pattern already
used in other functions in this driver.

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260406-renesas-v3-2-4b724d7708f4@gmail.c=
om
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesa=
s-i3c.c
index 8e8b78fb233b..e2ea43599ee0 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -748,7 +748,6 @@ static int renesas_i3c_send_ccc_cmd(struct i3c_master=
_controller *m,
 					   struct i3c_ccc_cmd *ccc)
 {
 	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
-	struct renesas_i3c_xfer *xfer;
 	struct renesas_i3c_cmd *cmd;
 	int ret, pos =3D 0;
=20
@@ -758,7 +757,7 @@ static int renesas_i3c_send_ccc_cmd(struct i3c_master=
_controller *m,
 			return pos;
 	}
=20
-	xfer =3D renesas_i3c_alloc_xfer(i3c, 1);
+	struct renesas_i3c_xfer *xfer __free(kfree) =3D renesas_i3c_alloc_xfer(=
i3c, 1);
 	if (!xfer)
 		return -ENOMEM;
=20
@@ -807,8 +806,6 @@ static int renesas_i3c_send_ccc_cmd(struct i3c_master=
_controller *m,
 	if (ret)
 		ccc->err =3D I3C_ERROR_M2;
=20
-	kfree(xfer);
-
 	return ret;
 }
=20
--=20
2.43.0

