Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15981.1794916058622950224
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:38 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 69F9140698;
	Tue, 17 Nov 2026 11:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC251F000C4;
	Tue, 17 Nov 2026 11:47:37 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 64/69] hwmon: (tmp108) Add NXP p3t1085 support
Date: Tue, 17 Nov 2026 13:45:48 +0200
Message-ID: <20261117114553.1484215-65-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24905
Content-Type: text/plain; charset="utf-8"

From: Frank Li <Frank.Li@nxp.com>

commit 11d35624d7696a64724160199fc94587010d7cb2 upstream.

Add compatible string 'nxp,p3t1085' since p3t1085's register layout is th=
e
same as tmp108.

The p3t1085 supports I3C interface.

Update document tmp108.rst and Kconfig's help context.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Message-ID: <20241111-p3t1085-v3-2-bff511550aad@nxp.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/hwmon/tmp108.rst | 8 ++++++++
 drivers/hwmon/Kconfig          | 2 +-
 drivers/hwmon/tmp108.c         | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/tmp108.rst b/Documentation/hwmon/tmp108.=
rst
index 6df7cf1b42f4..bc4941d98268 100644
--- a/Documentation/hwmon/tmp108.rst
+++ b/Documentation/hwmon/tmp108.rst
@@ -3,6 +3,14 @@ Kernel driver tmp108
=20
 Supported chips:
=20
+  * NXP P3T1085
+
+    Prefix: 'p3t1085'
+
+    Addresses scanned: none
+
+    Datasheet: https://www.nxp.com/docs/en/data-sheet/P3T1085UK.pdf
+
   * Texas Instruments TMP108
=20
     Prefix: 'tmp108'
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index c82bb7664cad..6f8022008f85 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1842,7 +1842,7 @@ config SENSORS_TMP108
 	select REGMAP_I2C
 	help
 	  If you say yes here you get support for Texas Instruments TMP108
-	  sensor chips.
+	  sensor chips and NXP P3T1085.
=20
 	  This driver can also be built as a module. If so, the module
 	  will be called tmp108.
diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index 1d10ab8e1695..9490dfa09989 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -420,6 +420,7 @@ MODULE_DEVICE_TABLE(i2c, tmp108_i2c_ids);
=20
 #ifdef CONFIG_OF
 static const struct of_device_id tmp108_of_ids[] =3D {
+	{ .compatible =3D "nxp,p3t1085", },
 	{ .compatible =3D "ti,tmp108", },
 	{}
 };
--=20
2.43.0

