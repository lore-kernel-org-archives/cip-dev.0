Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D711DD3E2C6
	for <webhook@archiver.kernel.org>; Mon, 28 Oct 2024 20:04:04 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.2545.1730145837013840641
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Oct 2024 13:03:57 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,239,1725289200"; 
   d="scan'208";a="223233415"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 29 Oct 2024 05:03:56 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.179])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E9602408D216;
	Tue, 29 Oct 2024 05:03:54 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 02/27] media: i2c: ov5645: Use runtime PM
Date: Mon, 28 Oct 2024 20:03:24 +0000
Message-ID: <20241028200349.9620-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028200349.9620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241028200349.9620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Oct 2024 20:04:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17084

commit b504503954c7c3741112d4260fbfc9214c66de9b upstream.

Switch to using runtime PM for power management.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/i2c/ov5645.c | 133 +++++++++++++++++++------------------
 1 file changed, 68 insertions(+), 65 deletions(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index 75baf5a67a691..d56f3197d6716 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_graph.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -108,7 +109,6 @@ struct ov5645 {
 	u8 timing_tc_reg21;
 
 	struct mutex power_lock; /* lock to protect power state */
-	int power_count;
 
 	struct gpio_desc *enable_gpio;
 	struct gpio_desc *rst_gpio;
@@ -635,8 +635,24 @@ static int ov5645_set_register_array(struct ov5645 *ov5645,
 	return 0;
 }
 
-static int ov5645_set_power_on(struct ov5645 *ov5645)
+static int ov5645_set_power_off(struct device *dev)
 {
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
+	struct ov5645 *ov5645 = to_ov5645(sd);
+
+	ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x58);
+	gpiod_set_value_cansleep(ov5645->rst_gpio, 1);
+	gpiod_set_value_cansleep(ov5645->enable_gpio, 0);
+	clk_disable_unprepare(ov5645->xclk);
+	regulator_bulk_disable(OV5645_NUM_SUPPLIES, ov5645->supplies);
+
+	return 0;
+}
+
+static int ov5645_set_power_on(struct device *dev)
+{
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
+	struct ov5645 *ov5645 = to_ov5645(sd);
 	int ret;
 
 	ret = regulator_bulk_enable(OV5645_NUM_SUPPLIES, ov5645->supplies);
@@ -658,57 +674,19 @@ static int ov5645_set_power_on(struct ov5645 *ov5645)
 
 	msleep(20);
 
-	return 0;
-}
-
-static void ov5645_set_power_off(struct ov5645 *ov5645)
-{
-	gpiod_set_value_cansleep(ov5645->rst_gpio, 1);
-	gpiod_set_value_cansleep(ov5645->enable_gpio, 0);
-	clk_disable_unprepare(ov5645->xclk);
-	regulator_bulk_disable(OV5645_NUM_SUPPLIES, ov5645->supplies);
-}
-
-static int ov5645_s_power(struct v4l2_subdev *sd, int on)
-{
-	struct ov5645 *ov5645 = to_ov5645(sd);
-	int ret = 0;
-
-	mutex_lock(&ov5645->power_lock);
-
-	/* If the power count is modified from 0 to != 0 or from != 0 to 0,
-	 * update the power state.
-	 */
-	if (ov5645->power_count == !on) {
-		if (on) {
-			ret = ov5645_set_power_on(ov5645);
-			if (ret < 0)
-				goto exit;
-
-			ret = ov5645_set_register_array(ov5645,
-					ov5645_global_init_setting,
+	ret = ov5645_set_register_array(ov5645, ov5645_global_init_setting,
 					ARRAY_SIZE(ov5645_global_init_setting));
-			if (ret < 0) {
-				dev_err(ov5645->dev,
-					"could not set init registers\n");
-				ov5645_set_power_off(ov5645);
-				goto exit;
-			}
-
-			usleep_range(500, 1000);
-		} else {
-			ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x58);
-			ov5645_set_power_off(ov5645);
-		}
+	if (ret < 0) {
+		dev_err(ov5645->dev, "could not set init registers\n");
+		goto exit;
 	}
 
-	/* Update the power count. */
-	ov5645->power_count += on ? 1 : -1;
-	WARN_ON(ov5645->power_count < 0);
+	usleep_range(500, 1000);
 
-exit:
-	mutex_unlock(&ov5645->power_lock);
+	return 0;
 
+exit:
+	ov5645_set_power_off(dev);
 	return ret;
 }
 
@@ -795,7 +773,7 @@ static int ov5645_s_ctrl(struct v4l2_ctrl *ctrl)
 	int ret;
 
 	mutex_lock(&ov5645->power_lock);
-	if (!ov5645->power_count) {
+	if (!pm_runtime_get_if_in_use(ov5645->dev)) {
 		mutex_unlock(&ov5645->power_lock);
 		return 0;
 	}
@@ -827,6 +805,8 @@ static int ov5645_s_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	}
 
+	pm_runtime_mark_last_busy(ov5645->dev);
+	pm_runtime_put_autosuspend(ov5645->dev);
 	mutex_unlock(&ov5645->power_lock);
 
 	return ret;
@@ -989,6 +969,10 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
 	int ret;
 
 	if (enable) {
+		ret = pm_runtime_resume_and_get(ov5645->dev);
+		if (ret < 0)
+			return ret;
+
 		ret = ov5645_set_register_array(ov5645,
 					ov5645->current_mode->data,
 					ov5645->current_mode->data_size);
@@ -996,22 +980,22 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
 			dev_err(ov5645->dev, "could not set mode %dx%d\n",
 				ov5645->current_mode->width,
 				ov5645->current_mode->height);
-			return ret;
+			goto err_rpm_put;
 		}
 		ret = v4l2_ctrl_handler_setup(&ov5645->ctrls);
 		if (ret < 0) {
 			dev_err(ov5645->dev, "could not sync v4l2 controls\n");
-			return ret;
+			goto err_rpm_put;
 		}
 
 		ret = ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x45);
 		if (ret < 0)
-			return ret;
+			goto err_rpm_put;
 
 		ret = ov5645_write_reg(ov5645, OV5645_SYSTEM_CTRL0,
 				       OV5645_SYSTEM_CTRL0_START);
 		if (ret < 0)
-			return ret;
+			goto err_rpm_put;
 	} else {
 		ret = ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x40);
 		if (ret < 0)
