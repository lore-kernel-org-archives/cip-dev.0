Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15828.1794916034526366477
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:14 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EE42363429;
	Tue, 17 Nov 2026 11:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9747F1F000C4;
	Tue, 17 Nov 2026 11:47:12 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 48/69] i3c: Correct the macro module_i3c_i2c_driver
Date: Tue, 17 Nov 2026 13:45:32 +0200
Message-ID: <20261117114553.1484215-49-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24889
Content-Type: text/plain; charset="utf-8"

From: Naveen Krishna Chatradhi <nchatrad@amd.com>

commit 01744ce9f07f0b76b0b2d30adba2a7c104f1ff2a upstream.

Present definition for module_i3c_i2c_driver uses only the
1st argument i.e., struct i3c_driver.
Irrespective of CONFIG_I3C being enabled/disabled,
struct i2c_driver is never passed to module_driver()

Passing struct i2c_driver as the 4th argument works.

Signed-off-by: Akshay Gupta <Akshay.Gupta@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
Link: https://lore.kernel.org/r/20221205105413.937704-1-naveenkrishna.cha=
tradhi@amd.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 include/linux/i3c/device.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index de102e4418ab..ad18deff6574 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -287,7 +287,8 @@ static inline void i3c_i2c_driver_unregister(struct i=
3c_driver *i3cdrv,
 #define module_i3c_i2c_driver(__i3cdrv, __i2cdrv)	\
 	module_driver(__i3cdrv,				\
 		      i3c_i2c_driver_register,		\
-		      i3c_i2c_driver_unregister)
+		      i3c_i2c_driver_unregister,	\
+		      __i2cdrv)
=20
 int i3c_device_do_priv_xfers(struct i3c_device *dev,
 			     struct i3c_priv_xfer *xfers,
--=20
2.43.0

