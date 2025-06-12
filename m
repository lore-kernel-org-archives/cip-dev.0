Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BDDC71136
	for <webhook@archiver.kernel.org>; Thu, 12 Jun 2025 12:20:04 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.11402.1749730795908596530
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Jun 2025 05:19:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=m6GIWX2Y;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1749730764;x=1750940364;bh=xQm9
	B29yPR1oyas3GtkbwBMzJYt6zLvgmttpuy7ZSPk=;b=m6GIWX2YM04uEf5/Wo/254lns3u3M97P5W
	Pl6qWDIJOXClOfPIsBGFnQB+ZWj2E7cq9Arx/a9F6dBdza77/v6eqkRqEOQD7C6wQbkCDKRJNj8o+
	2Ga2Izu5aJRluuTWS0+OqabyYAlQWpkyg0O0d7PmhT3jPul5b93xm4okt26EhYgq/mnr6UTdV4Nwl
	HRI0c96TDGYA7HA2tP26Yp9KwM+jqa4W+xrRqZtgBb4+r26h5vqEUBtV8tZSRr0EdFln1YAZ7dIbM
	EvFYPQ5qeOoK+wOO6qunR4TNxHD4+DRQZMDs41Ql3OYkTW6kQQ0tQNaVTc66dWdOvpbb1+JSDF1Ug
	==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 55CCJNit2959845; Thu, 12 Jun 2025 21:19:23 +0900
X-Iguazu-Qid: 2yAbuzQy46AqjXOFbU
X-Iguazu-QSIG: v=2; s=0; t=1749730763; q=2yAbuzQy46AqjXOFbU; m=FYXFmWI0MHZCpQZh0Nn2zLThPXMCPiWlDVx/pxSlSK0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 55CCJLIC1292051
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 21:19:21 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org, pavel@denx.de
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH for 5.10.y-cip 1/1] media: mc: Provide a helper for setting bus_info field
Date: Thu, 12 Jun 2025 21:19:10 +0900
X-TSB-HOP2: ON
Message-Id: <1749730750-6914-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1749730750-6914-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <1749730750-6914-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Jun 2025 12:20:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19040

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit 78a171e58717685ea0eb082a24bc75bd9e20518f upstream.

The bus_info or a similar field exists in a lot of structs, yet drivers
tend to set the value of that field by themselves in a determinable way.
Thus provide a helper for doing this. To be used in subsequent patches.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 include/media/media-device.h | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/include/media/media-device.h b/include/media/media-device.h
index 1345e6da688a..077250c49f1a 100644
--- a/include/media/media-device.h
+++ b/include/media/media-device.h
@@ -13,12 +13,13 @@
 
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
 
 #include <media/media-devnode.h>
 #include <media/media-entity.h>
 
 struct ida;
-struct device;
 struct media_device;
 
 /**
@@ -181,8 +182,7 @@ struct media_device {
 	atomic_t request_id;
 };
 
-/* We don't need to include pci.h or usb.h here */
-struct pci_dev;
+/* We don't need to include usb.h here */
 struct usb_device;
 
 #ifdef CONFIG_MEDIA_CONTROLLER
@@ -496,4 +496,27 @@ static inline void __media_device_usb_init(struct media_device *mdev,
 #define media_device_usb_init(mdev, udev, name) \
 	__media_device_usb_init(mdev, udev, name, KBUILD_MODNAME)
 
+/**
+ * media_set_bus_info() - Set bus_info field
+ *
+ * @bus_info:		Variable where to write the bus info (char array)
+ * @bus_info_size:	Length of the bus_info
+ * @dev:		Related struct device
+ *
+ * Sets bus information based on &dev. This is currently done for PCI and
+ * platform devices. dev is required to be non-NULL for this to happen.
+ *
+ * This function is not meant to be called from drivers.
+ */
+static inline void
+media_set_bus_info(char *bus_info, size_t bus_info_size, struct device *dev)
+{
+	if (!dev)
+		strscpy(bus_info, "no bus info", bus_info_size);
+	else if (dev_is_platform(dev))
+		snprintf(bus_info, bus_info_size, "platform:%s", dev_name(dev));
+	else if (dev_is_pci(dev))
+		snprintf(bus_info, bus_info_size, "PCI:%s", dev_name(dev));
+}
+
 #endif
-- 
2.25.1



