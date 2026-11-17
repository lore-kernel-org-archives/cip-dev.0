Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15921.1794916185430018101
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:49:45 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3C82B402F4;
	Tue, 17 Nov 2026 11:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A351F000C4;
	Tue, 17 Nov 2026 11:49:44 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 15/34] i3c: renesas: Update HW registers after SW computations are done
Date: Tue, 17 Nov 2026 13:49:01 +0200
Message-ID: <20261117114921.1485204-16-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
References: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:49:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24926
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 826a7d3d5ff2296d021a6a4521544b852609047a upstream.

renesas_i3c_bus_init() performs a number of computations and software
cache updates, interleaving them with hardware register writes. While
this works today, it makes it harder to minimize the time the controller
must remain powered when runtime PM is introduced.

Perform all software computations and cache updates first, then update
the hardware registers. This prepares for future runtime PM support.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260713130545.568657-14-claudiu.beznea+re=
nesas@tuxon.dev
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesa=
s-i3c.c
index cf6b1489b17e..82ee131cf565 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -566,10 +566,6 @@ static int renesas_i3c_bus_init(struct i3c_master_co=
ntroller *m)
 	if (!i3c->rate)
 		return -EINVAL;
=20
-	ret =3D renesas_i3c_reset(i3c);
-	if (ret)
-		return ret;
-
 	i2c_total_ticks =3D DIV_ROUND_UP(i3c->rate, bus->scl_rate.i2c);
 	i3c_total_ticks =3D DIV_ROUND_UP(i3c->rate, bus->scl_rate.i3c);
=20
@@ -620,27 +616,31 @@ static int renesas_i3c_bus_init(struct i3c_master_c=
ontroller *m)
 			STDBR_SBRHO(double_SBR, od_high_ticks) |
 			STDBR_SBRLP(pp_low_ticks) |
 			STDBR_SBRHP(pp_high_ticks);
-	renesas_writel(i3c->regs, STDBR, i3c->i3c_STDBR);
=20
 	/* Extended Bit Rate setting */
 	i3c->extbr =3D EXTBR_EBRLO(od_low_ticks) | EXTBR_EBRHO(od_high_ticks) |
 		     EXTBR_EBRLP(pp_low_ticks) | EXTBR_EBRHP(pp_high_ticks);
-	renesas_writel(i3c->regs, EXTBR, i3c->extbr);
-
-	renesas_writel(i3c->regs, REFCKCTL, REFCKCTL_IREFCKS(cks));
-	i3c->refclk_div =3D cks;
-
-	/* I3C hw init*/
-	renesas_i3c_hw_init(i3c);
=20
 	ret =3D i3c_master_get_free_addr(m, 0);
 	if (ret < 0)
 		return ret;
=20
+	info.dyn_addr =3D ret;
 	i3c->dyn_addr =3D ret;
-	renesas_writel(i3c->regs, MSDVAD, MSDVAD_MDYAD(ret) | MSDVAD_MDYADV);
+	i3c->refclk_div =3D cks;
+
+	ret =3D renesas_i3c_reset(i3c);
+	if (ret)
+		return ret;
+
+	renesas_writel(i3c->regs, STDBR, i3c->i3c_STDBR);
+	renesas_writel(i3c->regs, EXTBR, i3c->extbr);
+	renesas_writel(i3c->regs, REFCKCTL, REFCKCTL_IREFCKS(cks));
+	renesas_writel(i3c->regs, MSDVAD, MSDVAD_MDYAD(i3c->dyn_addr) | MSDVAD_=
MDYADV);
+
+	/* I3C hw init*/
+	renesas_i3c_hw_init(i3c);
=20
-	info.dyn_addr =3D ret;
 	return i3c_master_set_info(&i3c->base, &info);
 }
=20
--=20
2.43.0

