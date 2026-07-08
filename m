Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628DEC44503
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 08:13:06 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3913.1783498379243005992
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 01:12:59 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ttbc=fc=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4703241B66;
	Wed,  8 Jul 2026 08:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B061F000E9;
	Wed,  8 Jul 2026 08:12:57 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v2 14/17] phy: renesas: rcar-gen3-usb2: Move phy_data->init_bus check
Date: Wed,  8 Jul 2026 11:12:34 +0300
Message-ID: <20260708081237.3882574-15-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708081237.3882574-1-claudiu.beznea@tuxon.dev>
References: <20260708081237.3882574-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 08:13:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23543

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
[claudiu.beznea: fixed conflict by keeping the code from this patch]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renes=
as/phy-rcar-gen3-usb2.c
index 4e8cf7527439..6127c0b4b944 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -782,6 +782,9 @@ static int rcar_gen3_phy_usb2_init_bus(struct rcar_ge=
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
@@ -861,11 +864,9 @@ static int rcar_gen3_phy_usb2_probe(struct platform_=
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
 	spin_lock_init(&channel->lock);
 	for (i =3D 0; i < NUM_OF_PHYS; i++) {
--=20
2.43.0


