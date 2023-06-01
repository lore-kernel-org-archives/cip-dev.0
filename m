Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B60C7EE2E
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 15:04:21 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.34567.1685631857448189436
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 08:04:19 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,210,1681138800"; 
   d="scan'208";a="161816444"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Jun 2023 00:04:19 +0900
Received: from localhost.localdomain (unknown [10.226.93.19])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3C09640078AA;
	Fri,  2 Jun 2023 00:04:16 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 02/19] usb: typec: hd3ss3220: Add polling support
Date: Thu,  1 Jun 2023 16:03:53 +0100
Message-Id: <20230601150410.124773-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
References: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 15:04:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11732

commit 569d23e9bf58464887c55aa0d2bdb0ead97f8592 upstream.

Some platforms(for eg: RZ/V2M EVK) does not have interrupt pin
connected to HD3SS3220. Add polling support for role detection.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20221209171836.71610-3-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/usb/typec/hd3ss3220.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
index f633ec15b1a1..65a4c50e095a 100644
--- a/drivers/usb/typec/hd3ss3220.c
+++ b/drivers/usb/typec/hd3ss3220.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/usb/typec.h>
 #include <linux/delay.h>
+#include <linux/workqueue.h>
 
 #define HD3SS3220_REG_CN_STAT_CTRL	0x09
 #define HD3SS3220_REG_GEN_CTRL		0x0A
@@ -37,6 +38,9 @@ struct hd3ss3220 {
 	struct regmap *regmap;
 	struct usb_role_switch	*role_sw;
 	struct typec_port *port;
+	struct delayed_work output_poll_work;
+	enum usb_role role_state;
+	bool poll;
 };
 
 static int hd3ss3220_set_source_pref(struct hd3ss3220 *hd3ss3220, int src_pref)
@@ -118,6 +122,22 @@ static void hd3ss3220_set_role(struct hd3ss3220 *hd3ss3220)
 	default:
 		break;
 	}
+
+	hd3ss3220->role_state = role_state;
+}
+
+static void output_poll_execute(struct work_struct *work)
+{
+	struct delayed_work *delayed_work = to_delayed_work(work);
+	struct hd3ss3220 *hd3ss3220 = container_of(delayed_work,
+						   struct hd3ss3220,
+						   output_poll_work);
+	enum usb_role role_state = hd3ss3220_get_attached_state(hd3ss3220);
+
+	if (hd3ss3220->role_state != role_state)
+		hd3ss3220_set_role(hd3ss3220);
+
+	schedule_delayed_work(&hd3ss3220->output_poll_work, HZ);
 }
 
 static irqreturn_t hd3ss3220_irq(struct hd3ss3220 *hd3ss3220)
@@ -226,6 +246,9 @@ static int hd3ss3220_probe(struct i2c_client *client,
 					"hd3ss3220", &client->dev);
 		if (ret)
 			goto err_unreg_port;
+	} else {
+		INIT_DELAYED_WORK(&hd3ss3220->output_poll_work, output_poll_execute);
+		hd3ss3220->poll = true;
 	}
 
 	ret = i2c_smbus_read_byte_data(client, HD3SS3220_REG_DEV_REV);
@@ -234,6 +257,9 @@ static int hd3ss3220_probe(struct i2c_client *client,
 
 	fwnode_handle_put(connector);
 
+	if (hd3ss3220->poll)
+		schedule_delayed_work(&hd3ss3220->output_poll_work, HZ);
+
 	dev_info(&client->dev, "probed revision=0x%x\n", ret);
 
 	return 0;
@@ -251,6 +277,9 @@ static int hd3ss3220_remove(struct i2c_client *client)
 {
 	struct hd3ss3220 *hd3ss3220 = i2c_get_clientdata(client);
 
+	if (hd3ss3220->poll)
+		cancel_delayed_work_sync(&hd3ss3220->output_poll_work);
+
 	typec_unregister_port(hd3ss3220->port);
 	usb_role_switch_put(hd3ss3220->role_sw);
 
-- 
2.25.1


