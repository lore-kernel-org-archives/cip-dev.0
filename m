Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16061.1794916201224775035
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:50:01 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 08F1B4120F;
	Tue, 17 Nov 2026 11:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044AD1F000C4;
	Tue, 17 Nov 2026 11:49:59 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 26/34] pinctrl: renesas: rzg2l: Drop defines present in struct rzg2l_hwcfg
Date: Tue, 17 Nov 2026 13:49:12 +0200
Message-ID: <20261117114921.1485204-27-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
References: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:50:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24937
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
[claudiu.beznea: fixed conflict by dropping defines and RZ/G3L code]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/re=
nesas/pinctrl-rzg2l.c
index 817d974ef242..da3f984f6038 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -144,7 +144,6 @@
 #define SMT(off)		(0x3400 + (off) * 8)
 #define SD_CH(off, ch)		((off) + (ch) * 4)
 #define ETH_POC(off, ch)	((off) + (ch) * 4)
-#define QSPI			(0x3008) /* known on RZ/{G2L,G2LC,G2UL,Five} only */
=20
 #define PVDD_2500		2	/* I/O domain voltage 2.5V */
 #define PVDD_1800		1	/* I/O domain voltage <=3D 1.8V */
@@ -3321,9 +3320,9 @@ static const struct rzg2l_hwcfg rzg2l_hwcfg =3D {
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
--=20
2.43.0

