Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7884E9272A
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 08:41:50 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40113.1766997695650783994
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 00:41:46 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: +1YkhgAsRaSLrTRQuOIQZw==
X-CSE-MsgGUID: RWA4lF1xRAOV4ndKlx0Tqg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Dec 2025 17:41:46 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.6])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id EDB76400494A;
	Mon, 29 Dec 2025 17:41:44 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 6/8] net: stmmac: convert to use phy_eee_rx_clock_stop()
Date: Mon, 29 Dec 2025 08:41:30 +0000
Message-ID: <20251229084132.3624-7-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251229084132.3624-1-ovidiu.panait.rb@renesas.com>
References: <20251229084132.3624-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 08:41:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21239

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

commit a3242177d9f215e5d13e69fdb279a5ce2237ba84 upstream.

Convert stmmac to use phy_eee_rx_clock_stop() to set the PHY receive
clock stop in LPI setting, rather than calling the legacy
phy_init_eee() function.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://patch.msgid.link/E1tVZEB-0002Ke-RZ@rmk-PC.armlinux.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9ecf45e37799..fcf821394616 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1159,10 +1159,10 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 
 	stmmac_mac_set(priv, priv->ioaddr, true);
 	if (phy && priv->dma_cap.eee) {
-		priv->eee_active = phy->enable_tx_lpi &&
-			phy_init_eee(phy, !(priv->plat->flags &
-				STMMAC_FLAG_RX_CLK_RUNS_IN_LPI)) >= 0;
+		phy_eee_rx_clock_stop(phy, !(priv->plat->flags &
+					     STMMAC_FLAG_RX_CLK_RUNS_IN_LPI));
 		priv->tx_lpi_timer = phy->eee_cfg.tx_lpi_timer;
+		priv->eee_active = phy->enable_tx_lpi;
 		priv->eee_enabled = stmmac_eee_init(priv);
 		stmmac_set_eee_pls(priv, priv->hw, true);
 	}
-- 
2.51.0


