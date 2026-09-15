Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51080C88E75
	for <webhook@archiver.kernel.org>; Tue, 15 Sep 2026 12:23:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21577.1789475006952166491
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Sep 2026 05:23:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=yjg9=hh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B9B3143891;
	Tue, 15 Sep 2026 12:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5F61F00893;
	Tue, 15 Sep 2026 12:23:24 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: claudiu.beznea@tuxon.dev,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH linux-5.10.y-cip 1/2] pinctrl: renesas: rzg2l: Use -ENOTSUPP instead of -EOPNOTSUPP
Date: Tue, 15 Sep 2026 15:23:20 +0300
Message-ID: <20260915122321.2531353-2-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915122321.2531353-1-claudiu.beznea@tuxon.dev>
References: <20260915122321.2531353-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Sep 2026 12:23:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24183

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c1492da3939c89372929e062d731f328f7693f1e upstream.

The pinctrl and GPIO core code make exceptions for the -ENOTSUPP error
code.  One such example is gpio_set_config_with_argument_optional(),
which returns success when gpio_set_config_with_argument() returns
-ENOTSUPP, but reports failure for all other error codes.

Returning -EOPNOTSUPP from the pinctrl driver on the unsupported pinctrl
operation may lead to boot failures when pinctrl drivers implements
struct gpio_chip::set_config, the system uses GPIO hogs, and the
struct gpio_chip::set_config implementation returns -EOPNOTSUPP for the
unsupported operations.

Return -ENOTSUPP for the unsupported pinctrl operation.

Fixes: 560c633d378a ("pinctrl: renesas: rzg2l: Drop oen_read and oen_writ=
e callbacks")
Fixes: c4c4637eb57f ("pinctrl: renesas: Add RZ/G2L pin and gpio controlle=
r driver")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260515124008.2947838-2-claudiu.beznea@ke=
rnel.org
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/re=
nesas/pinctrl-rzg2l.c
index 404b96d4d54d..b649f9ac84a3 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1333,7 +1333,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl=
_dev *pctldev,
 			break;
=20
 		default:
-			return -EOPNOTSUPP;
+			return -ENOTSUPP;
 		}
 	}
=20
@@ -1415,7 +1415,7 @@ static int rzg2l_pinctrl_pinconf_group_get(struct p=
inctrl_dev *pctldev,
=20
 		/* Check config matching between to pin  */
 		if (i && prev_config !=3D *config)
-			return -EOPNOTSUPP;
+			return -ENOTSUPP;
=20
 		prev_config =3D *config;
 	}
--=20
2.43.0


