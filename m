Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AECC1B0FF
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 15:34:50 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.13489.1740670477142947630
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 07:34:48 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-CSE-ConnectionGUID: txQwVGiUQL+3hwlNRkhYTQ==
X-CSE-MsgGUID: aEDQE/whSka6aln78mL97w==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2025 00:34:48 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.138])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9AD2E402CEAD;
	Fri, 28 Feb 2025 00:34:46 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 11/12] net: ravb: Enable IPv6 TX checksum offload for GbEth
Date: Thu, 27 Feb 2025 15:34:12 +0000
Message-ID: <20250227153413.686812-12-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227153413.686812-1-paul.barker.ct@bp.renesas.com>
References: <20250227153413.686812-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 15:34:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17975

commit 85c171509821af048a45b435e0fac36edba6a0cb upstream.

The GbEth IP supports offloading IPv6 TCP, UDP & ICMPv6 checksums in the
TX path.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c | 15 +++++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 9ecf190964d8..92a5d35ada2d 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -997,7 +997,7 @@ enum CSR1_BIT {
 	CSR1_TDHD	= 0x08000000,
 };
 
-#define CSR1_CSUM_ENABLE (CSR1_TTCP4 | CSR1_TUDP4)
+#define CSR1_CSUM_ENABLE (CSR1_TTCP4 | CSR1_TUDP4 | CSR1_TTCP6 | CSR1_TUDP6)
 
 enum CSR2_BIT {
 	CSR2_RIP4	= 0x00000001,
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 2a9566d3af5c..6712f38d2df8 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2079,17 +2079,24 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 
 static bool ravb_can_tx_csum_gbeth(struct sk_buff *skb)
 {
-	struct iphdr *ip = ip_hdr(skb);
+	u8 inner_protocol;
 
 	/* TODO: Need to add support for VLAN tag 802.1Q */
 	if (skb_vlan_tag_present(skb))
 		return false;
 
-	/* TODO: Need to add hardware checksum for IPv6 */
-	if (skb->protocol != htons(ETH_P_IP))
+	switch (ntohs(skb->protocol)) {
+	case ETH_P_IP:
+		inner_protocol = ip_hdr(skb)->protocol;
+		break;
+	case ETH_P_IPV6:
+		inner_protocol = ipv6_hdr(skb)->nexthdr;
+		break;
+	default:
 		return false;
+	}
 
-	switch (ip->protocol) {
+	switch (inner_protocol) {
 	case IPPROTO_TCP:
 	case IPPROTO_UDP:
 		return true;
-- 
2.43.0


