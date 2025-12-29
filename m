Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1727E9271B
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 08:40:00 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40093.1766997599087274958
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 00:39:59 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: 4ACLIiTTQ5q+P7gauumOUw==
X-CSE-MsgGUID: NOq1IVCzRHizMyxmUkLyiw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Dec 2025 17:39:58 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.6])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 55A944005E3A;
	Mon, 29 Dec 2025 17:39:57 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 1/3] net: phy: add configuration of rx clock stop mode
Date: Mon, 29 Dec 2025 08:39:51 +0000
Message-ID: <20251229083954.3598-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251229083954.3598-1-ovidiu.panait.rb@renesas.com>
References: <20251229083954.3598-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 08:40:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21224

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
[OP: Added error handling and called phy_eee_rx_clock_stop()
     unconditionally to clear clock stop bits when disabled.]
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/net/phy/phy.c | 32 ++++++++++++++++++++++++++------
 include/linux/phy.h   |  1 +
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index d1aea767ed09..8448686d3b17 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1297,6 +1297,27 @@ static void mmd_eee_adv_to_linkmode(unsigned long *advertising, u16 eee_adv)
 				 advertising);
 }
 
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
@@ -1309,6 +1330,8 @@ static void mmd_eee_adv_to_linkmode(unsigned long *advertising, u16 eee_adv)
  */
 int phy_init_eee(struct phy_device *phydev, bool clk_stop_enable)
 {
+	int ret;
+
 	if (!phydev->drv)
 		return -EIO;
 
@@ -1354,12 +1377,9 @@ int phy_init_eee(struct phy_device *phydev, bool clk_stop_enable)
 		if (!phy_check_valid(phydev->speed, phydev->duplex, common))
 			goto eee_exit_err;
 
-		if (clk_stop_enable)
-			/* Configure the PHY to stop receiving xMII
-			 * clock while it is signaling LPI.
-			 */
-			phy_set_bits_mmd(phydev, MDIO_MMD_PCS, MDIO_CTRL1,
-					 MDIO_PCS_CTRL1_CLKSTOP_EN);
+		ret = phy_eee_rx_clock_stop(phydev, clk_stop_enable);
+		if (ret < 0)
+			return ret;
 
 		return 0; /* EEE supported */
 	}
diff --git a/include/linux/phy.h b/include/linux/phy.h
index a8c6e3c29ed6..3d97a222f9b1 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1765,6 +1765,7 @@ int phy_unregister_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask);
 int phy_unregister_fixup_for_id(const char *bus_id);
 int phy_unregister_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask);
 
+int phy_eee_rx_clock_stop(struct phy_device *phydev, bool clk_stop_enable);
 int phy_init_eee(struct phy_device *phydev, bool clk_stop_enable);
 int phy_get_eee_err(struct phy_device *phydev);
 int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_eee *data);
-- 
2.51.0


