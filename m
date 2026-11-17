Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15833.1794916042338791917
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:22 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C0B476344D;
	Tue, 17 Nov 2026 11:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE571F000C5;
	Tue, 17 Nov 2026 11:47:20 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 53/69] hwmon: (lm75) Fix tmp112 default config
Date: Tue, 17 Nov 2026 13:45:37 +0200
Message-ID: <20261117114553.1484215-54-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24894
Content-Type: text/plain; charset="utf-8"

From: Abdel Alkuor <alkuor@gmail.com>

commit 8249a0e25dd2972e919a2552425bf4faa2581d24 upstream.

Set tmp112 conversion rate to 8 HZ and 12-bit mode.

Fixes: 35cd18048542 ("hwmon: (lm75) Aproximate sample times to data-sheet=
 values")
Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
Link: https://lore.kernel.org/r/20240106030254.384963-1-alkuor@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/hwmon/lm75.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 4571634a558d..ce0464234fef 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -260,8 +260,9 @@ static const struct lm75_params device_params[] =3D {
 		.resolutions =3D (u8 []) {9, 10, 11, 12 },
 	},
 	[tmp112] =3D {
-		.set_mask =3D 3 << 5,	/* 8 samples / second */
-		.clr_mask =3D 1 << 7,	/* no one-shot mode*/
+		.config_reg_16bits =3D true,
+		.set_mask =3D 0x60C0,	/* 12-bit mode, 8 samples / second */
+		.clr_mask =3D 1 << 15,	/* no one-shot mode*/
 		.default_resolution =3D 12,
 		.default_sample_time =3D 125,
 		.num_sample_times =3D 4,
--=20
2.43.0

