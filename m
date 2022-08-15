Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE003C282E7
	for <webhook@archiver.kernel.org>; Mon, 15 Aug 2022 16:37:31 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web08.4591.1660581444601702642
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Aug 2022 09:37:25 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,238,1654527600";
   d="scan'208";a="131488432"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 16 Aug 2022 01:37:24 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8373540171F7;
	Tue, 16 Aug 2022 01:37:23 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 2/4] mmc: renesas_sdhi: Fix typo's
Date: Mon, 15 Aug 2022 17:37:16 +0100
Message-Id: <20220815163718.24056-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220815163718.24056-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220815163718.24056-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Aug 2022 16:37:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9214

commit 088604048b24846d1e79da4c2a73a6f3ad43edb4 upstream.

Fix typo's,
* difference -> different
* alignment -> aligned

While at it updated the comment to make it clear that Renesas SDHI DMAC
needs buffers to be 128-byte aligned.

Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20220624181438.4355-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index ff97f15e317c..bc6040be657b 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -179,7 +179,7 @@ renesas_sdhi_internal_dmac_dataend_dma(struct tmio_mmc_host *host) {
 }
 
 /*
- * renesas_sdhi_internal_dmac_map() will be called with two difference
+ * renesas_sdhi_internal_dmac_map() will be called with two different
  * sg pointers in two mmc_data by .pre_req(), but tmio host can have a single
  * sg_ptr only. So, renesas_sdhi_internal_dmac_{un}map() should use a sg
  * pointer in a mmc_data instead of host->sg_ptr.
@@ -213,7 +213,7 @@ renesas_sdhi_internal_dmac_map(struct tmio_mmc_host *host,
 
 	data->host_cookie = cookie;
 
-	/* This DMAC cannot handle if buffer is not 128-bytes alignment */
+	/* This DMAC needs buffers to be 128-byte aligned */
 	if (!IS_ALIGNED(sg_dma_address(data->sg), 128)) {
 		renesas_sdhi_internal_dmac_unmap(host, data, cookie);
 		return false;
-- 
2.17.1


