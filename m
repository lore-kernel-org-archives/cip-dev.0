Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15972.1794916046928170776
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:27 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5C3F763429;
	Tue, 17 Nov 2026 11:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061021F000C4;
	Tue, 17 Nov 2026 11:47:24 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 56/69] hwmon: (lm75) Hide register size differences in regmap access functions
Date: Tue, 17 Nov 2026 13:45:40 +0200
Message-ID: <20261117114553.1484215-57-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24897
Content-Type: text/plain; charset="utf-8"

From: Guenter Roeck <linux@roeck-us.net>

commit 6da24a25f766e02fbfc07570b5560154818ba59d upstream.

Hide register size differences in regmap access functions to simplify
runtime code and to simplify adding support for I3C devices. Also
use regmap API functions for bit operations where possible.

For this to work, the 16-bit and 8-bit configuration register has to be
mapped to a 16-bit value. Unlike other registers, this register is a
low-byte-first register, presumably for compatibility with chips with
8-bit wide configuration registers. Hide the differences in the regmap
access code.

While at it, enable alarm attribute support for TMP112.

Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/hwmon/lm75.c | 131 ++++++++++++++++++++-----------------------
 1 file changed, 62 insertions(+), 69 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 4cc2edf34881..9dff6761489b 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -110,7 +110,6 @@ struct lm75_data {
 	struct regmap			*regmap;
 	struct regulator		*vs;
 	u16				orig_conf;
-	u16				current_conf;
 	u8				resolution;	/* In bits, 9 to 16 */
 	unsigned int			sample_time;	/* In ms */
 	enum lm75_type			kind;
@@ -275,6 +274,7 @@ static const struct lm75_params device_params[] =3D {
 		.default_sample_time =3D 125,
 		.num_sample_times =3D 4,
 		.sample_times =3D (unsigned int []){ 125, 250, 1000, 4000 },
+		.alarm =3D true,
 	},
 	[tmp175] =3D {
 		.set_mask =3D 3 << 5,	/* 12-bit mode */
@@ -327,40 +327,16 @@ static inline long lm75_reg_to_mc(s16 temp, u8 reso=
lution)
 static int lm75_write_config(struct lm75_data *data, u16 set_mask,
 			     u16 clr_mask)
 {
-	unsigned int value;
+	int err;
=20
-	clr_mask |=3D LM75_SHUTDOWN << (8 * data->params->config_reg_16bits);
-	value =3D data->current_conf & ~clr_mask;
-	value |=3D set_mask;
+	err =3D regmap_update_bits(data->regmap, LM75_REG_CONF,
+				 clr_mask | LM75_SHUTDOWN, set_mask);
+	if (err)
+		return err;
=20
-	if (data->current_conf !=3D value) {
-		s32 err;
-		if (data->params->config_reg_16bits)
-			err =3D regmap_write(data->regmap, LM75_REG_CONF, value);
-		else
-			err =3D i2c_smbus_write_byte_data(data->client,
-							LM75_REG_CONF,
-							value);
-		if (err)
-			return err;
-		data->current_conf =3D value;
-	}
 	return 0;
 }
=20
-static int lm75_read_config(struct lm75_data *data)
-{
-	int ret;
-	unsigned int status;
-
-	if (data->params->config_reg_16bits) {
-		ret =3D regmap_read(data->regmap, LM75_REG_CONF, &status);
-		return ret ? ret : status;
-	}
-
-	return i2c_smbus_read_byte_data(data->client, LM75_REG_CONF);
-}
-
 static irqreturn_t lm75_alarm_handler(int irq, void *private)
 {
 	struct device *hwmon_dev =3D private;
@@ -410,7 +386,8 @@ static int lm75_read(struct device *dev, enum hwmon_s=
ensor_types type,
 		if (attr =3D=3D hwmon_temp_alarm) {
 			switch (data->kind) {
 			case as6200:
-				*val =3D (regval >> 5) & 0x1;
+			case tmp112:
+				*val =3D (regval >> 13) & 0x1;
 				break;
 			default:
 				return -EINVAL;
@@ -461,7 +438,6 @@ static int lm75_write_temp(struct device *dev, u32 at=
tr, long temp)
 static int lm75_update_interval(struct device *dev, long val)
 {
 	struct lm75_data *data =3D dev_get_drvdata(dev);
-	unsigned int reg;
 	u8 index;
 	s32 err;
=20
@@ -481,19 +457,14 @@ static int lm75_update_interval(struct device *dev,=
 long val)
 		break;
 	case tmp112:
 	case as6200:
-		err =3D regmap_read(data->regmap, LM75_REG_CONF, &reg);
-		if (err < 0)
-			return err;
-		reg &=3D ~0x00c0;
-		reg |=3D (3 - index) << 6;
-		err =3D regmap_write(data->regmap, LM75_REG_CONF, reg);
+		err =3D regmap_update_bits(data->regmap, LM75_REG_CONF,
+					 0xc000, (3 - index) << 14);
 		if (err < 0)
 			return err;
 		data->sample_time =3D data->params->sample_times[index];
 		break;
 	case pct2075:
-		err =3D i2c_smbus_write_byte_data(data->client, PCT2075_REG_IDLE,
-						index + 1);
+		err =3D regmap_write(data->regmap, PCT2075_REG_IDLE, index + 1);
 		if (err)
 			return err;
 		data->sample_time =3D data->params->sample_times[index];
@@ -590,6 +561,39 @@ static bool lm75_is_volatile_reg(struct device *dev,=
 unsigned int reg)
 	return reg =3D=3D LM75_REG_TEMP || reg =3D=3D LM75_REG_CONF;
 }
=20
+static int lm75_i2c_reg_read(void *context, unsigned int reg, unsigned i=
nt *val)
+{
+	struct lm75_data *data =3D context;
+	struct i2c_client *client =3D data->client;
+	int ret;
+
+	if (reg =3D=3D LM75_REG_CONF) {
+		if (!data->params->config_reg_16bits)
+			ret =3D i2c_smbus_read_byte_data(client, LM75_REG_CONF);
+		else
+			ret =3D i2c_smbus_read_word_data(client, LM75_REG_CONF);
+	} else {
+		ret =3D i2c_smbus_read_word_swapped(client, reg);
+	}
+	if (ret < 0)
+		return ret;
+	*val =3D ret;
+	return 0;
+}
+
+static int lm75_i2c_reg_write(void *context, unsigned int reg, unsigned =
int val)
+{
+	struct lm75_data *data =3D context;
+	struct i2c_client *client =3D data->client;
+
+	if (reg =3D=3D PCT2075_REG_IDLE ||
+	    (reg =3D=3D LM75_REG_CONF && !data->params->config_reg_16bits))
+		return i2c_smbus_write_byte_data(client, reg, val);
+	else if (reg =3D=3D LM75_REG_CONF)
+		return i2c_smbus_write_word_data(client, reg, val);
+	return i2c_smbus_write_word_swapped(client, reg, val);
+}
+
 static const struct regmap_config lm75_regmap_config =3D {
 	.reg_bits =3D 8,
 	.val_bits =3D 16,
@@ -602,6 +606,11 @@ static const struct regmap_config lm75_regmap_config=
 =3D {
 	.use_single_write =3D true,
 };
=20
+static const struct regmap_bus lm75_i2c_regmap_bus =3D {
+	.reg_read =3D lm75_i2c_reg_read,
+	.reg_write =3D lm75_i2c_reg_write,
+};
+
 static void lm75_disable_regulator(void *data)
 {
 	struct lm75_data *lm75 =3D data;
@@ -612,9 +621,8 @@ static void lm75_disable_regulator(void *data)
 static void lm75_remove(void *data)
 {
 	struct lm75_data *lm75 =3D data;
-	struct i2c_client *client =3D lm75->client;
=20
-	i2c_smbus_write_byte_data(client, LM75_REG_CONF, lm75->orig_conf);
+	regmap_write(lm75->regmap, LM75_REG_CONF, lm75->orig_conf);
 }
=20
 static int lm75_probe(struct i2c_client *client)
@@ -632,6 +640,9 @@ static int lm75_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
=20
+	/* needed by custom regmap callbacks */
+	dev_set_drvdata(dev, data);
+
 	data->client =3D client;
 	data->kind =3D (uintptr_t)i2c_get_match_data(client);
=20
@@ -639,7 +650,8 @@ static int lm75_probe(struct i2c_client *client)
 	if (IS_ERR(data->vs))
 		return PTR_ERR(data->vs);
=20
-	data->regmap =3D devm_regmap_init_i2c(client, &lm75_regmap_config);
+	data->regmap =3D devm_regmap_init(dev, &lm75_i2c_regmap_bus, data,
+					&lm75_regmap_config);
 	if (IS_ERR(data->regmap))
 		return PTR_ERR(data->regmap);
=20
@@ -665,13 +677,10 @@ static int lm75_probe(struct i2c_client *client)
 		return err;
=20
 	/* Cache original configuration */
-	status =3D lm75_read_config(data);
-	if (status < 0) {
-		dev_dbg(dev, "Can't read config? %d\n", status);
-		return status;
-	}
+	err =3D regmap_read(data->regmap, LM75_REG_CONF, &status);
+	if (err)
+		return err;
 	data->orig_conf =3D status;
-	data->current_conf =3D status;
=20
 	err =3D lm75_write_config(data, data->params->set_mask,
 				data->params->clr_mask);
@@ -959,32 +968,16 @@ static int lm75_detect(struct i2c_client *new_clien=
t,
 #ifdef CONFIG_PM
 static int lm75_suspend(struct device *dev)
 {
-	int status;
-	struct i2c_client *client =3D to_i2c_client(dev);
+	struct lm75_data *data =3D dev_get_drvdata(dev);
=20
-	status =3D i2c_smbus_read_byte_data(client, LM75_REG_CONF);
-	if (status < 0) {
-		dev_dbg(&client->dev, "Can't read config? %d\n", status);
-		return status;
-	}
-	status =3D status | LM75_SHUTDOWN;
-	i2c_smbus_write_byte_data(client, LM75_REG_CONF, status);
-	return 0;
+	return regmap_update_bits(data->regmap, LM75_REG_CONF, LM75_SHUTDOWN, L=
M75_SHUTDOWN);
 }
=20
 static int lm75_resume(struct device *dev)
 {
-	int status;
-	struct i2c_client *client =3D to_i2c_client(dev);
+	struct lm75_data *data =3D dev_get_drvdata(dev);
=20
-	status =3D i2c_smbus_read_byte_data(client, LM75_REG_CONF);
-	if (status < 0) {
-		dev_dbg(&client->dev, "Can't read config? %d\n", status);
-		return status;
-	}
-	status =3D status & ~LM75_SHUTDOWN;
-	i2c_smbus_write_byte_data(client, LM75_REG_CONF, status);
-	return 0;
+	return regmap_update_bits(data->regmap, LM75_REG_CONF, LM75_SHUTDOWN, 0=
);
 }
=20
 static const struct dev_pm_ops lm75_dev_pm_ops =3D {
--=20
2.43.0

