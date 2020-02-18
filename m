From: marian-cristian.rotariu.rb@bp.renesas.com (Marian-Cristian Rotariu)
Date: Tue, 18 Feb 2020 14:05:17 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 20/23] usb: gadget: udc: renesas_usb3:
	Enhance role switch support
In-Reply-To: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <1582034720-5249-21-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

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
