Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15968.1794916037787814304
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:17 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2FC3763445;
	Tue, 17 Nov 2026 11:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72261F000C4;
	Tue, 17 Nov 2026 11:47:15 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 50/69] hwmon: (lm75) fix Wvoid-pointer-to-enum-cast warning
Date: Tue, 17 Nov 2026 13:45:34 +0200
Message-ID: <20261117114553.1484215-51-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24891
Content-Type: text/plain; charset="utf-8"

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit c7e07faa48512f4beafef54b144a1e6df25c727f upstream.

'kind' is an enum, thus cast of pointer on 64-bit compile test with W=3D1
causes:

  lm75.c:581:10: error: cast to smaller integer type 'enum lm75_type' fro=
m 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230810093157.94244-6-krzysztof.kozlowsk=
i@linaro.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/hwmon/lm75.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index e447febd121a..ebf07e22ac33 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -562,7 +562,7 @@ static int lm75_probe(struct i2c_client *client)
 	enum lm75_type kind;
=20
 	if (client->dev.of_node)
-		kind =3D (enum lm75_type)of_device_get_match_data(&client->dev);
+		kind =3D (uintptr_t)of_device_get_match_data(&client->dev);
 	else
 		kind =3D i2c_match_id(lm75_ids, client)->driver_data;
=20
--=20
2.43.0

