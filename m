Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B3AE7717D
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 09:11:59 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.33054.1733476314916232608
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Dec 2024 01:11:55 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: BZmdc3foSNOgljsfsXrz4w==
X-CSE-MsgGUID: BhWB0eLRQJKfToWFRwWS4g==
X-IronPort-AV: E=Sophos;i="6.12,213,1728918000"; 
   d="scan'208";a="231085724"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Dec 2024 18:11:55 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C1C9641F4DE1;
	Fri,  6 Dec 2024 18:11:44 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 11/16] memory: renesas-rpc-if: Improve Runtime PM handling
Date: Fri,  6 Dec 2024 09:11:17 +0000
Message-ID: <20241206091122.67133-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206091122.67133-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241206091122.67133-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Dec 2024 09:11:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17353

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit bb0b025d72d22b8617df920b61f5ae1e23d1b593 upstream.

Convert from the deprecated pm_runtime_get_sync() to the new
pm_runtime_resume_and_get(), and add error checking.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/6f2bd3b2b3d98c5bed541d969900b2ad04f93943.1669213027.git.geert+renesas@glider.be
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 27f4083b51fe..0e88c49a98c6 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -303,12 +303,13 @@ int rpcif_hw_init(struct rpcif *rpcif, bool hyperflash)
 {
 	struct rpcif_priv *rpc = dev_get_drvdata(rpcif->dev);
 	u32 dummy;
+	int ret;
 
-	pm_runtime_get_sync(rpc->dev);
+	ret = pm_runtime_resume_and_get(rpc->dev);
+	if (ret)
+		return ret;
 
 	if (rpc->type == RPCIF_RZ_G2L) {
-		int ret;
-
 		ret = reset_control_reset(rpc->rstc);
 		if (ret)
 			return ret;
@@ -477,7 +478,9 @@ int rpcif_manual_xfer(struct rpcif *rpcif)
 	u32 smenr, smcr, pos = 0, max = rpc->bus_size == 2 ? 8 : 4;
 	int ret = 0;
 
-	pm_runtime_get_sync(rpc->dev);
+	ret = pm_runtime_resume_and_get(rpc->dev);
+	if (ret < 0)
+		return ret;
 
 	regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
 			   RPCIF_PHYCNT_CAL, RPCIF_PHYCNT_CAL);
@@ -645,11 +648,14 @@ ssize_t rpcif_dirmap_read(struct rpcif *rpcif, u64 offs, size_t len, void *buf)
 	struct rpcif_priv *rpc = dev_get_drvdata(rpcif->dev);
 	loff_t from = offs & (rpc->size - 1);
 	size_t size = rpc->size - from;
+	int ret;
 
 	if (len > size)
 		len = size;
 
-	pm_runtime_get_sync(rpc->dev);
+	ret = pm_runtime_resume_and_get(rpc->dev);
+	if (ret < 0)
+		return ret;
 
 	regmap_update_bits(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_MD, 0);
 	regmap_write(rpc->regmap, RPCIF_DRCR, 0);
-- 
2.43.0


