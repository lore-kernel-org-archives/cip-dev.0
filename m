Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0719C83F28
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:17:40 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.74915.1752488249501437797
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:17:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: 0vg5cLw6TW68FqxVW3QrRw==
X-CSE-MsgGUID: QZQavkk7TIisYv0yGdyTxw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2025 19:17:37 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8C55A400D4C7;
	Mon, 14 Jul 2025 19:17:35 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 21/36] can: rcar_canfd: Add rcar_canfd_setrnc()
Date: Mon, 14 Jul 2025 11:16:21 +0100
Message-ID: <20250714101650.80381-22-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
References: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:17:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19507

commit 6b9f8b53a1f3ad8e7880e3ad0e08074f5d7fd404 upstream.

Add rcar_canfd_setrnc() to replace the macro RCANFD_GAFLCFG_SETRNC.
While at it, replace int->unsigned int for local variables offset, page
and num_rules in rcar_canfd_configure_afl_rules().

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250417054320.14100-8-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 45d0c34f64f69..6b87c1548f684 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -90,10 +90,6 @@
 
 /* AFL Rx rules registers */
 
-/* RSCFDnCFDGAFLCFG0 / RSCFDnGAFLCFG0 */
-#define RCANFD_GAFLCFG_SETRNC(gpriv, n, x) \
-	((x) << (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8)))
-
 /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
 #define RCANFD_GAFLECTR_AFLDAE		BIT(8)
 #define RCANFD_GAFLECTR_AFLPN(gpriv, x)	((x) & reg_gen4(gpriv, 0x7f, 0x1f))
@@ -677,6 +673,15 @@ static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
 		can_free_echo_skb(ndev, i, NULL);
 }
 
+static void rcar_canfd_setrnc(struct rcar_canfd_global *gpriv, unsigned int ch,
+			      unsigned int num_rules)
+{
+	unsigned int shift = reg_gen4(gpriv, 16, 24) - (ch & 1) * reg_gen4(gpriv, 16, 8);
+	u32 rnc = num_rules << shift;
+
+	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(ch), rnc);
+}
+
 static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
 {
 	if (is_gen4(gpriv)) {
@@ -785,7 +790,7 @@ static void rcar_canfd_configure_controller(struct rcar_canfd_global *gpriv)
 static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
 					   u32 ch, u32 rule_entry)
 {
-	int offset, page, num_rules = RCANFD_CHANNEL_NUMRULES;
+	unsigned int offset, page, num_rules = RCANFD_CHANNEL_NUMRULES;
 	u32 rule_entry_index = rule_entry % 16;
 	u32 ridx = ch + RCANFD_RFFIFO_IDX;
 
@@ -796,8 +801,7 @@ static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
 			    RCANFD_GAFLECTR_AFLDAE));
 
 	/* Write number of rules for channel */
-	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(ch),
-			   RCANFD_GAFLCFG_SETRNC(gpriv, ch, num_rules));
+	rcar_canfd_setrnc(gpriv, ch, num_rules);
 	if (is_gen4(gpriv))
 		offset = RCANFD_GEN4_GAFL_OFFSET;
 	else if (gpriv->fdmode)
-- 
2.43.0


