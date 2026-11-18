Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.926.1795020135780253435
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 08:42:15 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=4qsa=jh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 91F7B424B4;
	Wed, 18 Nov 2026 16:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DEF1F000C4;
	Wed, 18 Nov 2026 16:42:14 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [RESEND PATCH 6.12.y-cip 19/35] i3c: renesas: Add runtime PM support
Date: Wed, 18 Nov 2026 18:41:30 +0200
Message-ID: <20261118164146.3040784-20-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
References: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 16:42:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24982
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 4af1aacc580c1633be5d7b37b5847ba91c6ad97f upstream.

On the SoCs where the Renesas I3C driver is enabled (RZ/G3S and RZ/G3E),
the clocks of the IP are managed through a clock PM domain. To keep the
I3C code simpler, the explicit clock handling was dropped along with the
addition of runtime PM support, in favor of the runtime PM APIs. Only the
code for getting tclk was preserved, as it is necessary to compute the
I3C clock rate.

All the APIs provided to the I3C subsystem through struct
i3c_master_controller_ops are guarded with runtime PM APIs to
enable/disable the controller at runtime.

As the Renesas I3C driver implements an asynchronous transmit model by
preparing a transfer and waiting for its completion through the ISR,
renesas_i3c_abort_xfer() was added to disable interrupts and clear any
pending IRQ status bits when there is no completion in the defined
timeout. Along with this, renesas_i3c_wait_xfer() return type was changed
to unsigned long.

