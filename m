Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A96C433F5
	for <webhook@archiver.kernel.org>; Mon, 31 Jan 2022 12:19:25 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.31207.1643631563602998327
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Jan 2022 04:19:24 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,330,1635174000";
   d="scan'208";a="108906304"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 31 Jan 2022 21:19:24 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4F4F64347FCA;
	Mon, 31 Jan 2022 21:19:23 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 14/27] memory: renesas-rpc-if: Drop usage of
 RPCIF_DIRMAP_SIZE macro
Date: Mon, 31 Jan 2022 12:18:50 +0000
Message-Id: <20220131121903.8620-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Jan 2022 12:19:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7535

commit 5da9b59b23d8112709034a07338e03dcc65fa11f upstream.

RPCIF_DIRMAP_SIZE may differ on various SoC's. Instead of using
RPCIF_DIRMAP_SIZE macro use resource size to get dirmap size
which is already part of struct rpcif.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20211025205631.21151-7-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 861870223300..140cb4e2b789 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -147,8 +147,6 @@
 #define RPCIF_PHYINT		0x0088	/* R/W */
 #define RPCIF_PHYINT_WPVAL	BIT(1)
 
-#define RPCIF_DIRMAP_SIZE	0x4000000
-
 static const struct regmap_range rpcif_volatile_ranges[] = {
 	regmap_reg_range(RPCIF_SMRDR0, RPCIF_SMRDR1),
 	regmap_reg_range(RPCIF_SMWDR0, RPCIF_SMWDR1),
@@ -547,8 +545,8 @@ EXPORT_SYMBOL(rpcif_manual_xfer);
 
 ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 offs, size_t len, void *buf)
 {
-	loff_t from = offs & (RPCIF_DIRMAP_SIZE - 1);
-	size_t size = RPCIF_DIRMAP_SIZE - from;
+	loff_t from = offs & (rpc->size - 1);
+	size_t size = rpc->size - from;
 
 	if (len > size)
 		len = size;
-- 
2.17.1


