Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15925.1794915976878672497
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:46:17 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4F9A163404;
	Tue, 17 Nov 2026 11:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D863F1F000C4;
	Tue, 17 Nov 2026 11:46:14 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 12/69] i3c: renesas: Store clock rate and reset controls in struct renesas_i3c
Date: Tue, 17 Nov 2026 13:44:56 +0200
Message-ID: <20261117114553.1484215-13-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:46:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24853
Content-Type: text/plain; charset="utf-8"

From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

commit ff4e4f03f0089635b3476d68f5b8833ea67adad6 upstream.

Update the struct renesas_i3c to store the clock rate, presetn and
tresetn handlers. Replace local usage of the clock rate and reset
controls with these structure fields.

Simplify the code and prepare the driver for upcoming suspend/resume
support.

No functional change intended.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/9e1da95dd9137590c752ecd9429925afcbeb918b.1=
767781092.git.tommaso.merciai.xr@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
[claudiu.beznea: fixed conflict in struct renesas_i3c and
 renesas_i3c_probe()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesa=
s-i3c.c
index 04a65ccea511..b1473b53f77c 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -259,12 +259,13 @@ struct renesas_i3c {
 	u32 free_pos;
 	u32 i2c_STDBR;
 	u32 i3c_STDBR;
+	unsigned long rate;
 	u8 addrs[RENESAS_I3C_MAX_DEVS];
 	struct renesas_i3c_xferqueue xferqueue;
 	void __iomem *regs;
 	struct clk_bulk_data *clks;
-	struct reset_control *tresetn;
 	struct reset_control *presetn;
+	struct reset_control *tresetn;
 	u8 num_clks;
 };
=20
@@ -491,22 +492,21 @@ static int renesas_i3c_bus_init(struct i3c_master_c=
ontroller *m)
 	struct i3c_bus *bus =3D i3c_master_get_bus(m);
 	struct i3c_device_info info =3D {};
 	struct i2c_timings t;
-	unsigned long rate;
 	u32 double_SBR, val;
 	int cks, pp_high_ticks, pp_low_ticks, i3c_total_ticks;
 	int od_high_ticks, od_low_ticks, i2c_total_ticks;
 	int ret;
=20
-	rate =3D clk_get_rate(i3c->clks[RENESAS_I3C_TCLK_IDX].clk);
-	if (!rate)
+	i3c->rate =3D clk_get_rate(i3c->clks[RENESAS_I3C_TCLK_IDX].clk);
+	if (!i3c->rate)
 		return -EINVAL;
=20
 	ret =3D renesas_i3c_reset(i3c);
 	if (ret)
 		return ret;
=20
-	i2c_total_ticks =3D DIV_ROUND_UP(rate, bus->scl_rate.i2c);
-	i3c_total_ticks =3D DIV_ROUND_UP(rate, bus->scl_rate.i3c);
+	i2c_total_ticks =3D DIV_ROUND_UP(i3c->rate, bus->scl_rate.i2c);
+	i3c_total_ticks =3D DIV_ROUND_UP(i3c->rate, bus->scl_rate.i3c);
=20
 	i2c_parse_fw_timings(&m->dev, &t, true);
=20
@@ -519,7 +519,7 @@ static int renesas_i3c_bus_init(struct i3c_master_con=
troller *m)
 			pp_high_ticks =3D ((i3c_total_ticks * 5) / 10);
 		else
 			pp_high_ticks =3D DIV_ROUND_UP(I3C_BUS_THIGH_MIXED_MAX_NS,
-						     NSEC_PER_SEC / rate);
+						     NSEC_PER_SEC / i3c->rate);
 		pp_low_ticks =3D i3c_total_ticks - pp_high_ticks;
=20
 		if ((od_low_ticks / 2) <=3D 0xFF && pp_low_ticks < 0x3F)
@@ -527,7 +527,7 @@ static int renesas_i3c_bus_init(struct i3c_master_con=
troller *m)
=20
 		i2c_total_ticks /=3D 2;
 		i3c_total_ticks /=3D 2;
-		rate /=3D 2;
+		i3c->rate /=3D 2;
 	}
=20
 	/* SCL clock period calculation in Open-drain mode */
@@ -548,8 +548,8 @@ static int renesas_i3c_bus_init(struct i3c_master_con=
troller *m)
 			STDBR_SBRLP(pp_low_ticks) |
 			STDBR_SBRHP(pp_high_ticks);
=20
-	od_low_ticks -=3D t.scl_fall_ns / (NSEC_PER_SEC / rate) + 1;
-	od_high_ticks -=3D t.scl_rise_ns / (NSEC_PER_SEC / rate) + 1;
+	od_low_ticks -=3D t.scl_fall_ns / (NSEC_PER_SEC / i3c->rate) + 1;
+	od_high_ticks -=3D t.scl_rise_ns / (NSEC_PER_SEC / i3c->rate) + 1;
 	i3c->i2c_STDBR =3D (double_SBR ? STDBR_DSBRPO : 0) |
 			STDBR_SBRLO(double_SBR, od_low_ticks) |
 			STDBR_SBRHO(double_SBR, od_high_ticks) |
@@ -600,13 +600,13 @@ static int renesas_i3c_bus_init(struct i3c_master_c=
ontroller *m)
 	renesas_set_bit(i3c->regs, SCSTRCTL, SCSTRCTL_ACKTWE);
=20
 	/* Bus condition timing */
-	val =3D DIV_ROUND_UP(I3C_BUS_TBUF_MIXED_FM_MIN_NS, NSEC_PER_SEC / rate)=
;
+	val =3D DIV_ROUND_UP(I3C_BUS_TBUF_MIXED_FM_MIN_NS, NSEC_PER_SEC / i3c->=
rate);
 	renesas_writel(i3c->regs, BFRECDT, BFRECDT_FRECYC(val));
=20
-	val =3D DIV_ROUND_UP(I3C_BUS_TAVAL_MIN_NS, NSEC_PER_SEC / rate);
+	val =3D DIV_ROUND_UP(I3C_BUS_TAVAL_MIN_NS, NSEC_PER_SEC / i3c->rate);
 	renesas_writel(i3c->regs, BAVLCDT, BAVLCDT_AVLCYC(val));
=20
-	val =3D DIV_ROUND_UP(I3C_BUS_TIDLE_MIN_NS, NSEC_PER_SEC / rate);
+	val =3D DIV_ROUND_UP(I3C_BUS_TIDLE_MIN_NS, NSEC_PER_SEC / i3c->rate);
 	renesas_writel(i3c->regs, BIDLCDT, BIDLCDT_IDLCYC(val));
=20
 	ret =3D i3c_master_get_free_addr(m, 0);
--=20
2.43.0

