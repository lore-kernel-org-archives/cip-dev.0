Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E01C64EC6
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:49 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.3726.1648842178937058012
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 12:43:01 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,228,1643641200";
   d="scan'208";a="116465342"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Apr 2022 04:43:00 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id F02C2401143D;
	Sat,  2 Apr 2022 04:42:58 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [RESEND PATCH 5.10.y-cip 14/40] mmc: renesas_internal_dmac: add
 pre_req and post_req support
Date: Fri,  1 Apr 2022 20:42:08 +0100
Message-Id: <20220401194234.14057-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7925

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 69e7d76afdb54243df957351804c0f1afca46d0f upstream.

Add pre_req and post_req support to improve performance.

Inspired by a patch in the BSP by Masaharu Hayakawa.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/1608114572-1892-3-git-send-email-yoshihiro.shimoda.uh@renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 91 +++++++++++++++++--
 1 file changed, 83 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index f3e76d6b3e3f..ff97f15e317c 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -56,6 +56,12 @@
 #define INFO2_DTRANERR1		BIT(17)
 #define INFO2_DTRANERR0		BIT(16)
 
+enum renesas_sdhi_dma_cookie {
+	COOKIE_UNMAPPED,
+	COOKIE_PRE_MAPPED,
+	COOKIE_MAPPED,
+};
+
 /*
  * Specification of this driver:
  * - host->chan_{rx,tx} will be used as a flag of enabling/disabling the dma
@@ -172,6 +178,50 @@ renesas_sdhi_internal_dmac_dataend_dma(struct tmio_mmc_host *host) {
 	tasklet_schedule(&priv->dma_priv.dma_complete);
 }
 
+/*
+ * renesas_sdhi_internal_dmac_map() will be called with two difference
+ * sg pointers in two mmc_data by .pre_req(), but tmio host can have a single
+ * sg_ptr only. So, renesas_sdhi_internal_dmac_{un}map() should use a sg
+ * pointer in a mmc_data instead of host->sg_ptr.
+ */
+static void
+renesas_sdhi_internal_dmac_unmap(struct tmio_mmc_host *host,
+				 struct mmc_data *data,
+				 enum renesas_sdhi_dma_cookie cookie)
+{
+	bool unmap = cookie == COOKIE_UNMAPPED ? (data->host_cookie != cookie) :
+						 (data->host_cookie == cookie);
+
+	if (unmap) {
+		dma_unmap_sg(&host->pdev->dev, data->sg, data->sg_len,
+			     mmc_get_dma_dir(data));
+		data->host_cookie = COOKIE_UNMAPPED;
+	}
+}
+
+static bool
+renesas_sdhi_internal_dmac_map(struct tmio_mmc_host *host,
+			       struct mmc_data *data,
+			       enum renesas_sdhi_dma_cookie cookie)
+{
+	if (data->host_cookie == COOKIE_PRE_MAPPED)
+		return true;
+
+	if (!dma_map_sg(&host->pdev->dev, data->sg, data->sg_len,
+			    mmc_get_dma_dir(data)))
+		return false;
+
+	data->host_cookie = cookie;
+
+	/* This DMAC cannot handle if buffer is not 128-bytes alignment */
+	if (!IS_ALIGNED(sg_dma_address(data->sg), 128)) {
+		renesas_sdhi_internal_dmac_unmap(host, data, cookie);
+		return false;
+	}
+
+	return true;
+}
+
 static void
 renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc_host *host,
 				     struct mmc_data *data)
@@ -182,14 +232,9 @@ renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc_host *host,
 	if (!test_bit(SDHI_INTERNAL_DMAC_ADDR_MODE_FIXED_ONLY, &global_flags))
 		dtran_mode |= DTRAN_MODE_ADDR_MODE;
 
-	if (!dma_map_sg(&host->pdev->dev, sg, host->sg_len,
-			mmc_get_dma_dir(data)))
+	if (!renesas_sdhi_internal_dmac_map(host, data, COOKIE_MAPPED))
 		goto force_pio;
 
-	/* This DMAC cannot handle if buffer is not 128-bytes alignment */
-	if (!IS_ALIGNED(sg_dma_address(sg), 128))
-		goto force_pio_with_unmap;
-
 	if (data->flags & MMC_DATA_READ) {
 		dtran_mode |= DTRAN_MODE_CH_NUM_CH1;
 		if (test_bit(SDHI_INTERNAL_DMAC_ONE_RX_ONLY, &global_flags) &&
@@ -212,7 +257,7 @@ renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc_host *host,
 	return;
 
 force_pio_with_unmap:
-	dma_unmap_sg(&host->pdev->dev, sg, host->sg_len, mmc_get_dma_dir(data));
+	renesas_sdhi_internal_dmac_unmap(host, data, COOKIE_UNMAPPED);
 
 force_pio:
 	renesas_sdhi_internal_dmac_enable_dma(host, false);
@@ -245,7 +290,7 @@ static bool renesas_sdhi_internal_dmac_complete(struct tmio_mmc_host *host)
 		dir = DMA_TO_DEVICE;
 
 	renesas_sdhi_internal_dmac_enable_dma(host, false);
-	dma_unmap_sg(&host->pdev->dev, host->sg_ptr, host->sg_len, dir);
+	renesas_sdhi_internal_dmac_unmap(host, host->data, COOKIE_MAPPED);
 
 	if (dir == DMA_FROM_DEVICE)
 		clear_bit(SDHI_INTERNAL_DMAC_RX_IN_USE, &global_flags);
@@ -274,6 +319,32 @@ static void renesas_sdhi_internal_dmac_end_dma(struct tmio_mmc_host *host)
 		renesas_sdhi_internal_dmac_complete(host);
 }
 
+static void renesas_sdhi_internal_dmac_post_req(struct mmc_host *mmc,
+						struct mmc_request *mrq,
+						int err)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct mmc_data *data = mrq->data;
+
+	if (!data)
+		return;
+
+	renesas_sdhi_internal_dmac_unmap(host, data, COOKIE_UNMAPPED);
+}
+
+static void renesas_sdhi_internal_dmac_pre_req(struct mmc_host *mmc,
+					       struct mmc_request *mrq)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct mmc_data *data = mrq->data;
+
+	if (!data)
+		return;
+
+	data->host_cookie = COOKIE_UNMAPPED;
+	renesas_sdhi_internal_dmac_map(host, data, COOKIE_PRE_MAPPED);
+}
+
 static void
 renesas_sdhi_internal_dmac_request_dma(struct tmio_mmc_host *host,
 				       struct tmio_mmc_data *pdata)
@@ -295,6 +366,10 @@ renesas_sdhi_internal_dmac_request_dma(struct tmio_mmc_host *host,
 	tasklet_init(&host->dma_issue,
 		     renesas_sdhi_internal_dmac_issue_tasklet_fn,
 		     (unsigned long)host);
+
+	/* Add pre_req and post_req */
+	host->ops.pre_req = renesas_sdhi_internal_dmac_pre_req;
+	host->ops.post_req = renesas_sdhi_internal_dmac_post_req;
 }
 
 static void
-- 
2.17.1


