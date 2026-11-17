Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15772.1794915970350602828
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:46:10 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C2B9C63408;
	Tue, 17 Nov 2026 11:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D301F000C4;
	Tue, 17 Nov 2026 11:46:08 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 08/69] i3c: renesas: Simplify return statement in 'renesas_i3c_daa'
Date: Tue, 17 Nov 2026 13:44:52 +0200
Message-ID: <20261117114553.1484215-9-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:46:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24849
Content-Type: text/plain; charset="utf-8"

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit bc7dd24c114e37c67061f4651bbbbbc57106c617 upstream.

There was already a bail out for 'ret < 0', so we can always return
success at the end of the function.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/aIyzJ7HOENL1qp1l@stanley.mountain
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250803211256.18513-2-wsa+renesas@sang-e=
ngineering.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesa=
s-i3c.c
index 6b2e3bb1585a..ea9468b008d3 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -688,7 +688,7 @@ static int renesas_i3c_daa(struct i3c_master_controll=
er *m)
 			i3c_master_add_i3c_dev_locked(m, i3c->addrs[pos]);
 	}
=20
-	return ret < 0 ? ret : 0;
+	return 0;
 }
=20
 static bool renesas_i3c_supports_ccc_cmd(struct i3c_master_controller *m=
,
--=20
2.43.0

