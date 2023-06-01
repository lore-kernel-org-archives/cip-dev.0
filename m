Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBD2C7EE33
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 15:04:41 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.34577.1685631880118354685
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 08:04:40 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,210,1681138800"; 
   d="scan'208";a="165350523"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Jun 2023 00:04:39 +0900
Received: from localhost.localdomain (unknown [10.226.93.19])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 94D284010DC0;
	Fri,  2 Jun 2023 00:04:37 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 10/19] usb: gadget: udc: renesas_usb3: Add role switch support for RZ/V2M
Date: Thu,  1 Jun 2023 16:04:01 +0100
Message-Id: <20230601150410.124773-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
References: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 15:04:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11740

commit 3827fa1ef38f52d9de7ec6e52b4f724dd7b60bb2 upstream.

As RZ/V2M has both HOST and PERI reset module, we need to do reset release
before accessing registers in respective IP module.

This patch adds role switch support for RZ/V2M.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230121145853.4792-7-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/usb/gadget/udc/renesas_usb3.c | 34 +++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index 8ad76f7dccb7..a1e8669536d8 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -7,6 +7,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/extcon-provider.h>
@@ -2366,6 +2367,9 @@ static int renesas_usb3_start(struct usb_gadget *gadget,
 
 	usb3 = gadget_to_renesas_usb3(gadget);
 
+	if (usb3->is_rzv2m && usb3_is_a_device(usb3))
+		return -EBUSY;
+
 	/* hook up the driver */
 	usb3->driver = driver;
 
@@ -2374,6 +2378,10 @@ static int renesas_usb3_start(struct usb_gadget *gadget,
 
 	pm_runtime_get_sync(usb3_to_dev(usb3));
 
+	/* Peripheral Reset */
+	if (usb3->is_rzv2m)
+		rzv2m_usb3drd_reset(usb3_to_dev(usb3)->parent, false);
+
 	renesas_usb3_init_controller(usb3);
 
 	return 0;
@@ -2386,8 +2394,10 @@ static int renesas_usb3_stop(struct usb_gadget *gadget)
 	usb3->softconnect = false;
 	usb3->gadget.speed = USB_SPEED_UNKNOWN;
 	usb3->driver = NULL;
-	renesas_usb3_stop_controller(usb3);
+	if (usb3->is_rzv2m)
+		rzv2m_usb3drd_reset(usb3_to_dev(usb3)->parent, false);
 
+	renesas_usb3_stop_controller(usb3);
 	if (usb3->phy)
 		phy_exit(usb3->phy);
 
@@ -2447,18 +2457,29 @@ static void handle_ext_role_switch_states(struct device *dev,
 	switch (role) {
 	case USB_ROLE_NONE:
 		usb3->connection_state = USB_ROLE_NONE;
-		if (cur_role == USB_ROLE_HOST)
+		if (!usb3->is_rzv2m && cur_role == USB_ROLE_HOST)
 			device_release_driver(host);
-		if (usb3->driver)
+		if (usb3->driver) {
+			if (usb3->is_rzv2m)
+				rzv2m_usb3drd_reset(dev->parent, false);
 			usb3_disconnect(usb3);
+		}
 		usb3_vbus_out(usb3, false);
+
+		if (usb3->is_rzv2m) {
+			rzv2m_usb3drd_reset(dev->parent, true);
+			device_release_driver(host);
+		}
 		break;
 	case USB_ROLE_DEVICE:
 		if (usb3->connection_state == USB_ROLE_NONE) {
 			usb3->connection_state = USB_ROLE_DEVICE;
 			usb3_set_mode(usb3, false);
-			if (usb3->driver)
+			if (usb3->driver) {
+				if (usb3->is_rzv2m)
+					renesas_usb3_init_controller(usb3);
 				usb3_connect(usb3);
+			}
 		} else if (cur_role == USB_ROLE_HOST)  {
 			device_release_driver(host);
 			usb3_set_mode(usb3, false);
@@ -2469,8 +2490,11 @@ static void handle_ext_role_switch_states(struct device *dev,
 		break;
 	case USB_ROLE_HOST:
 		if (usb3->connection_state == USB_ROLE_NONE) {
-			if (usb3->driver)
+			if (usb3->driver) {
+				if (usb3->is_rzv2m)
+					rzv2m_usb3drd_reset(dev->parent, false);
 				usb3_disconnect(usb3);
+			}
 
 			usb3->connection_state = USB_ROLE_HOST;
 			usb3_set_mode(usb3, true);
-- 
2.25.1


