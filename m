Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FDEC369CB
	for <webhook@archiver.kernel.org>; Wed, 23 Apr 2025 21:05:19 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.494.1745442306767471673
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Apr 2025 14:05:09 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: cwSkdN2lTxupYIXEbV4YQA==
X-CSE-MsgGUID: KVmP/Em9SaOLSfEx8bz30w==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Apr 2025 06:05:09 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E40CA401C94B;
	Thu, 24 Apr 2025 06:05:07 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.12.y-cip 4/8] i2c: riic: Use BIT macro consistently
Date: Wed, 23 Apr 2025 22:04:54 +0100
Message-ID: <20250423210458.14698-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423210458.14698-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250423210458.14698-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Apr 2025 21:05:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18587

commit 0094d6b70d6b4eb5084e3b7dd99ebfc94d3ca58d upstream.

Easier to read and ensures proper types.

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
 drivers/i2c/busses/i2c-riic.c | 37 ++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 0fcb0814846b..fb7067a6953b 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -34,6 +34,7 @@
  * Also check the comments in the interrupt routines for some gory details.
  */
 
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/err.h>
@@ -46,32 +47,32 @@
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
-#define ICCR1_ICE	0x80
-#define ICCR1_IICRST	0x40
-#define ICCR1_SOWP	0x10
+#define ICCR1_ICE	BIT(7)
+#define ICCR1_IICRST	BIT(6)
+#define ICCR1_SOWP	BIT(4)
 
-#define ICCR2_BBSY	0x80
-#define ICCR2_SP	0x08
-#define ICCR2_RS	0x04
-#define ICCR2_ST	0x02
+#define ICCR2_BBSY	BIT(7)
+#define ICCR2_SP	BIT(3)
+#define ICCR2_RS	BIT(2)
+#define ICCR2_ST	BIT(1)
 
 #define ICMR1_CKS_MASK	0x70
-#define ICMR1_BCWP	0x08
+#define ICMR1_BCWP	BIT(3)
 #define ICMR1_CKS(_x)	((((_x) << 4) & ICMR1_CKS_MASK) | ICMR1_BCWP)
 
-#define ICMR3_RDRFS	0x20
-#define ICMR3_ACKWP	0x10
-#define ICMR3_ACKBT	0x08
+#define ICMR3_RDRFS	BIT(5)
+#define ICMR3_ACKWP	BIT(4)
+#define ICMR3_ACKBT	BIT(3)
 
-#define ICFER_FMPE	0x80
+#define ICFER_FMPE	BIT(7)
 
-#define ICIER_TIE	0x80
-#define ICIER_TEIE	0x40
-#define ICIER_RIE	0x20
-#define ICIER_NAKIE	0x10
-#define ICIER_SPIE	0x08
+#define ICIER_TIE	BIT(7)
+#define ICIER_TEIE	BIT(6)
+#define ICIER_RIE	BIT(5)
+#define ICIER_NAKIE	BIT(4)
+#define ICIER_SPIE	BIT(3)
 
-#define ICSR2_NACKF	0x10
+#define ICSR2_NACKF	BIT(4)
 
 #define ICBR_RESERVED	0xe0 /* Should be 1 on writes */
 
-- 
2.43.0