@@ -1021,14 +1005,17 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
 				       OV5645_SYSTEM_CTRL0_STOP);
 		if (ret < 0)
 			return ret;
+
+		pm_runtime_mark_last_busy(ov5645->dev);
+		pm_runtime_put_autosuspend(ov5645->dev);
 	}
 
 	return 0;
-}
 
-static const struct v4l2_subdev_core_ops ov5645_core_ops = {
-	.s_power = ov5645_s_power,
-};
+err_rpm_put:
+	pm_runtime_put_sync(ov5645->dev);
+	return ret;
+}
 
 static const struct v4l2_subdev_video_ops ov5645_video_ops = {
 	.s_stream = ov5645_s_stream,
@@ -1044,7 +1031,6 @@ static const struct v4l2_subdev_pad_ops ov5645_subdev_pad_ops = {
 };
 
 static const struct v4l2_subdev_ops ov5645_subdev_ops = {
-	.core = &ov5645_core_ops,
 	.video = &ov5645_video_ops,
 	.pad = &ov5645_subdev_pad_ops,
 };
@@ -1186,11 +1172,9 @@ static int ov5645_probe(struct i2c_client *client)
 		goto free_ctrl;
 	}
 
-	ret = ov5645_s_power(&ov5645->sd, true);
-	if (ret < 0) {
-		dev_err(dev, "could not power up OV5645\n");
+	ret = ov5645_set_power_on(dev);
+	if (ret)
 		goto free_entity;
-	}
 
 	ret = ov5645_read_reg(ov5645, OV5645_CHIP_ID_HIGH, &chip_id_high);
 	if (ret < 0 || chip_id_high != OV5645_CHIP_ID_HIGH_BYTE) {
@@ -1231,20 +1215,30 @@ static int ov5645_probe(struct i2c_client *client)
 		goto power_down;
 	}
 
-	ov5645_s_power(&ov5645->sd, false);
+	pm_runtime_set_active(dev);
+	pm_runtime_get_noresume(dev);
+	pm_runtime_enable(dev);
 
 	ret = v4l2_async_register_subdev(&ov5645->sd);
 	if (ret < 0) {
 		dev_err(dev, "could not register v4l2 device\n");
-		goto free_entity;
+		goto err_pm_runtime;
 	}
 
+	pm_runtime_set_autosuspend_delay(dev, 1000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
 	ov5645_entity_init_cfg(&ov5645->sd, NULL);
 
 	return 0;
 
+err_pm_runtime:
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
 power_down:
-	ov5645_s_power(&ov5645->sd, false);
+	ov5645_set_power_off(dev);
 free_entity:
 	media_entity_cleanup(&ov5645->sd.entity);
 free_ctrl:
@@ -1262,6 +1256,10 @@ static int ov5645_remove(struct i2c_client *client)
 	v4l2_async_unregister_subdev(&ov5645->sd);
 	media_entity_cleanup(&ov5645->sd.entity);
 	v4l2_ctrl_handler_free(&ov5645->ctrls);
+	pm_runtime_disable(ov5645->dev);
+	if (!pm_runtime_status_suspended(ov5645->dev))
+		ov5645_set_power_off(ov5645->dev);
+	pm_runtime_set_suspended(ov5645->dev);
 	mutex_destroy(&ov5645->power_lock);
 
 	return 0;
@@ -1279,10 +1277,15 @@ static const struct of_device_id ov5645_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ov5645_of_match);
 
+static const struct dev_pm_ops ov5645_pm_ops = {
+	SET_RUNTIME_PM_OPS(ov5645_set_power_off, ov5645_set_power_on, NULL)
+};
+
 static struct i2c_driver ov5645_i2c_driver = {
 	.driver = {
 		.of_match_table = of_match_ptr(ov5645_of_match),
 		.name  = "ov5645",
+		.pm = &ov5645_pm_ops,
 	},
 	.probe_new = ov5645_probe,
 	.remove = ov5645_remove,
-- 
2.43.0


