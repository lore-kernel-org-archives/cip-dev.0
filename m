Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C0AC369D5
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 09:11:17 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.2669.1745572264712836893
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Apr 2025 02:11:11 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: O+7AcoAFSHG4W7oedna0Dw==
X-CSE-MsgGUID: yeFgSS6VStKpUmDjiJW8yQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 Apr 2025 18:11:10 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0408641FE018;
	Fri, 25 Apr 2025 18:11:08 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 05/15] i2c: riic: Add suspend/resume support
Date: Fri, 25 Apr 2025 10:10:47 +0100
Message-ID: <20250425091057.33752-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425091057.33752-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250425091057.33752-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Apr 2025 09:11:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18609

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 53326135d0e041ebe7d08bf22f82529ae69a096e upstream.

Add suspend/resume support for the RIIC driver. This is necessary for the
Renesas RZ/G3S SoC which support suspend to deep sleep state where power
to most of the SoC components is turned off. As a result the I2C controller
needs to be reconfigured after suspend/resume. For this, the reset line
was stored in the driver private data structure as well as i2c timings.
The reset line and I2C timings are necessary to re-initialize the
controller after resume.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 73 +++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index d3c17891970ab..f46d8b21f6379 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -106,6 +106,8 @@ struct riic_dev {
 	struct completion msg_done;
 	struct i2c_adapter adapter;
 	struct clk *clk;
+	struct reset_control *rstc;
+	struct i2c_timings i2c_t;
 };
 
 struct riic_irq_desc {
@@ -303,11 +305,12 @@ static const struct i2c_algorithm riic_algo = {
 	.functionality	= riic_func,
 };
 
-static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
+static int riic_init_hw(struct riic_dev *riic)
 {
 	int ret;
 	unsigned long rate;
 	int total_ticks, cks, brl, brh;
+	struct i2c_timings *t = &riic->i2c_t;
 	struct device *dev = riic->adapter.dev.parent;
 
 	if (t->bus_freq_hz > I2C_MAX_FAST_MODE_FREQ) {
@@ -424,8 +427,6 @@ static int riic_i2c_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct riic_dev *riic;
 	struct i2c_adapter *adap;
-	struct i2c_timings i2c_t;
-	struct reset_control *rstc;
 	int i, ret;
 
 	riic = devm_kzalloc(dev, sizeof(*riic), GFP_KERNEL);
@@ -442,16 +443,16 @@ static int riic_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(riic->clk);
 	}
 
-	rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
-	if (IS_ERR(rstc))
-		return dev_err_probe(dev, PTR_ERR(rstc),
+	riic->rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(riic->rstc))
+		return dev_err_probe(dev, PTR_ERR(riic->rstc),
 				     "Error: missing reset ctrl\n");
 
-	ret = reset_control_deassert(rstc);
+	ret = reset_control_deassert(riic->rstc);
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(dev, riic_reset_control_assert, rstc);
+	ret = devm_add_action_or_reset(dev, riic_reset_control_assert, riic->rstc);
 	if (ret)
 		return ret;
 
@@ -480,14 +481,14 @@ static int riic_i2c_probe(struct platform_device *pdev)
 
 	init_completion(&riic->msg_done);
 
-	i2c_parse_fw_timings(dev, &i2c_t, true);
+	i2c_parse_fw_timings(dev, &riic->i2c_t, true);
 
 	/* Default 0 to save power. Can be overridden via sysfs for lower latency. */
 	pm_runtime_set_autosuspend_delay(dev, 0);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_enable(dev);
 
-	ret = riic_init_hw(riic, &i2c_t);
+	ret = riic_init_hw(riic);
 	if (ret)
 		goto out;
 
@@ -497,7 +498,7 @@ static int riic_i2c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, riic);
 
-	dev_info(dev, "registered with %dHz bus speed\n", i2c_t.bus_freq_hz);
+	dev_info(dev, "registered with %dHz bus speed\n", riic->i2c_t.bus_freq_hz);
 	return 0;
 
 out:
@@ -556,6 +557,55 @@ static const struct riic_of_data riic_rz_v2h_info = {
 	},
 };
 
+static int riic_i2c_suspend(struct device *dev)
+{
+	struct riic_dev *riic = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	i2c_mark_adapter_suspended(&riic->adapter);
+
+	/* Disable output on SDA, SCL pins. */
+	riic_clear_set_bit(riic, ICCR1_ICE, 0, RIIC_ICCR1);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_sync(dev);
+
+	return reset_control_assert(riic->rstc);
+}
+
+static int riic_i2c_resume(struct device *dev)
+{
+	struct riic_dev *riic = dev_get_drvdata(dev);
+	int ret;
+
+	ret = reset_control_deassert(riic->rstc);
+	if (ret)
+		return ret;
+
+	ret = riic_init_hw(riic);
+	if (ret) {
+		/*
+		 * In case this happens there is no way to recover from this
+		 * state. The driver will remain loaded. We want to avoid
+		 * keeping the reset line de-asserted for no reason.
+		 */
+		reset_control_assert(riic->rstc);
+		return ret;
+	}
+
+	i2c_mark_adapter_resumed(&riic->adapter);
+
+	return 0;
+}
+
+static const struct dev_pm_ops riic_i2c_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(riic_i2c_suspend, riic_i2c_resume)
+};
+
 static const struct of_device_id riic_i2c_dt_ids[] = {
 	{ .compatible = "renesas,riic-rz", .data = &riic_rz_a_info },
 	{ .compatible = "renesas,riic-r9a09g057", .data = &riic_rz_v2h_info },
@@ -568,6 +618,7 @@ static struct platform_driver riic_i2c_driver = {
 	.driver		= {
 		.name	= "i2c-riic",
 		.of_match_table = riic_i2c_dt_ids,
+		.pm	= pm_ptr(&riic_i2c_pm_ops),
 	},
 };
 
-- 
2.43.0


