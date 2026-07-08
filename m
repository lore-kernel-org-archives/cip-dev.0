Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D20C44506
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 08:11:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3855.1783498277990366628
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 01:11:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ttbc=fc=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5BE5F6001D;
	Wed,  8 Jul 2026 08:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371A91F000E9;
	Wed,  8 Jul 2026 08:11:16 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v2 21/27] phy: renesas: rcar-gen3-usb2: store drvdata pointer in channel
Date: Wed,  8 Jul 2026 11:10:40 +0300
Message-ID: <20260708081046.3882290-22-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708081046.3882290-1-claudiu.beznea@tuxon.dev>
References: <20260708081046.3882290-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 08:11:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23499

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit f75806d26318c08ddb79652cce89086e4da17257 upstream.

Store the SoC-specific driver data pointer (struct rcar_gen3_phy_drv_data=
)
directly in struct rcar_gen3_chan instead of copying individual flags int=
o
separate channel members.

Obtain the drvdata with of_device_get_match_data() in probe and assign it
to channel->phy_data. Update all call sites to reference
`channel->phy_data->*` for SoC-specific behaviour (for example no_adp_ctr=
l
and utmi_ctrl). Remove the redundant soc_no_adp_ctrl and utmi_ctrl fields
from struct rcar_gen3_chan.

This simplifies the probe path, reduces duplication, and makes it easier
to extend the driver with additional platform-specific fields in the
future.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20250808215209.3692744-3-prabhakar.mahade=
v-lad.rj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[claudiu.beznea:
 - fixed conflict in struct rcar_gen3_chan
 - dropped channel->phy_data->utmi_ctrl check in rcar_gen3_phy_usb2_init(=
)
   along with the code block that followed it, as it doesn't apply to
   v5.10 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renes=
as/phy-rcar-gen3-usb2.c
index afd706a3b0c7..b7f5305b6b38 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -116,6 +116,7 @@ struct rcar_gen3_phy {
 struct rcar_gen3_chan {
 	void __iomem *base;
 	struct device *dev;	/* platform_device's device */
+	const struct rcar_gen3_phy_drv_data *phy_data;
 	struct extcon_dev *extcon;
 	struct rcar_gen3_phy rphys[NUM_OF_PHYS];
 	struct regulator *vbus;
@@ -127,7 +128,6 @@ struct rcar_gen3_chan {
 	bool extcon_host;
 	bool is_otg_channel;
 	bool uses_otg_pins;
-	bool soc_no_adp_ctrl;
 };
=20
 struct rcar_gen3_phy_drv_data {
@@ -196,7 +196,7 @@ static void rcar_gen3_enable_vbus_ctrl(struct rcar_ge=
n3_chan *ch, int vbus)
 	u32 val;
=20
 	dev_vdbg(ch->dev, "%s: %08x, %d\n", __func__, val, vbus);
-	if (ch->soc_no_adp_ctrl) {
+	if (ch->phy_data->no_adp_ctrl) {
 		if (ch->vbus)
 			regulator_hardware_enable(ch->vbus, vbus);
=20
@@ -282,7 +282,7 @@ static bool rcar_gen3_check_id(struct rcar_gen3_chan =
*ch)
 	if (!ch->uses_otg_pins)
 		return (ch->dr_mode =3D=3D USB_DR_MODE_HOST) ? false : true;
=20
-	if (ch->soc_no_adp_ctrl)
+	if (ch->phy_data->no_adp_ctrl)
 		return !!(readl(ch->base + USB2_LINECTRL1) & USB2_LINECTRL1_USB2_IDMON=
);
=20
 	return !!(readl(ch->base + USB2_ADPCTRL) & USB2_ADPCTRL_IDDIG);
@@ -414,7 +414,7 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan =
*ch)
 	      USB2_LINECTRL1_DMRPD_EN | USB2_LINECTRL1_DM_RPD;
 	writel(val, usb2_base + USB2_LINECTRL1);
=20
-	if (!ch->soc_no_adp_ctrl) {
+	if (!ch->phy_data->no_adp_ctrl) {
 		val =3D readl(usb2_base + USB2_VBCTRL);
 		val &=3D ~USB2_VBCTRL_OCCLREN;
 		writel(val | USB2_VBCTRL_DRVVBUSSEL, usb2_base + USB2_VBCTRL);
@@ -711,7 +711,6 @@ static int rcar_gen3_phy_usb2_init_bus(struct rcar_ge=
n3_chan *channel)
=20
 static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 {
-	const struct rcar_gen3_phy_drv_data *phy_data;
 	struct device *dev =3D &pdev->dev;
 	struct rcar_gen3_chan *channel;
 	struct phy_provider *provider;
@@ -754,8 +753,8 @@ static int rcar_gen3_phy_usb2_probe(struct platform_d=
evice *pdev)
 	 */
 	pm_runtime_enable(dev);
=20
-	phy_data =3D of_device_get_match_data(dev);
-	if (!phy_data) {
+	channel->phy_data =3D of_device_get_match_data(dev);
+	if (!channel->phy_data) {
 		ret =3D -EINVAL;
 		goto error;
 	}
@@ -763,21 +762,20 @@ static int rcar_gen3_phy_usb2_probe(struct platform=
_device *pdev)
 	platform_set_drvdata(pdev, channel);
 	channel->dev =3D dev;
=20
-	if (phy_data->init_bus) {
+	if (channel->phy_data->init_bus) {
 		ret =3D rcar_gen3_phy_usb2_init_bus(channel);
 		if (ret)
 			goto error;
 	}
=20
-	channel->soc_no_adp_ctrl =3D phy_data->no_adp_ctrl;
-	if (phy_data->no_adp_ctrl)
+	if (channel->phy_data->no_adp_ctrl)
 		channel->obint_enable_bits =3D USB2_OBINT_IDCHG_EN;
=20
 	spin_lock_init(&channel->lock);
=20
 	for (i =3D 0; i < NUM_OF_PHYS; i++) {
 		channel->rphys[i].phy =3D devm_phy_create(dev, NULL,
-							phy_data->phy_usb2_ops);
+							channel->phy_data->phy_usb2_ops);
 		if (IS_ERR(channel->rphys[i].phy)) {
 			dev_err(dev, "Failed to create USB2 PHY\n");
 			ret =3D PTR_ERR(channel->rphys[i].phy);
@@ -788,7 +786,7 @@ static int rcar_gen3_phy_usb2_probe(struct platform_d=
evice *pdev)
 		phy_set_drvdata(channel->rphys[i].phy, &channel->rphys[i]);
 	}
=20
-	if (channel->soc_no_adp_ctrl && channel->is_otg_channel)
+	if (channel->phy_data->no_adp_ctrl && channel->is_otg_channel)
 		channel->vbus =3D devm_regulator_get_exclusive(dev, "vbus");
 	else
 		channel->vbus =3D devm_regulator_get_optional(dev, "vbus");
--=20
2.43.0


