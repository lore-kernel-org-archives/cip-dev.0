Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAEBCD98D6
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 10:46:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42616.1781174759243749223
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jun 2026 03:45:59 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=pbru=eh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1189A405AB;
	Thu, 11 Jun 2026 10:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF11B1F00893;
	Thu, 11 Jun 2026 10:45:57 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 15/21] phy: renesas: rcar-gen3-usb2: store drvdata pointer in channel
Date: Thu, 11 Jun 2026 13:45:25 +0300
Message-ID: <20260611104532.2532863-16-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611104532.2532863-1-claudiu.beznea@tuxon.dev>
References: <20260611104532.2532863-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 10:46:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23104

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
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 27 ++++++++++--------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renes=
as/phy-rcar-gen3-usb2.c
index 97fb744271d9..65cca04c374f 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -124,6 +124,7 @@ struct rcar_gen3_phy {
 struct rcar_gen3_chan {
 	void __iomem *base;
 	struct device *dev;	/* platform_device's device */
+	const struct rcar_gen3_phy_drv_data *phy_data;
 	struct extcon_dev *extcon;
 	struct rcar_gen3_phy rphys[NUM_OF_PHYS];
 	struct regulator *vbus;
@@ -134,8 +135,6 @@ struct rcar_gen3_chan {
 	bool extcon_host;
 	bool is_otg_channel;
 	bool uses_otg_pins;
-	bool soc_no_adp_ctrl;
-	bool utmi_ctrl;
 };
=20
 struct rcar_gen3_phy_drv_data {
@@ -205,7 +204,7 @@ static void rcar_gen3_enable_vbus_ctrl(struct rcar_ge=
n3_chan *ch, int vbus)
 	u32 val;
=20
 	dev_vdbg(ch->dev, "%s: %08x, %d\n", __func__, val, vbus);
-	if (ch->soc_no_adp_ctrl) {
+	if (ch->phy_data->no_adp_ctrl) {
 		if (ch->vbus)
 			regulator_hardware_enable(ch->vbus, vbus);
=20
@@ -291,7 +290,7 @@ static bool rcar_gen3_check_id(struct rcar_gen3_chan =
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
@@ -422,7 +421,7 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan =
*ch)
 	      USB2_LINECTRL1_DMRPD_EN | USB2_LINECTRL1_DM_RPD;
 	writel(val, usb2_base + USB2_LINECTRL1);
=20
-	if (!ch->soc_no_adp_ctrl) {
+	if (!ch->phy_data->no_adp_ctrl) {
 		val =3D readl(usb2_base + USB2_VBCTRL);
 		val &=3D ~USB2_VBCTRL_OCCLREN;
 		writel(val | USB2_VBCTRL_DRVVBUSSEL, usb2_base + USB2_VBCTRL);
@@ -488,7 +487,7 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
 	if (rphy->int_enable_bits)
 		rcar_gen3_init_otg(channel);
=20
-	if (channel->utmi_ctrl) {
+	if (channel->phy_data->utmi_ctrl) {
 		val =3D readl(usb2_base + USB2_REGEN_CG_CTRL) | USB2_REGEN_CG_CTRL_UPH=
Y_WEN;
 		writel(val, usb2_base + USB2_REGEN_CG_CTRL);
=20
@@ -731,7 +730,6 @@ static int rcar_gen3_phy_usb2_init_bus(struct rcar_ge=
n3_chan *channel)
=20
 static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 {
-	const struct rcar_gen3_phy_drv_data *phy_data;
 	struct device *dev =3D &pdev->dev;
 	struct rcar_gen3_chan *channel;
 	struct phy_provider *provider;
@@ -774,8 +772,8 @@ static int rcar_gen3_phy_usb2_probe(struct platform_d=
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
@@ -783,22 +781,19 @@ static int rcar_gen3_phy_usb2_probe(struct platform=
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
-	channel->utmi_ctrl =3D phy_data->utmi_ctrl;
-
 	spin_lock_init(&channel->lock);
 	for (i =3D 0; i < NUM_OF_PHYS; i++) {
 		channel->rphys[i].phy =3D devm_phy_create(dev, NULL,
-							phy_data->phy_usb2_ops);
+							channel->phy_data->phy_usb2_ops);
 		if (IS_ERR(channel->rphys[i].phy)) {
 			dev_err(dev, "Failed to create USB2 PHY\n");
 			ret =3D PTR_ERR(channel->rphys[i].phy);
@@ -809,7 +804,7 @@ static int rcar_gen3_phy_usb2_probe(struct platform_d=
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


