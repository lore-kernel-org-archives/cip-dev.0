Return-Path: <SRS0=SQxA=4J=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34CBC35656
	for <cip-dev@archiver.kernel.org>; Fri, 21 Feb 2020 16:52:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83A26222C4
	for <cip-dev@archiver.kernel.org>; Fri, 21 Feb 2020 16:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A26222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7798D875DC;
	Fri, 21 Feb 2020 16:52:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XCyb0HQz0YVa; Fri, 21 Feb 2020 16:52:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2CF4B84BCF;
	Fri, 21 Feb 2020 16:52:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19854C013E;
	Fri, 21 Feb 2020 16:52:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D467FC013E
 for <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2020 16:52:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C33FC875CD
 for <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2020 16:52:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k6oQazf5Oi5v for <cip-dev@lists.cip-project.org>;
 Fri, 21 Feb 2020 16:52:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 66E6884BCF
 for <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2020 16:52:35 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.70,468,1574089200"; d="scan'208";a="39726162"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 22 Feb 2020 01:52:35 +0900
Received: from marian-VirtualBox.ree.adwin.renesas.com (unknown
 [10.226.36.164])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4C7CB40A3616;
 Sat, 22 Feb 2020 01:52:34 +0900 (JST)
From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
Date: Fri, 21 Feb 2020 16:52:07 +0000
Message-Id: <1582303929-5773-21-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582303929-5773-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1582303929-5773-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Subject: [cip-dev] [PATCH v2 4.19.y-cip 20/22] usb: gadget: udc:
	renesas_usb3: Enhance role switch support
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

From: Biju Das <biju.das@bp.renesas.com>

commit 0604160d8c0b6082727182398d432a68bdd58872 upstream.

