Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0182AC4708E
	for <webhook@archiver.kernel.org>; Tue, 13 Dec 2022 17:23:29 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.79731.1670952204464812552
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Dec 2022 09:23:25 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.96,241,1665414000"; 
   d="scan'208";a="143214808"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Dec 2022 02:23:25 +0900
Received: from localhost.localdomain (unknown [10.226.93.72])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5EDF94053D02;
	Wed, 14 Dec 2022 02:23:23 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 2/7] can: rcar_canfd: Add missing ECC error checks for channels 2-7
Date: Tue, 13 Dec 2022 17:23:11 +0000
Message-Id: <20221213172316.1848032-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221213172316.1848032-1-biju.das.jz@bp.renesas.com>
References: <20221213172316.1848032-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Dec 2022 17:23:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10223

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 8b043dfb3dc7c32f9c2c0c93e3c2de346ee5e358 upstream.

When introducing support for R-Car V3U, which has 8 instead of 2
channels, the ECC error bitmask was extended to take into account the
extra channels, but rcar_canfd_global_error() was not updated to act
upon the extra bits.

Replace the RCANFD_GERFL_EEF[01] macros by a new macro that takes the
channel number, fixing R-Car V3U while simplifying the code.

Fixes: 45721c406dcf50d4 ("can: rcar_canfd: Add support for r8a779a0 SoC")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/all/4edb2ea46cc64d0532a08a924179827481e14b4f.1666951503.git.geert+renesas@glider.be
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
[biju: removed V3U changes and updated RCANFD_GERFL_ERR macro]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index f93b44ae4121..a44277f31f69 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -79,15 +79,14 @@ enum rcanfd_chip_id {
 #define RCANFD_GSTS_GNOPM		(BIT(0) | BIT(1) | BIT(2) | BIT(3))
 
 /* RSCFDnCFDGERFL / RSCFDnGERFL */
-#define RCANFD_GERFL_EEF1		BIT(17)
-#define RCANFD_GERFL_EEF0		BIT(16)
+#define RCANFD_GERFL_EEF(ch)		BIT(16 + (ch))
 #define RCANFD_GERFL_CMPOF		BIT(3)	/* CAN FD only */
 #define RCANFD_GERFL_THLES		BIT(2)
 #define RCANFD_GERFL_MES		BIT(1)
 #define RCANFD_GERFL_DEF		BIT(0)
 
-#define RCANFD_GERFL_ERR(gpriv, x)	((x) & (RCANFD_GERFL_EEF1 |\
-					RCANFD_GERFL_EEF0 | RCANFD_GERFL_MES |\
+#define RCANFD_GERFL_ERR(gpriv, x)	((x) & (RCANFD_GERFL_EEF(1) |\
+					RCANFD_GERFL_EEF(0) | RCANFD_GERFL_MES |\
 					(gpriv->fdmode ?\
 					 RCANFD_GERFL_CMPOF : 0)))
 
@@ -881,12 +880,8 @@ static void rcar_canfd_global_error(struct net_device *ndev)
 	u32 ridx = ch + RCANFD_RFFIFO_IDX;
 
 	gerfl = rcar_canfd_read(priv->base, RCANFD_GERFL);
-	if ((gerfl & RCANFD_GERFL_EEF0) && (ch == 0)) {
-		netdev_dbg(ndev, "Ch0: ECC Error flag\n");
-		stats->tx_dropped++;
-	}
-	if ((gerfl & RCANFD_GERFL_EEF1) && (ch == 1)) {
-		netdev_dbg(ndev, "Ch1: ECC Error flag\n");
+	if (gerfl & RCANFD_GERFL_EEF(ch)) {
+		netdev_dbg(ndev, "Ch%u: ECC Error flag\n", ch);
 		stats->tx_dropped++;
 	}
 	if (gerfl & RCANFD_GERFL_MES) {
-- 
2.25.1


