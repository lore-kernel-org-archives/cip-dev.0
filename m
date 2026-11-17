Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15848.1794916065481589965
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:45 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E392463445;
	Tue, 17 Nov 2026 11:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0451F000C4;
	Tue, 17 Nov 2026 11:47:43 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 68/69] hwmon: (tmp108) Add basic regulator support
Date: Tue, 17 Nov 2026 13:45:52 +0200
Message-ID: <20261117114553.1484215-69-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24909
Content-Type: text/plain; charset="utf-8"

From: Stanislav Jakubek <stano.jakubek@gmail.com>

commit bddbb9cff4ab97ad367692201a0abe680a59d44d upstream.

TMP108/P3T1085 are powered by the V+/VCC regulator, add support for it.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/hwmon/tmp108.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index 75f22b2aa163..f01f742fc8d4 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
=20
 #define	DRIVER_NAME "tmp108"
@@ -331,6 +332,10 @@ static int tmp108_common_probe(struct device *dev, s=
truct regmap *regmap, char *
 	u32 config;
 	int err;
=20
+	err =3D devm_regulator_get_enable(dev, "vcc");
+	if (err)
+		return dev_err_probe(dev, err, "Failed to enable regulator\n");
+
 	tmp108 =3D devm_kzalloc(dev, sizeof(*tmp108), GFP_KERNEL);
 	if (!tmp108)
 		return -ENOMEM;
--=20
2.43.0

