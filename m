Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB12CD98D2
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 10:46:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42671.1781174762220371104
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jun 2026 03:46:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=pbru=eh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0AF9841533;
	Thu, 11 Jun 2026 10:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF2B1F00893;
	Thu, 11 Jun 2026 10:46:00 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 17/21] phy: renesas: rcar-gen3-usb2: Move phy_data->init_bus check
Date: Thu, 11 Jun 2026 13:45:27 +0300
Message-ID: <20260611104532.2532863-18-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611104532.2532863-1-claudiu.beznea@tuxon.dev>
References: <20260611104532.2532863-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 10:46:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23106

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 79d9db7f7a0c94b2b505666513879ac470c7e12f upstream.

Move the check of phy_data->init_bus from rcar_gen3_phy_usb2_init_bus()
to rcar_gen3_phy_usb2_probe() to avoid having it duplicated in both the
probe path and the upcoming resume code. This is a preparatory patch.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patch.msgid.link/20251119120418.686224-2-claudiu.beznea.uj@=
bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renes=
as/phy-rcar-gen3-usb2.c
index 9507ebb6b13d..d42ba815bb0c 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -711,6 +711,9 @@ static int rcar_gen3_phy_usb2_init_bus(struct rcar_ge=
n3_chan *channel)
 	int ret;
 	u32 val;
=20
+	if (!channel->phy_data->init_bus)
+		return 0;
+
 	rstc =3D devm_reset_control_array_get_shared(dev);
 	if (IS_ERR(rstc))
 		return PTR_ERR(rstc);
@@ -791,11 +794,9 @@ static int rcar_gen3_phy_usb2_probe(struct platform_=
device *pdev)
 	platform_set_drvdata(pdev, channel);
 	channel->dev =3D dev;
=20
-	if (channel->phy_data->init_bus) {
-		ret =3D rcar_gen3_phy_usb2_init_bus(channel);
-		if (ret)
-			goto error;
-	}
+	ret =3D rcar_gen3_phy_usb2_init_bus(channel);
+	if (ret)
+		goto error;
=20
 	if (channel->phy_data->no_adp_ctrl)
 		channel->obint_enable_bits =3D USB2_OBINT_IDCHG_EN;
--=20
2.43.0


