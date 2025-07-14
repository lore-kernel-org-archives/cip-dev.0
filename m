Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6D9C83F1B
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:09:40 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.74880.1752487774498628932
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:09:38 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: QOZmZEWcQsSSRrd4YzBdfA==
X-CSE-MsgGUID: FwDZNJ3xQVuLR4cG5wR2kg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2025 19:09:37 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 543AF41D4E22;
	Mon, 14 Jul 2025 19:09:36 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 44/57] can: rcar_canfd: Add max_aflpn variable to struct rcar_canfd_hw_info
Date: Mon, 14 Jul 2025 11:07:25 +0100
Message-ID: <20250714100802.80035-45-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:09:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19472

commit 2d6cb8ff94166f3965b3fc3637faecf295a8c708 upstream.

R-Car Gen3 has maximum acceptance filter list page number of 31 whereas on
R-Car Gen4 it is 127. Add max_aflpn variable to struct rcar_canfd_hw_info
in order to support RZ/G3E that has max AFLPN of 63.

While at it, rename the parameter x->page_num in RCANFD_GAFLECTR_AFLPN
macro to make it clear.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250417054320.14100-11-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 9eafa2d42d64..ea828465baeb 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -93,7 +93,7 @@
 
 /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
 #define RCANFD_GAFLECTR_AFLDAE		BIT(8)
-#define RCANFD_GAFLECTR_AFLPN(gpriv, x)	((x) & reg_gen4(gpriv, 0x7f, 0x1f))
+#define RCANFD_GAFLECTR_AFLPN(gpriv, page_num)	((page_num) & (gpriv)->info->max_aflpn)
 
 /* RSCFDnCFDGAFLIDj / RSCFDnGAFLIDj */
 #define RCANFD_GAFLID_GAFLLB		BIT(29)
@@ -505,6 +505,7 @@ struct rcar_canfd_global;
 
 struct rcar_canfd_hw_info {
 	u8 rnc_field_width;
+	u8 max_aflpn;
 	u8 max_channels;
 	u8 postdiv;
 	/* hardware features */
@@ -582,6 +583,7 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
 
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.rnc_field_width = 8,
+	.max_aflpn = 31,
 	.max_channels = 2,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
@@ -589,6 +591,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.rnc_field_width = 16,
+	.max_aflpn = 127,
 	.max_channels = 8,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
@@ -596,6 +599,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.rnc_field_width = 8,
+	.max_aflpn = 31,
 	.max_channels = 2,
 	.postdiv = 1,
 	.multi_channel_irqs = 1,
-- 
2.43.0


