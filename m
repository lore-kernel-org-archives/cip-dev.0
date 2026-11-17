Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15835.1794916043895765950
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:24 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4E60D63445;
	Tue, 17 Nov 2026 11:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB2D1F000C5;
	Tue, 17 Nov 2026 11:47:21 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 54/69] hwmon: (lm75) Remove use of i2c_match_id()
Date: Tue, 17 Nov 2026 13:45:38 +0200
Message-ID: <20261117114553.1484215-55-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24895
Content-Type: text/plain; charset="utf-8"

From: Andrew Davis <afd@ti.com>

commit 5178911d5c13308a0c2e80e0055c04f36a515bbf upstream.

The function i2c_match_id() is used to fetch the matching ID from
the i2c_device_id table. This is often used to then retrieve the
matching driver_data. This can be done in one step with the helper
i2c_get_match_data().

This helper has a couple other benefits:
 * It doesn't need the i2c_device_id passed in so we do not need
   to have that forward declared, allowing us to remove those or
   move the i2c_device_id table down to its more natural spot
   with the other module info.
 * It also checks for device match data, which allows for OF and
   ACPI based probing. That means we do not have to manually check
   those first and can remove those checks.

Signed-off-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20240403203633.914389-14-afd@ti.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/hwmon/lm75.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index ce0464234fef..c24d2d3ab761 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -609,20 +609,12 @@ static void lm75_remove(void *data)
 	i2c_smbus_write_byte_data(client, LM75_REG_CONF, lm75->orig_conf);
 }
=20
-static const struct i2c_device_id lm75_ids[];
-
 static int lm75_probe(struct i2c_client *client)
 {
 	struct device *dev =3D &client->dev;
 	struct device *hwmon_dev;
 	struct lm75_data *data;
 	int status, err;
-	enum lm75_type kind;
-
-	if (client->dev.of_node)
-		kind =3D (uintptr_t)of_device_get_match_data(&client->dev);
-	else
-		kind =3D i2c_match_id(lm75_ids, client)->driver_data;
=20
 	if (!i2c_check_functionality(client->adapter,
 			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
@@ -633,7 +625,7 @@ static int lm75_probe(struct i2c_client *client)
 		return -ENOMEM;
=20
 	data->client =3D client;
-	data->kind =3D kind;
+	data->kind =3D (uintptr_t)i2c_get_match_data(client);
=20
 	data->vs =3D devm_regulator_get(dev, "vs");
 	if (IS_ERR(data->vs))
--=20
2.43.0

