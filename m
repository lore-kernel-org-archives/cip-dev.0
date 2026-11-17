Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15844.1794916056103580820
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:36 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 86D7363445;
	Tue, 17 Nov 2026 11:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315091F000C5;
	Tue, 17 Nov 2026 11:47:34 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 62/69] hwmon: (lm75) Fix I3C transfer buffer pointer for incoming data
Date: Tue, 17 Nov 2026 13:45:46 +0200
Message-ID: <20261117114553.1484215-63-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24903
Content-Type: text/plain; charset="utf-8"

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

commit 0ddce5549012a3f3b9ddcf59822aa0d1be61e8e8 upstream.

Use the I3C private transfer input buffer pointer for incoming data
instead of output buffer. For now this is harmless since both of those
pointers are union members but may confuse when reading the code.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20250513111739.508886-1-jarkko.nikula@lin=
ux.intel.com
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/hwmon/lm75.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 1266d61a63e5..3e5dce39daf4 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -606,7 +606,7 @@ static int lm75_i3c_reg_read(void *context, unsigned =
int reg, unsigned int *val)
 		{
 			.rnw =3D true,
 			.len =3D 2,
-			.data.out =3D data->val_buf,
+			.data.in =3D data->val_buf,
 		},
 	};
 	int ret;
--=20
2.43.0

