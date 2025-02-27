Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B436FC19F2E
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 15:34:50 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.13489.1740670477142947630
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 07:34:44 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-CSE-ConnectionGUID: i7tn6zTpRhKWVZILY+r41g==
X-CSE-MsgGUID: McSubJHgQNi/gTcTDB8a0w==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2025 00:34:43 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.138])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id EB62D402CEAC;
	Fri, 28 Feb 2025 00:34:41 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 09/12] net: ravb: Simplify UDP TX checksum offload
Date: Thu, 27 Feb 2025 15:34:10 +0000
Message-ID: <20250227153413.686812-10-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227153413.686812-1-paul.barker.ct@bp.renesas.com>
References: <20250227153413.686812-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 15:34:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17973

commit e63b5fd02a00aab8e79691359e931dafcd9dfd05 upstream.

The GbEth IP will pass through a zero UDP checksum without asserting any
error flags so we do not need to resort to software checksum calculation
in this case.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index ad480e2d61e7..2a9566d3af5c 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2091,20 +2091,11 @@ static bool ravb_can_tx_csum_gbeth(struct sk_buff *skb)
 
 	switch (ip->protocol) {
 	case IPPROTO_TCP:
-		break;
 	case IPPROTO_UDP:
-		/* If the checksum value in the UDP header field is 0, TOE does
-		 * not calculate checksum for UDP part of this frame as it is
-		 * optional function as per standards.
-		 */
-		if (udp_hdr(skb)->check == 0)
-			return false;
-		break;
+		return true;
 	default:
 		return false;
 	}
-
-	return true;
 }
 
 /* Packet transmit function for Ethernet AVB */
-- 
2.43.0


