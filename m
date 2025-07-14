Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9E1C83F1B
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:09:30 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.74791.1752487761686406921
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:09:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: VjMNTJGgTBaONz2bdsGU/w==
X-CSE-MsgGUID: iYVL+NYDQT+tC3vXfBilKw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2025 19:09:21 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7D9F041D4BDF;
	Mon, 14 Jul 2025 19:09:19 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 36/57] can: rcar_canfd: Remove superfluous parentheses in address calculations
Date: Mon, 14 Jul 2025 11:07:17 +0100
Message-ID: <20250714100802.80035-37-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:09:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19464

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit f9a83965d40ef162bab1e3af338523b8da69cb82 upstream.

There is no need to wrap simple variables or multiplications inside
parentheses.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/b5aee80895fa029070fd37d1d837cf1c0ecb52dc.1716973640.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 2e31af958cca..eea46a54e857 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -628,28 +628,28 @@ static inline void rcar_canfd_update(u32 mask, u32 val, u32 __iomem *reg)
 
 static inline u32 rcar_canfd_read(void __iomem *base, u32 offset)
 {
-	return readl(base + (offset));
+	return readl(base + offset);
 }
 
 static inline void rcar_canfd_write(void __iomem *base, u32 offset, u32 val)
 {
-	writel(val, base + (offset));
+	writel(val, base + offset);
 }
 
 static void rcar_canfd_set_bit(void __iomem *base, u32 reg, u32 val)
 {
-	rcar_canfd_update(val, val, base + (reg));
+	rcar_canfd_update(val, val, base + reg);
 }
 
 static void rcar_canfd_clear_bit(void __iomem *base, u32 reg, u32 val)
 {
-	rcar_canfd_update(val, 0, base + (reg));
+	rcar_canfd_update(val, 0, base + reg);
 }
 
 static void rcar_canfd_update_bit(void __iomem *base, u32 reg,
 				  u32 mask, u32 val)
 {
-	rcar_canfd_update(mask, val, base + (reg));
+	rcar_canfd_update(mask, val, base + reg);
 }
 
 static void rcar_canfd_get_data(struct rcar_canfd_channel *priv,
@@ -660,7 +660,7 @@ static void rcar_canfd_get_data(struct rcar_canfd_channel *priv,
 	lwords = DIV_ROUND_UP(cf->len, sizeof(u32));
 	for (i = 0; i < lwords; i++)
 		*((u32 *)cf->data + i) =
-			rcar_canfd_read(priv->base, off + (i * sizeof(u32)));
+			rcar_canfd_read(priv->base, off + i * sizeof(u32));
 }
 
 static void rcar_canfd_put_data(struct rcar_canfd_channel *priv,
@@ -670,7 +670,7 @@ static void rcar_canfd_put_data(struct rcar_canfd_channel *priv,
 
 	lwords = DIV_ROUND_UP(cf->len, sizeof(u32));
 	for (i = 0; i < lwords; i++)
-		rcar_canfd_write(priv->base, off + (i * sizeof(u32)),
+		rcar_canfd_write(priv->base, off + i * sizeof(u32),
 				 *((u32 *)cf->data + i));
 }
 
-- 
2.43.0


