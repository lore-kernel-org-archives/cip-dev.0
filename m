Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89245C4450A
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 08:12:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3887.1783498345269436087
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 01:12:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ttbc=fc=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 122F941B66;
	Wed,  8 Jul 2026 08:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3CA1F000E9;
	Wed,  8 Jul 2026 08:12:23 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 17/22] phy: renesas: rcar-gen3-usb2: Add support for the RZ/G3S SoC
Date: Wed,  8 Jul 2026 11:11:54 +0300
Message-ID: <20260708081159.3882514-18-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708081159.3882514-1-claudiu.beznea@tuxon.dev>
References: <20260708081159.3882514-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 08:12:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23523

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 3c2ea12a625dbf5a864f4920235fa1c739d06e7d upstream.

Add support for the Renesas RZ/G3S SoC. The support is similar with the
rest of RZ/G2 devices with the except that the RZ/G3S needs bus
initialization due to hardware limitation.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20240822152801.602318-13-claudiu.beznea.u=
j@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[claudiu.beznea: fixed conflict with v2h driver data by keeping both of
 them; moved g3s driver data above v2h driver data to have them
 alphanumerically sorted]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renes=
as/phy-rcar-gen3-usb2.c
index 65cca04c374f..9507ebb6b13d 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -604,6 +604,12 @@ static const struct rcar_gen3_phy_drv_data rz_g2l_ph=
y_usb2_data =3D {
 	.no_adp_ctrl =3D true,
 };
=20
+static const struct rcar_gen3_phy_drv_data rz_g3s_phy_usb2_data =3D {
+	.phy_usb2_ops =3D &rcar_gen3_phy_usb2_ops,
+	.no_adp_ctrl =3D true,
+	.init_bus =3D true,
+};
+
 static const struct rcar_gen3_phy_drv_data rz_v2h_phy_usb2_data =3D {
 	.phy_usb2_ops =3D &rcar_gen3_phy_usb2_ops,
 	.no_adp_ctrl =3D true,
@@ -635,6 +641,10 @@ static const struct of_device_id rcar_gen3_phy_usb2_=
match_table[] =3D {
 		.compatible =3D "renesas,rzg2l-usb2-phy",
 		.data =3D &rz_g2l_phy_usb2_data,
 	},
+	{
+		.compatible =3D "renesas,usb2-phy-r9a08g045",
+		.data =3D &rz_g3s_phy_usb2_data,
+	},
 	{
 		.compatible =3D "renesas,rcar-gen3-usb2-phy",
 		.data =3D &rcar_gen3_phy_usb2_data,
--=20
2.43.0


