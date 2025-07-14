Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53612C83F27
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:09:30 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.74878.1752487768048222683
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:09:28 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: gwcNyD17RxCn7ss9uVKBGw==
X-CSE-MsgGUID: Sjhdv31YQhquqjVwzPHUQg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2025 19:09:27 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id ECA9F41D4BF2;
	Mon, 14 Jul 2025 19:09:25 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 39/57] can: rcar_canfd: Update RCANFD_GERFL_ERR macro
Date: Mon, 14 Jul 2025 11:07:20 +0100
Message-ID: <20250714100802.80035-40-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:09:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19467

commit b75fcf2af2dbbc5f913cf1b9194ed01ce9c068b6 upstream.

Replace the macro RCANFD_GERFL_EEF0_7->RCANFD_GERFL_EEF. The macros
RCANFD_GERFL_EEF* in RCANFD_GERFL_ERR can be replaced by FIELD_PREP() and
drop the redundant macro RCANFD_GERFL_EEF(ch).

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250417054320.14100-6-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index bcb6dccf8ed7..b703d9e9d5fc 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -21,6 +21,7 @@
  * wherever it is modified to a readable name.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/can/dev.h>
@@ -75,18 +76,18 @@
 #define RCANFD_GSTS_GNOPM		(BIT(0) | BIT(1) | BIT(2) | BIT(3))
 
 /* RSCFDnCFDGERFL / RSCFDnGERFL */
-#define RCANFD_GERFL_EEF0_7		GENMASK(23, 16)
-#define RCANFD_GERFL_EEF(ch)		BIT(16 + (ch))
+#define RCANFD_GERFL_EEF		GENMASK(23, 16)
 #define RCANFD_GERFL_CMPOF		BIT(3)	/* CAN FD only */
 #define RCANFD_GERFL_THLES		BIT(2)
 #define RCANFD_GERFL_MES		BIT(1)
 #define RCANFD_GERFL_DEF		BIT(0)
 
 #define RCANFD_GERFL_ERR(gpriv, x) \
-	((x) & (reg_gen4(gpriv, RCANFD_GERFL_EEF0_7, \
-			 RCANFD_GERFL_EEF(0) | RCANFD_GERFL_EEF(1)) | \
-		RCANFD_GERFL_MES | \
-		((gpriv)->fdmode ? RCANFD_GERFL_CMPOF : 0)))
+({\
+	typeof(gpriv) (_gpriv) = (gpriv); \
+	((x) & ((FIELD_PREP(RCANFD_GERFL_EEF, (_gpriv)->channels_mask)) | \
+		RCANFD_GERFL_MES | ((_gpriv)->fdmode ? RCANFD_GERFL_CMPOF : 0))); \
+})
 
 /* AFL Rx rules registers */
 
@@ -939,7 +940,7 @@ static void rcar_canfd_global_error(struct net_device *ndev)
 	u32 ridx = ch + RCANFD_RFFIFO_IDX;
 
 	gerfl = rcar_canfd_read(priv->base, RCANFD_GERFL);
-	if (gerfl & RCANFD_GERFL_EEF(ch)) {
+	if (gerfl & FIELD_PREP(RCANFD_GERFL_EEF, BIT(ch))) {
 		netdev_dbg(ndev, "Ch%u: ECC Error flag\n", ch);
 		stats->tx_dropped++;
 	}
-- 
2.43.0


