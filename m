Return-Path: <SRS0=SQxA=4J=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC4BC35657
	for <cip-dev@archiver.kernel.org>; Fri, 21 Feb 2020 16:52:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C94F208C4
	for <cip-dev@archiver.kernel.org>; Fri, 21 Feb 2020 16:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C94F208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3E56A20432;
	Fri, 21 Feb 2020 16:52:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aJE02S9J1q1n; Fri, 21 Feb 2020 16:52:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5AA4520408;
	Fri, 21 Feb 2020 16:52:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42950C013E;
	Fri, 21 Feb 2020 16:52:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10F7CC013E
 for <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2020 16:52:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F1595875CD
 for <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2020 16:52:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JmBpDHArEGg5 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Feb 2020 16:52:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1B8AE875DC
 for <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2020 16:52:16 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.70,468,1574089200"; d="scan'208";a="39726114"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 22 Feb 2020 01:52:15 +0900
Received: from marian-VirtualBox.ree.adwin.renesas.com (unknown
 [10.226.36.164])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id C7ED340A35F7;
 Sat, 22 Feb 2020 01:52:14 +0900 (JST)
From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
Date: Fri, 21 Feb 2020 16:51:51 +0000
Message-Id: <1582303929-5773-5-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582303929-5773-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1582303929-5773-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Subject: [cip-dev] [PATCH v2 4.19.y-cip 04/22] usb: roles: Find the muxes by
	also matching against the device node
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

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit ec69e9533c4879c81eb7122771792864eb49af35 upstream.

When the connections are defined in firmware, struct
device_connection will have the fwnode member pointing to
the device node (struct fwnode_handle) of the requested
device, and the endpoint will not be used at all in that
case.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
Tested-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 drivers/usb/roles/class.c | 21 ++++++++++++++++++---
 include/linux/usb/role.h  |  2 ++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index 1dd492e..44a4af2 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/usb/role.h>
+#include <linux/property.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -84,7 +85,12 @@ enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw)
 }
 EXPORT_SYMBOL_GPL(usb_role_switch_get_role);
 
-static int __switch_match(struct device *dev, const void *name)
+static int switch_fwnode_match(struct device *dev, const void *fwnode)
+{
+	return dev_fwnode(dev) == fwnode;
+}
+
+static int switch_name_match(struct device *dev, const void *name)
 {
 	return !strcmp((const char *)name, dev_name(dev));
 }
@@ -94,8 +100,16 @@ static void *usb_role_switch_match(struct device_connection *con, int ep,
 {
 	struct device *dev;
 
-	dev = class_find_device(role_class, NULL, con->endpoint[ep],
-				__switch_match);
+	if (con->fwnode) {
+		if (!fwnode_property_present(con->fwnode, con->id))
+			return NULL;
+
+		dev = class_find_device(role_class, NULL, con->fwnode,
+					switch_fwnode_match);
+	} else {
+		dev = class_find_device(role_class, NULL, con->endpoint[ep],
+					switch_name_match);
+	}
 
 	return dev ? to_role_switch(dev) : ERR_PTR(-EPROBE_DEFER);
 }
@@ -266,6 +280,7 @@ usb_role_switch_register(struct device *parent,
 	sw->get = desc->get;
 
 	sw->dev.parent = parent;
+	sw->dev.fwnode = desc->fwnode;
 	sw->dev.class = role_class;
 	sw->dev.type = &usb_role_dev_type;
 	dev_set_name(&sw->dev, "%s-role-switch", dev_name(parent));
diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
index edc51be..c05ffa6 100644
--- a/include/linux/usb/role.h
+++ b/include/linux/usb/role.h
@@ -18,6 +18,7 @@ typedef enum usb_role (*usb_role_switch_get_t)(struct device *dev);
 
 /**
  * struct usb_role_switch_desc - USB Role Switch Descriptor
+ * @fwnode: The device node to be associated with the role switch
  * @usb2_port: Optional reference to the host controller port device (USB2)
  * @usb3_port: Optional reference to the host controller port device (USB3)
  * @udc: Optional reference to the peripheral controller device
@@ -32,6 +33,7 @@ typedef enum usb_role (*usb_role_switch_get_t)(struct device *dev);
  * usb_role_switch_register() before registering the switch.
  */
 struct usb_role_switch_desc {
+	struct fwnode_handle *fwnode;
 	struct device *usb2_port;
 	struct device *usb3_port;
 	struct device *udc;
-- 
2.7.4

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
