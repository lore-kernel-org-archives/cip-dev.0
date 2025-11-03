Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D07CCFA08
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 11:36:50 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18460.1762169800316022948
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Nov 2025 03:36:43 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: john.madieu.xa@bp.renesas.com)
X-CSE-ConnectionGUID: NGIBVhUVQfiBUGJfmoqM5g==
X-CSE-MsgGUID: q4/y50AaRImfgcQAoKX6cw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 03 Nov 2025 20:36:43 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.166])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 04085400942A;
	Mon,  3 Nov 2025 20:36:41 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Subject: [PATCH 6.1.y-cip 19/25] net: stmmac: provide set_clk_tx_rate() hook
Date: Mon,  3 Nov 2025 12:35:52 +0100
Message-ID: <20251103113608.36240-20-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
References: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Nov 2025 11:36:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20311

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

[ Upstream commit dea5c8ec20be7603e4a56b9d6571321f330626c1 ]

Several stmmac sub-drivers which support RGMII follow the same pattern.
They calculate the transmit clock rate, and then call clk_set_rate().

Analysis of several implementation documents suggests that the platform
is responsible for providing the transmit clock to the DWMAC core's
clk_tx_i. The expected rates are:

	10Mbps	100Mbps	1Gbps
MII	2.5MHz	25MHz
RMII	2.5MHz	25MHz
GMII			125MHz
RGMI	2.5MHz	25MHz	125MHz

It seems some platforms require this clock to be manually configured,
but there are outputs from the MAC core that indicate the speed, so a
platform may use these to automatically configure the clock. Thus, we
can't just provide one solution to configure this clock rate.

Moreover, the clock may need to be derived from one of several sources
depending on the interface mode.

Provide a platform hook that is passed the transmit clock, interface
mode and speed.

Reviewed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/E1tna0F-0052sS-Lr@rmk-PC.armlinux.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[john.madieu
 - Re-ordered structure fields]
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 +++++++++++
 include/linux/stmmac.h                            |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index be84aed47160..bd0524213933 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -993,6 +993,7 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 {
 	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
 	u32 old_ctrl, ctrl;
+	int ret;
 
 	old_ctrl = readl(priv->ioaddr + MAC_CTRL_REG);
 	ctrl = old_ctrl & ~priv->hw->link.speed_mask;
@@ -1081,6 +1082,16 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 	if (ctrl != old_ctrl)
 		writel(ctrl, priv->ioaddr + MAC_CTRL_REG);
 
+	if (priv->plat->set_clk_tx_rate) {
+		ret = priv->plat->set_clk_tx_rate(priv->plat->bsp_priv,
+						priv->plat->clk_tx_i,
+						interface, speed);
+		if (ret < 0)
+			netdev_err(priv->dev,
+				   "failed to configure transmit clock for %dMbps: %pe\n",
+				   speed, ERR_PTR(ret));
+	}
+
 	stmmac_mac_set(priv, priv->ioaddr, true);
 	if (phy && priv->dma_cap.eee) {
 		priv->eee_active =
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 9f4a4f70270d..c9b0cd32fde3 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -76,6 +76,8 @@
 			| DMA_AXI_BLEN_32 | DMA_AXI_BLEN_64 \
 			| DMA_AXI_BLEN_128 | DMA_AXI_BLEN_256)
 
+struct clk;
+
 /* Platfrom data for platform device structure's platform_data field */
 
 struct stmmac_mdio_bus_data {
@@ -223,6 +225,8 @@ struct plat_stmmacenet_data {
 	u8 tx_sched_algorithm;
 	struct stmmac_rxq_cfg rx_queues_cfg[MTL_MAX_RX_QUEUES];
 	struct stmmac_txq_cfg tx_queues_cfg[MTL_MAX_TX_QUEUES];
+	int (*set_clk_tx_rate)(void *priv, struct clk *clk_tx_i,
+			       phy_interface_t interface, int speed);
 	void (*fix_mac_speed)(void *priv, unsigned int speed);
 	int (*serdes_powerup)(struct net_device *ndev, void *priv);
 	void (*serdes_powerdown)(struct net_device *ndev, void *priv);
@@ -239,6 +243,7 @@ struct plat_stmmacenet_data {
 	struct clk *stmmac_clk;
 	struct clk *pclk;
 	struct clk *clk_ptp_ref;
+	struct clk *clk_tx_i;		/* clk_tx_i to MAC core */
 	unsigned int clk_ptp_rate;
 	unsigned int clk_ref_rate;
 	unsigned int mult_fact_100ns;
-- 
2.25.1


