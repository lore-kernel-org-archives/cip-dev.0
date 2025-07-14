Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC03C83F1B
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:09:10 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.74863.1752487730286377307
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:09:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: catwCwqgR02SHANAOZoyTw==
X-CSE-MsgGUID: lALEoDdPT5GnPFR5KYny+A==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2025 19:09:02 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C375241D4BDF;
	Mon, 14 Jul 2025 19:09:00 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 27/57] can: rcar_canfd: Sort included header files
Date: Mon, 14 Jul 2025 11:07:08 +0100
Message-ID: <20250714100802.80035-28-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:09:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19455

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit d506b151bb95c2a80c15e19c4d4686245af0fccb upstream.

This may avoid conflicts when adding or removing files in the future.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/f7fa8090487c6e05b2c7f89542e0a1bd045356f1.1674499048.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index fabf35d99a31..3ecdae5a4c14 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -21,23 +21,23 @@
  * wherever it is modified to a readable name.
  */
 
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+#include <linux/can/dev.h>
+#include <linux/clk.h>
 #include <linux/errno.h>
 #include <linux/ethtool.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/netdevice.h>
-#include <linux/platform_device.h>
-#include <linux/can/dev.h>
-#include <linux/clk.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/bitmap.h>
-#include <linux/bitops.h>
-#include <linux/iopoll.h>
+#include <linux/platform_device.h>
 #include <linux/reset.h>
+#include <linux/types.h>
 
 #define RCANFD_DRV_NAME			"rcar_canfd"
 
-- 
2.43.0


