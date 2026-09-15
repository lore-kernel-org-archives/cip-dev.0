Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53646C88E75
	for <webhook@archiver.kernel.org>; Tue, 15 Sep 2026 12:23:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21620.1789475027071544380
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Sep 2026 05:23:47 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=yjg9=hh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3AD87600D1;
	Tue, 15 Sep 2026 12:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FEA1F00893;
	Tue, 15 Sep 2026 12:23:44 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: claudiu.beznea@tuxon.dev,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH linux-6.12.y-cip] pinctrl: renesas: rzg2l: Populate struct gpio_chip::set_config
Date: Tue, 15 Sep 2026 15:23:43 +0300
Message-ID: <20260915122343.2531425-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Sep 2026 12:23:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24186

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 60a19a68779b1f24e3160c8e4317d0334a397687 upstream.

Populate struct gpio_chip::set_config to allow various GPIO settings.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260515124008.2947838-3-claudiu.beznea@ke=
rnel.org
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/re=
nesas/pinctrl-rzg2l.c
index db8362951325..3f16b03c1ea1 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -3222,6 +3222,7 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl=
 *pctrl)
 	chip->direction_output =3D rzg2l_gpio_direction_output;
 	chip->get =3D rzg2l_gpio_get;
 	chip->set =3D rzg2l_gpio_set;
+	chip->set_config =3D gpiochip_generic_config;
 	chip->label =3D name;
 	chip->parent =3D pctrl->dev;
 	chip->owner =3D THIS_MODULE;
--=20
2.43.0


