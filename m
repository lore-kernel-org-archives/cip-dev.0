Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466E0C19F2E
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 14:58:00 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.12486.1740668248506296267
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 06:57:50 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-CSE-ConnectionGUID: exkkLIGzQB2gGgmec7nG6g==
X-CSE-MsgGUID: 6n6MnG3STbe5sfzwYOBRdw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 27 Feb 2025 23:57:50 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.138])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 86253434774C;
	Thu, 27 Feb 2025 23:57:48 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 11/11] net: ravb: Add VLAN checksum support
Date: Thu, 27 Feb 2025 14:57:20 +0000
Message-ID: <20250227145720.229324-12-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227145720.229324-1-paul.barker.ct@bp.renesas.com>
References: <20250227145720.229324-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 14:58:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17962

commit 546875ccba938ba4f7b5c616a1a1e334c5f2903f upstream.

The GbEth IP supports offloading checksum calculation for VLAN-tagged
packets, provided that the EtherType is 0x8100 and only one VLAN tag is
present.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  1 +
 drivers/net/ethernet/renesas/ravb_main.c | 24 ++++++++++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index bc0b0eca6efd..7dc6e79e34d7 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1053,6 +1053,7 @@ struct ravb_hw_info {
 	size_t gstrings_size;
 	netdev_features_t net_hw_features;
 	netdev_features_t net_features;
+	netdev_features_t vlan_features;
 	int stats_len;
 	u32 tccr_mask;
 	u32 tx_max_frame_size;
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 54e001a00f46..e980c6db54ad 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2041,13 +2041,27 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 
 static bool ravb_can_tx_csum_gbeth(struct sk_buff *skb)
 {
+	u16 net_protocol = ntohs(skb->protocol);
 	u8 inner_protocol;
 
-	/* TODO: Need to add support for VLAN tag 802.1Q */
-	if (skb_vlan_tag_present(skb))
-		return false;
+	/* GbEth IP can calculate the checksum if:
+	 * - there are zero or one VLAN headers with TPID=0x8100
+	 * - the network protocol is IPv4 or IPv6
+	 * - the transport protocol is TCP, UDP or ICMP
+	 * - the packet is not fragmented
+	 */
+
+	if (net_protocol == ETH_P_8021Q) {
+		struct vlan_hdr vhdr, *vh;
+
+		vh = skb_header_pointer(skb, ETH_HLEN, sizeof(vhdr), &vhdr);
+		if (!vh)
+			return false;
+
+		net_protocol = ntohs(vh->h_vlan_encapsulated_proto);
+	}
 
-	switch (ntohs(skb->protocol)) {
+	switch (net_protocol) {
 	case ETH_P_IP:
 		inner_protocol = ip_hdr(skb)->protocol;
 		break;
@@ -2708,6 +2722,7 @@ static const struct ravb_hw_info gbeth_hw_info = {
 	.gstrings_size = sizeof(ravb_gstrings_stats_gbeth),
 	.net_hw_features = NETIF_F_RXCSUM | NETIF_F_HW_CSUM,
 	.net_features = NETIF_F_RXCSUM | NETIF_F_HW_CSUM,
+	.vlan_features = NETIF_F_RXCSUM | NETIF_F_HW_CSUM,
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats_gbeth),
 	.tccr_mask = TCCR_TSRQ0,
 	.tx_max_frame_size = 1522,
@@ -2848,6 +2863,7 @@ static int ravb_probe(struct platform_device *pdev)
 
 	ndev->features = info->net_features;
 	ndev->hw_features = info->net_hw_features;
+	ndev->vlan_features = info->vlan_features;
 
 	error = reset_control_deassert(rstc);
 	if (error)
-- 
2.43.0


