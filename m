Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A752C83F1A
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:09:20 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.74789.1752487749111177872
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:09:11 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: fgKxhnxwQFG4QY7tUf1Zmw==
X-CSE-MsgGUID: Cjfbm5WDRNem2PZGjgg+Ww==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2025 19:09:10 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1A8EA41D4BDF;
	Mon, 14 Jul 2025 19:09:08 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 31/57] can: rcar_canfd: Add transceiver support
Date: Mon, 14 Jul 2025 11:07:12 +0100
Message-ID: <20250714100802.80035-32-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:09:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19459

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit a0340df7eca4f28e18afd3ecd6e464db5f2994c0 upstream.

Add support for CAN transceivers described as PHYs.

While simple CAN transceivers can do without, this is needed for CAN
transceivers like NXP TJR1443 that need a configuration step (like
pulling standby or enable lines), and/or impose a bitrate limit.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/1ce907572ac1d4e1733fa6ea7712250f2229cfcb.1679414936.git.geert+renesas@glider.be
[mkl: squash error message update from patch 2]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index a2b0f657dc76..993e1d34d843 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -35,6 +35,7 @@
 #include <linux/netdevice.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/types.h>
@@ -530,6 +531,7 @@ struct rcar_canfd_channel {
 	struct net_device *ndev;
 	struct rcar_canfd_global *gpriv;	/* Controller reference */
 	void __iomem *base;			/* Register base address */
+	struct phy *transceiver;		/* Optional transceiver */
 	struct napi_struct napi;
 	u32 tx_head;				/* Incremented on xmit */
 	u32 tx_tail;				/* Incremented on xmit done */
@@ -1405,11 +1407,17 @@ static int rcar_canfd_open(struct net_device *ndev)
 	struct rcar_canfd_global *gpriv = priv->gpriv;
 	int err;
 
+	err = phy_power_on(priv->transceiver);
+	if (err) {
+		netdev_err(ndev, "failed to power on PHY: %pe\n", ERR_PTR(err));
+		return err;
+	}
+
 	/* Peripheral clock is already enabled in probe */
 	err = clk_prepare_enable(gpriv->can_clk);
 	if (err) {
 		netdev_err(ndev, "failed to enable CAN clock, error %d\n", err);
-		goto out_clock;
+		goto out_phy;
 	}
 
 	err = open_candev(ndev);
@@ -1429,7 +1437,8 @@ static int rcar_canfd_open(struct net_device *ndev)
 	close_candev(ndev);
 out_can_clock:
 	clk_disable_unprepare(gpriv->can_clk);
-out_clock:
+out_phy:
+	phy_power_off(priv->transceiver);
 	return err;
 }
 
@@ -1472,6 +1481,7 @@ static int rcar_canfd_close(struct net_device *ndev)
 	napi_disable(&priv->napi);
 	clk_disable_unprepare(gpriv->can_clk);
 	close_candev(ndev);
+	phy_power_off(priv->transceiver);
 	return 0;
 }
 
@@ -1703,7 +1713,7 @@ static const struct ethtool_ops rcar_canfd_ethtool_ops = {
 };
 
 static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
-				    u32 fcan_freq)
+				    u32 fcan_freq, struct phy *transceiver)
 {
 	const struct rcar_canfd_hw_info *info = gpriv->info;
 	struct platform_device *pdev = gpriv->pdev;
@@ -1724,8 +1734,11 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 	ndev->flags |= IFF_ECHO;
 	priv->ndev = ndev;
 	priv->base = gpriv->base;
+	priv->transceiver = transceiver;
 	priv->channel = ch;
 	priv->gpriv = gpriv;
+	if (transceiver)
+		priv->can.bitrate_max = transceiver->attrs.max_link_rate;
 	priv->can.clock.freq = fcan_freq;
 	dev_info(dev, "can_clk rate is %u\n", priv->can.clock.freq);
 
@@ -1828,6 +1841,7 @@ static void rcar_canfd_channel_remove(struct rcar_canfd_global *gpriv, u32 ch)
 
 static int rcar_canfd_probe(struct platform_device *pdev)
 {
+	struct phy *transceivers[RCANFD_NUM_CHANNELS] = { 0, };
 	const struct rcar_canfd_hw_info *info;
 	struct device *dev = &pdev->dev;
 	void __iomem *addr;
@@ -1850,9 +1864,14 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	for (i = 0; i < info->max_channels; ++i) {
 		name[7] = '0' + i;
 		of_child = of_get_child_by_name(dev->of_node, name);
-		if (of_child && of_device_is_available(of_child))
+		if (of_child && of_device_is_available(of_child)) {
 			channels_mask |= BIT(i);
+			transceivers[i] = devm_of_phy_optional_get(dev,
+							of_child, NULL);
+		}
 		of_node_put(of_child);
+		if (IS_ERR(transceivers[i]))
+			return PTR_ERR(transceivers[i]);
 	}
 
 	if (info->shared_global_irqs) {
@@ -2029,7 +2048,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	}
 
 	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels) {
-		err = rcar_canfd_channel_probe(gpriv, ch, fcan_freq);
+		err = rcar_canfd_channel_probe(gpriv, ch, fcan_freq,
+					       transceivers[ch]);
 		if (err)
 			goto fail_channel;
 	}
-- 
2.43.0


