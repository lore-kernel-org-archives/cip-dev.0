Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.924.1795020132268133663
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 08:42:12 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=4qsa=jh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AF3FC62BE3;
	Wed, 18 Nov 2026 16:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892621F000C5;
	Wed, 18 Nov 2026 16:42:10 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [RESEND PATCH 6.12.y-cip 16/35] i3c: renesas: Organize structures to avoid unnecessary padding
Date: Wed, 18 Nov 2026 18:41:27 +0200
Message-ID: <20261118164146.3040784-17-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
References: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 16:42:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24979
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 42a6f531c950c8b8009d938b3e51fed3533a1a3c upstream.

Reorder structure members to reduce padding and improve memory layout.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260713130545.568657-15-claudiu.beznea+re=
nesas@tuxon.dev
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesa=
s-i3c.c
index 1fec310ed5d1..bf576e6cc895 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -221,19 +221,19 @@ enum renesas_i3c_event {
 };
=20
 struct renesas_i3c_cmd {
+	const void *tx_buf;
+	void *rx_buf;
+	/* i2c xfer */
+	u8 *i2c_buf;
+	const struct i2c_msg *msg;
+	int i2c_bytes_left;
+	int i2c_is_last;
 	u32 cmd0;
 	u32 len;
-	const void *tx_buf;
 	u32 tx_count;
-	void *rx_buf;
 	u32 rx_count;
 	u32 err;
 	u8 rnw;
-	/* i2c xfer */
-	int i2c_bytes_left;
-	int i2c_is_last;
-	u8 *i2c_buf;
-	const struct i2c_msg *msg;
 };
=20
 struct renesas_i3c_xfer {
@@ -253,21 +253,22 @@ struct renesas_i3c_xferqueue {
 };
=20
 struct renesas_i3c {
+	void __iomem *regs;
+	struct clk_bulk_data *clks;
+	struct reset_control *presetn;
+	struct reset_control *tresetn;
+	struct renesas_i3c_xferqueue xferqueue;
 	struct i3c_master_controller base;
+	u8 addrs[RENESAS_I3C_MAX_DEVS];
+	unsigned long rate;
 	enum i3c_internal_state internal_state;
-	u16 maxdevs;
+	bool resuming;
 	u32 free_pos;
 	u32 dyn_addr;
 	u32 i2c_STDBR;
 	u32 i3c_STDBR;
 	u32 extbr;
-	unsigned long rate;
-	u8 addrs[RENESAS_I3C_MAX_DEVS];
-	struct renesas_i3c_xferqueue xferqueue;
-	void __iomem *regs;
-	struct clk_bulk_data *clks;
-	struct reset_control *presetn;
-	struct reset_control *tresetn;
+	u16 maxdevs;
 	u8 num_clks;
 	u8 refclk_div;
 };
--=20
2.43.0

