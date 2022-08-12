Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FBDC282E7
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 10:13:35 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.9106.1660299202951792196
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Aug 2022 03:13:30 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,231,1654527600";
   d="scan'208";a="131210697"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Aug 2022 19:13:29 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 875934243969;
	Fri, 12 Aug 2022 19:13:28 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 05/11] memory: renesas-rpc-if: Simplify
 single/double data register access
Date: Fri, 12 Aug 2022 11:13:11 +0100
Message-Id: <20220812101317.12380-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220812101317.12380-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220812101317.12380-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Aug 2022 10:13:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9177

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 1f26a60b55aa654c73b5b9eb9eab8a7d687d429d upstream.

For manual write and read, factor out the common access to the first
data register by keeping track of the current data pointer.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/c3b2a8d1a69f1b1e8d1a460148406cfb83e52eb4.1649857740.git.geert+renesas@glider.be
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 7163d93a6498..54ed31b862d4 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -489,7 +489,7 @@ int rpcif_manual_xfer(struct rpcif *rpc)
 	case RPCIF_DATA_OUT:
 		while (pos < rpc->xferlen) {
 			u32 bytes_left = rpc->xferlen - pos;
-			u32 nbytes, data[2];
+			u32 nbytes, data[2], *p = data;
 
 			smcr = rpc->smcr | RPCIF_SMCR_SPIE;
 
@@ -503,15 +503,9 @@ int rpcif_manual_xfer(struct rpcif *rpc)
 			rpc->xfer_size = nbytes;
 
 			memcpy(data, rpc->buffer + pos, nbytes);
-			if (nbytes == 8) {
-				regmap_write(rpc->regmap, RPCIF_SMWDR1,
-					     data[0]);
-				regmap_write(rpc->regmap, RPCIF_SMWDR0,
-					     data[1]);
-			} else {
-				regmap_write(rpc->regmap, RPCIF_SMWDR0,
-					     data[0]);
-			}
+			if (nbytes == 8)
+				regmap_write(rpc->regmap, RPCIF_SMWDR1, *p++);
+			regmap_write(rpc->regmap, RPCIF_SMWDR0, *p);
 
 			regmap_write(rpc->regmap, RPCIF_SMCR, smcr);
 			ret = wait_msg_xfer_end(rpc);
@@ -553,7 +547,7 @@ int rpcif_manual_xfer(struct rpcif *rpc)
 		}
 		while (pos < rpc->xferlen) {
 			u32 bytes_left = rpc->xferlen - pos;
-			u32 nbytes, data[2];
+			u32 nbytes, data[2], *p = data;
 
 			/* nbytes may only be 1, 2, 4, or 8 */
 			nbytes = bytes_left >= max ? max : (1 << ilog2(bytes_left));
@@ -570,15 +564,9 @@ int rpcif_manual_xfer(struct rpcif *rpc)
 			if (ret)
 				goto err_out;
 
-			if (nbytes == 8) {
-				regmap_read(rpc->regmap, RPCIF_SMRDR1,
-					    &data[0]);
-				regmap_read(rpc->regmap, RPCIF_SMRDR0,
-					    &data[1]);
-			} else {
-				regmap_read(rpc->regmap, RPCIF_SMRDR0,
-					    &data[0]);
-			}
+			if (nbytes == 8)
+				regmap_read(rpc->regmap, RPCIF_SMRDR1, p++);
+			regmap_read(rpc->regmap, RPCIF_SMRDR0, p);
 			memcpy(rpc->buffer + pos, data, nbytes);
 
 			pos += nbytes;
-- 
2.17.1


