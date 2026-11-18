Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.910.1795020121172548320
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 08:42:01 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=4qsa=jh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 98B7462BE3;
	Wed, 18 Nov 2026 16:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD5C1F000C4;
	Wed, 18 Nov 2026 16:41:59 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [RESEND PATCH 6.12.y-cip 08/35] i3c: renesas: Perform Dynamic Address Assignment on resume
Date: Wed, 18 Nov 2026 18:41:19 +0200
Message-ID: <20261118164146.3040784-9-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
References: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 16:42:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24971
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit fbf26154c47953d08c60fb402ab19c5c56c3779f upstream.

The Renesas RZ/G3S SoC supports a power saving mode where power to most
SoC components, including I3C, is turned off.

On systems where the I3C devices also loses power during suspend (e.g. NX=
P
P3T1085UK-ARD connected to the PMOD1_6A connector of the RZ SMARC Carrier
2 + Renesas RZ/G3S SMARC SOM), the devices becomes unreachable after
resume.

Running DAA in the controller resume path restores communication. However=
,
DAA relies on interrupts for TX/RX, which are not available in the noirq
suspend/resume phase (unless they are wakeup interrupts). For this, the
suspend/resume callbacks were moved out of the noirq phase. Currently,
there is no identified use case on either the Renesas RZ/G3S or Renesas
RZ/G3E SoCs that requires the controller suspend/resume hooks to be part =
of
the noirq suspend/resume phase.

Since renesas_i3c_reset() is not called anymore in atomic context
update it to use read_poll_timeout().

Along with this, struct renesas_i3c::DATBASn and its usage were removed,
as they are no longer needed.

Fixes: e7218986319b ("i3c: renesas: Add suspend/resume support")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260713130545.568657-7-claudiu.beznea+ren=
esas@tuxon.dev
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 38 +++++++++++++-------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesa=
s-i3c.c
index 7ed56370c92e..3e7789a80b7b 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -265,7 +265,6 @@ struct renesas_i3c {
 	u8 addrs[RENESAS_I3C_MAX_DEVS];
 	struct renesas_i3c_xferqueue xferqueue;
 	void __iomem *regs;
-	u32 *DATBASn;
 	struct clk_bulk_data *clks;
 	struct reset_control *presetn;
 	struct reset_control *tresetn;
@@ -495,8 +494,8 @@ static int renesas_i3c_reset(struct renesas_i3c *i3c)
 	renesas_writel(i3c->regs, BCTL, 0);
 	renesas_set_bit(i3c->regs, RSTCTL, RSTCTL_RI3CRST);
=20
-	return read_poll_timeout_atomic(renesas_readl, val, !(val & RSTCTL_RI3C=
RST),
-					0, 1000, false, i3c->regs, RSTCTL);
+	return read_poll_timeout(renesas_readl, val, !(val & RSTCTL_RI3CRST),
+				 0, 1000, false, i3c->regs, RSTCTL);
 }
=20
 static void renesas_i3c_hw_init(struct renesas_i3c *i3c)
@@ -1419,12 +1418,6 @@ static int renesas_i3c_probe(struct platform_devic=
e *pdev)
 	i3c->maxdevs =3D RENESAS_I3C_MAX_DEVS;
 	i3c->free_pos =3D GENMASK(i3c->maxdevs - 1, 0);
=20
-	/* Allocate dynamic Device Address Table backup. */
-	i3c->DATBASn =3D devm_kzalloc(&pdev->dev, sizeof(u32) * i3c->maxdevs,
-				    GFP_KERNEL);
-	if (!i3c->DATBASn)
-		return -ENOMEM;
-
 	return i3c_master_register(&i3c->base, &pdev->dev, &renesas_i3c_ops, fa=
lse);
 }
=20
@@ -1435,17 +1428,13 @@ static void renesas_i3c_remove(struct platform_de=
vice *pdev)
 	i3c_master_unregister(&i3c->base);
 }
=20
-static int renesas_i3c_suspend_noirq(struct device *dev)
+static int renesas_i3c_suspend(struct device *dev)
 {
 	struct renesas_i3c *i3c =3D dev_get_drvdata(dev);
-	int i, ret;
+	int ret;
=20
 	i2c_mark_adapter_suspended(&i3c->base.i2c);
=20
-	/* Store Device Address Table values. */
-	for (i =3D 0; i < i3c->maxdevs; i++)
-		i3c->DATBASn[i] =3D renesas_readl(i3c->regs, DATBAS(i));
-
 	ret =3D reset_control_assert(i3c->presetn);
 	if (ret)
 		goto err_mark_resumed;
@@ -1466,10 +1455,10 @@ static int renesas_i3c_suspend_noirq(struct devic=
e *dev)
 	return ret;
 }
=20
-static int renesas_i3c_resume_noirq(struct device *dev)
+static int renesas_i3c_resume(struct device *dev)
 {
 	struct renesas_i3c *i3c =3D dev_get_drvdata(dev);
-	int i, ret;
+	int ret;
=20
 	ret =3D reset_control_deassert(i3c->tresetn);
 	if (ret)
@@ -1495,15 +1484,19 @@ static int renesas_i3c_resume_noirq(struct device=
 *dev)
 	renesas_writel(i3c->regs, MSDVAD, MSDVAD_MDYADV |
 		       MSDVAD_MDYAD(i3c->dyn_addr));
=20
-	/* Restore Device Address Table values. */
-	for (i =3D 0; i < i3c->maxdevs; i++)
-		renesas_writel(i3c->regs, DATBAS(i), i3c->DATBASn[i]);
-
 	/* I3C hw init. */
 	renesas_i3c_hw_init(i3c);
=20
+	ret =3D i3c_master_do_daa_ext(&i3c->base, true);
+	if (ret)
+		dev_err(dev, "DAA failed on resume, ret=3D%d", ret);
+
 	i2c_mark_adapter_resumed(&i3c->base.i2c);
=20
+	/*
+	 * I3C devices may have retained their dynamic address anyway. Do not
+	 * fail the resume because of DAA error.
+	 */
 	return 0;
=20
 err_clks_disable:
@@ -1516,8 +1509,7 @@ static int renesas_i3c_resume_noirq(struct device *=
dev)
 }
=20
 static const struct dev_pm_ops renesas_i3c_pm_ops =3D {
-	NOIRQ_SYSTEM_SLEEP_PM_OPS(renesas_i3c_suspend_noirq,
-				  renesas_i3c_resume_noirq)
+	SYSTEM_SLEEP_PM_OPS(renesas_i3c_suspend, renesas_i3c_resume)
 };
=20
 static const struct of_device_id renesas_i3c_of_ids[] =3D {
--=20
2.43.0

