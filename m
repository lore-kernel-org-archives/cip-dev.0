Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.963.1795020139845517308
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 08:42:19 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=4qsa=jh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9C35B41980;
	Wed, 18 Nov 2026 16:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F57F1F000C4;
	Wed, 18 Nov 2026 16:42:18 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [RESEND PATCH 6.12.y-cip 22/35] pinctrl: renesas: rzg2l: Fix type in .pin_config_group_get() callback
Date: Wed, 18 Nov 2026 18:41:33 +0200
Message-ID: <20261118164146.3040784-23-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
References: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 16:42:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24985
Content-Type: text/plain; charset="utf-8"

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit f246b6c2bdeca803364af9789309559e5274fa34 upstream.

On 64-bit platforms, "unsigned long" is 64-bit.  Hence checking if all
"unsigned long" configuration values are equal should be done using an
"unsigned long" temporary.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/6befae30f129daffd94f7a9507d874443e444a21.1=
777562725.git.geert+renesas@glider.be
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/re=
nesas/pinctrl-rzg2l.c
index 3f16b03c1ea1..6fdffa2cf3ae 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1824,8 +1824,9 @@ static int rzg2l_pinctrl_pinconf_group_get(struct p=
inctrl_dev *pctldev,
 					   unsigned int group,
 					   unsigned long *config)
 {
+	unsigned long prev_config =3D 0;
 	const unsigned int *pins;
-	unsigned int i, npins, prev_config =3D 0;
+	unsigned int i, npins;
 	int ret;
=20
 	ret =3D pinctrl_generic_get_group_pins(pctldev, group, &pins, &npins);
--=20
2.43.0

