Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15845.1794916060150432327
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:40 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EB02543B26;
	Tue, 17 Nov 2026 11:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CD01F000C4;
	Tue, 17 Nov 2026 11:47:38 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 65/69] hwmon: (tmp108) Add helper function tmp108_common_probe() to prepare I3C support
Date: Tue, 17 Nov 2026 13:45:49 +0200
Message-ID: <20261117114553.1484215-66-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24906
Content-Type: text/plain; charset="utf-8"

From: Frank Li <Frank.Li@nxp.com>

commit 700f3250198d51093884254220a96777a922dd47 upstream.

Add help function tmp108_common_probe() to pave road to support i3c for
P3T1085(NXP) chip.

Use dev_err_probe() to simplify the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Message-ID: <20241112-p3t1085-v4-1-a1334314b1e6@nxp.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/hwmon/tmp108.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index 9490dfa09989..9e87851ebf64 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -323,33 +323,19 @@ static const struct regmap_config tmp108_regmap_con=
fig =3D {
 	.use_single_write =3D true,
 };
=20
-static int tmp108_probe(struct i2c_client *client)
+static int tmp108_common_probe(struct device *dev, struct regmap *regmap=
, char *name)
 {
-	struct device *dev =3D &client->dev;
 	struct device *hwmon_dev;
 	struct tmp108 *tmp108;
-	int err;
 	u32 config;
-
-	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_WORD_DATA)) {
-		dev_err(dev,
-			"adapter doesn't support SMBus word transactions\n");
-		return -ENODEV;
-	}
+	int err;
=20
 	tmp108 =3D devm_kzalloc(dev, sizeof(*tmp108), GFP_KERNEL);
 	if (!tmp108)
 		return -ENOMEM;
=20
 	dev_set_drvdata(dev, tmp108);
-
-	tmp108->regmap =3D devm_regmap_init_i2c(client, &tmp108_regmap_config);
-	if (IS_ERR(tmp108->regmap)) {
-		err =3D PTR_ERR(tmp108->regmap);
-		dev_err(dev, "regmap init failed: %d", err);
-		return err;
-	}
+	tmp108->regmap =3D regmap;
=20
 	err =3D regmap_read(tmp108->regmap, TMP108_REG_CONF, &config);
 	if (err < 0) {
@@ -383,13 +369,30 @@ static int tmp108_probe(struct i2c_client *client)
 		return err;
 	}
=20
-	hwmon_dev =3D devm_hwmon_device_register_with_info(dev, client->name,
+	hwmon_dev =3D devm_hwmon_device_register_with_info(dev, name,
 							 tmp108,
 							 &tmp108_chip_info,
 							 NULL);
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
=20
+static int tmp108_probe(struct i2c_client *client)
+{
+	struct device *dev =3D &client->dev;
+	struct regmap *regmap;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_WORD_DATA))
+		return dev_err_probe(dev, -ENODEV,
+				     "adapter doesn't support SMBus word transactions\n");
+
+	regmap =3D devm_regmap_init_i2c(client, &tmp108_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed");
+
+	return tmp108_common_probe(dev, regmap, client->name);
+}
+
 static int tmp108_suspend(struct device *dev)
 {
 	struct tmp108 *tmp108 =3D dev_get_drvdata(dev);
--=20
2.43.0

