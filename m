Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F20AC77B7F
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 08:21:37 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.20937.1684484491304088301
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 May 2023 01:21:33 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,176,1681138800"; 
   d="scan'208";a="159963188"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 19 May 2023 17:21:33 +0900
Received: from localhost.localdomain (unknown [10.226.93.34])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4C5D2419EC47;
	Fri, 19 May 2023 17:21:31 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 12/23] driver core: add a helper to setup both the of_node and fwnode of a device
Date: Fri, 19 May 2023 09:20:47 +0100
Message-Id: <20230519082058.109760-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
References: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 08:21:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11544

From: Ioana Ciornei <ioana.ciornei@nxp.com>

commit 43e76d463c09a0272b84775bcc727c1eb8b384b2 upstream.

There are many places where both the fwnode_handle and the of_node of a
device need to be populated. Add a function which does both so that we
have consistency.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/base/core.c    | 7 +++++++
 include/linux/device.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 9a874a58d690..cb859febd03c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4352,6 +4352,13 @@ void device_set_of_node_from_dev(struct device *dev, const struct device *dev2)
 }
 EXPORT_SYMBOL_GPL(device_set_of_node_from_dev);
 
+void device_set_node(struct device *dev, struct fwnode_handle *fwnode)
+{
+	dev->fwnode = fwnode;
+	dev->of_node = to_of_node(fwnode);
+}
+EXPORT_SYMBOL_GPL(device_set_node);
+
 int device_match_name(struct device *dev, const void *name)
 {
 	return sysfs_streq(dev_name(dev), name);
diff --git a/include/linux/device.h b/include/linux/device.h
index 5dc0f81e4f9d..4f7e0c85e11f 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -818,6 +818,7 @@ int device_online(struct device *dev);
 void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
 void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
 void device_set_of_node_from_dev(struct device *dev, const struct device *dev2);
+void device_set_node(struct device *dev, struct fwnode_handle *fwnode);
 
 static inline int dev_num_vf(struct device *dev)
 {
-- 
2.25.1


