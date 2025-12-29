Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE87DD3B7E5
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 08:41:40 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40113.1766997695650783994
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 00:41:37 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: 5btH42+bSyy3F4fPZVDRrw==
X-CSE-MsgGUID: 0vgaq3M5RpKwjB9SFQUSpA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Dec 2025 17:41:36 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.6])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A38B44005E3A;
	Mon, 29 Dec 2025 17:41:35 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 1/8] net: phy: add configuration of rx clock stop mode
Date: Mon, 29 Dec 2025 08:41:25 +0000
Message-ID: <20251229084132.3624-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251229084132.3624-1-ovidiu.panait.rb@renesas.com>
References: <20251229084132.3624-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 08:41:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21234

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

commit cf337105ad38564d7855151889a7315da73119d0 upstream.

Add a function to allow configuration of the PCS's clock stop enable
bit, used to configure whether the xMII receive clock can be stopped
during LPI mode.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://patch.msgid.link/E1tVZDR-0002Jl-Ry@rmk-PC.armlinux.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/net/phy/phy.c | 27 ++++++++++++++++++++++-----
 include/linux/phy.h   |  1 +
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 707a6ff5242b..d9afa8374b2f 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1644,6 +1644,27 @@ void phy_mac_interrupt(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(phy_mac_interrupt);
 
+/**
+ * phy_eee_rx_clock_stop() - configure PHY receive clock in LPI
+ * @phydev: target phy_device struct
+ * @clk_stop_enable: flag to indicate whether the clock can be stopped
+ *
+ * Configure whether the PHY can disable its receive clock during LPI mode,
+ * See IEEE 802.3 sections 22.2.2.2, 35.2.2.10, and 45.2.3.1.4.
+ *
+ * Returns: 0 or negative error.
+ */
+int phy_eee_rx_clock_stop(struct phy_device *phydev, bool clk_stop_enable)
+{
+	/* Configure the PHY to stop receiving xMII
+	 * clock while it is signaling LPI.
+	 */
+	return phy_modify_mmd(phydev, MDIO_MMD_PCS, MDIO_CTRL1,
+			      MDIO_PCS_CTRL1_CLKSTOP_EN,
+			      clk_stop_enable ? MDIO_PCS_CTRL1_CLKSTOP_EN : 0);
+}
+EXPORT_SYMBOL_GPL(phy_eee_rx_clock_stop);
+
 /**
  * phy_init_eee - init and check the EEE feature
  * @phydev: target phy_device struct
@@ -1668,11 +1689,7 @@ int phy_init_eee(struct phy_device *phydev, bool clk_stop_enable)
 		return -EPROTONOSUPPORT;
 
 	if (clk_stop_enable)
-		/* Configure the PHY to stop receiving xMII
-		 * clock while it is signaling LPI.
-		 */
-		ret = phy_set_bits_mmd(phydev, MDIO_MMD_PCS, MDIO_CTRL1,
-				       MDIO_PCS_CTRL1_CLKSTOP_EN);
+		ret = phy_eee_rx_clock_stop(phydev, true);
 
 	return ret < 0 ? ret : 0;
 }
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 89aa0df5e5cf..23d6fe246587 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2077,6 +2077,7 @@ int phy_unregister_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask);
 int phy_unregister_fixup_for_id(const char *bus_id);
 int phy_unregister_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask);
 
+int phy_eee_rx_clock_stop(struct phy_device *phydev, bool clk_stop_enable);
 int phy_init_eee(struct phy_device *phydev, bool clk_stop_enable);
 int phy_get_eee_err(struct phy_device *phydev);
 int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_keee *data);
-- 
2.51.0


