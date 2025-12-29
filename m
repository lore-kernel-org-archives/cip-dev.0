Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D18D3B7E5
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 08:41:50 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40113.1766997695650783994
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 00:41:50 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: FahOz5aGT+aEtkWf1svibA==
X-CSE-MsgGUID: kqHkwcRKRlau0HPXiJ73DA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Dec 2025 17:41:49 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.6])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 81BE04005E3A;
	Mon, 29 Dec 2025 17:41:48 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 8/8] net: stmmac: Disable EEE RX clock stop when VLAN is enabled
Date: Mon, 29 Dec 2025 08:41:32 +0000
Message-ID: <20251229084132.3624-9-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251229084132.3624-1-ovidiu.panait.rb@renesas.com>
References: <20251229084132.3624-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 08:41:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21241

commit c171e679ee66d7c0e2b58db9531af96797a76bca upstream.

On the Renesas RZ/V2H EVK platform, where the stmmac MAC is connected to a
Microchip KSZ9131RNXI PHY, creating or deleting VLAN interfaces may fail
with timeouts:

    # ip link add link end1 name end1.5 type vlan id 5
    15c40000.ethernet end1: Timeout accessing MAC_VLAN_Tag_Filter
    RTNETLINK answers: Device or resource busy

Disabling EEE at runtime avoids the problem:

    # ethtool --set-eee end1 eee off
    # ip link add link end1 name end1.5 type vlan id 5
    # ip link del end1.5

The stmmac hardware requires the receive clock to be running when writing
certain registers, such as those used for MAC address configuration or
VLAN filtering. However, by default the driver enables Energy Efficient
Ethernet (EEE) and allows the PHY to stop the receive clock when the link
is idle. As a result, the RX clock might be stopped when attempting to
access these registers, leading to timeouts and other issues.

Commit dd557266cf5fb ("net: stmmac: block PHY RXC clock-stop")
addressed this issue for most register accesses by wrapping them in
phylink_rx_clk_stop_block()/phylink_rx_clk_stop_unblock() calls.
However, VLAN add/delete operations may be invoked with bottom halves
disabled, where sleeping is not allowed, so using these helpers is not
possible.

Therefore, to fix this, disable the RX clock stop feature in the phylink
configuration if VLAN features are set. This ensures the RX clock remains
active and register accesses succeed during VLAN operations.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://patch.msgid.link/20251113112721.70500-3-ovidiu.panait.rb@renesas.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[OP: Phylink-managed EEE RX clock-stop control is not available in 6.12.
     Adapt the fix to use the existing RX clock-stop handling in
     stmmac_mac_link_up()]
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fcf821394616..6fffca5bff18 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1159,8 +1159,14 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 
 	stmmac_mac_set(priv, priv->ioaddr, true);
 	if (phy && priv->dma_cap.eee) {
-		phy_eee_rx_clock_stop(phy, !(priv->plat->flags &
-					     STMMAC_FLAG_RX_CLK_RUNS_IN_LPI));
+		/* Disable EEE RX clock stop to ensure VLAN register access works
+		 * correctly.
+		 */
+		bool clk_stop_enable =
+			!(priv->plat->flags & STMMAC_FLAG_RX_CLK_RUNS_IN_LPI) &&
+			!(priv->dev->features & NETIF_F_VLAN_FEATURES);
+
+		phy_eee_rx_clock_stop(phy, clk_stop_enable);
 		priv->tx_lpi_timer = phy->eee_cfg.tx_lpi_timer;
 		priv->eee_active = phy->enable_tx_lpi;
 		priv->eee_enabled = stmmac_eee_init(priv);
-- 
2.51.0


