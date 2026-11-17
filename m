Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15843.1794916050957702422
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:31 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BFAC14238E;
	Tue, 17 Nov 2026 11:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957491F000C4;
	Tue, 17 Nov 2026 11:47:29 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 59/69] hwmon: (lm75) Remove superfluous 'client' member from private struct
Date: Tue, 17 Nov 2026 13:45:43 +0200
Message-ID: <20261117114553.1484215-60-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24900
Content-Type: text/plain; charset="utf-8"

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 7a5c24da4b3c96949a6d93c3c7fa4133c6f2b88e upstream.

The regmap-only conversion allows us to store the client-pointer as the
'context' parameter for regmap. This not only makes the private struct
smaller, but also allows proper separation of I2C and I3C in the future.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20241219225522.3490-10-wsa+renesas@sang-e=
ngineering.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/hwmon/lm75.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index e549c505edc4..5e158f84f9d2 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -104,9 +104,7 @@ static const unsigned short normal_i2c[] =3D { 0x48, =
0x49, 0x4a, 0x4b, 0x4c,
 #define LM75_REG_MAX		0x03
 #define PCT2075_REG_IDLE	0x04
=20
-/* Each client has this additional data */
 struct lm75_data {
-	struct i2c_client		*client;
 	struct regmap			*regmap;
 	u16				orig_conf;
 	u8				resolution;	/* In bits, 9 to 16 */
@@ -556,8 +554,8 @@ static bool lm75_is_volatile_reg(struct device *dev, =
unsigned int reg)
=20
 static int lm75_i2c_reg_read(void *context, unsigned int reg, unsigned i=
nt *val)
 {
-	struct lm75_data *data =3D context;
-	struct i2c_client *client =3D data->client;
+	struct i2c_client *client =3D context;
+	struct lm75_data *data =3D i2c_get_clientdata(client);
 	int ret;
=20
 	if (reg =3D=3D LM75_REG_CONF) {
@@ -576,8 +574,8 @@ static int lm75_i2c_reg_read(void *context, unsigned =
int reg, unsigned int *val)
=20
 static int lm75_i2c_reg_write(void *context, unsigned int reg, unsigned =
int val)
 {
-	struct lm75_data *data =3D context;
-	struct i2c_client *client =3D data->client;
+	struct i2c_client *client =3D context;
+	struct lm75_data *data =3D i2c_get_clientdata(client);
=20
 	if (reg =3D=3D PCT2075_REG_IDLE ||
 	    (reg =3D=3D LM75_REG_CONF && !data->params->config_reg_16bits))
@@ -629,14 +627,13 @@ static int lm75_probe(struct i2c_client *client)
 	/* needed by custom regmap callbacks */
 	dev_set_drvdata(dev, data);
=20
-	data->client =3D client;
 	data->kind =3D (uintptr_t)i2c_get_match_data(client);
=20
 	err =3D devm_regulator_get_enable(dev, "vs");
 	if (err)
 		return err;
=20
-	data->regmap =3D devm_regmap_init(dev, &lm75_i2c_regmap_bus, data,
+	data->regmap =3D devm_regmap_init(dev, &lm75_i2c_regmap_bus, client,
 					&lm75_regmap_config);
 	if (IS_ERR(data->regmap))
 		return PTR_ERR(data->regmap);
--=20
2.43.0

