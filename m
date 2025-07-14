Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F238DC83F1A
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:08:59 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.74863.1752487730286377307
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:08:52 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: WpoAF9P4RJKusPHp+bZLig==
X-CSE-MsgGUID: /EMVgj+zR9ymvt3tdIR/nA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2025 19:08:51 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4BFC541D45A9;
	Mon, 14 Jul 2025 19:08:50 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 22/57] can: rcar_canfd: Fix R-Car V3U CAN mode selection
Date: Mon, 14 Jul 2025 11:07:03 +0100
Message-ID: <20250714100802.80035-23-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:08:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19450

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 0a016639ef92b28eb74ba4fed21bee1f1328513a upstream.

When adding support for R-Car V3U, the Global FD Configuration register
(CFDGFDCFG) and the Channel-specific CAN-FD Configuration Registers
(CFDCmFDCFG) were mixed up.  Use the correct register, and apply the
selected CAN mode to all available channels.

Annotate the corresponding register bits, to make it clear they do
not exist on older variants.

Fixes: 45721c406dcf50d4 ("can: rcar_canfd: Add support for r8a779a0 SoC")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/388ddf312917eb9f6cc460a481f68402a876f9b5.1674499048.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index c1d8762dc5c5..6a732bbed822 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -197,8 +197,8 @@
 #define RCANFD_DCFG_DBRP(x)		(((x) & 0xff) << 0)
 
 /* RSCFDnCFDCmFDCFG */
-#define RCANFD_FDCFG_CLOE		BIT(30)
-#define RCANFD_FDCFG_FDOE		BIT(28)
+#define RCANFD_V3U_FDCFG_CLOE		BIT(30)
+#define RCANFD_V3U_FDCFG_FDOE		BIT(28)
 #define RCANFD_FDCFG_TDCE		BIT(9)
 #define RCANFD_FDCFG_TDCOC		BIT(8)
 #define RCANFD_FDCFG_TDCO(x)		(((x) & 0x7f) >> 16)
@@ -429,8 +429,8 @@
 #define RCANFD_C_RPGACC(r)		(0x1900 + (0x04 * (r)))
 
 /* R-Car V3U Classical and CAN FD mode specific register map */
-#define RCANFD_V3U_CFDCFG		(0x1314)
 #define RCANFD_V3U_DCFG(m)		(0x1400 + (0x20 * (m)))
+#define RCANFD_V3U_FDCFG(m)		(0x1404 + (0x20 * (m)))
 
 #define RCANFD_V3U_GAFL_OFFSET		(0x1800)
 
@@ -689,12 +689,13 @@ static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
 static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
 {
 	if (is_v3u(gpriv)) {
-		if (gpriv->fdmode)
-			rcar_canfd_set_bit(gpriv->base, RCANFD_V3U_CFDCFG,
-					   RCANFD_FDCFG_FDOE);
-		else
-			rcar_canfd_set_bit(gpriv->base, RCANFD_V3U_CFDCFG,
-					   RCANFD_FDCFG_CLOE);
+		u32 ch, val = gpriv->fdmode ? RCANFD_V3U_FDCFG_FDOE
+					    : RCANFD_V3U_FDCFG_CLOE;
+
+		for_each_set_bit(ch, &gpriv->channels_mask,
+				 gpriv->info->max_channels)
+			rcar_canfd_set_bit(gpriv->base, RCANFD_V3U_FDCFG(ch),
+					   val);
 	} else {
 		if (gpriv->fdmode)
 			rcar_canfd_set_bit(gpriv->base, RCANFD_GRMCFG,
-- 
2.43.0


