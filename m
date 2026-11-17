Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15841.1794916049987480420
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:30 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6AC6B63445;
	Tue, 17 Nov 2026 11:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1431E1F000C4;
	Tue, 17 Nov 2026 11:47:27 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 58/69] hwmon: (lm75) simplify regulator handling
Date: Tue, 17 Nov 2026 13:45:42 +0200
Message-ID: <20261117114553.1484215-59-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24899
Content-Type: text/plain; charset="utf-8"

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 2b64c6f652b0f5435b293d33f7d231132e987fb2 upstream.

devm_regulator_get_enable() was introduced exactly to avoid open coding
regulator handling like in this driver. Make use of this helper.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20241219225522.3490-9-wsa+renesas@sang-en=
gineering.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/hwmon/lm75.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 611320e94db8..e549c505edc4 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -108,7 +108,6 @@ static const unsigned short normal_i2c[] =3D { 0x48, =
0x49, 0x4a, 0x4b, 0x4c,
 struct lm75_data {
 	struct i2c_client		*client;
 	struct regmap			*regmap;
-	struct regulator		*vs;
 	u16				orig_conf;
 	u8				resolution;	/* In bits, 9 to 16 */
 	unsigned int			sample_time;	/* In ms */
@@ -605,13 +604,6 @@ static const struct regmap_bus lm75_i2c_regmap_bus =3D=
 {
 	.reg_write =3D lm75_i2c_reg_write,
 };
=20
-static void lm75_disable_regulator(void *data)
-{
-	struct lm75_data *lm75 =3D data;
-
-	regulator_disable(lm75->vs);
-}
-
 static void lm75_remove(void *data)
 {
 	struct lm75_data *lm75 =3D data;
@@ -640,9 +632,9 @@ static int lm75_probe(struct i2c_client *client)
 	data->client =3D client;
 	data->kind =3D (uintptr_t)i2c_get_match_data(client);
=20
-	data->vs =3D devm_regulator_get(dev, "vs");
-	if (IS_ERR(data->vs))
-		return PTR_ERR(data->vs);
+	err =3D devm_regulator_get_enable(dev, "vs");
+	if (err)
+		return err;
=20
 	data->regmap =3D devm_regmap_init(dev, &lm75_i2c_regmap_bus, data,
 					&lm75_regmap_config);
@@ -659,17 +651,6 @@ static int lm75_probe(struct i2c_client *client)
 	data->sample_time =3D data->params->default_sample_time;
 	data->resolution =3D data->params->default_resolution;
=20
-	/* Enable the power */
-	err =3D regulator_enable(data->vs);
-	if (err) {
-		dev_err(dev, "failed to enable regulator: %d\n", err);
-		return err;
-	}
-
-	err =3D devm_add_action_or_reset(dev, lm75_disable_regulator, data);
-	if (err)
-		return err;
-
 	/* Cache original configuration */
 	err =3D regmap_read(data->regmap, LM75_REG_CONF, &status);
 	if (err)
--=20
2.43.0

