Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15785.1794915980173888875
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:46:20 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9807563404;
	Tue, 17 Nov 2026 11:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33ED01F000C4;
	Tue, 17 Nov 2026 11:46:17 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 14/69] i3c: renesas: Add suspend/resume support
Date: Tue, 17 Nov 2026 13:44:58 +0200
Message-ID: <20261117114553.1484215-15-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:46:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24855
Content-Type: text/plain; charset="utf-8"

From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

commit e7218986319b4e903dfb4642dcbd1087cf16aaec upstream.

The Renesas I3C controller does not retain its register state across syst=
em
suspend, requiring the driver to explicitly save and restore hardware
configuration.

Add suspend and resume NOIRQ callbacks to handle system sleep transitions=
.

During suspend, save the Device Address Table (DAT) entries, assert reset
lines, and disable all related clocks to allow the controller to enter a
low-power state.

On resume, re-enable clocks and reset lines in the proper order. Restore
the REFCKCTL register, master dynamic address, and all DAT entries, then
reinitialize the controller.

Store the REFCLK divider value, and the master dynamic address to restore
timing and addressing configuration after resume.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/c469ef89e0156d37746a85bfc314232847d1185a.1=
767781092.git.tommaso.merciai.xr@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 89 ++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesa=
s-i3c.c
index 737f60dd0001..2560efbac566 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -257,16 +257,19 @@ struct renesas_i3c {
 	enum i3c_internal_state internal_state;
 	u16 maxdevs;
 	u32 free_pos;
+	u32 dyn_addr;
 	u32 i2c_STDBR;
 	u32 i3c_STDBR;
 	unsigned long rate;
 	u8 addrs[RENESAS_I3C_MAX_DEVS];
 	struct renesas_i3c_xferqueue xferqueue;
 	void __iomem *regs;
+	u32 *DATBASn;
 	struct clk_bulk_data *clks;
 	struct reset_control *presetn;
 	struct reset_control *tresetn;
 	u8 num_clks;
+	u8 refclk_div;
 };
=20
 struct renesas_i3c_i2c_dev_data {
@@ -616,6 +619,7 @@ static int renesas_i3c_bus_init(struct i3c_master_con=
troller *m)
 					   EXTBR_EBRHP(pp_high_ticks));
=20
 	renesas_writel(i3c->regs, REFCKCTL, REFCKCTL_IREFCKS(cks));
+	i3c->refclk_div =3D cks;
=20
 	/* I3C hw init*/
 	renesas_i3c_hw_init(i3c);
@@ -624,6 +628,7 @@ static int renesas_i3c_bus_init(struct i3c_master_con=
troller *m)
 	if (ret < 0)
 		return ret;
=20
+	i3c->dyn_addr =3D ret;
 	renesas_writel(i3c->regs, MSDVAD, MSDVAD_MDYAD(ret) | MSDVAD_MDYADV);
=20
 	memset(&info, 0, sizeof(info));
@@ -1400,6 +1405,12 @@ static int renesas_i3c_probe(struct platform_devic=
e *pdev)
 	i3c->maxdevs =3D RENESAS_I3C_MAX_DEVS;
 	i3c->free_pos =3D GENMASK(i3c->maxdevs - 1, 0);
=20
+	/* Allocate dynamic Device Address Table backup. */
+	i3c->DATBASn =3D devm_kzalloc(&pdev->dev, sizeof(u32) * i3c->maxdevs,
+				    GFP_KERNEL);
+	if (!i3c->DATBASn)
+		return -ENOMEM;
+
 	return i3c_master_register(&i3c->base, &pdev->dev, &renesas_i3c_ops, fa=
lse);
 }
=20
@@ -1412,6 +1423,83 @@ static int renesas_i3c_remove(struct platform_devi=
ce *pdev)
 	return 0;
 }
=20
+static int renesas_i3c_suspend_noirq(struct device *dev)
+{
+	struct renesas_i3c *i3c =3D dev_get_drvdata(dev);
+	int i, ret;
+
+	i2c_mark_adapter_suspended(&i3c->base.i2c);
+
+	/* Store Device Address Table values. */
+	for (i =3D 0; i < i3c->maxdevs; i++)
+		i3c->DATBASn[i] =3D renesas_readl(i3c->regs, DATBAS(i));
+
+	ret =3D reset_control_assert(i3c->presetn);
+	if (ret)
+		goto err_mark_resumed;
+
+	ret =3D reset_control_assert(i3c->tresetn);
+	if (ret)
+		goto err_presetn;
+
+	clk_bulk_disable(i3c->num_clks, i3c->clks);
+
+	return 0;
+
+err_presetn:
+	reset_control_deassert(i3c->presetn);
+err_mark_resumed:
+	i2c_mark_adapter_resumed(&i3c->base.i2c);
+
+	return ret;
+}
+
+static int renesas_i3c_resume_noirq(struct device *dev)
+{
+	struct renesas_i3c *i3c =3D dev_get_drvdata(dev);
+	int i, ret;
+
+	ret =3D reset_control_deassert(i3c->presetn);
+	if (ret)
+		return ret;
+
+	ret =3D reset_control_deassert(i3c->tresetn);
+	if (ret)
+		goto err_presetn;
+
+	ret =3D clk_bulk_enable(i3c->num_clks, i3c->clks);
+	if (ret)
+		goto err_tresetn;
+
+	/* Re-store I3C registers value. */
+	renesas_writel(i3c->regs, REFCKCTL,
+		       REFCKCTL_IREFCKS(i3c->refclk_div));
+	renesas_writel(i3c->regs, MSDVAD, MSDVAD_MDYADV |
+		       MSDVAD_MDYAD(i3c->dyn_addr));
+
+	/* Restore Device Address Table values. */
+	for (i =3D 0; i < i3c->maxdevs; i++)
+		renesas_writel(i3c->regs, DATBAS(i), i3c->DATBASn[i]);
+
+	/* I3C hw init. */
+	renesas_i3c_hw_init(i3c);
+
+	i2c_mark_adapter_resumed(&i3c->base.i2c);
+
+	return 0;
+
+err_tresetn:
+	reset_control_assert(i3c->tresetn);
+err_presetn:
+	reset_control_assert(i3c->presetn);
+	return ret;
+}
+
+static const struct dev_pm_ops renesas_i3c_pm_ops =3D {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(renesas_i3c_suspend_noirq,
+				  renesas_i3c_resume_noirq)
+};
+
 static const struct of_device_id renesas_i3c_of_ids[] =3D {
 	{ .compatible =3D "renesas,r9a08g045-i3c" },
 	{ .compatible =3D "renesas,r9a09g047-i3c" },
@@ -1425,6 +1513,7 @@ static struct platform_driver renesas_i3c =3D {
 	.driver =3D {
 		.name =3D "renesas-i3c",
 		.of_match_table =3D renesas_i3c_of_ids,
+		.pm =3D pm_sleep_ptr(&renesas_i3c_pm_ops),
 	},
 };
 module_platform_driver(renesas_i3c);
--=20
2.43.0

