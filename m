Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD423CD98DA
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 10:45:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42606.1781174744088802016
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jun 2026 03:45:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=pbru=eh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 748606020D;
	Thu, 11 Jun 2026 10:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312711F00893;
	Thu, 11 Jun 2026 10:45:41 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 05/21] reset: rzg2l-usbphy-ctrl: Fix a NULL vs IS_ERR() bug in probe
Date: Thu, 11 Jun 2026 13:45:15 +0300
Message-ID: <20260611104532.2532863-6-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611104532.2532863-1-claudiu.beznea@tuxon.dev>
References: <20260611104532.2532863-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 10:45:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23094

From: Dan Carpenter <dan.carpenter@linaro.org>

commit cea5d43b63b221522f8532a7894149f3d8d11f4b upstream.

The devm_regmap_field_alloc() function never returns NULL, it returns
error pointers.  Update the error checking to match.

Fixes: 58128aa88867 ("reset: rzg2l-usbphy-ctrl: Add support for USB PWRRD=
Y")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/rese=
t-rzg2l-usbphy-ctrl.c
index 4bdef864c331..feb537aaf918 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -158,8 +158,8 @@ static int rzg2l_usbphy_ctrl_pwrrdy_init(struct devic=
e *dev)
 	field.msb =3D __fls(args[1]);
=20
 	pwrrdy =3D devm_regmap_field_alloc(dev, regmap, field);
-	if (!pwrrdy)
-		return -ENOMEM;
+	if (IS_ERR(pwrrdy))
+		return PTR_ERR(pwrrdy);
=20
 	rzg2l_usbphy_ctrl_set_pwrrdy(pwrrdy, true);
=20
--=20
2.43.0


