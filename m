Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D05FC83F22
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:09:00 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.74863.1752487730286377307
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:08:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: 7x3GS77eSTGP6CNPsRF8+A==
X-CSE-MsgGUID: BevK8ECqS2OChYxQZg2X7A==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2025 19:08:53 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5CC7341D45A9;
	Mon, 14 Jul 2025 19:08:52 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 23/57] can: rcar_canfd: Abstract out DCFG address differences
Date: Mon, 14 Jul 2025 11:07:04 +0100
Message-ID: <20250714100802.80035-24-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:09:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19451

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit bbf6681d1f0f74a737e0804ab586ac016b2f4ccb upstream.

Abstract the different addresses for the Channel n Data Bitrate
Configuration Register (DCFG) in the definition of the register macro,
like is already done for other register definitions, to simplify code
accessing this register.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/13e02d710dac3ddef73aa4be2b995766db9b6b4d.1674499048.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 6a732bbed822..2a76610bfa34 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -429,7 +429,6 @@
 #define RCANFD_C_RPGACC(r)		(0x1900 + (0x04 * (r)))
 
 /* R-Car V3U Classical and CAN FD mode specific register map */
-#define RCANFD_V3U_DCFG(m)		(0x1400 + (0x20 * (m)))
 #define RCANFD_V3U_FDCFG(m)		(0x1404 + (0x20 * (m)))
 
 #define RCANFD_V3U_GAFL_OFFSET		(0x1800)
@@ -437,7 +436,7 @@
 /* CAN FD mode specific register map */
 
 /* RSCFDnCFDCmXXX -> RCANFD_F_XXX(m) */
-#define RCANFD_F_DCFG(m)		(0x0500 + (0x20 * (m)))
+#define RCANFD_F_DCFG(gpriv, m)		(reg_v3u(gpriv, 0x1400, 0x0500) + (0x20 * (m)))
 #define RCANFD_F_CFDCFG(m)		(0x0504 + (0x20 * (m)))
 #define RCANFD_F_CFDCTR(m)		(0x0508 + (0x20 * (m)))
 #define RCANFD_F_CFDSTS(m)		(0x050c + (0x20 * (m)))
@@ -1338,10 +1337,7 @@ static void rcar_canfd_set_bittiming(struct net_device *dev)
 		cfg = (RCANFD_DCFG_DTSEG1(gpriv, tseg1) | RCANFD_DCFG_DBRP(brp) |
 		       RCANFD_DCFG_DSJW(sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
 
-		if (is_v3u(gpriv))
-			rcar_canfd_write(priv->base, RCANFD_V3U_DCFG(ch), cfg);
-		else
-			rcar_canfd_write(priv->base, RCANFD_F_DCFG(ch), cfg);
+		rcar_canfd_write(priv->base, RCANFD_F_DCFG(gpriv, ch), cfg);
 		netdev_dbg(priv->ndev, "drate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
 			   brp, sjw, tseg1, tseg2);
 	} else {
-- 
2.43.0


