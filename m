Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D386C83F1A
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:09:40 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.74880.1752487774498628932
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:09:34 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: 6rR/w4CtQc6Exl8NTwsCjQ==
X-CSE-MsgGUID: aoZTV9l0TP+lnLY38z7n4Q==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2025 19:09:33 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3411141D4BDF;
	Mon, 14 Jul 2025 19:09:31 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 42/57] can: rcar_canfd: Update RCANFD_GAFLCFG macro
Date: Mon, 14 Jul 2025 11:07:23 +0100
Message-ID: <20250714100802.80035-43-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:09:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19470

commit a2427e44942bb772cf4e416df45b569a0e35b1cb upstream.

Update RCANFD_GAFLCFG macro by replacing the parameter ch->w, where w is
the GAFLCFG index used in the hardware manual.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250417054320.14100-9-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 8669cd5d0495..5c72342dde1b 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -291,7 +291,7 @@
 /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
 #define RCANFD_GAFLECTR			(0x0098)
 /* RSCFDnCFDGAFLCFG / RSCFDnGAFLCFG */
-#define RCANFD_GAFLCFG(ch)		(0x009c + (0x04 * ((ch) / 2)))
+#define RCANFD_GAFLCFG(w)		(0x009c + (0x04 * (w)))
 /* RSCFDnCFDRMNB / RSCFDnRMNB */
 #define RCANFD_RMNB			(0x00a4)
 /* RSCFDnCFDRMND / RSCFDnRMND */
@@ -679,8 +679,9 @@ static void rcar_canfd_setrnc(struct rcar_canfd_global *gpriv, unsigned int ch,
 {
 	unsigned int shift = reg_gen4(gpriv, 16, 24) - (ch & 1) * reg_gen4(gpriv, 16, 8);
 	u32 rnc = num_rules << shift;
+	unsigned int w = ch / 2;
 
-	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(ch), rnc);
+	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(w), rnc);
 }
 
 static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
-- 
2.43.0


