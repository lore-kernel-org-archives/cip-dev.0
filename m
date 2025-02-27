Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43812C282C1
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 14:57:50 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.12486.1740668248506296267
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 06:57:41 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-CSE-ConnectionGUID: /s4NvTsBRmuj9fy00ubF0A==
X-CSE-MsgGUID: Hk1SPrVaTJy+AGhlwLnReA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 27 Feb 2025 23:57:40 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.138])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 569B8435C42A;
	Thu, 27 Feb 2025 23:57:39 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 07/11] net: ravb: Disable IP header TX checksum offloading
Date: Thu, 27 Feb 2025 14:57:16 +0000
Message-ID: <20250227145720.229324-8-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227145720.229324-1-paul.barker.ct@bp.renesas.com>
References: <20250227145720.229324-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 14:57:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17958

commit 4574ba5b711d7f7968c116521ef58d46fd4f89b1 upstream.

For IPv4 packets, the header checksum will always be calculated in software
in the TX path (Documentation/networking/checksum-offloads.rst says "No
offloading of the IP header checksum is performed; it is always done in
software.") so there is no advantage in asking the hardware to also
calculate this checksum.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 03961b10771f..1d358e58b575 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -996,7 +996,7 @@ enum CSR1_BIT {
 	CSR1_TDHD	= 0x08000000,
 };
 
-#define CSR1_CSUM_ENABLE (CSR1_TIP4 | CSR1_TTCP4 | CSR1_TUDP4)
+#define CSR1_CSUM_ENABLE (CSR1_TTCP4 | CSR1_TUDP4)
 
 enum CSR2_BIT {
 	CSR2_RIP4	= 0x00000001,
-- 
2.43.0


