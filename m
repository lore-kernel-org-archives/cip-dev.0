Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15832.1794916040812341624
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:20 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3FFFC63429;
	Tue, 17 Nov 2026 11:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF4D1F000C4;
	Tue, 17 Nov 2026 11:47:18 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 52/69] hwmon: (lm75) Add AMS AS6200 temperature sensor
Date: Tue, 17 Nov 2026 13:45:36 +0200
Message-ID: <20261117114553.1484215-53-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24893

From: Abdel Alkuor <alkuor@gmail.com>

commit 4b6358e1fe4668e88cd654b345a2a62da9d373f7 upstream.

as6200 is a temperature sensor with 0.0625=C2=B0C resolution and a
range between -40=C2=B0C to 125=C2=B0C.

By default, the driver configures as6200 as following:
- Converstion rate: 8 Hz
- Conversion mode: continuous
- Consecutive fault counts: 4 samples
- Alert state: high polarity
- Alert mode: comparator mode

Interrupt is supported for the alert pin.

Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
Link: https://lore.kernel.org/r/d1686678991bf8ee0d00cb08ca046798f37ca4b3.=
1703127334.git.alkuor@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[claudiu.beznea: fixed conflict]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/hwmon/lm75.rst |  10 ++++
 drivers/hwmon/lm75.c         | 108 ++++++++++++++++++++++++++++++-----
 2 files changed, 104 insertions(+), 14 deletions(-)

diff --git a/Documentation/hwmon/lm75.rst b/Documentation/hwmon/lm75.rst
index 81257d5fc48f..f4ba3e626dc4 100644
--- a/Documentation/hwmon/lm75.rst
+++ b/Documentation/hwmon/lm75.rst
@@ -131,6 +131,16 @@ Supported chips:
=20
                https://www.nxp.com/docs/en/data-sheet/PCT2075.pdf
=20
+  * AMS OSRAM AS6200
+
+    Prefix: 'as6200'
+
+    Addresses scanned: none
+
+    Datasheet: Publicly available at the AMS website
+
+               https://ams.com/documents/20143/36005/AS6200_DS000449_4-0=
0.pdf
+
 Author: Frodo Looijaard <frodol@dds.nl>
