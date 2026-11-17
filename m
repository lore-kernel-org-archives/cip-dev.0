Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16040.1794916176076072636
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:49:36 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8008C62472;
	Tue, 17 Nov 2026 11:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526BF1F000C4;
	Tue, 17 Nov 2026 11:49:34 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 08/34] i3c: renesas: Perform Dynamic Address Assignment on resume
Date: Tue, 17 Nov 2026 13:48:54 +0200
Message-ID: <20261117114921.1485204-9-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
References: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:49:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24919
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
index 65344e73b1a0..24129e942f2c 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -266,7 +266,6 @@ struct renesas_i3c {
 	u8 addrs[RENESAS_I3C_MAX_DEVS];
 	struct renesas_i3c_xferqueue xferqueue;
 	void __iomem *regs;
-	u32 *DATBASn;
 	struct clk_bulk_data *clks;
 	struct reset_control *presetn;
 	struct reset_control *tresetn;
@@ -496,8 +495,8 @@ static int renesas_i3c_reset(struct renesas_i3c *i3c)
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
@@ -1443,12 +1442,6 @@ static int renesas_i3c_probe(struct platform_devic=
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
@@ -1461,17 +1454,13 @@ static int renesas_i3c_remove(struct platform_dev=
ice *pdev)
 	return 0;
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
@@ -1492,10 +1481,10 @@ static int renesas_i3c_suspend_noirq(struct devic=
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
@@ -1521,15 +1510,19 @@ static int renesas_i3c_resume_noirq(struct device=
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
@@ -1542,8 +1535,7 @@ static int renesas_i3c_resume_noirq(struct device *=
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

