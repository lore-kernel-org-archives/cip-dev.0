Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE41BC54E67
	for <webhook@archiver.kernel.org>; Fri, 15 Mar 2024 17:03:17 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.1377.1710522190846788783
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Mar 2024 10:03:11 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.07,128,1708354800"; 
   d="scan'208";a="197911855"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Mar 2024 02:03:09 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.63])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 377BE4001B74;
	Sat, 16 Mar 2024 02:03:07 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 1/3] memory: renesas-rpc-if: Clear HS bit during hardware initialization
Date: Fri, 15 Mar 2024 17:03:02 +0000
Message-Id: <20240315170304.31604-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315170304.31604-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240315170304.31604-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Mar 2024 17:03:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15330

From: Cong Dang <cong.dang.xn@renesas.com>

commit 5192481f908e576be42bd39ec12979b79e11f7e0 upstream.

According to the datasheet, HS bit should be specified to 1 when using
DMA transfer. As DMA transfer is not supported, it should be cleared to
0.

Previously, the driver relied on the HS bit being cleared by prior
firmware but this is not always the case.

Fix this by ensuring the bit is cleared during hardware initialization.

Fixes: ca7d8b980b67 ("memory: add Renesas RPC-IF driver")
Signed-off-by: Cong Dang <cong.dang.xn@renesas.com>
Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/08d9fb10b3051decebf871267a6e2e7cb2d4faf9.1665583089.git.geert+renesas@glider.be
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 6a096a033651..598180b2adaf 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -318,6 +318,9 @@ int rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
 	regmap_update_bits(rpc->regmap, RPCIF_PHYCNT, RPCIF_PHYCNT_PHYMEM_MASK,
 			   RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0));
 
+	/* DMA Transfer is not supported */
+	regmap_update_bits(rpc->regmap, RPCIF_PHYCNT, RPCIF_PHYCNT_HS, 0);
+
 	if (rpc->type == RPCIF_RCAR_GEN3)
 		regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
 				   RPCIF_PHYCNT_STRTIM(7), RPCIF_PHYCNT_STRTIM(7));
-- 
2.34.1


