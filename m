Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DF5E9271B
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 08:41:50 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40113.1766997695650783994
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 00:41:40 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: x736xlmtTV69VUVHPymnEw==
X-CSE-MsgGUID: 9pufg0xSSiuAc/eBRiP2Ew==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Dec 2025 17:41:40 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.6])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3B565400494A;
	Mon, 29 Dec 2025 17:41:38 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 3/8] net: stmmac: make EEE depend on phy->enable_tx_lpi
Date: Mon, 29 Dec 2025 08:41:27 +0000
Message-ID: <20251229084132.3624-4-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251229084132.3624-1-ovidiu.panait.rb@renesas.com>
References: <20251229084132.3624-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 08:41:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21236

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

commit beb1e0148e6da2534113245cebdfcbb2381b6bca upstream.

Make stmmac EEE depend on phylib's evaluation of user settings and PHY
negotiation, as indicated by phy->enable_tx_lpi. This will ensure when
phylib has evaluated that the user has disabled LPI, phy_init_eee()
will not be called, and priv->eee_active will be false, causing LPI/EEE
to be disabled.

This is an interim measure - phy_init_eee() will be removed in a later
patch.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://patch.msgid.link/E1tVZDm-0002K9-9w@rmk-PC.armlinux.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 61911d9a22d9..4d1acedf9893 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1160,7 +1160,7 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 
 	stmmac_mac_set(priv, priv->ioaddr, true);
 	if (phy && priv->dma_cap.eee) {
-		priv->eee_active =
+		priv->eee_active = phy->enable_tx_lpi &&
 			phy_init_eee(phy, !(priv->plat->flags &
 				STMMAC_FLAG_RX_CLK_RUNS_IN_LPI)) >= 0;
 		priv->tx_lpi_timer = phy->eee_cfg.tx_lpi_timer;
-- 
2.51.0


