Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15778.1794915974713383404
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:46:14 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 814EB40887;
	Tue, 17 Nov 2026 11:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494D21F000C4;
	Tue, 17 Nov 2026 11:46:13 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 11/69] i3c: renesas: Switch to clk_bulk API and store clocks in private data
Date: Tue, 17 Nov 2026 13:44:55 +0200
Message-ID: <20261117114553.1484215-12-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:46:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24852
Content-Type: text/plain; charset="utf-8"

From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

commit 579c7255922a3e0ba432eb608deb7d0fed896052 upstream.

Replace individual devm_clk_get_enabled() calls with the clk_bulk API
and store the clock handles in the driver's private data structure.

All clocks required by the controller are now acquired and enabled using
devm_clk_bulk_get_all_enabled(), removing the need for per-SoC clock
handling and the renesas_i3c_config data.
The TCLK is accessed via a fixed index in the bulk clock array.

Simplify the code and prepare the driver for upcoming suspend/resume
support.

No functional change intended.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/1286f8600b542da55facf9920fed7c06b2b0e4d5.1=
767781092.git.tommaso.merciai.xr@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
[claudiu.beznea: fixed conflict]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 46 +++++++++-----------------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesa=
s-i3c.c
index ea9468b008d3..04a65ccea511 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -199,6 +199,8 @@
 #define RENESAS_I3C_MAX_DEVS	8
 #define I2C_INIT_MSG		-1
=20
+#define RENESAS_I3C_TCLK_IDX	1
+
 enum i3c_internal_state {
 	I3C_INTERNAL_STATE_DISABLED,
 	I3C_INTERNAL_STATE_CONTROLLER_IDLE,
@@ -260,9 +262,10 @@ struct renesas_i3c {
 	u8 addrs[RENESAS_I3C_MAX_DEVS];
 	struct renesas_i3c_xferqueue xferqueue;
 	void __iomem *regs;
-	struct clk *tclk;
+	struct clk_bulk_data *clks;
 	struct reset_control *tresetn;
 	struct reset_control *presetn;
+	u8 num_clks;
 };
=20
 struct renesas_i3c_i2c_dev_data {
@@ -275,10 +278,6 @@ struct renesas_i3c_irq_desc {
 	const char *desc;
 };
=20
-struct renesas_i3c_config {
-	unsigned int has_pclkrw:1;
-};
-
 static inline void renesas_i3c_reg_update(void __iomem *reg, u32 mask, u=
32 val)
 {
 	u32 data =3D readl(reg);
@@ -498,7 +497,7 @@ static int renesas_i3c_bus_init(struct i3c_master_con=
troller *m)
 	int od_high_ticks, od_low_ticks, i2c_total_ticks;
 	int ret;
=20
-	rate =3D clk_get_rate(i3c->tclk);
+	rate =3D clk_get_rate(i3c->clks[RENESAS_I3C_TCLK_IDX].clk);
 	if (!rate)
 		return -EINVAL;
=20
@@ -1322,13 +1321,8 @@ static void renesas_i3c_reset_control_assert(void =
*data)
 static int renesas_i3c_probe(struct platform_device *pdev)
 {
 	struct renesas_i3c *i3c;
-	struct clk *clk;
-	const struct renesas_i3c_config *config =3D of_device_get_match_data(&p=
dev->dev);
 	int ret, i;
=20
-	if (!config)
-		return -ENODATA;
-
 	i3c =3D devm_kzalloc(&pdev->dev, sizeof(*i3c), GFP_KERNEL);
 	if (!i3c)
 		return -ENOMEM;
@@ -1337,19 +1331,12 @@ static int renesas_i3c_probe(struct platform_devi=
ce *pdev)
 	if (IS_ERR(i3c->regs))
 		return PTR_ERR(i3c->regs);
=20
-	clk =3D devm_clk_get_enabled(&pdev->dev, "pclk");
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	if (config->has_pclkrw) {
-		clk =3D devm_clk_get_enabled(&pdev->dev, "pclkrw");
-		if (IS_ERR(clk))
-			return PTR_ERR(clk);
-	}
-
-	i3c->tclk =3D devm_clk_get_enabled(&pdev->dev, "tclk");
-	if (IS_ERR(i3c->tclk))
-		return PTR_ERR(i3c->tclk);
+	ret =3D devm_clk_bulk_get_all_enabled(&pdev->dev, &i3c->clks);
+	if (ret <=3D RENESAS_I3C_TCLK_IDX)
+		return dev_err_probe(&pdev->dev, ret < 0 ? ret : -EINVAL,
+				     "Failed to get clocks (need > %d, got %d)\n",
+				     RENESAS_I3C_TCLK_IDX, ret);
+	i3c->num_clks =3D ret;
=20
 	i3c->tresetn =3D devm_reset_control_get_optional_exclusive(&pdev->dev, =
"tresetn");
 	if (IS_ERR(i3c->tresetn))
@@ -1414,16 +1401,9 @@ static int renesas_i3c_remove(struct platform_devi=
ce *pdev)
 	return 0;
 }
=20
-static const struct renesas_i3c_config empty_i3c_config =3D {
-};
-
-static const struct renesas_i3c_config r9a09g047_i3c_config =3D {
-	.has_pclkrw =3D 1,
-};
-
 static const struct of_device_id renesas_i3c_of_ids[] =3D {
-	{ .compatible =3D "renesas,r9a08g045-i3c", .data =3D &empty_i3c_config =
},
-	{ .compatible =3D "renesas,r9a09g047-i3c", .data =3D &r9a09g047_i3c_con=
fig },
+	{ .compatible =3D "renesas,r9a08g045-i3c" },
+	{ .compatible =3D "renesas,r9a09g047-i3c" },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, renesas_i3c_of_ids);
--=20
2.43.0

