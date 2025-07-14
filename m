Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE14C83F21
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:08:59 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.74863.1752487730286377307
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:08:58 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: 0o8ALSWfTDSGCy3EgsoOYw==
X-CSE-MsgGUID: bGaf8V0FQwOxZ4Wxyu6w9A==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2025 19:08:58 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9042D41D4BE8;
	Mon, 14 Jul 2025 19:08:56 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 25/57] can: rcar_canfd: Fix R-Car Gen4 DCFG.DSJW field width
Date: Mon, 14 Jul 2025 11:07:06 +0100
Message-ID: <20250714100802.80035-26-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:08:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19453

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 0424281688f11bfe79b9461420ca3465995178cc upstream.

On R-Car Gen4 CAN_FD variants, the Data Bit Rate Resynchronization Jump
Width Control (DSJW) field in the Channel n Data Bitrate Configuration
Register (DCFG) register is one bit wider than on older variants.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/c4e8bc220bf87e6c7e375f7a2ce51e2aa89ea8a7.1674499048.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 3b6863e6f6ae..32a8948d86dd 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -186,7 +186,7 @@
 #define RCANFD_CERFL_ERR(x)		((x) & (0x7fff)) /* above bits 14:0 */
 
 /* RSCFDnCFDCmDCFG */
-#define RCANFD_DCFG_DSJW(x)		(((x) & 0x7) << 24)
+#define RCANFD_DCFG_DSJW(gpriv, x)	(((x) & reg_gen4(gpriv, 0xf, 0x7)) << 24)
 
 #define RCANFD_DCFG_DTSEG2(gpriv, x) \
 	(((x) & reg_gen4(gpriv, 0x0f, 0x7)) << reg_gen4(gpriv, 16, 20))
@@ -1335,7 +1335,7 @@ static void rcar_canfd_set_bittiming(struct net_device *dev)
 		tseg2 = dbt->phase_seg2 - 1;
 
 		cfg = (RCANFD_DCFG_DTSEG1(gpriv, tseg1) | RCANFD_DCFG_DBRP(brp) |
-		       RCANFD_DCFG_DSJW(sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
+		       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
 
 		rcar_canfd_write(priv->base, RCANFD_F_DCFG(gpriv, ch), cfg);
 		netdev_dbg(priv->ndev, "drate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
-- 
2.43.0


