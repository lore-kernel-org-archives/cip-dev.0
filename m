Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.973.1795020148200049696
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 08:42:28 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=4qsa=jh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 06B0446770;
	Wed, 18 Nov 2026 16:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8B91F000C5;
	Wed, 18 Nov 2026 16:42:26 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [RESEND PATCH 6.12.y-cip 28/35] pinctrl: renesas: rzg2l: Drop defines present in struct rzg2l_hwcfg
Date: Wed, 18 Nov 2026 18:41:39 +0200
Message-ID: <20261118164146.3040784-29-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
References: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 16:42:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24991
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 382ec4d1e27a95ef23080c9e3bca8b44d31736f9 upstream.

Drop the QSPI and OTHER_POC register defines, which are SoC specific and
accessible through struct rzg2l_hwcfg::{qspi, other_poc}.  While at it
move the assignement of rzg2l_hwcfg->regs->qspi upper to have the
initializations as sorted (by offsets) as possible.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260904125425.412632-3-claudiu.beznea+ren=
esas@tuxon.dev
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/re=
nesas/pinctrl-rzg2l.c
index 3f1ab64097ef..77dc53afa72b 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -181,8 +181,6 @@
 #define SMT(off)		(0x3400 + (off) * 8)
 #define SD_CH(off, ch)		((off) + (ch) * 4)
 #define ETH_POC(off, ch)	((off) + (ch) * 4)
-#define QSPI			(0x3008) /* known on RZ/{G2L,G2LC,G2UL,Five} only */
-#define OTHER_POC		(0x3028) /* known on RZ/G3L only */
=20
 #define PVDD_2500		2	/* I/O domain voltage 2.5V */
 #define PVDD_1800		1	/* I/O domain voltage <=3D 1.8V */
@@ -3852,9 +3850,9 @@ static const struct rzg2l_hwcfg rzg2l_hwcfg =3D {
 	.regs =3D {
 		.pwpr =3D 0x3014,
 		.sd_ch =3D 0x3000,
+		.qspi =3D 0x3008,
 		.eth_poc =3D 0x300c,
 		.oen =3D 0x3018,
-		.qspi =3D QSPI,
 	},
 	.iolh_groupa_ua =3D {
 		/* 3v3 power source */
@@ -3872,7 +3870,7 @@ static const struct rzg2l_hwcfg rzg3l_hwcfg =3D {
 		.sd_ch2 =3D 0x3024,
 		.eth_poc =3D 0x3010,
 		.oen =3D 0x3018,
-		.other_poc =3D OTHER_POC,
+		.other_poc =3D 0x3028,
 	},
 	.masks =3D {
 		.other_poc_pvdd1833_oth_awo_poc =3D BIT(0),
--=20
2.43.0

