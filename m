Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A56ACA0EFA
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 08:47:30 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.15343.1755679641016086371
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 01:47:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: aFn3wVkcSzeqgfdNQ7qFWg==
X-CSE-MsgGUID: weY7J69kTaaPm+jV1vFX1w==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Aug 2025 17:47:20 +0900
Received: from localhost.localdomain (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BF3B340138ED;
	Wed, 20 Aug 2025 17:47:18 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 12/23] memory: renesas-rpc-if: Move rpcif_info definitions near to the user
Date: Wed, 20 Aug 2025 09:45:58 +0100
Message-ID: <20250820084645.6988-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
References: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 08:47:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19807

commit 74c35c84f2ba942e7a7744658a8257d0b3188ac2 upstream.

Move rpcif_info definitions near to the user.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250401143537.224047-6-biju.das.jz@bp.renesas.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 40 ++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 11461f6ceb71a..c194390b1cdd9 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -191,26 +191,6 @@ struct rpcif_priv {
 	u32 ddr;		/* DRDRENR or SMDRENR */
 };
 
-static const struct rpcif_info rpcif_info_r8a7796 = {
-	.type = RPCIF_RCAR_GEN3,
-	.strtim = 6,
-};
-
-static const struct rpcif_info rpcif_info_gen3 = {
-	.type = RPCIF_RCAR_GEN3,
-	.strtim = 7,
-};
-
-static const struct rpcif_info rpcif_info_rz_g2l = {
-	.type = RPCIF_RZ_G2L,
-	.strtim = 7,
-};
-
-static const struct rpcif_info rpcif_info_gen4 = {
-	.type = RPCIF_RCAR_GEN4,
-	.strtim = 15,
-};
-
 /*
  * Custom accessor functions to ensure SM[RW]DR[01] are always accessed with
  * proper width.  Requires rpcif_priv.xfer_size to be correctly set before!
@@ -784,6 +764,26 @@ static void rpcif_remove(struct platform_device *pdev)
 	platform_device_unregister(rpc->vdev);
 }
 
+static const struct rpcif_info rpcif_info_r8a7796 = {
+	.type = RPCIF_RCAR_GEN3,
+	.strtim = 6,
+};
+
+static const struct rpcif_info rpcif_info_gen3 = {
+	.type = RPCIF_RCAR_GEN3,
+	.strtim = 7,
+};
+
+static const struct rpcif_info rpcif_info_rz_g2l = {
+	.type = RPCIF_RZ_G2L,
+	.strtim = 7,
+};
+
+static const struct rpcif_info rpcif_info_gen4 = {
+	.type = RPCIF_RCAR_GEN4,
+	.strtim = 15,
+};
+
 static const struct of_device_id rpcif_of_match[] = {
 	{ .compatible = "renesas,r8a7796-rpc-if", .data = &rpcif_info_r8a7796 },
 	{ .compatible = "renesas,rcar-gen3-rpc-if", .data = &rpcif_info_gen3 },
-- 
2.43.0


