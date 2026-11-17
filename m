Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15831.1794916038723272818
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:18 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 851B74585D;
	Tue, 17 Nov 2026 11:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4651F000C4;
	Tue, 17 Nov 2026 11:47:17 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 51/69] hwmon: (lm75) remove now-unused include
Date: Tue, 17 Nov 2026 13:45:35 +0200
Message-ID: <20261117114553.1484215-52-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24892
Content-Type: text/plain; charset="utf-8"

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

commit cfe09564467b8217b992aa329430897d0983e7db upstream.

Including hwmon-sysfs.h is not needed since sysfs code got removed from
this file in commit 08b024338166 ("hwmon: (lm75) Convert to use new hwmon
registration API").

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Link: https://lore.kernel.org/r/20231228-hwmon-cleanup-include-v1-1-e36f6=
5aee1f0@bootlin.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/hwmon/lm75.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index ebf07e22ac33..4ced145055da 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -11,7 +11,6 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
-#include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/of_device.h>
 #include <linux/of.h>
--=20
2.43.0

