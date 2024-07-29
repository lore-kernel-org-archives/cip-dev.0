Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C566AC3DA4A
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 15:01:08 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.58080.1722265258132494915
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jul 2024 08:01:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,246,1716217200"; 
   d="scan'208";a="213907156"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 30 Jul 2024 00:01:04 +0900
Received: from ree-du1sdd5.ree.adwin.renesas.com (unknown [10.226.105.7])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4A0CA401849C;
	Tue, 30 Jul 2024 00:01:02 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y cip 5/8] net: add netdev_sw_irq_coalesce_default_on()
Date: Mon, 29 Jul 2024 15:00:46 +0000
Message-Id: <20240729150049.1924352-6-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240729150049.1924352-1-paul.barker.ct@bp.renesas.com>
References: <20240729150049.1924352-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jul 2024 15:01:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16650

From: Heiner Kallweit <hkallweit1@gmail.com>

commit d93607082e982223cf92750f2d9039ff365b9d24 upstream.

Add a helper for drivers wanting to set SW IRQ coalescing
by default. The related sysfs attributes can be used to
override the default values.

Follow Jakub's suggestion and put this functionality into
net core so that drivers wanting to use software interrupt
coalescing per default don't have to open-code it.

Note that this function needs to be called before the
netdevice is registered.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 include/linux/netdevice.h |  1 +
 net/core/dev.c            | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0373e0935990..ca90dfb71299 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -78,6 +78,7 @@ struct xdp_buff;
 void synchronize_net(void);
 void netdev_set_default_ethtool_ops(struct net_device *dev,
 				    const struct ethtool_ops *ops);
+void netdev_sw_irq_coalesce_default_on(struct net_device *dev);
 
 /* Backlog congestion levels */
 #define NET_RX_SUCCESS		0	/* keep 'em coming, baby */
diff --git a/net/core/dev.c b/net/core/dev.c
index 20d8b9195ef6..895082bd254b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10570,6 +10570,22 @@ void netdev_set_default_ethtool_ops(struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(netdev_set_default_ethtool_ops);
 
+/**
+ * netdev_sw_irq_coalesce_default_on() - enable SW IRQ coalescing by default
+ * @dev: netdev to enable the IRQ coalescing on
+ *
+ * Sets a conservative default for SW IRQ coalescing. Users can use
+ * sysfs attributes to override the default values.
+ */
+void netdev_sw_irq_coalesce_default_on(struct net_device *dev)
+{
+	WARN_ON(dev->reg_state == NETREG_REGISTERED);
+
+	dev->gro_flush_timeout = 20000;
+	dev->napi_defer_hard_irqs = 1;
+}
+EXPORT_SYMBOL_GPL(netdev_sw_irq_coalesce_default_on);
+
 void netdev_freemem(struct net_device *dev)
 {
 	char *addr = (char *)dev - dev->padded;
-- 
2.25.1


