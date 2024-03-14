Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32802C54E5D
	for <webhook@archiver.kernel.org>; Thu, 14 Mar 2024 19:30:12 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.1789.1710444599362286876
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Mar 2024 12:30:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.07,126,1708354800"; 
   d="scan'208";a="201703511"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Mar 2024 04:30:04 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.128])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 20A384001B5F;
	Fri, 15 Mar 2024 04:30:02 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 4.19.y-cip 6/9] memory: renesas-rpc-if: Simplify single/double data register access
Date: Thu, 14 Mar 2024 19:29:47 +0000
Message-Id: <20240314192950.27343-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240314192950.27343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240314192950.27343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Mar 2024 19:30:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15314

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
index ae1aa4d5aa68..2a58e95861ab 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -461,7 +461,7 @@ int rpcif_manual_xfer(struct rpcif *rpc)
 	case RPCIF_DATA_OUT:
 		while (pos < rpc->xferlen) {
 			u32 bytes_left = rpc->xferlen - pos;
-			u32 nbytes, data[2];
+			u32 nbytes, data[2], *p = data;
 
 			smcr = rpc->smcr | RPCIF_SMCR_SPIE;
 
@@ -475,15 +475,9 @@ int rpcif_manual_xfer(struct rpcif *rpc)
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
@@ -525,7 +519,7 @@ int rpcif_manual_xfer(struct rpcif *rpc)
 		}
 		while (pos < rpc->xferlen) {
 			u32 bytes_left = rpc->xferlen - pos;
-			u32 nbytes, data[2];
+			u32 nbytes, data[2], *p = data;
 
 			/* nbytes may only be 1, 2, 4, or 8 */
 			nbytes = bytes_left >= max ? max : (1 << ilog2(bytes_left));
@@ -542,15 +536,9 @@ int rpcif_manual_xfer(struct rpcif *rpc)
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
2.34.1