The RZ/G2E cat874 board has a type-c connector connected to hd3ss3220 usb
type-c drp port controller. Enhance role switch support to assign the role
requested by connector device using the usb role switch class framework.

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
(fixed checkpatch alignment warnings)
Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 drivers/usb/gadget/udc/renesas_usb3.c | 91 ++++++++++++++++++++++++++++++++---
 1 file changed, 84 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index b6eec81..d9668f8 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -352,6 +352,8 @@ struct renesas_usb3 {
 	int disabled_count;
 
 	struct usb_request *ep0_req;
+
+	enum usb_role connection_state;
 	u16 test_mode;
 	u8 ep0_buf[USB3_EP0_BUF_SIZE];
 	bool softconnect;
@@ -360,6 +362,7 @@ struct renesas_usb3 {
 	bool extcon_usb;		/* check vbus and set EXTCON_USB */
 	bool forced_b_device;
 	bool start_to_connect;
+	bool role_sw_by_connector;
 };
 
 #define gadget_to_renesas_usb3(_gadget)	\
@@ -700,8 +703,11 @@ static void usb3_mode_config(struct renesas_usb3 *usb3, bool host, bool a_dev)
 	unsigned long flags;
 
 	spin_lock_irqsave(&usb3->lock, flags);
-	usb3_set_mode_by_role_sw(usb3, host);
-	usb3_vbus_out(usb3, a_dev);
+	if (!usb3->role_sw_by_connector ||
+	    usb3->connection_state != USB_ROLE_NONE) {
+		usb3_set_mode_by_role_sw(usb3, host);
+		usb3_vbus_out(usb3, a_dev);
+	}
 	/* for A-Peripheral or forced B-device mode */
 	if ((!host && a_dev) || usb3->start_to_connect)
 		usb3_connect(usb3);
@@ -717,7 +723,8 @@ static void usb3_check_id(struct renesas_usb3 *usb3)
 {
 	usb3->extcon_host = usb3_is_a_device(usb3);
 
-	if (usb3->extcon_host && !usb3->forced_b_device)
+	if ((!usb3->role_sw_by_connector && usb3->extcon_host &&
+	     !usb3->forced_b_device) || usb3->connection_state == USB_ROLE_HOST)
 		usb3_mode_config(usb3, true, true);
 	else
 		usb3_mode_config(usb3, false, false);
@@ -2344,14 +2351,65 @@ static enum usb_role renesas_usb3_role_switch_get(struct device *dev)
 	return cur_role;
 }
 
-static int renesas_usb3_role_switch_set(struct device *dev,
-					enum usb_role role)
+static void handle_ext_role_switch_states(struct device *dev,
+					  enum usb_role role)
+{
+	struct renesas_usb3 *usb3 = dev_get_drvdata(dev);
+	struct device *host = usb3->host_dev;
+	enum usb_role cur_role = renesas_usb3_role_switch_get(dev);
+
+	switch (role) {
+	case USB_ROLE_NONE:
+		usb3->connection_state = USB_ROLE_NONE;
+		if (usb3->driver)
+			usb3_disconnect(usb3);
+		usb3_vbus_out(usb3, false);
+		break;
+	case USB_ROLE_DEVICE:
+		if (usb3->connection_state == USB_ROLE_NONE) {
+			usb3->connection_state = USB_ROLE_DEVICE;
+			usb3_set_mode(usb3, false);
+			if (usb3->driver)
+				usb3_connect(usb3);
+		} else if (cur_role == USB_ROLE_HOST)  {
+			device_release_driver(host);
+			usb3_set_mode(usb3, false);
+			if (usb3->driver)
+				usb3_connect(usb3);
+		}
+		usb3_vbus_out(usb3, false);
+		break;
+	case USB_ROLE_HOST:
+		if (usb3->connection_state == USB_ROLE_NONE) {
+			if (usb3->driver)
+				usb3_disconnect(usb3);
+
+			usb3->connection_state = USB_ROLE_HOST;
+			usb3_set_mode(usb3, true);
+			usb3_vbus_out(usb3, true);
+			if (device_attach(host) < 0)
+				dev_err(dev, "device_attach(host) failed\n");
+		} else if (cur_role == USB_ROLE_DEVICE) {
+			usb3_disconnect(usb3);
+			/* Must set the mode before device_attach of the host */
+			usb3_set_mode(usb3, true);
+			/* This device_attach() might sleep */
+			if (device_attach(host) < 0)
+				dev_err(dev, "device_attach(host) failed\n");
+		}
+		break;
+	default:
+		break;
+	}
+}
+
+static void handle_role_switch_states(struct device *dev,
+				      enum usb_role role)
 {
 	struct renesas_usb3 *usb3 = dev_get_drvdata(dev);
 	struct device *host = usb3->host_dev;
 	enum usb_role cur_role = renesas_usb3_role_switch_get(dev);
 
-	pm_runtime_get_sync(dev);
 	if (cur_role == USB_ROLE_HOST && role == USB_ROLE_DEVICE) {
 		device_release_driver(host);
 		usb3_set_mode(usb3, false);
@@ -2362,6 +2420,20 @@ static int renesas_usb3_role_switch_set(struct device *dev,
 		if (device_attach(host) < 0)
 			dev_err(dev, "device_attach(host) failed\n");
 	}
+}
+
+static int renesas_usb3_role_switch_set(struct device *dev,
+					enum usb_role role)
+{
+	struct renesas_usb3 *usb3 = dev_get_drvdata(dev);
+
+	pm_runtime_get_sync(dev);
+
+	if (usb3->role_sw_by_connector)
+		handle_ext_role_switch_states(dev, role);
+	else
+		handle_role_switch_states(dev, role);
+
 	pm_runtime_put(dev);
 
 	return 0;
@@ -2651,7 +2723,7 @@ static const unsigned int renesas_usb3_cable[] = {
 	EXTCON_NONE,
 };
 
-static const struct usb_role_switch_desc renesas_usb3_role_switch_desc = {
+static struct usb_role_switch_desc renesas_usb3_role_switch_desc = {
 	.set = renesas_usb3_role_switch_set,
 	.get = renesas_usb3_role_switch_get,
 	.allow_userspace_control = true,
@@ -2742,6 +2814,11 @@ static int renesas_usb3_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_dev_create;
 
+	if (device_property_read_bool(&pdev->dev, "usb-role-switch")) {
+		usb3->role_sw_by_connector = true;
+		renesas_usb3_role_switch_desc.fwnode = dev_fwnode(&pdev->dev);
+	}
+
 	INIT_WORK(&usb3->role_work, renesas_usb3_role_work);
 	usb3->role_sw = usb_role_switch_register(&pdev->dev,
 					&renesas_usb3_role_switch_desc);
-- 
2.7.4

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
