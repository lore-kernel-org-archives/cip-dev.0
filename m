Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15847.1794916063823813391
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:43 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4266F63429;
	Tue, 17 Nov 2026 11:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59621F000C4;
	Tue, 17 Nov 2026 11:47:41 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 67/69] hwmon: (tmp108) Do not fail in I3C probe when I3C regmap is a module
Date: Tue, 17 Nov 2026 13:45:51 +0200
Message-ID: <20261117114553.1484215-68-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24908
Content-Type: text/plain; charset="utf-8"

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

commit 8281d627905dc72241ca3969ee18f3e029e96d00 upstream.

I3C device probe fails when CONFIG_REGMAP_I3C=3Dm:

	p3t1085_i3c 0-23615290090: error -ENODEV: Failed to register i3c regmap

Fix this by using the IS_ENABLED(CONFIG_REGMAP_I3C) macro in the code.

Fixes: c40655e33106 ("hwmon: (tmp108) Add support for I3C device")
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <20241121121819.393104-1-jarkko.nikula@linux.intel.com>
[groeck: Remove #ifdef entirely; it is not needed due to dead code elimin=
ation]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/hwmon/tmp108.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index b1f46f04a949..75f22b2aa163 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -452,12 +452,7 @@ static int p3t1085_i3c_probe(struct i3c_device *i3cd=
ev)
 	struct device *dev =3D i3cdev_to_dev(i3cdev);
 	struct regmap *regmap;
=20
-#ifdef CONFIG_REGMAP_I3C
 	regmap =3D devm_regmap_init_i3c(i3cdev, &tmp108_regmap_config);
-#else
-	regmap =3D ERR_PTR(-ENODEV);
-#endif
-
 	if (IS_ERR(regmap))
 		return dev_err_probe(dev, PTR_ERR(regmap),
 				     "Failed to register i3c regmap\n");
--=20
2.43.0

