Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D91D711D5
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 08:00:09 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.76406.1766390404027715137
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 00:00:04 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: Miv6khmzR5ijQHk3b6ZEJw==
X-CSE-MsgGUID: VvveErNpT/Cid7fQR3Pe5w==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 22 Dec 2025 17:00:03 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4383840E227B;
	Mon, 22 Dec 2025 17:00:01 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 1/1] dmaengine: sh: rz-dmac: handle configs where one address is zero
Date: Mon, 22 Dec 2025 07:59:49 +0000
Message-ID: <20251222075949.58472-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222075949.58472-1-ovidiu.panait.rb@renesas.com>
References: <20251222075949.58472-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 08:00:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21185

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 6e9c5c8ef2820d18492d07172ac52f23ea8a54d9 upstream.

Configs like the ones coming from the MMC subsystem will have either
'src' or 'dst' zeroed, resulting in an unknown bus width. This will bail
out on the RZ DMA driver because of the sanity check for a valid bus
width. Reorder the code, so that the check will only be applied when the
corresponding address is non-zero.

Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20241007110200.43166-6-wsa+renesas@sang-engineering.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 32850608d4c4..40bccd1746d5 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -625,22 +625,25 @@ static int rz_dmac_config(struct dma_chan *chan,
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
 	u32 val;
 
-	channel->src_per_address = config->src_addr;
 	channel->dst_per_address = config->dst_addr;
-
-	val = rz_dmac_ds_to_val_mapping(config->dst_addr_width);
-	if (val == CHCFG_DS_INVALID)
-		return -EINVAL;
-
 	channel->chcfg &= ~CHCFG_FILL_DDS_MASK;
-	channel->chcfg |= FIELD_PREP(CHCFG_FILL_DDS_MASK, val);
+	if (channel->dst_per_address) {
+		val = rz_dmac_ds_to_val_mapping(config->dst_addr_width);
+		if (val == CHCFG_DS_INVALID)
+			return -EINVAL;
 
-	val = rz_dmac_ds_to_val_mapping(config->src_addr_width);
-	if (val == CHCFG_DS_INVALID)
-		return -EINVAL;
+		channel->chcfg |= FIELD_PREP(CHCFG_FILL_DDS_MASK, val);
+	}
 
+	channel->src_per_address = config->src_addr;
 	channel->chcfg &= ~CHCFG_FILL_SDS_MASK;
-	channel->chcfg |= FIELD_PREP(CHCFG_FILL_SDS_MASK, val);
+	if (channel->src_per_address) {
+		val = rz_dmac_ds_to_val_mapping(config->src_addr_width);
+		if (val == CHCFG_DS_INVALID)
+			return -EINVAL;
+
+		channel->chcfg |= FIELD_PREP(CHCFG_FILL_SDS_MASK, val);
+	}
 
 	return 0;
 }
-- 
2.51.0


