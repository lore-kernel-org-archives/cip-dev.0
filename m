Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FD0C44501
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 08:12:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3903.1783498367572158980
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 01:12:47 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ttbc=fc=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D87EE6001D;
	Wed,  8 Jul 2026 08:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE0A1F000E9;
	Wed,  8 Jul 2026 08:12:45 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v2 05/17] reset: rzg2l-usbphy-ctrl: Propagate the return value of regmap_field_update_bits()
Date: Wed,  8 Jul 2026 11:12:25 +0300
Message-ID: <20260708081237.3882574-6-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708081237.3882574-1-claudiu.beznea@tuxon.dev>
References: <20260708081237.3882574-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 08:12:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23534

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 2289ccd753deeb2cfe300d97e8697680c1ce556c upstream.

Propagate the return value of regmap_field_update_bits() to avoid losing
any possible error. With this, the return type of
rzg2l_usbphy_ctrl_set_pwrrdy() was updated accordingly.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/rese=
t-rzg2l-usbphy-ctrl.c
index 6d8c48d247a0..6158f8a288af 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -117,13 +117,13 @@ static const struct regmap_config rzg2l_usb_regconf=
 =3D {
 	.max_register =3D 1,
 };
=20
-static void rzg2l_usbphy_ctrl_set_pwrrdy(struct regmap_field *pwrrdy,
-					 bool power_on)
+static int rzg2l_usbphy_ctrl_set_pwrrdy(struct regmap_field *pwrrdy,
+					bool power_on)
 {
 	u32 val =3D power_on ? 0 : 1;
=20
 	/* The initialization path guarantees that the mask is 1 bit long. */
-	regmap_field_update_bits(pwrrdy, 1, val);
+	return regmap_field_update_bits(pwrrdy, 1, val);
 }
=20
 static void rzg2l_usbphy_ctrl_pwrrdy_off(void *data)
@@ -138,6 +138,7 @@ static int rzg2l_usbphy_ctrl_pwrrdy_init(struct devic=
e *dev)
 	struct regmap *regmap;
 	const int *data;
 	u32 args[2];
+	int ret;
=20
 	data =3D device_get_match_data(dev);
 	if ((uintptr_t)data !=3D RZG2L_USBPHY_CTRL_PWRRDY)
@@ -161,7 +162,9 @@ static int rzg2l_usbphy_ctrl_pwrrdy_init(struct devic=
e *dev)
 	if (IS_ERR(pwrrdy))
 		return PTR_ERR(pwrrdy);
=20
-	rzg2l_usbphy_ctrl_set_pwrrdy(pwrrdy, true);
+	ret =3D rzg2l_usbphy_ctrl_set_pwrrdy(priv->pwrrdy, true);
+	if (ret)
+		return ret;
=20
 	return devm_add_action_or_reset(dev, rzg2l_usbphy_ctrl_pwrrdy_off, pwrr=
dy);
 }
--=20
2.43.0


