Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321F0C3DA49
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 08:23:08 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.5818.1721118180107077795
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 01:23:01 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="211467674"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Jul 2024 17:23:01 +0900
Received: from localhost.localdomain (unknown [10.226.92.125])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8CA294005B53;
	Tue, 16 Jul 2024 17:22:59 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 01/31] mfd: core: Delete corresponding OF node entries from list on MFD removal
Date: Tue, 16 Jul 2024 09:22:12 +0100
Message-ID: <20240716082255.56551-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
References: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 08:23:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16527

From: Michal Oleszczyk <oleszczyk.m@gmail.com>

commit 8e88c61d6f3432f27a2c6b8bc58ae4fe974f4b6d upstream.

When we consider MFD which implements hotplug (e.g. USB hotplug
driver based on product and vendor IDs) functionality it turns out
that its sub-devices are correctly matched with corresponding device
tree nodes only at the first time. When physical device reboots
or is replugged (and MFD driver is disconnected and probed back
again) all sub-devices fails in mfd_add_device() with error
'Failed to locate of_node'.

The reason of that behavior is that when any MFD sub-device is
created for the first time (and matched with device tree node) it
is added to the mfd_of_node_list. It looks like this list is never
cleaned even if devices added there are intentionally removed from
the system. So when MFD device is replugged and all sub-devices
are matched with their device tree nodes again they fail as matched
nodes already exist in mfd_of_node_list. In other words current
implementation does not support MFD with hotplug feature.

This commit extends MFD core for hotplugging support by removing
appropriate OF node entry from mfd_of_node_list when corresponding
device is removed from the system. Thanks to that when device is
added once again it can be matched with its device tree node
successfully.

Signed-off-by: Michal Oleszczyk <oleszczyk.m@gmail.com>
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/20220809060336.31892-1-m.oleszczyk@grinn-global.com
[biju: Same behaviour during bind/unbind]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mfd/mfd-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index c0083e38d527..e81128143b5b 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -367,6 +367,7 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
 {
 	struct platform_device *pdev;
 	const struct mfd_cell *cell;
+	struct mfd_of_node_entry *of_entry, *tmp;
 	int *level = data;
 
 	if (dev->type != &mfd_dev_type)
@@ -378,6 +379,12 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
 	if (level && cell->level > *level)
 		return 0;
 
+	list_for_each_entry_safe(of_entry, tmp, &mfd_of_node_list, list)
+		if (of_entry->dev == &pdev->dev) {
+			list_del(&of_entry->list);
+			kfree(of_entry);
+		}
+
 	regulator_bulk_unregister_supply_alias(dev, cell->parent_supplies,
 					       cell->num_parent_supplies);
 
-- 
2.43.0


