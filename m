Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713CEC43458
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 08:11:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3691.1783498263444432442
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 01:11:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ttbc=fc=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 94CA1601D9;
	Wed,  8 Jul 2026 08:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706631F000E9;
	Wed,  8 Jul 2026 08:11:01 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v2 10/27] reset: rzg2l-usbphy-ctrl: Add suspend/resume support
Date: Wed,  8 Jul 2026 11:10:29 +0300
Message-ID: <20260708081046.3882290-11-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708081046.3882290-1-claudiu.beznea@tuxon.dev>
References: <20260708081046.3882290-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 08:11:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23488

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c5b7cd9adefc5c060facaff6f54d3187480e4e1b upstream.

The RZ/G2L USBPHY control driver is also used on the RZ/G3S SoC.
The RZ/G3S SoC supports a power-saving mode in which power to most USB
components (including the USBPHY control block) is turned off. Because of
this, the USBPHY control block needs to be reconfigured when returning
from power-saving mode.

Add suspend/resume support to handle runtime suspend/resume of the device=
,
assert/deassert the reset signal, and reinitialize the USBPHY control
block.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
[claudiu.beznea: use SIMPLE_DEV_PM_OPS() instead of
 DEFINE_SIMPLE_DEV_PM_OPS()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 99 +++++++++++++++++++++----
 1 file changed, 84 insertions(+), 15 deletions(-)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/rese=
t-rzg2l-usbphy-ctrl.c
index a75de9b2e9ef..5a8483e44165 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -36,6 +36,7 @@ struct rzg2l_usbphy_ctrl_priv {
 	struct reset_control *rstc;
 	void __iomem *base;
 	struct platform_device *vdev;
+	struct regmap_field *pwrrdy;
=20
 	spinlock_t lock;
 };
@@ -92,6 +93,19 @@ static int rzg2l_usbphy_ctrl_status(struct reset_contr=
oller_dev *rcdev,
 	return !!(readl(priv->base + RESET) & port_mask);
 }
=20
+/* put pll and phy into reset state */
+static void rzg2l_usbphy_ctrl_init(struct rzg2l_usbphy_ctrl_priv *priv)
+{
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	val =3D readl(priv->base + RESET);
+	val |=3D RESET_SEL_PLLRESET | RESET_PLLRESET | PHY_RESET_PORT2 | PHY_RE=
SET_PORT1;
+	writel(val, priv->base + RESET);
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
 #define RZG2L_USBPHY_CTRL_PWRRDY	1
=20
 static const struct of_device_id rzg2l_usbphy_ctrl_match_table[] =3D {
@@ -131,9 +145,9 @@ static void rzg2l_usbphy_ctrl_pwrrdy_off(void *data)
 	rzg2l_usbphy_ctrl_set_pwrrdy(data, false);
 }
=20
-static int rzg2l_usbphy_ctrl_pwrrdy_init(struct device *dev)
+static int rzg2l_usbphy_ctrl_pwrrdy_init(struct device *dev,
+					 struct rzg2l_usbphy_ctrl_priv *priv)
 {
-	struct regmap_field *pwrrdy;
 	struct reg_field field;
 	struct regmap *regmap;
 	const int *data;
@@ -158,15 +172,15 @@ static int rzg2l_usbphy_ctrl_pwrrdy_init(struct dev=
ice *dev)
 	field.lsb =3D __ffs(args[1]);
 	field.msb =3D __fls(args[1]);
=20
-	pwrrdy =3D devm_regmap_field_alloc(dev, regmap, field);
-	if (IS_ERR(pwrrdy))
-		return PTR_ERR(pwrrdy);
+	priv->pwrrdy =3D devm_regmap_field_alloc(dev, regmap, field);
+	if (IS_ERR(priv->pwrrdy))
+		return PTR_ERR(priv->pwrrdy);
=20
 	ret =3D rzg2l_usbphy_ctrl_set_pwrrdy(priv->pwrrdy, true);
 	if (ret)
 		return ret;
=20
-	return devm_add_action_or_reset(dev, rzg2l_usbphy_ctrl_pwrrdy_off, pwrr=
dy);
+	return devm_add_action_or_reset(dev, rzg2l_usbphy_ctrl_pwrrdy_off, priv=
->pwrrdy);
 }
=20
 static int rzg2l_usbphy_ctrl_probe(struct platform_device *pdev)
@@ -175,9 +189,7 @@ static int rzg2l_usbphy_ctrl_probe(struct platform_de=
vice *pdev)
 	struct rzg2l_usbphy_ctrl_priv *priv;
 	struct platform_device *vdev;
 	struct regmap *regmap;
-	unsigned long flags;
 	int error;
-	u32 val;
=20
 	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -191,7 +203,7 @@ static int rzg2l_usbphy_ctrl_probe(struct platform_de=
vice *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
=20
-	error =3D rzg2l_usbphy_ctrl_pwrrdy_init(dev);
+	error =3D rzg2l_usbphy_ctrl_pwrrdy_init(dev, priv);
 	if (error)
 		return error;
=20
@@ -214,12 +226,7 @@ static int rzg2l_usbphy_ctrl_probe(struct platform_d=
evice *pdev)
 		goto err_pm_disable_reset_deassert;
 	}
=20
-	/* put pll and phy into reset state */
-	spin_lock_irqsave(&priv->lock, flags);
-	val =3D readl(priv->base + RESET);
-	val |=3D RESET_SEL_PLLRESET | RESET_PLLRESET | PHY_RESET_PORT2 | PHY_RE=
SET_PORT1;
-	writel(val, priv->base + RESET);
-	spin_unlock_irqrestore(&priv->lock, flags);
+	rzg2l_usbphy_ctrl_init(priv);
=20
 	priv->rcdev.ops =3D &rzg2l_usbphy_ctrl_reset_ops;
 	priv->rcdev.of_reset_n_cells =3D 1;
@@ -267,10 +274,72 @@ static int rzg2l_usbphy_ctrl_remove(struct platform=
_device *pdev)
 	return 0;
 }
=20
+static int rzg2l_usbphy_ctrl_suspend(struct device *dev)
+{
+	struct rzg2l_usbphy_ctrl_priv *priv =3D dev_get_drvdata(dev);
+	u32 val;
+	int ret;
+
+	val =3D readl(priv->base + RESET);
+	if (!(val & PHY_RESET_PORT2) || !(val & PHY_RESET_PORT1))
+		WARN(1, "Suspend with resets de-asserted\n");
+
+	pm_runtime_put_sync(dev);
+
+	ret =3D reset_control_assert(priv->rstc);
+	if (ret)
+		goto rpm_resume;
+
+	ret =3D rzg2l_usbphy_ctrl_set_pwrrdy(priv->pwrrdy, false);
+	if (ret)
+		goto reset_deassert;
+
+	return 0;
+
+reset_deassert:
+	reset_control_deassert(priv->rstc);
+rpm_resume:
+	pm_runtime_resume_and_get(dev);
+	return ret;
+}
+
+static int rzg2l_usbphy_ctrl_resume(struct device *dev)
+{
+	struct rzg2l_usbphy_ctrl_priv *priv =3D dev_get_drvdata(dev);
+	int ret;
+
+	ret =3D rzg2l_usbphy_ctrl_set_pwrrdy(priv->pwrrdy, true);
+	if (ret)
+		return ret;
+
+	ret =3D reset_control_deassert(priv->rstc);
+	if (ret)
+		goto pwrrdy_off;
+
+	ret =3D pm_runtime_resume_and_get(dev);
+	if (ret)
+		goto reset_assert;
+
+	rzg2l_usbphy_ctrl_init(priv);
+
+	return 0;
+
+reset_assert:
+	reset_control_assert(priv->rstc);
+pwrrdy_off:
+	rzg2l_usbphy_ctrl_set_pwrrdy(priv->pwrrdy, false);
+	return ret;
+}
+
+static SIMPLE_DEV_PM_OPS(rzg2l_usbphy_ctrl_pm_ops,
+			 rzg2l_usbphy_ctrl_suspend,
+			 rzg2l_usbphy_ctrl_resume);
+
 static struct platform_driver rzg2l_usbphy_ctrl_driver =3D {
 	.driver =3D {
 		.name		=3D "rzg2l_usbphy_ctrl",
 		.of_match_table	=3D rzg2l_usbphy_ctrl_match_table,
+		.pm		=3D pm_ptr(&rzg2l_usbphy_ctrl_pm_ops),
 	},
 	.probe	=3D rzg2l_usbphy_ctrl_probe,
 	.remove	=3D rzg2l_usbphy_ctrl_remove,
--=20
2.43.0


