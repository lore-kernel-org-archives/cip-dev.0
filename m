Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7030BC00140
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 10:13:25 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.9106.1660299202951792196
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Aug 2022 03:13:24 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,231,1654527600";
   d="scan'208";a="131210688"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Aug 2022 19:13:24 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BB6CE424396E;
	Fri, 12 Aug 2022 19:13:22 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 02/11] memory: renesas-rpc-if: simplify register
 update
Date: Fri, 12 Aug 2022 11:13:08 +0100
Message-Id: <20220812101317.12380-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220812101317.12380-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220812101317.12380-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Aug 2022 10:13:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9174

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 2db468d6fda4c33d26ba9dde7c72e081b2b86ad1 upstream.

No need to open code regmap_update_bits().

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20211117102902.20062-1-wsa+renesas@sang-engineering.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index dc35f1460425..36c6042f6a07 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -290,17 +290,14 @@ EXPORT_SYMBOL(rpcif_sw_init);
 
 static void rpcif_rzg2l_timing_adjust_sdr(struct rpcif *rpc)
 {
-	u32 data;
-
 	regmap_write(rpc->regmap, RPCIF_PHYWR, 0xa5390000);
 	regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000000);
 	regmap_write(rpc->regmap, RPCIF_PHYWR, 0x00008080);
 	regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000022);
 	regmap_write(rpc->regmap, RPCIF_PHYWR, 0x00008080);
 	regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000024);
-
-	regmap_read(rpc->regmap, RPCIF_PHYCNT, &data);
-	regmap_write(rpc->regmap, RPCIF_PHYCNT, data | RPCIF_PHYCNT_CKSEL(3));
+	regmap_update_bits(rpc->regmap, RPCIF_PHYCNT, RPCIF_PHYCNT_CKSEL(3),
+			   RPCIF_PHYCNT_CKSEL(3));
 	regmap_write(rpc->regmap, RPCIF_PHYWR, 0x00000030);
 	regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000032);
 }
-- 
2.17.1


