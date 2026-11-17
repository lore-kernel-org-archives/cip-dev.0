Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15975.1794916053049345664
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:33 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7979963429;
	Tue, 17 Nov 2026 11:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B5D1F000C4;
	Tue, 17 Nov 2026 11:47:30 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 60/69] hwmon: (lm75) separate probe into common and I2C parts
Date: Tue, 17 Nov 2026 13:45:44 +0200
Message-ID: <20261117114553.1484215-61-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24901
Content-Type: text/plain; charset="utf-8"

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit bc96dc1a1cdad999ccd84a7ea6d5e0926c26d8ce upstream.

Put generic probe functionality into a separate function and let the I2C
driver call it. This is a preparation for adding I3C support which will
also use the generic probe function.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20241219225522.3490-11-wsa+renesas@sang-e=
ngineering.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[claudiu.beznea: fixed conflicts]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/hwmon/lm75.c | 68 +++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 5e158f84f9d2..6b64dcab10b8 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -585,6 +585,11 @@ static int lm75_i2c_reg_write(void *context, unsigne=
d int reg, unsigned int val)
 	return i2c_smbus_write_word_swapped(client, reg, val);
 }
=20
+static const struct regmap_bus lm75_i2c_regmap_bus =3D {
+	.reg_read =3D lm75_i2c_reg_read,
+	.reg_write =3D lm75_i2c_reg_write,
+};
+
 static const struct regmap_config lm75_regmap_config =3D {
 	.reg_bits =3D 8,
 	.val_bits =3D 16,
@@ -597,11 +602,6 @@ static const struct regmap_config lm75_regmap_config=
 =3D {
 	.use_single_write =3D true,
 };
=20
-static const struct regmap_bus lm75_i2c_regmap_bus =3D {
-	.reg_read =3D lm75_i2c_reg_read,
-	.reg_write =3D lm75_i2c_reg_write,
-};
-
 static void lm75_remove(void *data)
 {
 	struct lm75_data *lm75 =3D data;
@@ -609,17 +609,13 @@ static void lm75_remove(void *data)
 	regmap_write(lm75->regmap, LM75_REG_CONF, lm75->orig_conf);
 }
=20
-static int lm75_probe(struct i2c_client *client)
+static int lm75_generic_probe(struct device *dev, const char *name,
+			      const void *kind_ptr, int irq, struct regmap *regmap)
 {
-	struct device *dev =3D &client->dev;
 	struct device *hwmon_dev;
 	struct lm75_data *data;
 	int status, err;
=20
-	if (!i2c_check_functionality(client->adapter,
-			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
-		return -EIO;
-
 	data =3D devm_kzalloc(dev, sizeof(struct lm75_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -627,17 +623,13 @@ static int lm75_probe(struct i2c_client *client)
 	/* needed by custom regmap callbacks */
 	dev_set_drvdata(dev, data);
=20
-	data->kind =3D (uintptr_t)i2c_get_match_data(client);
+	data->kind =3D (uintptr_t)kind_ptr;
+	data->regmap =3D regmap;
=20
 	err =3D devm_regulator_get_enable(dev, "vs");
 	if (err)
 		return err;
=20
-	data->regmap =3D devm_regmap_init(dev, &lm75_i2c_regmap_bus, client,
-					&lm75_regmap_config);
-	if (IS_ERR(data->regmap))
-		return PTR_ERR(data->regmap);
-
 	/* Set to LM75 resolution (9 bits, 1/2 degree C) and range.
 	 * Then tweak to be more precise when appropriate.
 	 */
@@ -663,20 +655,19 @@ static int lm75_probe(struct i2c_client *client)
 	if (err)
 		return err;
=20
-	hwmon_dev =3D devm_hwmon_device_register_with_info(dev, client->name,
-							 data, &lm75_chip_info,
-							 NULL);
+	hwmon_dev =3D devm_hwmon_device_register_with_info(dev, name, data,
+							 &lm75_chip_info, NULL);
 	if (IS_ERR(hwmon_dev))
 		return PTR_ERR(hwmon_dev);
=20
-	if (client->irq) {
+	if (irq) {
 		if (data->params->alarm) {
 			err =3D devm_request_threaded_irq(dev,
-							client->irq,
+							irq,
 							NULL,
 							&lm75_alarm_handler,
 							IRQF_ONESHOT,
-							client->name,
+							name,
 							hwmon_dev);
 			if (err)
 				return err;
@@ -686,12 +677,29 @@ static int lm75_probe(struct i2c_client *client)
 		}
 	}
=20
-	dev_info(dev, "%s: sensor '%s'\n", dev_name(hwmon_dev), client->name);
+	dev_info(dev, "%s: sensor '%s'\n", dev_name(hwmon_dev), name);
=20
 	return 0;
 }
=20
-static const struct i2c_device_id lm75_ids[] =3D {
+static int lm75_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev =3D &client->dev;
+	struct regmap *regmap;
+
+	if (!i2c_check_functionality(client->adapter,
+			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
+		return -EOPNOTSUPP;
+
+	regmap =3D devm_regmap_init(dev, &lm75_i2c_regmap_bus, client, &lm75_re=
gmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return lm75_generic_probe(dev, client->name, i2c_get_match_data(client)=
,
+				  client->irq, regmap);
+}
+
+static const struct i2c_device_id lm75_i2c_ids[] =3D {
 	{ "adt75", adt75, },
 	{ "as6200", as6200, },
 	{ "ds1775", ds1775, },
@@ -722,7 +730,7 @@ static const struct i2c_device_id lm75_ids[] =3D {
 	{ "tmp75c", tmp75c, },
 	{ /* LIST END */ }
 };
-MODULE_DEVICE_TABLE(i2c, lm75_ids);
+MODULE_DEVICE_TABLE(i2c, lm75_i2c_ids);
=20
 static const struct of_device_id __maybe_unused lm75_of_match[] =3D {
 	{
@@ -961,20 +969,20 @@ static const struct dev_pm_ops lm75_dev_pm_ops =3D =
{
 #define LM75_DEV_PM_OPS NULL
 #endif /* CONFIG_PM */
=20
-static struct i2c_driver lm75_driver =3D {
+static struct i2c_driver lm75_i2c_driver =3D {
 	.class		=3D I2C_CLASS_HWMON,
 	.driver =3D {
 		.name	=3D "lm75",
 		.of_match_table =3D of_match_ptr(lm75_of_match),
 		.pm	=3D LM75_DEV_PM_OPS,
 	},
-	.probe_new	=3D lm75_probe,
-	.id_table	=3D lm75_ids,
+	.probe_new	=3D lm75_i2c_probe,
+	.id_table	=3D lm75_i2c_ids,
 	.detect		=3D lm75_detect,
 	.address_list	=3D normal_i2c,
 };
=20
-module_i2c_driver(lm75_driver);
+module_i2c_driver(lm75_i2c_driver);
=20
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
 MODULE_DESCRIPTION("LM75 driver");
--=20
2.43.0

