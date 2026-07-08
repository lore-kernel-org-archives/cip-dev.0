Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E35C43602
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 08:13:06 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3914.1783498379736510220
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 01:12:59 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ttbc=fc=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 87FBD43616;
	Wed,  8 Jul 2026 08:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E601F000E9;
	Wed,  8 Jul 2026 08:12:58 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v2 15/17] phy: renesas: rcar-gen3-usb2: Add suspend/resume support
Date: Wed,  8 Jul 2026 11:12:35 +0300
Message-ID: <20260708081237.3882574-16-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708081237.3882574-1-claudiu.beznea@tuxon.dev>
References: <20260708081237.3882574-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 08:13:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23544

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 942a7a6bf4c6a8661324539f686a34c9448610bd upstream.

The Renesas RZ/G3S supports a power saving mode where power to most of th=
e
SoC components is turned off. The USB PHY is among these components.
Because of this the settings applied in driver probe need to be executed
also on resume path. On suspend path only reset signal need to be asserte=
d.
Add suspend/resume support.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patch.msgid.link/20251119120418.686224-3-claudiu.beznea.uj@=
bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 57 +++++++++++++++++-------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renes=
as/phy-rcar-gen3-usb2.c
index 6127c0b4b944..1628ede79f9a 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -132,6 +132,7 @@ struct rcar_gen3_chan {
 	struct device *dev;	/* platform_device's device */
 	const struct rcar_gen3_phy_drv_data *phy_data;
 	struct extcon_dev *extcon;
+	struct reset_control *rstc;
 	struct rcar_gen3_phy rphys[NUM_OF_PHYS];
 	struct regulator *vbus;
 	struct work_struct work;
@@ -778,38 +779,24 @@ static void rcar_gen3_reset_assert(void *data)
 static int rcar_gen3_phy_usb2_init_bus(struct rcar_gen3_chan *channel)
 {
 	struct device *dev =3D channel->dev;
-	struct reset_control *rstc;
 	int ret;
 	u32 val;
=20
 	if (!channel->phy_data->init_bus)
 		return 0;
=20
-	rstc =3D devm_reset_control_array_get_shared(dev);
-	if (IS_ERR(rstc))
-		return PTR_ERR(rstc);
-
 	ret =3D pm_runtime_resume_and_get(dev);
 	if (ret)
 		return ret;
=20
-	ret =3D reset_control_deassert(rstc);
-	if (ret)
-		goto rpm_put;
-
-	ret =3D devm_add_action_or_reset(dev, rcar_gen3_reset_assert, rstc);
-	if (ret)
-		goto rpm_put;
-
 	val =3D readl(channel->base + USB2_AHB_BUS_CTR);
 	val &=3D ~USB2_AHB_BUS_CTR_MBL_MASK;
 	val |=3D USB2_AHB_BUS_CTR_MBL_INCR4;
 	writel(val, channel->base + USB2_AHB_BUS_CTR);
=20
-rpm_put:
 	pm_runtime_put(dev);
=20
-	return ret;
+	return 0;
 }
=20
 static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
@@ -849,6 +836,18 @@ static int rcar_gen3_phy_usb2_probe(struct platform_=
device *pdev)
 		}
 	}
=20
+	channel->rstc =3D devm_reset_control_array_get_optional_shared(dev);
+	if (IS_ERR(channel->rstc))
+		return PTR_ERR(channel->rstc);
+
+	ret =3D reset_control_deassert(channel->rstc);
+	if (ret)
+		return ret;
+
+	ret =3D devm_add_action_or_reset(dev, rcar_gen3_reset_assert, channel->=
rstc);
+	if (ret)
+		return ret;
+
 	/*
 	 * devm_phy_create() will call pm_runtime_enable(&phy->dev);
 	 * And then, phy-core will manage runtime pm for this device.
@@ -937,10 +936,38 @@ static void rcar_gen3_phy_usb2_remove(struct platfo=
rm_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 };
=20
+static int rcar_gen3_phy_usb2_suspend(struct device *dev)
+{
+	struct rcar_gen3_chan *channel =3D dev_get_drvdata(dev);
+
+	return reset_control_assert(channel->rstc);
+}
+
+static int rcar_gen3_phy_usb2_resume(struct device *dev)
+{
+	struct rcar_gen3_chan *channel =3D dev_get_drvdata(dev);
+	int ret;
+
+	ret =3D reset_control_deassert(channel->rstc);
+	if (ret)
+		return ret;
+
+	ret =3D rcar_gen3_phy_usb2_init_bus(channel);
+	if (ret)
+		reset_control_assert(channel->rstc);
+
+	return ret;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(rcar_gen3_phy_usb2_pm_ops,
+				rcar_gen3_phy_usb2_suspend,
+				rcar_gen3_phy_usb2_resume);
+
 static struct platform_driver rcar_gen3_phy_usb2_driver =3D {
 	.driver =3D {
 		.name		=3D "phy_rcar_gen3_usb2",
 		.of_match_table	=3D rcar_gen3_phy_usb2_match_table,
+		.pm		=3D pm_ptr(&rcar_gen3_phy_usb2_pm_ops),
 	},
 	.probe	=3D rcar_gen3_phy_usb2_probe,
 	.remove_new =3D rcar_gen3_phy_usb2_remove,
--=20
2.43.0


