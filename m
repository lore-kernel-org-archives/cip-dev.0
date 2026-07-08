Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69E3C44506
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 08:12:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3738.1783498365491358288
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 01:12:45 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ttbc=fc=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4CDCD43616;
	Wed,  8 Jul 2026 08:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D83D1F000E9;
	Wed,  8 Jul 2026 08:12:44 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v2 04/17] reset: rzg2l-usbphy-ctrl: Fix a NULL vs IS_ERR() bug in probe
Date: Wed,  8 Jul 2026 11:12:24 +0300
Message-ID: <20260708081237.3882574-5-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708081237.3882574-1-claudiu.beznea@tuxon.dev>
References: <20260708081237.3882574-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 08:12:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23533

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

Changes in v2:
- none

 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/rese=
t-rzg2l-usbphy-ctrl.c
index 4d51213e59ba..6d8c48d247a0 100644
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


