Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDF1C83F22
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:17:50 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.74913.1752488245150104217
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:17:41 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: I7ILfWPKQ/SDScio8jLJFQ==
X-CSE-MsgGUID: Lp6tcFbLRpq2rQpg6kpPHQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2025 19:17:41 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E7922400D4C7;
	Mon, 14 Jul 2025 19:17:39 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 23/36] can: rcar_canfd: Add rnc_field_width variable to struct rcar_canfd_hw_info
Date: Mon, 14 Jul 2025 11:16:23 +0100
Message-ID: <20250714101650.80381-24-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
References: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:17:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19509

commit e9ffa12e02e193395e594df8977157121b107c21 upstream.

The shift and w value in rcar_canfd_setrnc() are dictated by the
field width:
  - R-Car Gen4 packs 2 values in a 32-bit word, using a field width
    of 16 bits,
  - R-Car Gen3 packs up to 4 values in a 32-bit word, using a field
    width of 8 bits.

Add rnc_field_width variable to struct rcar_canfd_hw_info to handle this
difference. The rnc_stride is 32 / rnc_field_width and the index parameter
w is calculated by ch / rnc_stride. The shift value in rcar_canfd_setrnc()
is computed by using (32 - (ch % rnc_stride + 1) * rnc_field_width).

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250417054320.14100-10-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index fded4da501031..558291a360433 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -503,6 +503,7 @@
 struct rcar_canfd_global;
 
 struct rcar_canfd_hw_info {
+	u8 rnc_field_width;
 	u8 max_channels;
 	u8 postdiv;
 	/* hardware features */
@@ -579,18 +580,21 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
 };
 
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
+	.rnc_field_width = 8,
 	.max_channels = 2,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
+	.rnc_field_width = 16,
 	.max_channels = 8,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
+	.rnc_field_width = 8,
 	.max_channels = 2,
 	.postdiv = 1,
 	.multi_channel_irqs = 1,
@@ -676,9 +680,10 @@ static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
 static void rcar_canfd_setrnc(struct rcar_canfd_global *gpriv, unsigned int ch,
 			      unsigned int num_rules)
 {
-	unsigned int shift = reg_gen4(gpriv, 16, 24) - (ch & 1) * reg_gen4(gpriv, 16, 8);
+	unsigned int rnc_stride = 32 / gpriv->info->rnc_field_width;
+	unsigned int shift = 32 - (ch % rnc_stride + 1) * gpriv->info->rnc_field_width;
+	unsigned int w = ch / rnc_stride;
 	u32 rnc = num_rules << shift;
-	unsigned int w = ch / 2;
 
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(w), rnc);
 }
-- 
2.43.0


