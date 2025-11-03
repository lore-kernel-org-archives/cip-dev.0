Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DA2CCFA07
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 11:38:50 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18672.1762169924690370402
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Nov 2025 03:38:49 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: john.madieu.xa@bp.renesas.com)
X-CSE-ConnectionGUID: RjuAvoYISRuStcUDEV1q8g==
X-CSE-MsgGUID: Ph97PPMQRoeLSs+CY4wAbg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 03 Nov 2025 20:38:49 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.166])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2D53841A027C;
	Mon,  3 Nov 2025 20:38:47 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Subject: [PATCH 6.12.y-cip 17/22] net: stmmac: provide generic implementation for set_clk_tx_rate method
Date: Mon,  3 Nov 2025 12:38:01 +0100
Message-ID: <20251103113817.36331-18-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103113817.36331-1-john.madieu.xa@bp.renesas.com>
References: <20251103113817.36331-1-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Nov 2025 11:38:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20335

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

[ Upstream commit 12bce6d5404ea30180536322c1ad31bc45a988d2 ]

Provide a generic implementation for the set_clk_tx_rate method
introduced by the previous patch, which is capable of configuring the
MAC transmit clock for 10M, 100M and 1000M speeds for at least MII,
GMII, RGMII and RMII interface modes.

Reviewed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/E1tna0K-0052sY-QF@rmk-PC.armlinux.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 32 +++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index ea135203ff2e..7a976aab322f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -421,6 +421,8 @@ int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt);
 int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size);
 int stmmac_bus_clks_config(struct stmmac_priv *priv, bool enabled);
 void stmmac_fpe_apply(struct stmmac_priv *priv);
+int stmmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
+			   phy_interface_t interface, int speed);
 
 static inline bool stmmac_xdp_is_enabled(struct stmmac_priv *priv)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2c2ba1dba80d..557d442c3713 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -179,6 +179,38 @@ int stmmac_bus_clks_config(struct stmmac_priv *priv, bool enabled)
 }
 EXPORT_SYMBOL_GPL(stmmac_bus_clks_config);
 
+/**
+ * stmmac_set_clk_tx_rate() - set the clock rate for the MAC transmit clock
+ * @bsp_priv: BSP private data structure (unused)
+ * @clk_tx_i: the transmit clock
+ * @interface: the selected interface mode
+ * @speed: the speed that the MAC will be operating at
+ *
+ * Set the transmit clock rate for the MAC, normally 2.5MHz for 10Mbps,
+ * 25MHz for 100Mbps and 125MHz for 1Gbps. This is suitable for at least
+ * MII, GMII, RGMII and RMII interface modes. Platforms can hook this into
+ * the plat_data->set_clk_tx_rate method directly, call it via their own
+ * implementation, or implement their own method should they have more
+ * complex requirements. It is intended to only be used in this method.
+ *
+ * plat_data->clk_tx_i must be filled in.
+ */
+int stmmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
+			   phy_interface_t interface, int speed)
+{
+	long rate = rgmii_clock(speed);
+
+	/* Silently ignore unsupported speeds as rgmii_clock() only
+	 * supports 10, 100 and 1000Mbps. We do not want to spit
+	 * errors for 2500 and higher speeds here.
+	 */
+	if (rate < 0)
+		return 0;
+
+	return clk_set_rate(clk_tx_i, rate);
+}
+EXPORT_SYMBOL_GPL(stmmac_set_clk_tx_rate);
+
 /**
  * stmmac_verify_args - verify the driver parameters.
  * Description: it checks the driver parameters and set a default in case of
-- 
2.25.1


