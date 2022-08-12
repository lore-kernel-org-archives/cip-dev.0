Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5F8C00140
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 10:13:35 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.9106.1660299202951792196
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Aug 2022 03:13:26 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,231,1654527600";
   d="scan'208";a="131210691"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Aug 2022 19:13:25 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A39814243969;
	Fri, 12 Aug 2022 19:13:24 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 03/11] memory: renesas-rpc-if: avoid use of
 undocumented bits
Date: Fri, 12 Aug 2022 11:13:09 +0100
Message-Id: <20220812101317.12380-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220812101317.12380-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220812101317.12380-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Aug 2022 10:13:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9175

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 57ea9daad51f7707f61a602a743decf10cf9fea9 upstream.

Instead of writing fixed values with undocumented bits which happen to
be set on some SoCs, better switch to read-modify-write operations
changing only bits which are documented. This is way more future-proof
as we don't know yet how these bits may be on upcoming SoCs.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20211117093710.14430-1-wsa+renesas@sang-engineering.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 58 +++++++++++++--------------------
 1 file changed, 22 insertions(+), 36 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 36c6042f6a07..b98eed3f3ab2 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -20,7 +20,6 @@
 
 #define RPCIF_CMNCR		0x0000	/* R/W */
 #define RPCIF_CMNCR_MD		BIT(31)
-#define RPCIF_CMNCR_SFDE	BIT(24) /* undocumented but must be set */
 #define RPCIF_CMNCR_MOIIO3(val)	(((val) & 0x3) << 22)
 #define RPCIF_CMNCR_MOIIO2(val)	(((val) & 0x3) << 20)
 #define RPCIF_CMNCR_MOIIO1(val)	(((val) & 0x3) << 18)
@@ -318,49 +317,36 @@ int rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
 		rpcif_rzg2l_timing_adjust_sdr(rpc);
 	}
 
-	/*
-	 * NOTE: The 0x260 are undocumented bits, but they must be set.
-	 *	 RPCIF_PHYCNT_STRTIM is strobe timing adjustment bits,
-	 *	 0x0 : the delay is biggest,
-	 *	 0x1 : the delay is 2nd biggest,
-	 *	 On H3 ES1.x, the value should be 0, while on others,
-	 *	 the value should be 7.
-	 */
-	if (rpc->type == RPCIF_RCAR_GEN3) {
-		regmap_write(rpc->regmap, RPCIF_PHYCNT, RPCIF_PHYCNT_STRTIM(7) |
-			     RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260);
-	} else {
-		regmap_read(rpc->regmap, RPCIF_PHYCNT, &dummy);
-		dummy &= ~RPCIF_PHYCNT_PHYMEM_MASK;
-		dummy |= RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260;
-		regmap_write(rpc->regmap, RPCIF_PHYCNT, dummy);
-	}
+	regmap_update_bits(rpc->regmap, RPCIF_PHYCNT, RPCIF_PHYCNT_PHYMEM_MASK,
+			   RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0));
+
+	if (rpc->type == RPCIF_RCAR_GEN3)
+		regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
+				   RPCIF_PHYCNT_STRTIM(7), RPCIF_PHYCNT_STRTIM(7));
 
-	/*
-	 * NOTE: The 0x1511144 are undocumented bits, but they must be set
-	 *       for RPCIF_PHYOFFSET1.
-	 *	 The 0x31 are undocumented bits, but they must be set
-	 *	 for RPCIF_PHYOFFSET2.
-	 */
-	regmap_write(rpc->regmap, RPCIF_PHYOFFSET1, 0x1511144 |
-		     RPCIF_PHYOFFSET1_DDRTMG(3));
-	regmap_write(rpc->regmap, RPCIF_PHYOFFSET2, 0x31 |
-		     RPCIF_PHYOFFSET2_OCTTMG(4));
+	regmap_update_bits(rpc->regmap, RPCIF_PHYOFFSET1, RPCIF_PHYOFFSET1_DDRTMG(3),
+			   RPCIF_PHYOFFSET1_DDRTMG(3));
+	regmap_update_bits(rpc->regmap, RPCIF_PHYOFFSET2, RPCIF_PHYOFFSET2_OCTTMG(7),
+			   RPCIF_PHYOFFSET2_OCTTMG(4));
 
 	if (hyperflash)
 		regmap_update_bits(rpc->regmap, RPCIF_PHYINT,
 				   RPCIF_PHYINT_WPVAL, 0);
 
 	if (rpc->type == RPCIF_RCAR_GEN3)
-		regmap_write(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_SFDE |
-			     RPCIF_CMNCR_MOIIO_HIZ | RPCIF_CMNCR_IOFV_HIZ |
-			     RPCIF_CMNCR_BSZ(hyperflash ? 1 : 0));
+		regmap_update_bits(rpc->regmap, RPCIF_CMNCR,
+				   RPCIF_CMNCR_MOIIO_HIZ | RPCIF_CMNCR_BSZ(3),
+				   RPCIF_CMNCR_MOIIO_HIZ |
+				   RPCIF_CMNCR_BSZ(hyperflash ? 1 : 0));
 	else
-		regmap_write(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_SFDE |
-			     RPCIF_CMNCR_MOIIO3(1) | RPCIF_CMNCR_MOIIO2(1) |
-			     RPCIF_CMNCR_MOIIO1(1) | RPCIF_CMNCR_MOIIO0(1) |
-			     RPCIF_CMNCR_IO3FV(2) | RPCIF_CMNCR_IO2FV(2) |
-			     RPCIF_CMNCR_IO0FV(2) | RPCIF_CMNCR_BSZ(hyperflash ? 1 : 0));
+		regmap_update_bits(rpc->regmap, RPCIF_CMNCR,
+				   RPCIF_CMNCR_MOIIO_HIZ | RPCIF_CMNCR_IOFV_HIZ |
+				   RPCIF_CMNCR_BSZ(3),
+				   RPCIF_CMNCR_MOIIO3(1) | RPCIF_CMNCR_MOIIO2(1) |
+				   RPCIF_CMNCR_MOIIO1(1) | RPCIF_CMNCR_MOIIO0(1) |
+				   RPCIF_CMNCR_IO3FV(2) | RPCIF_CMNCR_IO2FV(2) |
+				   RPCIF_CMNCR_IO0FV(2) |
+				   RPCIF_CMNCR_BSZ(hyperflash ? 1 : 0));
 
 	/* Set RCF after BSZ update */
 	regmap_write(rpc->regmap, RPCIF_DRCR, RPCIF_DRCR_RCF);
-- 
2.17.1


