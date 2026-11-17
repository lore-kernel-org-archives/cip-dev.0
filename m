Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15806.1794916008802326706
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:46:48 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 99A4943C6F;
	Tue, 17 Nov 2026 11:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6BF1F000C4;
	Tue, 17 Nov 2026 11:46:47 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 32/69] i3c: renesas: Drop unused structure member 'resuming'
Date: Tue, 17 Nov 2026 13:45:16 +0200
Message-ID: <20261117114553.1484215-33-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:46:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24873
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 2cdb9c2138bef5f767dd786431fd6ca7581177aa upstream.

The struct renesas_i3c::resuming is a leftover from a rebase. It is not
used anywhere within the driver. Drop it.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260721191618.1850795-1-claudiu.beznea+re=
nesas@tuxon.dev
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesa=
s-i3c.c
index 31b51766dba1..66522b212476 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -263,7 +263,6 @@ struct renesas_i3c {
 	u8 addrs[RENESAS_I3C_MAX_DEVS];
 	unsigned long rate;
 	enum i3c_internal_state internal_state;
-	bool resuming;
 	u32 free_pos;
 	u32 dyn_addr;
 	u32 i2c_STDBR;
--=20
2.43.0

