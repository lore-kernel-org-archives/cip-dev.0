Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5439FCA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 08:39:39 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.15363.1755679165193961126
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 01:39:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: fI7a0GfGQvGmIRfVlUTGZA==
X-CSE-MsgGUID: 8X/eNSUBSfKNSOQvk5Fh9g==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Aug 2025 17:39:28 +0900
Received: from localhost.localdomain (unknown [10.226.92.43])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 32EE4415F18B;
	Wed, 20 Aug 2025 17:39:26 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 11/22] memory: renesas-rpc-if: Move rpcif_info definitions near to the user
Date: Wed, 20 Aug 2025 09:38:19 +0100
Message-ID: <20250820083855.6337-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820083855.6337-1-biju.das.jz@bp.renesas.com>
References: <20250820083855.6337-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 08:39:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19780

commit 74c35c84f2ba942e7a7744658a8257d0b3188ac2 upstream.

Move rpcif_info definitions near to the user.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250401143537.224047-6-biju.das.jz@bp.renesas.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 200b8a5c2bef..771a18b7ff30 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -191,16 +191,6 @@ struct rpcif_priv {
 	u32 ddr;		/* DRDRENR or SMDRENR */
 };
 
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
 /*
  * Custom accessor functions to ensure SM[RW]DR[01] are always accessed with
  * proper width.  Requires rpcif_priv.xfer_size to be correctly set before!
@@ -776,6 +766,16 @@ static int rpcif_remove(struct platform_device *pdev)
 	return 0;
 }
 
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
 static const struct of_device_id rpcif_of_match[] = {
 	{ .compatible = "renesas,rcar-gen3-rpc-if", .data = &rpcif_info_gen3 },
 	{ .compatible = "renesas,rzg2l-rpc-if", .data = &rpcif_info_rz_g2l },
-- 
2.43.0


