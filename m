Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15920.1794916184018726118
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:49:44 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CE8EC40262;
	Tue, 17 Nov 2026 11:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D281C1F000C4;
	Tue, 17 Nov 2026 11:49:42 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 14/34] i3c: renesas: Drop the explicit memset() call
Date: Tue, 17 Nov 2026 13:49:00 +0200
Message-ID: <20261117114921.1485204-15-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
References: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:49:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24925
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 5e0b4ae8017782c5495f96f924b28fa447682a36 upstream.

Drop the explicit memset() call on struct i3c_device_info object, as it i=
s
already initialized at declaration through compiler initialization.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260713130545.568657-13-claudiu.beznea+re=
nesas@tuxon.dev
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesa=
s-i3c.c
index fa686b538b46..cf6b1489b17e 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -640,7 +640,6 @@ static int renesas_i3c_bus_init(struct i3c_master_con=
troller *m)
 	i3c->dyn_addr =3D ret;
 	renesas_writel(i3c->regs, MSDVAD, MSDVAD_MDYAD(ret) | MSDVAD_MDYADV);
=20
-	memset(&info, 0, sizeof(info));
 	info.dyn_addr =3D ret;
 	return i3c_master_set_info(&i3c->base, &info);
 }
--=20
2.43.0

