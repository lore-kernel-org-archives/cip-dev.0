Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D7AE8FDB1
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 08:41:50 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40117.1766997708512086359
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 00:41:48 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: 3S+vrFfwRymsh/8w2RuznA==
X-CSE-MsgGUID: WqQNNJKuTSOdScJFq15Sgg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Dec 2025 17:41:47 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.6])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B7255400494A;
	Mon, 29 Dec 2025 17:41:46 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 7/8] net: stmmac: Fix VLAN 0 deletion in vlan_del_hw_rx_fltr()
Date: Mon, 29 Dec 2025 08:41:31 +0000
Message-ID: <20251229084132.3624-8-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251229084132.3624-1-ovidiu.panait.rb@renesas.com>
References: <20251229084132.3624-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 08:41:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21240

commit d9db25723677c3741a0cf3643f7f7429fc983921 upstream.

When the "rx-vlan-filter" feature is enabled on a network device, the 8021q
module automatically adds a VLAN 0 hardware filter when the device is
brought administratively up.

For stmmac, this causes vlan_add_hw_rx_fltr() to create a new entry for
VID 0 in the mac_device_info->vlan_filter array, in the following format:

    VLAN_TAG_DATA_ETV | VLAN_TAG_DATA_VEN | vid

Here, VLAN_TAG_DATA_VEN indicates that the hardware filter is enabled for
that VID.

However, on the delete path, vlan_del_hw_rx_fltr() searches the vlan_filter
array by VID only, without verifying whether a VLAN entry is enabled. As a
result, when the 8021q module attempts to remove VLAN 0, the function may
mistakenly match a zero-initialized slot rather than the actual VLAN 0
entry, causing incorrect deletions and leaving stale entries in the
hardware table.

Fix this by verifying that the VLAN entry's enable bit (VLAN_TAG_DATA_VEN)
is set before matching and deleting by VID. This ensures only active VLAN
entries are removed and avoids leaving stale entries in the VLAN filter
table, particularly for VLAN ID 0.

Fixes: ed64639bc1e08 ("net: stmmac: Add support for VLAN Rx filtering")
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Link: https://patch.msgid.link/20251113112721.70500-2-ovidiu.panait.rb@renesas.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[OP: Applied the fix in dwmac4_del_hw_vlan_rx_fltr() function]
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index e65a65666cc1..4a409ccfb2c7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -570,7 +570,8 @@ static int dwmac4_del_hw_vlan_rx_fltr(struct net_device *dev,
 
 	/* Extended Rx VLAN Filter Enable */
 	for (i = 0; i < hw->num_vlan; i++) {
-		if ((hw->vlan_filter[i] & GMAC_VLAN_TAG_DATA_VID) == vid) {
+		if ((hw->vlan_filter[i] & GMAC_VLAN_TAG_DATA_VEN) &&
+		    (hw->vlan_filter[i] & GMAC_VLAN_TAG_DATA_VID) == vid) {
 			ret = dwmac4_write_vlan_filter(dev, hw, i, 0);
 
 			if (!ret)
-- 
2.51.0


