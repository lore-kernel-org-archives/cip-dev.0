Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15974.1794916048456613404
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:28 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DCE696344D;
	Tue, 17 Nov 2026 11:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FFA1F000C4;
	Tue, 17 Nov 2026 11:47:26 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 57/69] hwmon: (lm75) simplify lm75_write_config()
Date: Tue, 17 Nov 2026 13:45:41 +0200
Message-ID: <20261117114553.1484215-58-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24898
Content-Type: text/plain; charset="utf-8"

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit c4d08cf8a03eb9b14858a9b8cf8f4d71a639da57 upstream.

After previous refactoring, it is now possible to make
lm75_write_config() a simple inline function.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20241219225522.3490-8-wsa+renesas@sang-en=
gineering.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/hwmon/lm75.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 9dff6761489b..611320e94db8 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -324,17 +324,11 @@ static inline long lm75_reg_to_mc(s16 temp, u8 reso=
lution)
 	return ((temp >> (16 - resolution)) * 1000) >> (resolution - 8);
 }
=20
-static int lm75_write_config(struct lm75_data *data, u16 set_mask,
-			     u16 clr_mask)
+static inline int lm75_write_config(struct lm75_data *data, u16 set_mask=
,
+				    u16 clr_mask)
 {
-	int err;
-
-	err =3D regmap_update_bits(data->regmap, LM75_REG_CONF,
-				 clr_mask | LM75_SHUTDOWN, set_mask);
-	if (err)
-		return err;
-
-	return 0;
+	return regmap_update_bits(data->regmap, LM75_REG_CONF,
+				  clr_mask | LM75_SHUTDOWN, set_mask);
 }
=20
 static irqreturn_t lm75_alarm_handler(int irq, void *private)
--=20
2.43.0

