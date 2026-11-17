Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15976.1794916054034636148
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:34 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CE70640AD9;
	Tue, 17 Nov 2026 11:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44AD1F000C4;
	Tue, 17 Nov 2026 11:47:32 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 61/69] hwmon: (lm75) add I3C support for P3T1755
Date: Tue, 17 Nov 2026 13:45:45 +0200
Message-ID: <20261117114553.1484215-62-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24902
Content-Type: text/plain; charset="utf-8"

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 6071d10413ff8489c3e842b19b1e0d539700068d upstream.

Introduce I3C support by defining I3C accessors for regmap and
implementing an I3C driver. Enable I3C for the NXP P3T1755.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20241220093635.11218-1-wsa+renesas@sang-e=
ngineering.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/hwmon/Kconfig |   2 +
 drivers/hwmon/lm75.c  | 121 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 119 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index efb851d72699..c82bb7664cad 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1177,7 +1177,9 @@ config SENSORS_LM73
 config SENSORS_LM75
 	tristate "National Semiconductor LM75 and compatibles"
 	depends on I2C
+	depends on I3C || !I3C
 	select REGMAP_I2C
+	select REGMAP_I3C if I3C
 	help
 	  If you say yes here you get support for one common type of
 	  temperature sensor chip, with models including:
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 6b64dcab10b8..1266d61a63e5 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
+#include <linux/i3c/device.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
 #include <linux/of_device.h>
@@ -111,6 +112,8 @@ struct lm75_data {
 	unsigned int			sample_time;	/* In ms */
 	enum lm75_type			kind;
 	const struct lm75_params	*params;
+	u8				reg_buf[1];
+	u8				val_buf[3];
 };
=20
 /*----------------------------------------------------------------------=
-*/
@@ -590,6 +593,77 @@ static const struct regmap_bus lm75_i2c_regmap_bus =3D=
 {
 	.reg_write =3D lm75_i2c_reg_write,
 };
=20
+static int lm75_i3c_reg_read(void *context, unsigned int reg, unsigned i=
nt *val)
+{
+	struct i3c_device *i3cdev =3D context;
+	struct lm75_data *data =3D i3cdev_get_drvdata(i3cdev);
+	struct i3c_priv_xfer xfers[] =3D {
+		{
+			.rnw =3D false,
+			.len =3D 1,
+			.data.out =3D data->reg_buf,
+		},
+		{
+			.rnw =3D true,
+			.len =3D 2,
+			.data.out =3D data->val_buf,
+		},
+	};
+	int ret;
+
+	data->reg_buf[0] =3D reg;
+
+	if (reg =3D=3D LM75_REG_CONF && !data->params->config_reg_16bits)
+		xfers[1].len--;
+
+	ret =3D i3c_device_do_priv_xfers(i3cdev, xfers, 2);
+	if (ret < 0)
+		return ret;
+
+	if (reg =3D=3D LM75_REG_CONF && !data->params->config_reg_16bits)
+		*val =3D data->val_buf[0];
+	else if (reg =3D=3D LM75_REG_CONF)
+		*val =3D data->val_buf[0] | (data->val_buf[1] << 8);
+	else
+		*val =3D data->val_buf[1] | (data->val_buf[0] << 8);
+
+	return 0;
+}
+
+static int lm75_i3c_reg_write(void *context, unsigned int reg, unsigned =
int val)
+{
+	struct i3c_device *i3cdev =3D context;
+	struct lm75_data *data =3D i3cdev_get_drvdata(i3cdev);
+	struct i3c_priv_xfer xfers[] =3D {
+		{
+			.rnw =3D false,
+			.len =3D 3,
+			.data.out =3D data->val_buf,
+		},
+	};
+
+	data->val_buf[0] =3D reg;
+
+	if (reg =3D=3D PCT2075_REG_IDLE ||
+	    (reg =3D=3D LM75_REG_CONF && !data->params->config_reg_16bits)) {
+		xfers[0].len--;
+		data->val_buf[1] =3D val & 0xff;
+	} else if (reg =3D=3D LM75_REG_CONF) {
+		data->val_buf[1] =3D val & 0xff;
+		data->val_buf[2] =3D (val >> 8) & 0xff;
+	} else {
+		data->val_buf[1] =3D (val >> 8) & 0xff;
+		data->val_buf[2] =3D val & 0xff;
+	}
+
+	return i3c_device_do_priv_xfers(i3cdev, xfers, 1);
+}
+
+static const struct regmap_bus lm75_i3c_regmap_bus =3D {
+	.reg_read =3D lm75_i3c_reg_read,
+	.reg_write =3D lm75_i3c_reg_write,
+};
+
 static const struct regmap_config lm75_regmap_config =3D {
 	.reg_bits =3D 8,
 	.val_bits =3D 16,
@@ -610,7 +684,7 @@ static void lm75_remove(void *data)
 }
