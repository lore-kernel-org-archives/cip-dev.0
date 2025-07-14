Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C16EC83F1A
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:09:10 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.74784.1752487740778471526
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:09:01 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: yZ7pJ2SIQC6Y7COE26+qPg==
X-CSE-MsgGUID: HIUc3tNpSXKgBs7/hq9W7g==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2025 19:09:00 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A17B241D4BE8;
	Mon, 14 Jul 2025 19:08:58 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 26/57] can: rcar_canfd: Fix R-Car Gen4 CFCC.CFTML field width
Date: Mon, 14 Jul 2025 11:07:07 +0100
Message-ID: <20250714100802.80035-27-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:09:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19454

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 3e73d3df4d3861265367b4df6dd7fc5789e05d3c upstream.

On R-Car Gen4 CAN_FD variants, the Common FIFO TX Message Buffer Link
(CFTML) field in the Common FIFO Configuration / Control Register (CCFC)
register is one bit wider than on older variants.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/9c37aaa799a2391be272dbaa474379cf9a7af147.1674499048.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 32a8948d86dd..fabf35d99a31 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -233,7 +233,8 @@
 /* Common FIFO bits */
 
 /* RSCFDnCFDCFCCk */
-#define RCANFD_CFCC_CFTML(gpriv, x)	(((x) & 0xf) << reg_gen4(gpriv, 16, 20))
+#define RCANFD_CFCC_CFTML(gpriv, x)	\
+	(((x) & reg_gen4(gpriv, 0x1f, 0xf)) << reg_gen4(gpriv, 16, 20))
 #define RCANFD_CFCC_CFM(gpriv, x)	(((x) & 0x3) << reg_gen4(gpriv,  8, 16))
 #define RCANFD_CFCC_CFIM		BIT(12)
 #define RCANFD_CFCC_CFDC(gpriv, x)	(((x) & 0x7) << reg_gen4(gpriv, 21,  8))
-- 
2.43.0


