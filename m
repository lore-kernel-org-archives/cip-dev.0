Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6A2C83F1B
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:09:20 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.74873.1752487753247271222
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:09:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: OxN1CMrLT5WqFxbHUUaOAQ==
X-CSE-MsgGUID: A7i3dtswSwyqGLVitcxyog==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2025 19:09:18 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6BBDB41D4BF2;
	Mon, 14 Jul 2025 19:09:17 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 35/57] can: rcar_canfd: Improve printing of global operational state
Date: Mon, 14 Jul 2025 11:07:16 +0100
Message-ID: <20250714100802.80035-36-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:09:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19463

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 0c1d0a69c5e7314f3787bc4272e286d800dbfc56 upstream.

Replace the printing of internal numerical values by the printing of
strings reflecting their meaning, to make the message self-explanatory.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa@kernel.org>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/14c8c5ce026e9fec128404706d1c73c8ffa11ced.1716973640.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 364ca8360757..2e31af958cca 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2044,8 +2044,9 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, gpriv);
-	dev_info(dev, "global operational state (clk %d, fdmode %d)\n",
-		 gpriv->extclk, gpriv->fdmode);
+	dev_info(dev, "global operational state (%s clk, %s mode)\n",
+		 gpriv->extclk ? "ext" : "canfd",
+		 gpriv->fdmode ? "fd" : "classical");
 	return 0;
 
 fail_channel:
-- 
2.43.0


