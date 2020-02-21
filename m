Return-Path: <SRS0=SQxA=4J=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C87C35658
	for <cip-dev@archiver.kernel.org>; Fri, 21 Feb 2020 16:52:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3534B208C4
	for <cip-dev@archiver.kernel.org>; Fri, 21 Feb 2020 16:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3534B208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2BE4D864B3;
	Fri, 21 Feb 2020 16:52:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T2TONlNVaixW; Fri, 21 Feb 2020 16:52:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 31855864AA;
	Fri, 21 Feb 2020 16:52:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2696AC1D88;
	Fri, 21 Feb 2020 16:52:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D96B3C1D88
 for <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2020 16:52:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C833D875CD
 for <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2020 16:52:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Tj8l5-XTTi1 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Feb 2020 16:52:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4FA918761A
 for <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2020 16:52:29 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.70,468,1574089200"; d="scan'208";a="39726146"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 22 Feb 2020 01:52:29 +0900
Received: from marian-VirtualBox.ree.adwin.renesas.com (unknown
 [10.226.36.164])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 357BA40A3602;
 Sat, 22 Feb 2020 01:52:28 +0900 (JST)
From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
Date: Fri, 21 Feb 2020 16:52:02 +0000
Message-Id: <1582303929-5773-16-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582303929-5773-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1582303929-5773-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Subject: [cip-dev] [PATCH v2 4.19.y-cip 15/22] usb: typec: driver for TI
	HD3SS3220 USB Type-C DRP port controller
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

From: Biju Das <biju.das at bp.renesas.com>

commit 1c48c759ef4bb9031b3347277f04484e07e27d97 upstream.

Driver for TI HD3SS3220 USB Type-C DRP port controller.

The driver currently registers the port and supports data role swapping.

Signed-off-by: Biju Das <biju.das at bp.renesas.com>
Acked-by: Heikki Krogerus <heikki.krogerus at linux.intel.com>
Link: https://lore.kernel.org/r/1567584941-13690-3-git-send-email-biju.das@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh at linuxfoundation.org>
(fixed return value of static function and checkpatch alignment warnings)
Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb at bp.renesas.com>
---
 drivers/usb/typec/Kconfig     |  10 ++
 drivers/usb/typec/Makefile    |   1 +
 drivers/usb/typec/hd3ss3220.c | 272 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 283 insertions(+)
 create mode 100644 drivers/usb/typec/hd3ss3220.c

diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
index 00878c3..fde51c5 100644
--- a/drivers/usb/typec/Kconfig
+++ b/drivers/usb/typec/Kconfig
@@ -92,6 +92,16 @@ endif # TYPEC_TCPM
 
 source "drivers/usb/typec/ucsi/Kconfig"
 
+config TYPEC_HD3SS3220
+	tristate "TI HD3SS3220 Type-C DRP Port controller driver"
+	depends on I2C
+	help
+	  Say Y or M here if your system has TI HD3SS3220 Type-C DRP Port
+	  controller driver.
+
+	  If you choose to build this driver as a dynamically linked module, the
+	  module will be called hd3ss3220.ko.
+
 config TYPEC_TPS6598X
 	tristate "TI TPS6598x USB Power Delivery controller driver"
 	depends on I2C
diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
index 45b0aef..ff58cea 100644
--- a/drivers/usb/typec/Makefile
+++ b/drivers/usb/typec/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_TYPEC_TCPM)	+= tcpm.o
 obj-y				+= fusb302/
 obj-$(CONFIG_TYPEC_WCOVE)	+= typec_wcove.o
 obj-$(CONFIG_TYPEC_UCSI)	+= ucsi/
+obj-$(CONFIG_TYPEC_HD3SS3220)	+= hd3ss3220.o
 obj-$(CONFIG_TYPEC_TPS6598X)	+= tps6598x.o
 obj-$(CONFIG_TYPEC)		+= mux/
 obj-$(CONFIG_TYPEC_TCPCI)	+= tcpci.o
diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
new file mode 100644
index 0000000..f0859a7
--- /dev/null
+++ b/drivers/usb/typec/hd3ss3220.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * TI HD3SS3220 Type-C DRP Port Controller Driver
+ *
+ * Copyright (C) 2019 Renesas Electronics Corp.
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/usb/role.h>
+#include <linux/irqreturn.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/usb/typec.h>
+#include <linux/delay.h>
+
+#define HD3SS3220_REG_CN_STAT_CTRL	0x09
+#define HD3SS3220_REG_GEN_CTRL		0x0A
+#define HD3SS3220_REG_DEV_REV		0xA0
+
+/* Register HD3SS3220_REG_CN_STAT_CTRL*/
+#define HD3SS3220_REG_CN_STAT_CTRL_ATTACHED_STATE_MASK	(BIT(7) | BIT(6))
+#define HD3SS3220_REG_CN_STAT_CTRL_AS_DFP		BIT(6)
+#define HD3SS3220_REG_CN_STAT_CTRL_AS_UFP		BIT(7)
+#define HD3SS3220_REG_CN_STAT_CTRL_TO_ACCESSORY		(BIT(7) | BIT(6))
+#define HD3SS3220_REG_CN_STAT_CTRL_INT_STATUS		BIT(4)
+
+/* Register HD3SS3220_REG_GEN_CTRL*/
+#define HD3SS3220_REG_GEN_CTRL_SRC_PREF_MASK		(BIT(2) | BIT(1))
+#define HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_DEFAULT	0x00
+#define HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_TRY_SNK	BIT(1)
+#define HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_TRY_SRC	(BIT(2) | BIT(1))
+
+struct hd3ss3220 {
+	struct device *dev;
+	struct regmap *regmap;
+	struct usb_role_switch	*role_sw;
+	struct typec_port *port;
+	struct typec_capability typec_cap;
+};
+
+static int hd3ss3220_set_source_pref(struct hd3ss3220 *hd3ss3220, int src_pref)
+{
+	return regmap_update_bits(hd3ss3220->regmap, HD3SS3220_REG_GEN_CTRL,
+				  HD3SS3220_REG_GEN_CTRL_SRC_PREF_MASK,
+				  src_pref);
+}
+
+static int hd3ss3220_get_attached_state(struct hd3ss3220 *hd3ss3220,
+		enum usb_role *attached_state)
+{
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(hd3ss3220->regmap, HD3SS3220_REG_CN_STAT_CTRL,
+			  &reg_val);
+	if (ret < 0)
+		return ret;
+
+	switch (reg_val & HD3SS3220_REG_CN_STAT_CTRL_ATTACHED_STATE_MASK) {
+	case HD3SS3220_REG_CN_STAT_CTRL_AS_DFP:
+		*attached_state = USB_ROLE_HOST;
+		break;
+	case HD3SS3220_REG_CN_STAT_CTRL_AS_UFP:
+		*attached_state = USB_ROLE_DEVICE;
+		break;
+	default:
+		*attached_state = USB_ROLE_NONE;
+		break;
+	}
+
+	return 0;
+}
+
+static int hd3ss3220_dr_set(const struct typec_capability *cap,
+			    enum typec_data_role role)
+{
+	struct hd3ss3220 *hd3ss3220 = container_of(cap, struct hd3ss3220,
+						   typec_cap);
+	enum usb_role role_val;
+	int pref, ret = 0;
+
+	if (role == TYPEC_HOST) {
+		role_val = USB_ROLE_HOST;
+		pref = HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_TRY_SRC;
+	} else {
+		role_val = USB_ROLE_DEVICE;
+		pref = HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_TRY_SNK;
+	}
+
+	ret = hd3ss3220_set_source_pref(hd3ss3220, pref);
+	usleep_range(10, 100);
+
+	usb_role_switch_set_role(hd3ss3220->role_sw, role_val);
+	typec_set_data_role(hd3ss3220->port, role);
+
+	return ret;
+}
+
+static int hd3ss3220_set_role(struct hd3ss3220 *hd3ss3220)
+{
+	enum usb_role role_state;
+	int ret;
+	
+	ret = hd3ss3220_get_attached_state(hd3ss3220, &role_state);
+	if (ret < 0)
+		return ret;
+
+	usb_role_switch_set_role(hd3ss3220->role_sw, role_state);
+	if (role_state == USB_ROLE_NONE)
+		hd3ss3220_set_source_pref(hd3ss3220,
+				HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_DEFAULT);
+
+	switch (role_state) {
+	case USB_ROLE_HOST:
+		typec_set_data_role(hd3ss3220->port, TYPEC_HOST);
+		break;
+	case USB_ROLE_DEVICE:
+		typec_set_data_role(hd3ss3220->port, TYPEC_DEVICE);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+irqreturn_t hd3ss3220_irq(struct hd3ss3220 *hd3ss3220)
+{
+	int err;
+
+	err = hd3ss3220_set_role(hd3ss3220);
+	if (err < 0)
+		return IRQ_NONE;
+
+	err = regmap_update_bits_base(hd3ss3220->regmap,
+				      HD3SS3220_REG_CN_STAT_CTRL,
+				      HD3SS3220_REG_CN_STAT_CTRL_INT_STATUS,
+				      HD3SS3220_REG_CN_STAT_CTRL_INT_STATUS,
+				      NULL, false, true);
+	if (err < 0)
+		return IRQ_NONE;
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t hd3ss3220_irq_handler(int irq, void *data)
+{
+	struct i2c_client *client = to_i2c_client(data);
+	struct hd3ss3220 *hd3ss3220 = i2c_get_clientdata(client);
+
+	return hd3ss3220_irq(hd3ss3220);
+}
+
+static const struct regmap_config config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x0A,
+};
+
+static int hd3ss3220_probe(struct i2c_client *client,
+			   const struct i2c_device_id *id)
+{
+	struct hd3ss3220 *hd3ss3220;
+	struct fwnode_handle *connector;
+	int ret;
+	unsigned int data;
+
+	hd3ss3220 = devm_kzalloc(&client->dev, sizeof(struct hd3ss3220),
+				 GFP_KERNEL);
+	if (!hd3ss3220)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, hd3ss3220);
+
+	hd3ss3220->dev = &client->dev;
+	hd3ss3220->regmap = devm_regmap_init_i2c(client, &config);
+	if (IS_ERR(hd3ss3220->regmap))
+		return PTR_ERR(hd3ss3220->regmap);
+
+	hd3ss3220_set_source_pref(hd3ss3220,
+				  HD3SS3220_REG_GEN_CTRL_SRC_PREF_DRP_DEFAULT);
+	connector = device_get_named_child_node(hd3ss3220->dev, "connector");
+	if (IS_ERR(connector))
+		return PTR_ERR(connector);
+
+	hd3ss3220->role_sw = fwnode_usb_role_switch_get(connector);
+	fwnode_handle_put(connector);
+	if (IS_ERR_OR_NULL(hd3ss3220->role_sw))
+		return PTR_ERR(hd3ss3220->role_sw);
+
+	hd3ss3220->typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
+	hd3ss3220->typec_cap.dr_set = hd3ss3220_dr_set;
+	hd3ss3220->typec_cap.type = TYPEC_PORT_DRP;
+	hd3ss3220->typec_cap.data = TYPEC_PORT_DRD;
+
+	hd3ss3220->port = typec_register_port(&client->dev,
+					      &hd3ss3220->typec_cap);
+	if (IS_ERR(hd3ss3220->port))
+		return PTR_ERR(hd3ss3220->port);
+
+	ret = hd3ss3220_set_role(hd3ss3220);
+	if (ret < 0)
+		goto error;
+
+	ret = regmap_read(hd3ss3220->regmap, HD3SS3220_REG_CN_STAT_CTRL, &data);
+	if (ret < 0)
+		goto error;
+
+	if (data & HD3SS3220_REG_CN_STAT_CTRL_INT_STATUS) {
+		ret = regmap_write(hd3ss3220->regmap,
+				   HD3SS3220_REG_CN_STAT_CTRL,
+				data | HD3SS3220_REG_CN_STAT_CTRL_INT_STATUS);
+		if (ret < 0)
+			goto error;
+	}
+
+	if (client->irq > 0) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+					hd3ss3220_irq_handler,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					"hd3ss3220", &client->dev);
+		if (ret)
+			goto error;
+	}
+
+	ret = i2c_smbus_read_byte_data(client, HD3SS3220_REG_DEV_REV);
+	if (ret < 0)
+		goto error;
+
+	dev_info(&client->dev, "probed revision=0x%x\n", ret);
+
+	return 0;
+error:
+	typec_unregister_port(hd3ss3220->port);
+	usb_role_switch_put(hd3ss3220->role_sw);
+
+	return ret;
+}
+
+static int hd3ss3220_remove(struct i2c_client *client)
+{
+	struct hd3ss3220 *hd3ss3220 = i2c_get_clientdata(client);
+
+	typec_unregister_port(hd3ss3220->port);
+	usb_role_switch_put(hd3ss3220->role_sw);
+
+	return 0;
+}
+
+static const struct of_device_id dev_ids[] = {
+	{ .compatible = "ti,hd3ss3220"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, dev_ids);
+
+static struct i2c_driver hd3ss3220_driver = {
+	.driver = {
+		.name = "hd3ss3220",
+		.of_match_table = of_match_ptr(dev_ids),
+	},
+	.probe = hd3ss3220_probe,
+	.remove =  hd3ss3220_remove,
+};
+
+module_i2c_driver(hd3ss3220_driver);
+
+MODULE_AUTHOR("Biju Das <biju.das@bp.renesas.com>");
+MODULE_DESCRIPTION("TI HD3SS3220 DRP Port Controller Driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
