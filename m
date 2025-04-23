Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E62CC369D9
	for <webhook@archiver.kernel.org>; Wed, 23 Apr 2025 21:05:19 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.494.1745442306767471673
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Apr 2025 14:05:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: qvRPSb3TT7uLK1Ge4j4dQw==
X-CSE-MsgGUID: qVDcbO6hQayKs1jX6xFYmQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Apr 2025 06:05:11 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 10404401C94A;
	Thu, 24 Apr 2025 06:05:09 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.12.y-cip 5/8] i2c: riic: Use GENMASK() macro for bitmask definitions
Date: Wed, 23 Apr 2025 22:04:55 +0100
Message-ID: <20250423210458.14698-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423210458.14698-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250423210458.14698-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Apr 2025 21:05:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18588

commit 72252162258c8a0b19d5bd0bb49fe20495898d6d upstream.

Replace raw bitmask values with the `GENMASK()` macro in the `i2c-riic`
driver to improve readability and maintain consistency.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index fb7067a6953b..0fc935722354 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -56,7 +56,7 @@
 #define ICCR2_RS	BIT(2)
 #define ICCR2_ST	BIT(1)
 
-#define ICMR1_CKS_MASK	0x70
+#define ICMR1_CKS_MASK	GENMASK(6, 4)
 #define ICMR1_BCWP	BIT(3)
 #define ICMR1_CKS(_x)	((((_x) << 4) & ICMR1_CKS_MASK) | ICMR1_BCWP)
 
@@ -74,7 +74,7 @@
 
 #define ICSR2_NACKF	BIT(4)
 
-#define ICBR_RESERVED	0xe0 /* Should be 1 on writes */
+#define ICBR_RESERVED	GENMASK(7, 5) /* Should be 1 on writes */
 
 #define RIIC_INIT_MSG	-1
 
-- 
2.43.0


