Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C8AC10F05
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 13:47:06 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.83957.1701956822418862823
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 05:47:03 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,256,1695654000"; 
   d="scan'208";a="189544025"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Dec 2023 22:47:02 +0900
Received: from localhost.localdomain (unknown [10.226.93.153])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id CBA7542B1D15;
	Thu,  7 Dec 2023 22:47:00 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 01/18] device property: Add const qualifier to device_get_match_data() parameter
Date: Thu,  7 Dec 2023 13:46:40 +0000
Message-Id: <20231207134657.371420-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207134657.371420-1-biju.das.jz@bp.renesas.com>
References: <20231207134657.371420-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 13:47:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13844

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit aade55c86033bee868a93e4bf3843c9c99e84526 upstream.

Add const qualifier to the device_get_match_data() parameter.
Some of the future users may utilize this function without
forcing the type.

All the same, dev_fwnode() may be used with a const qualifier.

Reported-by: kernel test robot <lkp@intel.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20220922135410.49694-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/base/property.c  | 4 ++--
 include/linux/property.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index cf88a5554d9c..e9fdef1f4517 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -18,7 +18,7 @@
 #include <linux/etherdevice.h>
 #include <linux/phy.h>
 
-struct fwnode_handle *dev_fwnode(struct device *dev)
+struct fwnode_handle *dev_fwnode(const struct device *dev)
 {
 	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
 		&dev->of_node->fwnode : dev->fwnode;
@@ -1179,7 +1179,7 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
 
-const void *device_get_match_data(struct device *dev)
+const void *device_get_match_data(const struct device *dev)
 {
 	return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data, dev);
 }
diff --git a/include/linux/property.h b/include/linux/property.h
index 2d4542629d80..34ac286db88d 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -31,7 +31,7 @@ enum dev_dma_attr {
 	DEV_DMA_COHERENT,
 };
 
-struct fwnode_handle *dev_fwnode(struct device *dev);
+struct fwnode_handle *dev_fwnode(const struct device *dev);
 
 bool device_property_present(struct device *dev, const char *propname);
 int device_property_read_u8_array(struct device *dev, const char *propname,
@@ -379,7 +379,7 @@ bool device_dma_supported(struct device *dev);
 
 enum dev_dma_attr device_get_dma_attr(struct device *dev);
 
-const void *device_get_match_data(struct device *dev);
+const void *device_get_match_data(const struct device *dev);
 
 int device_get_phy_mode(struct device *dev);
 
-- 
2.25.1


