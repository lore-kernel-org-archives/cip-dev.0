Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43322C19F32
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 14:57:50 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.12486.1740668248506296267
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 06:57:46 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-CSE-ConnectionGUID: B1z8xb0SQD+HMfjWyC71AA==
X-CSE-MsgGUID: raKQEVRKS2+lbCDNmpOmaA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 27 Feb 2025 23:57:45 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.138])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 00E52434774C;
	Thu, 27 Feb 2025 23:57:43 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 09/11] net: ravb: Enable IPv6 RX checksum offloading for GbEth
Date: Thu, 27 Feb 2025 14:57:18 +0000
Message-ID: <20250227145720.229324-10-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227145720.229324-1-paul.barker.ct@bp.renesas.com>
References: <20250227145720.229324-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 14:57:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17960

commit 59cceae40c67d943687587912483d68226cd04de upstream.

The GbEth IP supports offloading IPv6 TCP, UDP & ICMPv6 checksums in the
RX path.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 1d358e58b575..0a13f0be2a16 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1012,7 +1012,8 @@ enum CSR2_BIT {
 	CSR2_RDHD	= 0x08000000,
 };
 
-#define CSR2_CSUM_ENABLE (CSR2_RTCP4 | CSR2_RUDP4 | CSR2_RICMP4)
+#define CSR2_CSUM_ENABLE (CSR2_RTCP4 | CSR2_RUDP4 | CSR2_RICMP4 | \
+			  CSR2_RTCP6 | CSR2_RUDP6 | CSR2_RICMP6)
 
 #define DBAT_ENTRY_NUM	22
 #define RX_QUEUE_OFFSET	4
-- 
2.43.0


