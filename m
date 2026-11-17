Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15967.1794916035513448678
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:15 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 505404135B;
	Tue, 17 Nov 2026 11:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F611F000C4;
	Tue, 17 Nov 2026 11:47:13 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 49/69] i3c: Handle drivers without probe or remove callback
Date: Tue, 17 Nov 2026 13:45:33 +0200
Message-ID: <20261117114553.1484215-50-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24890

From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

commit 7456fea589c6ad3422b0c188871ae80e1d307737 upstream.

A registered driver without a probe callback doesn't make sense, so
refuse to register such a driver. (Otherwise i3c_device_probe() yields a
NULL pointer exception.)

A driver without remove is possible, e.g. when all resources are freed
using devm callbacks. So guard the call to driver->remove by a check
for being non-NULL.

Note that the only in-tree i3c driver
(drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c) doesn't have a remove
callback.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20210128091048.17006-1-u.kleine-koenig@pe=
ngutronix.de
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/device.c |  5 +++++
 drivers/i3c/master.c | 10 ++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index bb8e60dff988..e92d3e9a52bd 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -262,6 +262,11 @@ int i3c_driver_register_with_owner(struct i3c_driver=
 *drv, struct module *owner)
 	drv->driver.owner =3D owner;
 	drv->driver.bus =3D &i3c_bus_type;
=20
+	if (!drv->probe) {
+		pr_err("Trying to register an i3c driver without probe callback\n");
+		return -EINVAL;
+	}
+
 	return driver_register(&drv->driver);
 }
 EXPORT_SYMBOL_GPL(i3c_driver_register_with_owner);
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 1ce7794bf29e..2eb2c327dfbf 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -327,11 +327,13 @@ static int i3c_device_remove(struct device *dev)
 {
 	struct i3c_device *i3cdev =3D dev_to_i3cdev(dev);
 	struct i3c_driver *driver =3D drv_to_i3cdrv(dev->driver);
-	int ret;
+	int ret =3D 0;
=20
-	ret =3D driver->remove(i3cdev);
-	if (ret)
-		return ret;
+	if (driver->remove) {
+		ret =3D driver->remove(i3cdev);
+		if (ret)
+			return ret;
+	}
=20
 	i3c_device_free_ibi(i3cdev);
=20
--=20
2.43.0

