Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15784.1794915978522505526
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:46:18 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id ECDC463408;
	Tue, 17 Nov 2026 11:46:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A35A1F000C4;
	Tue, 17 Nov 2026 11:46:16 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 13/69] i3c: renesas: Factor out hardware initialization to separate function
Date: Tue, 17 Nov 2026 13:44:57 +0200
Message-ID: <20261117114553.1484215-14-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:46:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24854
Content-Type: text/plain; charset="utf-8"

From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

commit 5eb3e8763e076a47ab145c5fafcf39f1ac7c7aee upstream.

Move the hardware initialization sequence in renesas_i3c_bus_init()
into a dedicated renesas_i3c_hw_init() helper.

Simplify the code and prepare the driver for upcoming suspend/resume
support.

No functional change intended.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/795327270a6ceb23e15513a2619a19ae4876cfba.1=
767781092.git.tommaso.merciai.xr@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 99 ++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 44 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesa=
s-i3c.c
index b1473b53f77c..737f60dd0001 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -486,13 +486,65 @@ static int renesas_i3c_reset(struct renesas_i3c *i3=
c)
 				 0, 1000, false, i3c->regs, RSTCTL);
 }
=20
+static void renesas_i3c_hw_init(struct renesas_i3c *i3c)
+{
+	u32 val;
+
+	/* Disable Slave Mode */
+	renesas_writel(i3c->regs, SVCTL, 0);
+
+	/* Initialize Queue/Buffer threshold */
+	renesas_writel(i3c->regs, NQTHCTL, NQTHCTL_IBIDSSZ(6) |
+		       NQTHCTL_CMDQTH(1));
+
+	/* The only supported configuration is two entries*/
+	renesas_writel(i3c->regs, NTBTHCTL0, 0);
+	/* Interrupt when there is one entry in the queue */
+	renesas_writel(i3c->regs, NRQTHCTL, 0);
+
+	/* Enable all Bus/Transfer Status Flags */
+	renesas_writel(i3c->regs, BSTE, BSTE_ALL_FLAG);
+	renesas_writel(i3c->regs, NTSTE, NTSTE_ALL_FLAG);
+
+	/* Interrupt enable settings */
+	renesas_writel(i3c->regs, BIE, BIE_NACKDIE | BIE_TENDIE);
+	renesas_writel(i3c->regs, NTIE, 0);
+
+	/* Clear Status register */
+	renesas_writel(i3c->regs, NTST, 0);
+	renesas_writel(i3c->regs, INST, 0);
+	renesas_writel(i3c->regs, BST, 0);
+
+	/* Hot-Join Acknowlege setting. */
+	renesas_set_bit(i3c->regs, BCTL, BCTL_HJACKCTL);
+
+	renesas_writel(i3c->regs, IBINCTL, IBINCTL_NRHJCTL | IBINCTL_NRMRCTL |
+		       IBINCTL_NRSIRCTL);
+
+	renesas_writel(i3c->regs, SCSTLCTL, 0);
+	renesas_set_bit(i3c->regs, SCSTRCTL, SCSTRCTL_ACKTWE);
+
+	/* Bus condition timing */
+	val =3D DIV_ROUND_UP(I3C_BUS_TBUF_MIXED_FM_MIN_NS,
+			   NSEC_PER_SEC / i3c->rate);
+	renesas_writel(i3c->regs, BFRECDT, BFRECDT_FRECYC(val));
+
+	val =3D DIV_ROUND_UP(I3C_BUS_TAVAL_MIN_NS,
+			   NSEC_PER_SEC / i3c->rate);
+	renesas_writel(i3c->regs, BAVLCDT, BAVLCDT_AVLCYC(val));
+
+	val =3D DIV_ROUND_UP(I3C_BUS_TIDLE_MIN_NS,
+			   NSEC_PER_SEC / i3c->rate);
+	renesas_writel(i3c->regs, BIDLCDT, BIDLCDT_IDLCYC(val));
+}
+
 static int renesas_i3c_bus_init(struct i3c_master_controller *m)
 {
 	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
 	struct i3c_bus *bus =3D i3c_master_get_bus(m);
 	struct i3c_device_info info =3D {};
 	struct i2c_timings t;
-	u32 double_SBR, val;
+	u32 double_SBR;
 	int cks, pp_high_ticks, pp_low_ticks, i3c_total_ticks;
 	int od_high_ticks, od_low_ticks, i2c_total_ticks;
 	int ret;
@@ -565,49 +617,8 @@ static int renesas_i3c_bus_init(struct i3c_master_co=
ntroller *m)
=20
 	renesas_writel(i3c->regs, REFCKCTL, REFCKCTL_IREFCKS(cks));
=20
-	/* Disable Slave Mode */
-	renesas_writel(i3c->regs, SVCTL, 0);
-
-	/* Initialize Queue/Buffer threshold */
-	renesas_writel(i3c->regs, NQTHCTL, NQTHCTL_IBIDSSZ(6) |
-					     NQTHCTL_CMDQTH(1));
-
-	/* The only supported configuration is two entries*/
-	renesas_writel(i3c->regs, NTBTHCTL0, 0);
-	/* Interrupt when there is one entry in the queue */
-	renesas_writel(i3c->regs, NRQTHCTL, 0);
-
-	/* Enable all Bus/Transfer Status Flags */
-	renesas_writel(i3c->regs, BSTE, BSTE_ALL_FLAG);
-	renesas_writel(i3c->regs, NTSTE, NTSTE_ALL_FLAG);
-
-	/* Interrupt enable settings */
-	renesas_writel(i3c->regs, BIE, BIE_NACKDIE | BIE_TENDIE);
-	renesas_writel(i3c->regs, NTIE, 0);
-
-	/* Clear Status register */
-	renesas_writel(i3c->regs, NTST, 0);
-	renesas_writel(i3c->regs, INST, 0);
-	renesas_writel(i3c->regs, BST, 0);
-
-	/* Hot-Join Acknowlege setting. */
-	renesas_set_bit(i3c->regs, BCTL, BCTL_HJACKCTL);
-
-	renesas_writel(i3c->regs, IBINCTL, IBINCTL_NRHJCTL | IBINCTL_NRMRCTL |
-					     IBINCTL_NRSIRCTL);
-
-	renesas_writel(i3c->regs, SCSTLCTL, 0);
-	renesas_set_bit(i3c->regs, SCSTRCTL, SCSTRCTL_ACKTWE);
-
-	/* Bus condition timing */
-	val =3D DIV_ROUND_UP(I3C_BUS_TBUF_MIXED_FM_MIN_NS, NSEC_PER_SEC / i3c->=
rate);
-	renesas_writel(i3c->regs, BFRECDT, BFRECDT_FRECYC(val));
-
-	val =3D DIV_ROUND_UP(I3C_BUS_TAVAL_MIN_NS, NSEC_PER_SEC / i3c->rate);
-	renesas_writel(i3c->regs, BAVLCDT, BAVLCDT_AVLCYC(val));
-
-	val =3D DIV_ROUND_UP(I3C_BUS_TIDLE_MIN_NS, NSEC_PER_SEC / i3c->rate);
-	renesas_writel(i3c->regs, BIDLCDT, BIDLCDT_IDLCYC(val));
+	/* I3C hw init*/
+	renesas_i3c_hw_init(i3c);
=20
 	ret =3D i3c_master_get_free_addr(m, 0);
 	if (ret < 0)
--=20
2.43.0

