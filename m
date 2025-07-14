Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358CFC83F28
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:09:20 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.74873.1752487753247271222
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:09:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: eDZKuCaQQw+do4trxqU1qQ==
X-CSE-MsgGUID: IuJj6gh8R82tlcSYSX48gg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2025 19:09:14 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3C53A41D4BF2;
	Mon, 14 Jul 2025 19:09:12 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 33/57] can: rcar_canfd: rcar_canfd_probe(): fix plain integer in transceivers[] init
Date: Mon, 14 Jul 2025 11:07:14 +0100
Message-ID: <20250714100802.80035-34-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:09:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19461

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 8e85d550c127d8c559d94c8a2bb7b48e1d75432d upstream.

Fix the following compile warning with C=1:

| drivers/net/can/rcar/rcar_canfd.c:1852:59: warning: Using plain integer as NULL pointer

Fixes: a0340df7eca4f28e ("can: rcar_canfd: Add transceiver support")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20230328145658.7fdbc394@kernel.org
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Link: https://lore.kernel.org/all/7f7b0dde0caa2d2977b4fb5b65b63036e75f5022.1680071972.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 6efedff278ec..93e39d51d3ca 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1840,7 +1840,7 @@ static void rcar_canfd_channel_remove(struct rcar_canfd_global *gpriv, u32 ch)
 
 static int rcar_canfd_probe(struct platform_device *pdev)
 {
-	struct phy *transceivers[RCANFD_NUM_CHANNELS] = { 0, };
+	struct phy *transceivers[RCANFD_NUM_CHANNELS] = { NULL, };
 	const struct rcar_canfd_hw_info *info;
 	struct device *dev = &pdev->dev;
 	void __iomem *addr;
-- 
2.43.0


