Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBFCC1B0FF
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 15:34:40 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.13489.1740670477142947630
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 07:34:37 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-CSE-ConnectionGUID: qw93OvlVReStOAzkM6hM3Q==
X-CSE-MsgGUID: xPSPGLTBShugwh0ntNDl8Q==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2025 00:34:36 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.138])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id EA7B7402CEAC;
	Fri, 28 Feb 2025 00:34:34 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 06/12] net: ravb: Combine if conditions in RX csum validation
Date: Thu, 27 Feb 2025 15:34:07 +0000
Message-ID: <20250227153413.686812-7-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227153413.686812-1-paul.barker.ct@bp.renesas.com>
References: <20250227153413.686812-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 15:34:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17970

commit 5a2d973e36061cbf8d1ba00a9294244522715e53 upstream.

We can merge the two if conditions on skb_is_nonlinear(). Since
skb_frag_size_sub() and skb_trim() do not free memory, it is still safe
to access the trimmed bytes at the end of the packet after these calls.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 0d0a373365c9..e9a1c7e0a709 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -753,7 +753,6 @@ static void ravb_rx_csum_gbeth(struct sk_buff *skb)
 {
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
 	__wsum csum_proto;
-	skb_frag_t *last_frag;
 	u8 *hw_csum;
 
 	/* The hardware checksum status is contained in sizeof(__sum16) * 2 = 4
@@ -769,21 +768,19 @@ static void ravb_rx_csum_gbeth(struct sk_buff *skb)
 		return;
 
 	if (skb_is_nonlinear(skb)) {
-		last_frag = &shinfo->frags[shinfo->nr_frags - 1];
+		skb_frag_t *last_frag = &shinfo->frags[shinfo->nr_frags - 1];
+
 		hw_csum = skb_frag_address(last_frag) +
 			  skb_frag_size(last_frag);
+		skb_frag_size_sub(last_frag, 2 * sizeof(__sum16));
 	} else {
 		hw_csum = skb_tail_pointer(skb);
+		skb_trim(skb, skb->len - 2 * sizeof(__sum16));
 	}
 
 	hw_csum -= sizeof(__sum16);
 	csum_proto = csum_unfold((__force __sum16)get_unaligned_le16(hw_csum));
 
-	if (skb_is_nonlinear(skb))
-		skb_frag_size_sub(last_frag, 2 * sizeof(__sum16));
-	else
-		skb_trim(skb, skb->len - 2 * sizeof(__sum16));
-
 	if (!csum_proto)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 }
-- 
2.43.0


