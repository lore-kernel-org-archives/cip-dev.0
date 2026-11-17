Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15908.1794915960228772186
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:46:00 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DB32F435C8;
	Tue, 17 Nov 2026 11:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA2B1F000C4;
	Tue, 17 Nov 2026 11:45:58 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 02/69] i3c: Standardize defines for specification parameters
Date: Tue, 17 Nov 2026 13:44:46 +0200
Message-ID: <20261117114553.1484215-3-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:46:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24843
Content-Type: text/plain; charset="utf-8"

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 9c0609d685b27a0bb392390680207baa820ed118 upstream.

Align existing defines to follow the consistent pattern:
I3C_BUS_<PARAM>_<MAX|MIN|TYP>_<UNIT>. Prepare the codebase for adding
new parameters and help avoid duplication.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20250724094146.6443-2-wsa+renesas@sang-en=
gineering.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/master.c               | 12 ++++++------
 drivers/i3c/master/dw-i3c-master.c |  4 ++--
 include/linux/i3c/master.h         |  9 +++++----
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 0fff6e6e0b53..eaece9d4aa23 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -603,12 +603,12 @@ static int i3c_bus_set_mode(struct i3c_bus *i3cbus,=
 enum i3c_bus_mode mode,
 	switch (i3cbus->mode) {
 	case I3C_BUS_MODE_PURE:
 		if (!i3cbus->scl_rate.i3c)
-			i3cbus->scl_rate.i3c =3D I3C_BUS_TYP_I3C_SCL_RATE;
+			i3cbus->scl_rate.i3c =3D I3C_BUS_I3C_SCL_TYP_RATE;
 		break;
 	case I3C_BUS_MODE_MIXED_FAST:
 	case I3C_BUS_MODE_MIXED_LIMITED:
 		if (!i3cbus->scl_rate.i3c)
-			i3cbus->scl_rate.i3c =3D I3C_BUS_TYP_I3C_SCL_RATE;
+			i3cbus->scl_rate.i3c =3D I3C_BUS_I3C_SCL_TYP_RATE;
 		if (!i3cbus->scl_rate.i2c)
 			i3cbus->scl_rate.i2c =3D max_i2c_scl_rate;
 		break;
@@ -630,8 +630,8 @@ static int i3c_bus_set_mode(struct i3c_bus *i3cbus, e=
num i3c_bus_mode mode,
 	 * I3C/I2C frequency may have been overridden, check that user-provided
 	 * values are not exceeding max possible frequency.
 	 */
-	if (i3cbus->scl_rate.i3c > I3C_BUS_MAX_I3C_SCL_RATE ||
-	    i3cbus->scl_rate.i2c > I3C_BUS_I2C_FM_PLUS_SCL_RATE)
+	if (i3cbus->scl_rate.i3c > I3C_BUS_I3C_SCL_MAX_RATE ||
+	    i3cbus->scl_rate.i2c > I3C_BUS_I2C_FM_PLUS_SCL_MAX_RATE)
 		return -EINVAL;
=20
 	return 0;
@@ -2531,7 +2531,7 @@ int i3c_master_register(struct i3c_master_controlle=
r *master,
 			const struct i3c_master_controller_ops *ops,
 			bool secondary)
 {
-	unsigned long i2c_scl_rate =3D I3C_BUS_I2C_FM_PLUS_SCL_RATE;
+	unsigned long i2c_scl_rate =3D I3C_BUS_I2C_FM_PLUS_SCL_MAX_RATE;
 	struct i3c_bus *i3cbus =3D i3c_master_get_bus(master);
 	enum i3c_bus_mode mode =3D I3C_BUS_MODE_PURE;
 	struct i2c_dev_boardinfo *i2cbi;
@@ -2587,7 +2587,7 @@ int i3c_master_register(struct i3c_master_controlle=
r *master,
 		}
=20
 		if (i2cbi->lvr & I3C_LVR_I2C_FM_MODE)
-			i2c_scl_rate =3D I3C_BUS_I2C_FM_SCL_RATE;
+			i2c_scl_rate =3D I3C_BUS_I2C_FM_SCL_MAX_RATE;
 	}
=20
 	ret =3D i3c_bus_set_mode(i3cbus, mode, i2c_scl_rate);
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i=
3c-master.c
index 3a4502be860b..4861496ab7fe 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -571,13 +571,13 @@ static int dw_i2c_clk_cfg(struct dw_i3c_master *mas=
ter)
 	core_period =3D DIV_ROUND_UP(1000000000, core_rate);
=20
 	lcnt =3D DIV_ROUND_UP(I3C_BUS_I2C_FMP_TLOW_MIN_NS, core_period);
-	hcnt =3D DIV_ROUND_UP(core_rate, I3C_BUS_I2C_FM_PLUS_SCL_RATE) - lcnt;
+	hcnt =3D DIV_ROUND_UP(core_rate, I3C_BUS_I2C_FM_PLUS_SCL_MAX_RATE) - lc=
nt;
 	scl_timing =3D SCL_I2C_FMP_TIMING_HCNT(hcnt) |
 		     SCL_I2C_FMP_TIMING_LCNT(lcnt);
 	writel(scl_timing, master->regs + SCL_I2C_FMP_TIMING);
=20
 	lcnt =3D DIV_ROUND_UP(I3C_BUS_I2C_FM_TLOW_MIN_NS, core_period);
-	hcnt =3D DIV_ROUND_UP(core_rate, I3C_BUS_I2C_FM_SCL_RATE) - lcnt;
+	hcnt =3D DIV_ROUND_UP(core_rate, I3C_BUS_I2C_FM_SCL_MAX_RATE) - lcnt;
 	scl_timing =3D SCL_I2C_FM_TIMING_HCNT(hcnt) |
 		     SCL_I2C_FM_TIMING_LCNT(lcnt);
 	writel(scl_timing, master->regs + SCL_I2C_FM_TIMING);
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index b31170e37655..4e7daea4765d 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -240,10 +240,11 @@ struct i3c_device {
  */
 #define I3C_BUS_MAX_DEVS		11
=20
-#define I3C_BUS_MAX_I3C_SCL_RATE	12900000
-#define I3C_BUS_TYP_I3C_SCL_RATE	12500000
-#define I3C_BUS_I2C_FM_PLUS_SCL_RATE	1000000
-#define I3C_BUS_I2C_FM_SCL_RATE		400000
+/* Taken from the I3C Spec V1.1.1, chapter 6.2. "Timing specification" *=
/
+#define I3C_BUS_I2C_FM_PLUS_SCL_MAX_RATE	1000000
+#define I3C_BUS_I2C_FM_SCL_MAX_RATE		400000
+#define I3C_BUS_I3C_SCL_MAX_RATE	12900000
+#define I3C_BUS_I3C_SCL_TYP_RATE	12500000
 #define I3C_BUS_TLOW_OD_MIN_NS		200
=20
 /**
--=20
2.43.0

