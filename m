Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15836.1794916045395748195
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:25 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CE6846344B;
	Tue, 17 Nov 2026 11:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E931F000C4;
	Tue, 17 Nov 2026 11:47:23 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 55/69] hwmon: (lm75) Add NXP P3T1755 support
Date: Tue, 17 Nov 2026 13:45:39 +0200
Message-ID: <20261117114553.1484215-56-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24896
Content-Type: text/plain; charset="utf-8"

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit d3506653d01c0df1f1c86cd49fe70c98f00f1aef upstream.

Add this LM75 compatible sensor which needs a separate entry because of
its default sampling time and SMBusAlert handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20241218074131.4351-7-wsa+renesas@sang-en=
gineering.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[claudiu.beznea: fixed conflict in documentation]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/hwmon/lm75.rst |  8 ++++++--
 drivers/hwmon/lm75.c         | 13 +++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/lm75.rst b/Documentation/hwmon/lm75.rst
index f4ba3e626dc4..7483f399aa58 100644
--- a/Documentation/hwmon/lm75.rst
+++ b/Documentation/hwmon/lm75.rst
@@ -119,9 +119,11 @@ Supported chips:
=20
 	       https://www.ti.com/product/tmp275
=20
-  * NXP LM75B, PCT2075
+         https://www.ti.com/product/TMP1075
=20
-    Prefix: 'lm75b', 'pct2075'
+  * NXP LM75B, P3T1755, PCT2075
+
+    Prefix: 'lm75b', 'p3t1755', 'pct2075'
=20
     Addresses scanned: none
=20
@@ -129,6 +131,8 @@ Supported chips:
=20
 	       https://www.nxp.com/documents/data_sheet/LM75B.pdf
=20
+               https://www.nxp.com/docs/en/data-sheet/P3T1755.pdf
+
                https://www.nxp.com/docs/en/data-sheet/PCT2075.pdf
=20
   * AMS OSRAM AS6200
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index c24d2d3ab761..4cc2edf34881 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -38,6 +38,7 @@ enum lm75_type {		/* keep sorted in alphabetical order =
*/
 	max6626,
 	max31725,
 	mcp980x,
+	p3t1755,
 	pct2075,
 	stds75,
 	stlm75,
@@ -213,6 +214,13 @@ static const struct lm75_params device_params[] =3D =
{
 		.default_resolution =3D 9,
 		.default_sample_time =3D MSEC_PER_SEC / 18,
 	},
+	[p3t1755] =3D {
+		.clr_mask =3D 1 << 1 | 1 << 7,	/* disable SMBAlert and one-shot */
+		.default_resolution =3D 12,
+		.default_sample_time =3D 55,
+		.num_sample_times =3D 4,
+		.sample_times =3D (unsigned int []){ 28, 55, 110, 220 },
+	},
 	[pct2075] =3D {
 		.default_resolution =3D 11,
 		.default_sample_time =3D MSEC_PER_SEC / 10,
@@ -717,6 +725,7 @@ static const struct i2c_device_id lm75_ids[] =3D {
 	{ "max31725", max31725, },
 	{ "max31726", max31725, },
 	{ "mcp980x", mcp980x, },
+	{ "p3t1755", p3t1755, },
 	{ "pct2075", pct2075, },
 	{ "stds75", stds75, },
 	{ "stlm75", stlm75, },
@@ -791,6 +800,10 @@ static const struct of_device_id __maybe_unused lm75=
_of_match[] =3D {
 		.compatible =3D "maxim,mcp980x",
 		.data =3D (void *)mcp980x
 	},
+	{
+		.compatible =3D "nxp,p3t1755",
+		.data =3D (void *)p3t1755
+	},
 	{
 		.compatible =3D "nxp,pct2075",
 		.data =3D (void *)pct2075
--=20
2.43.0