Add runtime PM support for the Renesas I3C driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260713130545.568657-18-claudiu.beznea+re=
nesas@tuxon.dev
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
[claudiu.beznea:
- fix conflict in renesas_i3c_attach_i3c_dev() by using kzalloc() instead
  of kzalloc_obj()
- replaced PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND() and
  PM_RUNTIME_ACQUIRE_ERR() with pm_runtime_resume_and_get(),
  pm_runtime_mark_last_busy(), pm_runtime_put_autosuspend()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 194 ++++++++++++++++++++++++-------
 1 file changed, 155 insertions(+), 39 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesa=
s-i3c.c
index 15f6dfadd91f..6effdb633984 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
 #include "../internals.h"
@@ -199,8 +200,6 @@
 #define RENESAS_I3C_MAX_DEVS	8
 #define I2C_INIT_MSG		-1
=20
-#define RENESAS_I3C_TCLK_IDX	1
-
 enum i3c_internal_state {
 	I3C_INTERNAL_STATE_DISABLED,
 	I3C_INTERNAL_STATE_CONTROLLER_IDLE,
@@ -254,9 +253,10 @@ struct renesas_i3c_xferqueue {
=20
 struct renesas_i3c {
 	void __iomem *regs;
-	struct clk_bulk_data *clks;
+	struct clk *tclk;
 	struct reset_control *presetn;
 	struct reset_control *tresetn;
+	struct device *dev;
 	struct renesas_i3c_xferqueue xferqueue;
 	struct i3c_master_controller base;
 	u8 addrs[RENESAS_I3C_MAX_DEVS];
@@ -269,7 +269,6 @@ struct renesas_i3c {
 	u32 i3c_STDBR;
 	u32 extbr;
 	u16 maxdevs;
-	u8 num_clks;
 	u8 refclk_div;
 };
=20
@@ -449,7 +448,14 @@ static void renesas_i3c_irqs_mask_and_clear_locked(s=
truct renesas_i3c *i3c)
 	renesas_readl(i3c->regs, BST);
 }
=20
-static void renesas_i3c_wait_xfer(struct renesas_i3c *i3c, struct renesa=
s_i3c_xfer *xfer)
+static void renesas_i3c_irqs_mask_and_clear(struct renesas_i3c *i3c)
+{
+	guard(spinlock_irqsave)(&i3c->xferqueue.lock);
+
+	renesas_i3c_irqs_mask_and_clear_locked(i3c);
+}
+
+static unsigned long renesas_i3c_wait_xfer(struct renesas_i3c *i3c, stru=
ct renesas_i3c_xfer *xfer)
 {
 	unsigned long time_left;
=20
@@ -458,6 +464,8 @@ static void renesas_i3c_wait_xfer(struct renesas_i3c =
*i3c, struct renesas_i3c_xf
 	time_left =3D wait_for_completion_timeout(&xfer->comp, msecs_to_jiffies=
(1000));
 	if (!time_left)
 		renesas_i3c_dequeue_xfer(i3c, xfer);
+
+	return time_left;
 }
=20
 static void renesas_i3c_set_prts(struct renesas_i3c *i3c, u32 val)
@@ -491,12 +499,22 @@ static void renesas_i3c_bus_enable(struct i3c_maste=
r_controller *m, bool i3c_mod
 static int renesas_i3c_reset(struct renesas_i3c *i3c)
 {
 	u32 val;
+	int ret;
+
+	ret =3D pm_runtime_resume_and_get(i3c->dev);
+	if (ret)
+		return ret;
=20
 	renesas_writel(i3c->regs, BCTL, 0);
 	renesas_set_bit(i3c->regs, RSTCTL, RSTCTL_RI3CRST);
=20
-	return read_poll_timeout(renesas_readl, val, !(val & RSTCTL_RI3CRST),
-				 0, 1000, false, i3c->regs, RSTCTL);
+	ret =3D read_poll_timeout(renesas_readl, val, !(val & RSTCTL_RI3CRST),
+				0, 1000, false, i3c->regs, RSTCTL);
+
+	pm_runtime_mark_last_busy(i3c->dev);
+	pm_runtime_put_autosuspend(i3c->dev);
+
+	return ret;
 }
=20
 static void renesas_i3c_hw_init(struct renesas_i3c *i3c)
@@ -562,7 +580,7 @@ static int renesas_i3c_bus_init(struct i3c_master_con=
troller *m)
 	int od_high_ticks, od_low_ticks, i2c_total_ticks;
 	int ret;
=20
-	i3c->rate =3D clk_get_rate(i3c->clks[RENESAS_I3C_TCLK_IDX].clk);
+	i3c->rate =3D clk_get_rate(i3c->tclk);
 	if (!i3c->rate)
 		return -EINVAL;
=20
@@ -633,6 +651,10 @@ static int renesas_i3c_bus_init(struct i3c_master_co=
ntroller *m)
 	if (ret)
 		return ret;
=20
+	ret =3D pm_runtime_resume_and_get(i3c->dev);
+	if (ret)
+		return ret;
+
 	renesas_writel(i3c->regs, STDBR, i3c->i3c_STDBR);
 	renesas_writel(i3c->regs, EXTBR, i3c->extbr);
 	renesas_writel(i3c->regs, REFCKCTL, REFCKCTL_IREFCKS(cks));
@@ -641,7 +663,12 @@ static int renesas_i3c_bus_init(struct i3c_master_co=
ntroller *m)
 	/* I3C hw init*/
 	renesas_i3c_hw_init(i3c);
=20
-	return i3c_master_set_info(&i3c->base, &info);
+	ret =3D i3c_master_set_info(&i3c->base, &info);
+
+	pm_runtime_mark_last_busy(i3c->dev);
+	pm_runtime_put_autosuspend(i3c->dev);
+
+	return ret;
 }
=20
 static void renesas_i3c_bus_cleanup(struct i3c_master_controller *m)
@@ -655,6 +682,7 @@ static int renesas_i3c_daa(struct i3c_master_controll=
er *m)
 {
 	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
 	struct renesas_i3c_cmd *cmd;
+	unsigned long time_left;
 	u32 olddevs, newdevs;
 	u8 last_addr =3D 0, pos;
 	int ret;
@@ -667,6 +695,10 @@ static int renesas_i3c_daa(struct i3c_master_control=
ler *m)
 	cmd =3D xfer->cmds;
 	cmd->rx_count =3D 0;
=20
+	ret =3D pm_runtime_resume_and_get(i3c->dev);
+	if (ret)
+		return ret;
+
 	/* Enable I3C bus. */
 	renesas_i3c_bus_enable(m, true);
=20
@@ -679,8 +711,10 @@ static int renesas_i3c_daa(struct i3c_master_control=
ler *m)
 			continue;
=20
 		ret =3D i3c_master_get_free_addr(m, last_addr + 1);
-		if (ret < 0)
-			return -ENOSPC;
+		if (ret < 0) {
+			ret =3D -ENOSPC;
+			goto rpm_put;
+		}
=20
 		i3c->addrs[pos] =3D ret;
 		last_addr =3D ret;
@@ -690,7 +724,7 @@ static int renesas_i3c_daa(struct i3c_master_controll=
er *m)
=20
 	ret =3D renesas_i3c_get_free_pos(i3c);
 	if (ret < 0)
-		return ret;
+		goto rpm_put;
=20
 	/*
 	 * Setup the command descriptor to start the ENTDAA command
@@ -701,7 +735,9 @@ static int renesas_i3c_daa(struct i3c_master_controll=
er *m)
 		    NCMDQP_CMD(I3C_CCC_ENTDAA) | NCMDQP_DEV_INDEX(ret) |
 		    NCMDQP_DEV_COUNT(i3c->maxdevs - ret) | NCMDQP_TOC;
=20
-	renesas_i3c_wait_xfer(i3c, xfer);
+	time_left =3D renesas_i3c_wait_xfer(i3c, xfer);
+	if (!time_left)
+		renesas_i3c_irqs_mask_and_clear(i3c);
=20
 	if (cmd->rx_count >=3D i3c->maxdevs)
 		newdevs =3D 0;
@@ -715,7 +751,11 @@ static int renesas_i3c_daa(struct i3c_master_control=
ler *m)
 			i3c_master_add_i3c_dev_locked(m, i3c->addrs[pos]);
 	}
=20
-	return 0;
+rpm_put:
+	pm_runtime_mark_last_busy(i3c->dev);
+	pm_runtime_put_autosuspend(i3c->dev);
+
+	return ret < 0 ? ret : 0;
 }
=20
 static bool renesas_i3c_supports_ccc_cmd(struct i3c_master_controller *m=
,
@@ -767,6 +807,7 @@ static int renesas_i3c_send_ccc_cmd(struct i3c_master=
_controller *m,
 {
 	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
 	struct renesas_i3c_cmd *cmd;
+	unsigned long time_left;
 	int ret, pos =3D 0;
=20
 	if (ccc->id & I3C_CCC_DIRECT) {
@@ -784,6 +825,10 @@ static int renesas_i3c_send_ccc_cmd(struct i3c_maste=
r_controller *m,
 	cmd->rnw =3D ccc->rnw;
 	cmd->cmd0 =3D 0;
=20
+	ret =3D pm_runtime_resume_and_get(i3c->dev);
+	if (ret)
+		return ret;
+
 	renesas_i3c_bus_enable(m, true);
=20
 	/* Calculate the command descriptor. */
@@ -818,12 +863,17 @@ static int renesas_i3c_send_ccc_cmd(struct i3c_mast=
er_controller *m,
 		}
 	}
=20
-	renesas_i3c_wait_xfer(i3c, xfer);
+	time_left =3D renesas_i3c_wait_xfer(i3c, xfer);
+	if (!time_left)
+		renesas_i3c_irqs_mask_and_clear(i3c);
=20
 	ret =3D xfer->ret;
 	if (ret)
 		ccc->err =3D I3C_ERROR_M2;
=20
+	pm_runtime_mark_last_busy(i3c->dev);
+	pm_runtime_put_autosuspend(i3c->dev);
+
 	return ret;
 }
=20
@@ -833,7 +883,9 @@ static int renesas_i3c_priv_xfers(struct i3c_dev_desc=
 *dev, struct i3c_priv_xfer
 	struct i3c_master_controller *m =3D i3c_dev_get_master(dev);
 	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
 	struct renesas_i3c_i2c_dev_data *data =3D i3c_dev_get_master_data(dev);
-	int i;
+	unsigned long time_left;
+	bool xfer_failed =3D false;
+	int i, ret;
=20
 	struct renesas_i3c_xfer *xfer __free(kfree) =3D renesas_i3c_alloc_xfer(=
i3c, 1);
 	if (!xfer)
@@ -841,6 +893,10 @@ static int renesas_i3c_priv_xfers(struct i3c_dev_des=
c *dev, struct i3c_priv_xfer
=20
 	init_completion(&xfer->comp);
=20
+	ret =3D pm_runtime_resume_and_get(i3c->dev);
+	if (ret)
+		return ret;
+
 	/* Enable I3C bus. */
 	renesas_i3c_bus_enable(m, true);
=20
@@ -872,9 +928,17 @@ static int renesas_i3c_priv_xfers(struct i3c_dev_des=
c *dev, struct i3c_priv_xfer
 				renesas_set_bit(i3c->regs, NTIE, NTIE_TDBEIE0);
 		}
=20
-		renesas_i3c_wait_xfer(i3c, xfer);
+		time_left =3D renesas_i3c_wait_xfer(i3c, xfer);
+		if (!time_left)
+			xfer_failed =3D true;
 	}
=20
+	if (xfer_failed)
+		renesas_i3c_irqs_mask_and_clear(i3c);
+
+	pm_runtime_mark_last_busy(i3c->dev);
+	pm_runtime_put_autosuspend(i3c->dev);
+
 	return 0;
 }
=20
@@ -883,15 +947,21 @@ static int renesas_i3c_attach_i3c_dev(struct i3c_de=
v_desc *dev)
 	struct i3c_master_controller *m =3D i3c_dev_get_master(dev);
 	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
 	struct renesas_i3c_i2c_dev_data *data;
-	int pos;
+	int pos, ret;
=20
 	pos =3D renesas_i3c_get_free_pos(i3c);
 	if (pos < 0)
 		return pos;
=20
+	ret =3D pm_runtime_resume_and_get(i3c->dev);
+	if (ret)
+		return ret;
+
 	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
+	if (!data) {
+		ret =3D -ENOMEM;
+		goto rpm_put;
+	}
=20
 	data->index =3D pos;
 	i3c->addrs[pos] =3D dev->info.dyn_addr ? : dev->info.static_addr;
@@ -901,7 +971,11 @@ static int renesas_i3c_attach_i3c_dev(struct i3c_dev=
_desc *dev)
 				    datbas_dvdyad_with_parity(i3c->addrs[pos]));
 	i3c_dev_set_master_data(dev, data);
=20
-	return 0;
+rpm_put:
+	pm_runtime_mark_last_busy(i3c->dev);
+	pm_runtime_put_autosuspend(i3c->dev);
+
+	return ret;
 }
=20
 static int renesas_i3c_reattach_i3c_dev(struct i3c_dev_desc *dev,
@@ -910,7 +984,11 @@ static int renesas_i3c_reattach_i3c_dev(struct i3c_d=
ev_desc *dev,
 	struct i3c_master_controller *m =3D i3c_dev_get_master(dev);
 	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
 	struct renesas_i3c_i2c_dev_data *data =3D i3c_dev_get_master_data(dev);
-	int pos;
+	int pos, ret;
+
+	ret =3D pm_runtime_resume_and_get(i3c->dev);
+	if (ret)
+		return ret;
=20
 	pos =3D renesas_i3c_get_free_pos(i3c);
=20
@@ -930,6 +1008,9 @@ static int renesas_i3c_reattach_i3c_dev(struct i3c_d=
ev_desc *dev,
 		       DATBAS_DVSTAD(dev->info.static_addr) |
 		       datbas_dvdyad_with_parity(i3c->addrs[data->index]));
=20
+	pm_runtime_mark_last_busy(i3c->dev);
+	pm_runtime_put_autosuspend(i3c->dev);
+
 	return 0;
 }
=20
@@ -938,13 +1019,21 @@ static void renesas_i3c_detach_i3c_dev(struct i3c_=
dev_desc *dev)
 	struct renesas_i3c_i2c_dev_data *data =3D i3c_dev_get_master_data(dev);
 	struct i3c_master_controller *m =3D i3c_dev_get_master(dev);
 	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
+	int ret;
=20
-	renesas_writel(i3c->regs, DATBAS(data->index), 0);
+	ret =3D pm_runtime_resume_and_get(i3c->dev);
+	if (!ret)
+		renesas_writel(i3c->regs, DATBAS(data->index), 0);
=20
 	i3c_dev_set_master_data(dev, NULL);
 	i3c->addrs[data->index] =3D 0;
 	i3c->free_pos |=3D BIT(data->index);
 	kfree(data);
+
+	if (!ret) {
+		pm_runtime_mark_last_busy(i3c->dev);
+		pm_runtime_put_autosuspend(i3c->dev);
+	}
 }
=20
 static int renesas_i3c_i2c_xfers(struct i2c_dev_desc *dev,
@@ -955,7 +1044,9 @@ static int renesas_i3c_i2c_xfers(struct i2c_dev_desc=
 *dev,
 	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
 	struct renesas_i3c_cmd *cmd;
 	u8 start_bit =3D CNDCTL_STCND;
-	int i;
+	unsigned long time_left;
+	bool xfer_failed =3D false;
+	int i, ret;
=20
 	if (!i2c_nxfers)
 		return 0;
@@ -968,11 +1059,15 @@ static int renesas_i3c_i2c_xfers(struct i2c_dev_de=
sc *dev,
 	xfer->is_i2c_xfer =3D true;
 	cmd =3D xfer->cmds;
=20
+	ret =3D pm_runtime_resume_and_get(i3c->dev);
+	if (ret)
+		return ret;
+
 	renesas_i3c_bus_enable(m, false);
=20
 	if (!(renesas_readl(i3c->regs, BCST) & BCST_BFREF)) {
 		cmd->err =3D -EBUSY;
-		return cmd->err;
+		goto rpm_put;
 	}
=20
 	renesas_writel(i3c->regs, BST, 0);
@@ -994,7 +1089,9 @@ static int renesas_i3c_i2c_xfers(struct i2c_dev_desc=
 *dev,
=20
 		renesas_set_bit(i3c->regs, NTSTE, NTSTE_TDBEE0);
=20
-		wait_for_completion_timeout(&xfer->comp, m->i2c.timeout);
+		time_left =3D wait_for_completion_timeout(&xfer->comp, m->i2c.timeout)=
;
+		if (!time_left)
+			xfer_failed =3D true;
=20
 		if (cmd->err)
 			break;
@@ -1003,6 +1100,14 @@ static int renesas_i3c_i2c_xfers(struct i2c_dev_de=
sc *dev,
 	}
=20
 	renesas_i3c_dequeue_xfer(i3c, xfer);
+
+	if (xfer_failed)
+		renesas_i3c_irqs_mask_and_clear(i3c);
+
+rpm_put:
+	pm_runtime_mark_last_busy(i3c->dev);
+	pm_runtime_put_autosuspend(i3c->dev);
+
 	return cmd->err;
 }
=20
@@ -1384,12 +1489,16 @@ static int renesas_i3c_probe(struct platform_devi=
ce *pdev)
 	if (IS_ERR(i3c->regs))
 		return PTR_ERR(i3c->regs);
=20
-	ret =3D devm_clk_bulk_get_all_enabled(&pdev->dev, &i3c->clks);
-	if (ret <=3D RENESAS_I3C_TCLK_IDX)
-		return dev_err_probe(&pdev->dev, ret < 0 ? ret : -EINVAL,
-				     "Failed to get clocks (need > %d, got %d)\n",
-				     RENESAS_I3C_TCLK_IDX, ret);
-	i3c->num_clks =3D ret;
+	i3c->tclk =3D devm_clk_get(&pdev->dev, "tclk");
+	if (IS_ERR(i3c->tclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(i3c->tclk), "Failed to get tc=
lk");
+
+	i3c->dev =3D &pdev->dev;
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 300);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	ret =3D devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
=20
 	i3c->tresetn =3D devm_reset_control_get_optional_exclusive_deasserted(&=
pdev->dev, "tresetn");
 	if (IS_ERR(i3c->tresetn))
@@ -1456,8 +1565,6 @@ static int renesas_i3c_suspend(struct device *dev)
 	if (ret)
 		goto err_mark_resumed;
=20
-	clk_bulk_disable(i3c->num_clks, i3c->clks);
-
 	return 0;
=20
 err_mark_resumed:
@@ -1479,13 +1586,13 @@ static int renesas_i3c_resume(struct device *dev)
 	if (ret)
 		return ret;
=20
-	ret =3D clk_bulk_enable(i3c->num_clks, i3c->clks);
+	ret =3D renesas_i3c_reset(i3c);
 	if (ret)
 		goto err_resets_asserted;
=20
-	ret =3D renesas_i3c_reset(i3c);
+	ret =3D pm_runtime_resume_and_get(dev);
 	if (ret)
-		goto err_clks_disable;
+		goto err_resets_asserted;
=20
 	/* Re-store I3C registers value. */
 	renesas_writel(i3c->regs, STDBR, i3c->i3c_STDBR);
@@ -1504,15 +1611,24 @@ static int renesas_i3c_resume(struct device *dev)
=20
 	i2c_mark_adapter_resumed(&i3c->base.i2c);
=20
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
 	/*
 	 * I3C devices may have retained their dynamic address anyway. Do not
 	 * fail the resume because of DAA error.
 	 */
 	return 0;
=20
-err_clks_disable:
-	clk_bulk_disable(i3c->num_clks, i3c->clks);
 err_resets_asserted:
+	/*
+	 * If this happens, there is no way to recover from this state without
+	 * reloading the driver. We want to avoid keeping the reset line
+	 * deasserted unnecessarily. The runtime paths will still work correctl=
y
+	 * even if the IP registers are accessed while reset is asserted (e.g.
+	 * if a runtime path is triggered after a failed resume). Checked on
+	 * RZ/G3S.
+	 */
 	reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
 	return ret;
 }
--=20
2.43.0

