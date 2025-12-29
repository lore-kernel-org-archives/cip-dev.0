Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8C7E9271B
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 08:41:40 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40113.1766997695650783994
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 00:41:35 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: uwufWozqSsmZsH90RMl9lA==
X-CSE-MsgGUID: rmDn9GPQRLOF5gOV/baORg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Dec 2025 17:41:35 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.6])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id DACD84005E3A;
	Mon, 29 Dec 2025 17:41:33 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 0/8] net: stmmac: Fix EEE-related issues
Date: Mon, 29 Dec 2025 08:41:24 +0000
Message-ID: <20251229084132.3624-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 08:41:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21233

Hi,

The following EEE-related issues were observed on the Renesas RZ/V2H and
RZ/V2N platforms with 6.12-cip:

1. EEE is enabled despite ethtool reporting it as disabled

   When running `ethtool --show-eee end0` after boot, ethtool shows EEE as
   disabled but LPI interrupts are increasing, indicating EEE is
   actually active.

2. LPI interrupt storms and VLAN register access timeouts

   Both issues are caused by the RX clock stop feature being enabled by
   default. When EEE is active and the link is idle, the PHY stops the
   RX clock to save power. However, the stmmac hardware requires the RX
   clock to be running when accessing certain registers.

   More specifically, VLAN operations fail with:

       # ip link add link end1 name end1.5 type vlan id 5
       15c40000.ethernet end1: Timeout accessing MAC_VLAN_Tag_Filter
       RTNETLINK answers: Device or resource busy

   Also, LPI interrupt storms occur because the RX clock may be stopped when
   the driver attempts to clear the pending interrupt. The interrupt is
   not cleared and keeps re-triggering until the RX clock resumes.

   A comprehensive overview of RX clock related issues in stmmac can be
   found in these threads:
   https://lore.kernel.org/all/20251026122905.29028-1-laurent.pinchart@ideasonboard.com/
   https://lore.kernel.org/all/Z9ySeo61VYTClIJJ@shell.armlinux.org.uk/

These issues are already fixed in mainline. This series backports the
relevant stmmac EEE fixes to 6.12-cip.

Best regards,
Ovidiu


Ovidiu Panait (2):
  net: stmmac: Fix VLAN 0 deletion in vlan_del_hw_rx_fltr()
  net: stmmac: Disable EEE RX clock stop when VLAN is enabled

Russell King (Oracle) (6):
  net: phy: add configuration of rx clock stop mode
  net: stmmac: move tx_lpi_timer tracking to phylib
  net: stmmac: make EEE depend on phy->enable_tx_lpi
  net: stmmac: remove redundant code from ethtool EEE ops
  net: stmmac: remove priv->tx_lpi_enabled
  net: stmmac: convert to use phy_eee_rx_clock_stop()

 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  3 --
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 23 +-----------
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 37 +++++++++++++------
 drivers/net/phy/phy.c                         | 27 +++++++++++---
 include/linux/phy.h                           |  1 +
 6 files changed, 52 insertions(+), 42 deletions(-)

-- 
2.51.0


