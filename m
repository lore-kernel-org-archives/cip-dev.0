Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.948.1795020124834652566
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 08:42:04 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=4qsa=jh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9F701467B0;
	Wed, 18 Nov 2026 16:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33E21F000C9;
	Wed, 18 Nov 2026 16:42:03 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [RESEND PATCH 6.12.y-cip 11/35] i3c: renesas: Use reset_control_bulk_{assert, deassert}()
Date: Wed, 18 Nov 2026 18:41:22 +0200
Message-ID: <20261118164146.3040784-12-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
References: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 16:42:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24974
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 35e9bb2be1a20561e2cc19ca79c88c009f65c5f4 upstream.

Use reset_control_bulk_assert() and reset_control_bulk_deassert() in the
suspend and resume paths to simplify the code.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260713130545.568657-10-claudiu.beznea+re=
nesas@tuxon.dev
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesa=
s-i3c.c
index b85e2b1ce5f3..fc72ab162dd2 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -1437,24 +1437,22 @@ static void renesas_i3c_remove(struct platform_de=
vice *pdev)
 static int renesas_i3c_suspend(struct device *dev)
 {
 	struct renesas_i3c *i3c =3D dev_get_drvdata(dev);
+	struct reset_control_bulk_data resets[] =3D {
+		{ .rstc =3D i3c->presetn },
+		{ .rstc =3D i3c->tresetn },
+	};
 	int ret;
=20
 	i2c_mark_adapter_suspended(&i3c->base.i2c);
=20
-	ret =3D reset_control_assert(i3c->presetn);
+	ret =3D reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
 	if (ret)
 		goto err_mark_resumed;
=20
-	ret =3D reset_control_assert(i3c->tresetn);
-	if (ret)
-		goto err_presetn;
-
 	clk_bulk_disable(i3c->num_clks, i3c->clks);
=20
 	return 0;
=20
-err_presetn:
-	reset_control_deassert(i3c->presetn);
 err_mark_resumed:
 	i2c_mark_adapter_resumed(&i3c->base.i2c);
=20
@@ -1464,19 +1462,19 @@ static int renesas_i3c_suspend(struct device *dev=
)
 static int renesas_i3c_resume(struct device *dev)
 {
 	struct renesas_i3c *i3c =3D dev_get_drvdata(dev);
+	struct reset_control_bulk_data resets[] =3D {
+		{ .rstc =3D i3c->presetn },
+		{ .rstc =3D i3c->tresetn },
+	};
 	int ret;
=20
-	ret =3D reset_control_deassert(i3c->tresetn);
+	ret =3D reset_control_bulk_deassert(ARRAY_SIZE(resets), resets);
 	if (ret)
 		return ret;
=20
-	ret =3D reset_control_deassert(i3c->presetn);
-	if (ret)
-		goto err_tresetn;
-
 	ret =3D clk_bulk_enable(i3c->num_clks, i3c->clks);
 	if (ret)
-		goto err_presetn;
+		goto err_resets_asserted;
=20
 	ret =3D renesas_i3c_reset(i3c);
 	if (ret)
@@ -1507,10 +1505,8 @@ static int renesas_i3c_resume(struct device *dev)
=20
 err_clks_disable:
 	clk_bulk_disable(i3c->num_clks, i3c->clks);
-err_presetn:
-	reset_control_assert(i3c->presetn);
-err_tresetn:
-	reset_control_assert(i3c->tresetn);
+err_resets_asserted:
+	reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
 	return ret;
 }
=20
--=20
2.43.0

