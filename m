Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EF1E8FDB1
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 08:41:40 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40115.1766997699355062179
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 00:41:39 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: 1DZ8R7XAR3ue65xg6OBY4Q==
X-CSE-MsgGUID: G1V9KeJuQI68+KilY56amw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Dec 2025 17:41:38 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.6])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6E7BE4004BDF;
	Mon, 29 Dec 2025 17:41:37 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 2/8] net: stmmac: move tx_lpi_timer tracking to phylib
Date: Mon, 29 Dec 2025 08:41:26 +0000
Message-ID: <20251229084132.3624-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251229084132.3624-1-ovidiu.panait.rb@renesas.com>
References: <20251229084132.3624-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 08:41:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21235

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

commit 1991819debaa22ee75f4163f3b17f9e545f3ae98 upstream.

When stmmac_ethtool_op_get_eee() is called, stmmac sets the tx_lpi_timer
and tx_lpi_enabled members, and then calls into phylink and thus phylib.
phylib overwrites these members.

phylib will also cause a link down/link up transition when settings
that impact the MAC have been changed.

Convert stmmac to use the tx_lpi_timer setting in struct phy_device,
updating priv->tx_lpi_timer each time when the link comes up, rather
than trying to maintain this user setting itself. We initialise the
phylib tx_lpi_timer setting by doing a get_ee-modify-set_eee sequence
with the last known priv->tx_lpi_timer value. In order for this to work
correctly, we also need this member to be initialised earlier.

As stmmac_eee_init() is no longer called outside of stmmac_main.c, make
it static.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://patch.msgid.link/E1tVZDW-0002Jr-W3@rmk-PC.armlinux.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 -
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 14 +------------
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 21 ++++++++++++++-----
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 7a976aab322f..d3badbdad5cb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -416,7 +416,6 @@ int stmmac_dvr_probe(struct device *device,
 		     struct plat_stmmacenet_data *plat_dat,
 		     struct stmmac_resources *res);
 void stmmac_disable_eee_mode(struct stmmac_priv *priv);
-bool stmmac_eee_init(struct stmmac_priv *priv);
 int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt);
 int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size);
 int stmmac_bus_clks_config(struct stmmac_priv *priv, bool enabled);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 2a37592a6281..9a9630ad11e2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -898,7 +898,6 @@ static int stmmac_ethtool_op_get_eee(struct net_device *dev,
 	if (!priv->dma_cap.eee)
 		return -EOPNOTSUPP;
 
-	edata->tx_lpi_timer = priv->tx_lpi_timer;
 	edata->tx_lpi_enabled = priv->tx_lpi_enabled;
 
 	return phylink_ethtool_get_eee(priv->phylink, edata);
@@ -908,7 +907,6 @@ static int stmmac_ethtool_op_set_eee(struct net_device *dev,
 				     struct ethtool_keee *edata)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
-	int ret;
 
 	if (!priv->dma_cap.eee)
 		return -EOPNOTSUPP;
@@ -920,17 +918,7 @@ static int stmmac_ethtool_op_set_eee(struct net_device *dev,
 	if (!edata->eee_enabled)
 		stmmac_disable_eee_mode(priv);
 
-	ret = phylink_ethtool_set_eee(priv->phylink, edata);
-	if (ret)
-		return ret;
-
-	if (edata->eee_enabled &&
-	    priv->tx_lpi_timer != edata->tx_lpi_timer) {
-		priv->tx_lpi_timer = edata->tx_lpi_timer;
-		stmmac_eee_init(priv);
-	}
-
-	return 0;
+	return phylink_ethtool_set_eee(priv->phylink, edata);
 }
 
 static u32 stmmac_usec2riwt(u32 usec, struct stmmac_priv *priv)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e330e698b3f1..61911d9a22d9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -499,7 +499,7 @@ static void stmmac_eee_ctrl_timer(struct timer_list *t)
  *  can also manage EEE, this function enable the LPI state and start related
  *  timer.
  */
-bool stmmac_eee_init(struct stmmac_priv *priv)
+static bool stmmac_eee_init(struct stmmac_priv *priv)
 {
 	int eee_tw_timer = priv->eee_tw_timer;
 
@@ -1163,6 +1163,7 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 		priv->eee_active =
 			phy_init_eee(phy, !(priv->plat->flags &
 				STMMAC_FLAG_RX_CLK_RUNS_IN_LPI)) >= 0;
+		priv->tx_lpi_timer = phy->eee_cfg.tx_lpi_timer;
 		priv->eee_enabled = stmmac_eee_init(priv);
 		priv->tx_lpi_enabled = priv->eee_enabled;
 		stmmac_set_eee_pls(priv, priv->hw, true);
@@ -1262,6 +1263,16 @@ static int stmmac_init_phy(struct net_device *dev)
 		ret = phylink_fwnode_phy_connect(priv->phylink, fwnode, 0);
 	}
 
+	if (ret == 0) {
+		struct ethtool_keee eee;
+
+		/* Configure phylib's copy of the LPI timer */
+		if (!phylink_ethtool_get_eee(priv->phylink, &eee)) {
+			eee.tx_lpi_timer = priv->tx_lpi_timer;
+			phylink_ethtool_set_eee(priv->phylink, &eee);
+		}
+	}
+
 	if (!priv->plat->pmt) {
 		struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
 
@@ -3515,10 +3526,6 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 
 	priv->eee_tw_timer = STMMAC_DEFAULT_TWT_LS;
 
-	/* Convert the timer from msec to usec */
-	if (!priv->tx_lpi_timer)
-		priv->tx_lpi_timer = eee_timer * 1000;
-
 	if (priv->use_riwt) {
 		u32 queue;
 
@@ -3982,6 +3989,10 @@ static int __stmmac_open(struct net_device *dev,
 	u32 chan;
 	int ret;
 
+	/* Initialise the tx lpi timer, converting from msec to usec */
+	if (!priv->tx_lpi_timer)
+		priv->tx_lpi_timer = eee_timer * 1000;
+
 	ret = pm_runtime_resume_and_get(priv->device);
 	if (ret < 0)
 		return ret;
-- 
2.51.0


