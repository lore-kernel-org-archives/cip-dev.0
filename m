Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15980.1794916057639889952
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:37 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 153776344B;
	Tue, 17 Nov 2026 11:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CA01F000C4;
	Tue, 17 Nov 2026 11:47:35 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 63/69] hwmon: (tmp108) Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date: Tue, 17 Nov 2026 13:45:47 +0200
Message-ID: <20261117114553.1484215-64-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24904
Content-Type: text/plain; charset="utf-8"

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

commit 1efe2b254fe149d1b4ded4c3630f6a048add0269 upstream.

These newer PM macros allow the compiler to see what code it can remove
if !CONFIG_PM_SLEEP. This allows the removal of __maybe_unused markings
whilst achieving the same result.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://lore.kernel.org/r/20220925172759.3573439-17-jic23@kernel.or=
g
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[claudiu.beznea: dropped static keyword in front of
 DEFINE_SIMPLE_DEV_PM_OPS() to avoid compilation error]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/hwmon/tmp108.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index 5435664c3f6e..1d10ab8e1695 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -390,7 +390,7 @@ static int tmp108_probe(struct i2c_client *client)
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
=20
-static int __maybe_unused tmp108_suspend(struct device *dev)
+static int tmp108_suspend(struct device *dev)
 {
 	struct tmp108 *tmp108 =3D dev_get_drvdata(dev);
=20
@@ -398,7 +398,7 @@ static int __maybe_unused tmp108_suspend(struct devic=
e *dev)
 				  TMP108_CONF_MODE_MASK, TMP108_MODE_SHUTDOWN);
 }
=20
-static int __maybe_unused tmp108_resume(struct device *dev)
+static int tmp108_resume(struct device *dev)
 {
 	struct tmp108 *tmp108 =3D dev_get_drvdata(dev);
 	int err;
@@ -410,7 +410,7 @@ static int __maybe_unused tmp108_resume(struct device=
 *dev)
 	return err;
 }
=20
-static SIMPLE_DEV_PM_OPS(tmp108_dev_pm_ops, tmp108_suspend, tmp108_resum=
e);
+DEFINE_SIMPLE_DEV_PM_OPS(tmp108_dev_pm_ops, tmp108_suspend, tmp108_resum=
e);
=20
 static const struct i2c_device_id tmp108_i2c_ids[] =3D {
 	{ "tmp108", 0 },
@@ -429,7 +429,7 @@ MODULE_DEVICE_TABLE(of, tmp108_of_ids);
 static struct i2c_driver tmp108_driver =3D {
 	.driver =3D {
 		.name	=3D DRIVER_NAME,
-		.pm	=3D &tmp108_dev_pm_ops,
+		.pm	=3D pm_sleep_ptr(&tmp108_dev_pm_ops),
 		.of_match_table =3D of_match_ptr(tmp108_of_ids),
 	},
 	.probe_new	=3D tmp108_probe,
--=20
2.43.0

