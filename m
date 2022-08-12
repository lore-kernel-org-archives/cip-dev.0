Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F88C25B0E
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 10:13:35 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.9013.1660299208561499465
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Aug 2022 03:13:28 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,231,1654527600";
   d="scan'208";a="129340324"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Aug 2022 19:13:27 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9FC3C424396E;
	Fri, 12 Aug 2022 19:13:26 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 04/11] memory: renesas-rpc-if: refactor MOIIO and
 IOFV macros
Date: Fri, 12 Aug 2022 11:13:10 +0100
Message-Id: <20220812101317.12380-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220812101317.12380-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220812101317.12380-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Aug 2022 10:13:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9176

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 3542de6a5b159fac0e7ca84d77a57ea99125d6b1 upstream.

Don't use _HIZ macros but also provide a val. This is more consistent
with the other macros and, thus, easier to read. Also shorter.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20211119110442.4946-1-wsa+renesas@sang-engineering.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index b98eed3f3ab2..7163d93a6498 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -24,14 +24,13 @@
 #define RPCIF_CMNCR_MOIIO2(val)	(((val) & 0x3) << 20)
 #define RPCIF_CMNCR_MOIIO1(val)	(((val) & 0x3) << 18)
 #define RPCIF_CMNCR_MOIIO0(val)	(((val) & 0x3) << 16)
-#define RPCIF_CMNCR_MOIIO_HIZ	(RPCIF_CMNCR_MOIIO0(3) | \
-				 RPCIF_CMNCR_MOIIO1(3) | \
-				 RPCIF_CMNCR_MOIIO2(3) | RPCIF_CMNCR_MOIIO3(3))
+#define RPCIF_CMNCR_MOIIO(val)	(RPCIF_CMNCR_MOIIO0(val) | RPCIF_CMNCR_MOIIO1(val) | \
+				 RPCIF_CMNCR_MOIIO2(val) | RPCIF_CMNCR_MOIIO3(val))
 #define RPCIF_CMNCR_IO3FV(val)	(((val) & 0x3) << 14) /* documented for RZ/G2L */
 #define RPCIF_CMNCR_IO2FV(val)	(((val) & 0x3) << 12) /* documented for RZ/G2L */
 #define RPCIF_CMNCR_IO0FV(val)	(((val) & 0x3) << 8)
-#define RPCIF_CMNCR_IOFV_HIZ	(RPCIF_CMNCR_IO0FV(3) | RPCIF_CMNCR_IO2FV(3) | \
-				 RPCIF_CMNCR_IO3FV(3))
+#define RPCIF_CMNCR_IOFV(val)	(RPCIF_CMNCR_IO0FV(val) | RPCIF_CMNCR_IO2FV(val) | \
+				 RPCIF_CMNCR_IO3FV(val))
 #define RPCIF_CMNCR_BSZ(val)	(((val) & 0x3) << 0)
 
 #define RPCIF_SSLDR		0x0004	/* R/W */
@@ -335,17 +334,14 @@ int rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
 
 	if (rpc->type == RPCIF_RCAR_GEN3)
 		regmap_update_bits(rpc->regmap, RPCIF_CMNCR,
-				   RPCIF_CMNCR_MOIIO_HIZ | RPCIF_CMNCR_BSZ(3),
-				   RPCIF_CMNCR_MOIIO_HIZ |
+				   RPCIF_CMNCR_MOIIO(3) | RPCIF_CMNCR_BSZ(3),
+				   RPCIF_CMNCR_MOIIO(3) |
 				   RPCIF_CMNCR_BSZ(hyperflash ? 1 : 0));
 	else
 		regmap_update_bits(rpc->regmap, RPCIF_CMNCR,
-				   RPCIF_CMNCR_MOIIO_HIZ | RPCIF_CMNCR_IOFV_HIZ |
+				   RPCIF_CMNCR_MOIIO(3) | RPCIF_CMNCR_IOFV(3) |
 				   RPCIF_CMNCR_BSZ(3),
-				   RPCIF_CMNCR_MOIIO3(1) | RPCIF_CMNCR_MOIIO2(1) |
-				   RPCIF_CMNCR_MOIIO1(1) | RPCIF_CMNCR_MOIIO0(1) |
-				   RPCIF_CMNCR_IO3FV(2) | RPCIF_CMNCR_IO2FV(2) |
-				   RPCIF_CMNCR_IO0FV(2) |
+				   RPCIF_CMNCR_MOIIO(1) | RPCIF_CMNCR_IOFV(2) |
 				   RPCIF_CMNCR_BSZ(hyperflash ? 1 : 0));
 
 	/* Set RCF after BSZ update */
-- 
2.17.1


