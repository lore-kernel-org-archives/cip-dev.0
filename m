Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C016EE8FDB1
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 08:40:00 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40083.1766997598492293871
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 00:39:58 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: dug5YrAzQ8CyzFt8UqewVg==
X-CSE-MsgGUID: 5bWw8CMiQpKz+OgoYAM3vQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Dec 2025 17:39:56 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.6])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 89437400494A;
	Mon, 29 Dec 2025 17:39:55 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 0/3] net: stmmac: Fix EEE-related issues
Date: Mon, 29 Dec 2025 08:39:50 +0000
Message-ID: <20251229083954.3598-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 08:40:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21223

Hi,

When testing Ethernet on the Renesas RZ/V2H and RZ/V2N platforms with
6.1-cip, LPI interrupt storms and VLAN register access timeouts were
observed.

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
relevant stmmac EEE fixes to 6.1-cip.

Best regards,
Ovidiu


Ovidiu Panait (2):
  net: stmmac: Fix VLAN 0 deletion in vlan_del_hw_rx_fltr()
  net: stmmac: Disable EEE RX clock stop when VLAN is enabled

Russell King (Oracle) (1):
  net: phy: add configuration of rx clock stop mode

 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  3 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  8 ++++-
 drivers/net/phy/phy.c                         | 32 +++++++++++++++----
 include/linux/phy.h                           |  1 +
 4 files changed, 36 insertions(+), 8 deletions(-)

-- 
2.51.0