=20
 static int lm75_generic_probe(struct device *dev, const char *name,
-			      const void *kind_ptr, int irq, struct regmap *regmap)
+			      enum lm75_type kind, int irq, struct regmap *regmap)
 {
 	struct device *hwmon_dev;
 	struct lm75_data *data;
@@ -623,7 +697,7 @@ static int lm75_generic_probe(struct device *dev, con=
st char *name,
 	/* needed by custom regmap callbacks */
 	dev_set_drvdata(dev, data);
=20
-	data->kind =3D (uintptr_t)kind_ptr;
+	data->kind =3D kind;
 	data->regmap =3D regmap;
=20
 	err =3D devm_regulator_get_enable(dev, "vs");
@@ -695,7 +769,7 @@ static int lm75_i2c_probe(struct i2c_client *client)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
=20
-	return lm75_generic_probe(dev, client->name, i2c_get_match_data(client)=
,
+	return lm75_generic_probe(dev, client->name, (uintptr_t)i2c_get_match_d=
ata(client),
 				  client->irq, regmap);
 }
=20
@@ -732,6 +806,37 @@ static const struct i2c_device_id lm75_i2c_ids[] =3D=
 {
 };
 MODULE_DEVICE_TABLE(i2c, lm75_i2c_ids);
=20
+struct lm75_i3c_device {
+	enum lm75_type type;
+	const char *name;
+};
+
+static const struct lm75_i3c_device lm75_i3c_p3t1755 =3D {
+	.name =3D "p3t1755",
+	.type =3D p3t1755,
+};
+
+static const struct i3c_device_id lm75_i3c_ids[] =3D {
+	I3C_DEVICE(0x011b, 0x152a, &lm75_i3c_p3t1755),
+	{ /* LIST END */ }
+};
+MODULE_DEVICE_TABLE(i3c, lm75_i3c_ids);
+
+static int lm75_i3c_probe(struct i3c_device *i3cdev)
+{
+	struct device *dev =3D i3cdev_to_dev(i3cdev);
+	const struct lm75_i3c_device *id_data;
+	struct regmap *regmap;
+
+	regmap =3D devm_regmap_init(dev, &lm75_i3c_regmap_bus, i3cdev, &lm75_re=
gmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	id_data =3D i3c_device_match_id(i3cdev, lm75_i3c_ids)->data;
+
+	return lm75_generic_probe(dev, id_data->name, id_data->type, 0, regmap)=
;
+}
+
 static const struct of_device_id __maybe_unused lm75_of_match[] =3D {
 	{
 		.compatible =3D "adi,adt75",
@@ -982,7 +1087,15 @@ static struct i2c_driver lm75_i2c_driver =3D {
 	.address_list	=3D normal_i2c,
 };
=20
-module_i2c_driver(lm75_i2c_driver);
+static struct i3c_driver lm75_i3c_driver =3D {
+	.driver =3D {
+		.name =3D "lm75_i3c",
+	},
+	.probe =3D lm75_i3c_probe,
+	.id_table =3D lm75_i3c_ids,
+};
+
+module_i3c_i2c_driver(lm75_i3c_driver, &lm75_i2c_driver)
=20
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
 MODULE_DESCRIPTION("LM75 driver");
--=20
2.43.0