=20
 Description
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 4ced145055da..4571634a558d 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -7,6 +7,7 @@
=20
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
@@ -25,6 +26,7 @@
=20
 enum lm75_type {		/* keep sorted in alphabetical order */
 	adt75,
+	as6200,
 	ds1775,
 	ds75,
 	ds7505,
@@ -53,6 +55,7 @@ enum lm75_type {		/* keep sorted in alphabetical order =
*/
=20
 /**
  * struct lm75_params - lm75 configuration parameters.
+ * @config_reg_16bits:	Configure register size is 2 bytes.
  * @set_mask:		Bits to set in configuration register when configuring
  *			the chip.
  * @clr_mask:		Bits to clear in configuration register when configuring
@@ -73,17 +76,20 @@ enum lm75_type {		/* keep sorted in alphabetical orde=
r */
  * @sample_times:	All the possible sample times to be set. Mandatory if
  *			num_sample_times is larger than 1. If set, number of
  *			entries must match num_sample_times.
+ * @alarm:		Alarm bit is supported.
  */
=20
 struct lm75_params {
-	u8			set_mask;
-	u8			clr_mask;
+	bool			config_reg_16bits;
+	u16			set_mask;
+	u16			clr_mask;
 	u8			default_resolution;
 	u8			resolution_limits;
 	const u8		*resolutions;
 	unsigned int		default_sample_time;
 	u8			num_sample_times;
 	const unsigned int	*sample_times;
+	bool			alarm;
 };
=20
 /* Addresses scanned */
@@ -102,8 +108,8 @@ struct lm75_data {
 	struct i2c_client		*client;
 	struct regmap			*regmap;
 	struct regulator		*vs;
-	u8				orig_conf;
-	u8				current_conf;
+	u16				orig_conf;
+	u16				current_conf;
 	u8				resolution;	/* In bits, 9 to 16 */
 	unsigned int			sample_time;	/* In ms */
 	enum lm75_type			kind;
@@ -126,6 +132,15 @@ static const struct lm75_params device_params[] =3D =
{
 		.default_resolution =3D 12,
 		.default_sample_time =3D MSEC_PER_SEC / 10,
 	},
+	[as6200] =3D {
+		.config_reg_16bits =3D true,
+		.set_mask =3D 0x94C0,	/* 8 sample/s, 4 CF, positive polarity */
+		.default_resolution =3D 12,
+		.default_sample_time =3D 125,
+		.num_sample_times =3D 4,
+		.sample_times =3D (unsigned int []){ 125, 250, 1000, 4000 },
+		.alarm =3D true,
+	},
 	[ds1775] =3D {
 		.clr_mask =3D 3 << 5,
 		.set_mask =3D 2 << 5,	/* 11-bit mode */
@@ -300,20 +315,23 @@ static inline long lm75_reg_to_mc(s16 temp, u8 reso=
lution)
 	return ((temp >> (16 - resolution)) * 1000) >> (resolution - 8);
 }
=20
-static int lm75_write_config(struct lm75_data *data, u8 set_mask,
-			     u8 clr_mask)
+static int lm75_write_config(struct lm75_data *data, u16 set_mask,
+			     u16 clr_mask)
 {
-	u8 value;
+	unsigned int value;
=20
-	clr_mask |=3D LM75_SHUTDOWN;
+	clr_mask |=3D LM75_SHUTDOWN << (8 * data->params->config_reg_16bits);
 	value =3D data->current_conf & ~clr_mask;
 	value |=3D set_mask;
=20
 	if (data->current_conf !=3D value) {
 		s32 err;
-
-		err =3D i2c_smbus_write_byte_data(data->client, LM75_REG_CONF,
-						value);
+		if (data->params->config_reg_16bits)
+			err =3D regmap_write(data->regmap, LM75_REG_CONF, value);
+		else
+			err =3D i2c_smbus_write_byte_data(data->client,
+							LM75_REG_CONF,
+							value);
 		if (err)
 			return err;
 		data->current_conf =3D value;
@@ -321,6 +339,27 @@ static int lm75_write_config(struct lm75_data *data,=
 u8 set_mask,
 	return 0;
 }
=20
+static int lm75_read_config(struct lm75_data *data)
+{
+	int ret;
+	unsigned int status;
+
+	if (data->params->config_reg_16bits) {
+		ret =3D regmap_read(data->regmap, LM75_REG_CONF, &status);
+		return ret ? ret : status;
+	}
+
+	return i2c_smbus_read_byte_data(data->client, LM75_REG_CONF);
+}
+
+static irqreturn_t lm75_alarm_handler(int irq, void *private)
+{
+	struct device *hwmon_dev =3D private;
+
+	hwmon_notify_event(hwmon_dev, hwmon_temp, hwmon_temp_alarm, 0);
+	return IRQ_HANDLED;
+}
+
 static int lm75_read(struct device *dev, enum hwmon_sensor_types type,
 		     u32 attr, int channel, long *val)
 {
@@ -349,6 +388,9 @@ static int lm75_read(struct device *dev, enum hwmon_s=
ensor_types type,
 		case hwmon_temp_max_hyst:
 			reg =3D LM75_REG_HYST;
 			break;
+		case hwmon_temp_alarm:
+			reg =3D LM75_REG_CONF;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -356,7 +398,17 @@ static int lm75_read(struct device *dev, enum hwmon_=
sensor_types type,
 		if (err < 0)
 			return err;
=20
-		*val =3D lm75_reg_to_mc(regval, data->resolution);
+		if (attr =3D=3D hwmon_temp_alarm) {
+			switch (data->kind) {
+			case as6200:
+				*val =3D (regval >> 5) & 0x1;
+				break;
+			default:
+				return -EINVAL;
+			}
+		} else {
+			*val =3D lm75_reg_to_mc(regval, data->resolution);
+		}
 		break;
 	default:
 		return -EINVAL;
@@ -419,6 +471,7 @@ static int lm75_update_interval(struct device *dev, l=
ong val)
 			data->resolution =3D data->params->resolutions[index];
 		break;
 	case tmp112:
+	case as6200:
 		err =3D regmap_read(data->regmap, LM75_REG_CONF, &reg);
 		if (err < 0)
 			return err;
@@ -486,6 +539,10 @@ static umode_t lm75_is_visible(const void *data, enu=
m hwmon_sensor_types type,
 		case hwmon_temp_max:
 		case hwmon_temp_max_hyst:
 			return 0644;
+		case hwmon_temp_alarm:
+			if (config_data->params->alarm)
+				return 0444;
+			break;
 		}
 		break;
 	default:
@@ -498,7 +555,8 @@ static const struct hwmon_channel_info *lm75_info[] =3D=
 {
 	HWMON_CHANNEL_INFO(chip,
 			   HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL),
 	HWMON_CHANNEL_INFO(temp,
-			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST),
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_ALARM),
 	NULL
 };
=20
@@ -606,7 +664,7 @@ static int lm75_probe(struct i2c_client *client)
 		return err;
=20
 	/* Cache original configuration */
-	status =3D i2c_smbus_read_byte_data(client, LM75_REG_CONF);
+	status =3D lm75_read_config(data);
 	if (status < 0) {
 		dev_dbg(dev, "Can't read config? %d\n", status);
 		return status;
@@ -629,6 +687,23 @@ static int lm75_probe(struct i2c_client *client)
 	if (IS_ERR(hwmon_dev))
 		return PTR_ERR(hwmon_dev);
=20
+	if (client->irq) {
+		if (data->params->alarm) {
+			err =3D devm_request_threaded_irq(dev,
+							client->irq,
+							NULL,
+							&lm75_alarm_handler,
+							IRQF_ONESHOT,
+							client->name,
+							hwmon_dev);
+			if (err)
+				return err;
+		} else {
+			 /* alarm is only supported for chips with alarm bit */
+			dev_err(dev, "alarm interrupt is not supported\n");
+		}
+	}
+
 	dev_info(dev, "%s: sensor '%s'\n", dev_name(hwmon_dev), client->name);
=20
 	return 0;
@@ -636,6 +711,7 @@ static int lm75_probe(struct i2c_client *client)
=20
 static const struct i2c_device_id lm75_ids[] =3D {
 	{ "adt75", adt75, },
+	{ "as6200", as6200, },
 	{ "ds1775", ds1775, },
 	{ "ds75", ds75, },
 	{ "ds7505", ds7505, },
@@ -670,6 +746,10 @@ static const struct of_device_id __maybe_unused lm75=
_of_match[] =3D {
 		.compatible =3D "adi,adt75",
 		.data =3D (void *)adt75
 	},
+	{
+		.compatible =3D "ams,as6200",
+		.data =3D (void *)as6200
+	},
 	{
 		.compatible =3D "dallas,ds1775",
 		.data =3D (void *)ds1775
--=20
2.43.0

