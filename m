From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Nov 2019 13:00:32 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 02/17] mmc: renesas-sdhi: rename
	tmio_mmc_dma.c => renesas_sdhi_sys_dmac.c
In-Reply-To: <1574341247-46652-1-git-send-email-biju.das@bp.renesas.com>
References: <1574341247-46652-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574341247-46652-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

commit c2a96987c76f093be50550130f5629723b091176 upstream.

Rename the source file for DMA for SDHI as a follow-up to attaching
DMA code to the SDHI driver rather than the tmio_core driver.

The name "renesas" is chosen as the SDHI driver is applicable to a wider
range of SoCs than SH-Mobile it seems to be a more appropriate name.
However, the SDHI driver source itself, is left as sh_mobile_sdhi to
avoid unnecessary churn.

The name sys_dmac was chosen to reflect the type of DMA used.

Internal symbols have also been renamed to reflect the filename change.

A follow-up patch will re-organise the SDHI driver removing
the need for renesas_sdhi_get_dma_ops().

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/Makefile                |   2 +-
 drivers/mmc/host/renesas_sdhi.h          |  18 ++
 drivers/mmc/host/renesas_sdhi_sys_dmac.c | 368 +++++++++++++++++++++++++++++++
 drivers/mmc/host/sh_mobile_sdhi.c        |   3 +-
 drivers/mmc/host/tmio_mmc.h              |   9 -
 drivers/mmc/host/tmio_mmc_dma.c          | 365 ------------------------------
 6 files changed, 389 insertions(+), 376 deletions(-)
 create mode 100644 drivers/mmc/host/renesas_sdhi.h
 create mode 100644 drivers/mmc/host/renesas_sdhi_sys_dmac.c
 delete mode 100644 drivers/mmc/host/tmio_mmc_dma.c

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 2b75a43..7ab00194 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -36,7 +36,7 @@ obj-$(CONFIG_MMC_S3C)   	+= s3cmci.o
 obj-$(CONFIG_MMC_SDRICOH_CS)	+= sdricoh_cs.o
 obj-$(CONFIG_MMC_TMIO)		+= tmio_mmc.o
 obj-$(CONFIG_MMC_TMIO_CORE)	+= tmio_mmc_core.o
-obj-$(CONFIG_MMC_SDHI)		+= sh_mobile_sdhi.o tmio_mmc_dma.o
+obj-$(CONFIG_MMC_SDHI)		+= sh_mobile_sdhi.o renesas_sdhi_sys_dmac.o
 obj-$(CONFIG_MMC_CB710)		+= cb710-mmc.o
 obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
 obj-$(CONFIG_SDH_BFIN)		+= bfin_sdh.o
diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
new file mode 100644
index 0000000..f65d936c
--- /dev/null
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -0,0 +1,18 @@
+/*
+ * Renesas Mobile SDHI
+ *
+ * Copyright (C) 2017 Horms Solutions Ltd., Simon Horman
+ * Copyright (C) 2017 Renesas Electronics Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef RENESAS_SDHI_H
+#define RENESAS_SDHI_H
+
+#include "tmio_mmc.h"
+
+const struct tmio_mmc_dma_ops *renesas_sdhi_get_dma_ops(void);
+#endif
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
new file mode 100644
index 0000000..ca96e33
--- /dev/null
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -0,0 +1,368 @@
+/*
+ * DMA function for TMIO MMC implementations
+ *
+ * Copyright (C) 2010-2011 Guennadi Liakhovetski
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/mfd/tmio.h>
+#include <linux/mmc/host.h>
+#include <linux/pagemap.h>
+#include <linux/scatterlist.h>
+
+#include "tmio_mmc.h"
+
+#define TMIO_MMC_MIN_DMA_LEN 8
+
+static void renesas_sdhi_sys_dmac_enable_dma(struct tmio_mmc_host *host,
+					     bool enable)
+{
+	if (!host->chan_tx || !host->chan_rx)
+		return;
+
+	if (host->dma->enable)
+		host->dma->enable(host, enable);
+}
+
+static void renesas_sdhi_sys_dmac_abort_dma(struct tmio_mmc_host *host)
+{
+	renesas_sdhi_sys_dmac_enable_dma(host, false);
+
+	if (host->chan_rx)
+		dmaengine_terminate_all(host->chan_rx);
+	if (host->chan_tx)
+		dmaengine_terminate_all(host->chan_tx);
+
+	renesas_sdhi_sys_dmac_enable_dma(host, true);
+}
+
+static void renesas_sdhi_sys_dmac_dma_callback(void *arg)
+{
+	struct tmio_mmc_host *host = arg;
+
+	wait_for_completion(&host->dma_dataend);
+
+	spin_lock_irq(&host->lock);
+
+	if (!host->data)
+		goto out;
+
+	if (host->data->flags & MMC_DATA_READ)
+		dma_unmap_sg(host->chan_rx->device->dev,
+			     host->sg_ptr, host->sg_len,
+			     DMA_FROM_DEVICE);
+	else
+		dma_unmap_sg(host->chan_tx->device->dev,
+			     host->sg_ptr, host->sg_len,
+			     DMA_TO_DEVICE);
+
+	tmio_mmc_do_data_irq(host);
+out:
+	spin_unlock_irq(&host->lock);
+}
+
+static void renesas_sdhi_sys_dmac_start_dma_rx(struct tmio_mmc_host *host)
+{
+	struct scatterlist *sg = host->sg_ptr, *sg_tmp;
+	struct dma_async_tx_descriptor *desc = NULL;
+	struct dma_chan *chan = host->chan_rx;
+	dma_cookie_t cookie;
+	int ret, i;
+	bool aligned = true, multiple = true;
+	unsigned int align = (1 << host->pdata->alignment_shift) - 1;
+
+	for_each_sg(sg, sg_tmp, host->sg_len, i) {
+		if (sg_tmp->offset & align)
+			aligned = false;
+		if (sg_tmp->length & align) {
+			multiple = false;
+			break;
+		}
+	}
+
+	if ((!aligned && (host->sg_len > 1 || sg->length > PAGE_CACHE_SIZE ||
+			  (align & PAGE_MASK))) || !multiple) {
+		ret = -EINVAL;
+		goto pio;
+	}
+
+	if (sg->length < TMIO_MMC_MIN_DMA_LEN) {
+		host->force_pio = true;
+		return;
+	}
+
+	tmio_mmc_disable_mmc_irqs(host, TMIO_STAT_RXRDY);
+
+	/* The only sg element can be unaligned, use our bounce buffer then */
+	if (!aligned) {
+		sg_init_one(&host->bounce_sg, host->bounce_buf, sg->length);
+		host->sg_ptr = &host->bounce_sg;
+		sg = host->sg_ptr;
+	}
+
+	ret = dma_map_sg(chan->device->dev, sg, host->sg_len, DMA_FROM_DEVICE);
+	if (ret > 0)
+		desc = dmaengine_prep_slave_sg(chan, sg, ret,
+			DMA_DEV_TO_MEM, DMA_CTRL_ACK);
+
+	if (desc) {
+		reinit_completion(&host->dma_dataend);
+		desc->callback = renesas_sdhi_sys_dmac_dma_callback;
+		desc->callback_param = host;
+
+		cookie = dmaengine_submit(desc);
+		if (cookie < 0) {
+			desc = NULL;
+			ret = cookie;
+		}
+	}
+pio:
+	if (!desc) {
+		/* DMA failed, fall back to PIO */
+		renesas_sdhi_sys_dmac_enable_dma(host, false);
+		if (ret >= 0)
+			ret = -EIO;
+		host->chan_rx = NULL;
+		dma_release_channel(chan);
+		/* Free the Tx channel too */
+		chan = host->chan_tx;
+		if (chan) {
+			host->chan_tx = NULL;
+			dma_release_channel(chan);
+		}
+		dev_warn(&host->pdev->dev,
+			 "DMA failed: %d, falling back to PIO\n", ret);
+	}
+}
+
+static void renesas_sdhi_sys_dmac_start_dma_tx(struct tmio_mmc_host *host)
+{
+	struct scatterlist *sg = host->sg_ptr, *sg_tmp;
+	struct dma_async_tx_descriptor *desc = NULL;
+	struct dma_chan *chan = host->chan_tx;
+	dma_cookie_t cookie;
+	int ret, i;
+	bool aligned = true, multiple = true;
+	unsigned int align = (1 << host->pdata->alignment_shift) - 1;
+
+	for_each_sg(sg, sg_tmp, host->sg_len, i) {
+		if (sg_tmp->offset & align)
+			aligned = false;
+		if (sg_tmp->length & align) {
+			multiple = false;
+			break;
+		}
+	}
+
+	if ((!aligned && (host->sg_len > 1 || sg->length > PAGE_CACHE_SIZE ||
+			  (align & PAGE_MASK))) || !multiple) {
+		ret = -EINVAL;
+		goto pio;
+	}
+
+	if (sg->length < TMIO_MMC_MIN_DMA_LEN) {
+		host->force_pio = true;
+		return;
+	}
+
+	tmio_mmc_disable_mmc_irqs(host, TMIO_STAT_TXRQ);
+
+	/* The only sg element can be unaligned, use our bounce buffer then */
+	if (!aligned) {
+		unsigned long flags;
+		void *sg_vaddr = tmio_mmc_kmap_atomic(sg, &flags);
+		sg_init_one(&host->bounce_sg, host->bounce_buf, sg->length);
+		memcpy(host->bounce_buf, sg_vaddr, host->bounce_sg.length);
+		tmio_mmc_kunmap_atomic(sg, &flags, sg_vaddr);
+		host->sg_ptr = &host->bounce_sg;
+		sg = host->sg_ptr;
+	}
+
+	ret = dma_map_sg(chan->device->dev, sg, host->sg_len, DMA_TO_DEVICE);
+	if (ret > 0)
+		desc = dmaengine_prep_slave_sg(chan, sg, ret,
+			DMA_MEM_TO_DEV, DMA_CTRL_ACK);
+
+	if (desc) {
+		reinit_completion(&host->dma_dataend);
+		desc->callback = renesas_sdhi_sys_dmac_dma_callback;
+		desc->callback_param = host;
+
+		cookie = dmaengine_submit(desc);
+		if (cookie < 0) {
+			desc = NULL;
+			ret = cookie;
+		}
+	}
+pio:
+	if (!desc) {
+		/* DMA failed, fall back to PIO */
+		renesas_sdhi_sys_dmac_enable_dma(host, false);
+		if (ret >= 0)
+			ret = -EIO;
+		host->chan_tx = NULL;
+		dma_release_channel(chan);
+		/* Free the Rx channel too */
+		chan = host->chan_rx;
+		if (chan) {
+			host->chan_rx = NULL;
+			dma_release_channel(chan);
+		}
+		dev_warn(&host->pdev->dev,
+			 "DMA failed: %d, falling back to PIO\n", ret);
+	}
+}
+
+static void renesas_sdhi_sys_dmac_start_dma(struct tmio_mmc_host *host,
+			       struct mmc_data *data)
+{
+	if (data->flags & MMC_DATA_READ) {
+		if (host->chan_rx)
+			renesas_sdhi_sys_dmac_start_dma_rx(host);
+	} else {
+		if (host->chan_tx)
+			renesas_sdhi_sys_dmac_start_dma_tx(host);
+	}
+}
+
+static void renesas_sdhi_sys_dmac_issue_tasklet_fn(unsigned long priv)
+{
+	struct tmio_mmc_host *host = (struct tmio_mmc_host *)priv;
+	struct dma_chan *chan = NULL;
+
+	spin_lock_irq(&host->lock);
+
+	if (host && host->data) {
+		if (host->data->flags & MMC_DATA_READ)
+			chan = host->chan_rx;
+		else
+			chan = host->chan_tx;
+	}
+
+	spin_unlock_irq(&host->lock);
+
+	tmio_mmc_enable_mmc_irqs(host, TMIO_STAT_DATAEND);
+
+	if (chan)
+		dma_async_issue_pending(chan);
+}
+
+static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
+					      struct tmio_mmc_data *pdata)
+{
+	/* We can only either use DMA for both Tx and Rx or not use it at all */
+	if (!host->dma || (!host->pdev->dev.of_node &&
+		(!pdata->chan_priv_tx || !pdata->chan_priv_rx)))
+		return;
+
+	if (!host->chan_tx && !host->chan_rx) {
+		struct resource *res = platform_get_resource(host->pdev,
+							     IORESOURCE_MEM, 0);
+		struct dma_slave_config cfg = {};
+		dma_cap_mask_t mask;
+		int ret;
+
+		if (!res)
+			return;
+
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+
+		host->chan_tx = dma_request_slave_channel_compat(mask,
+					host->dma->filter, pdata->chan_priv_tx,
+					&host->pdev->dev, "tx");
+		dev_dbg(&host->pdev->dev, "%s: TX: got channel %p\n", __func__,
+			host->chan_tx);
+
+		if (!host->chan_tx)
+			return;
+
+		cfg.direction = DMA_MEM_TO_DEV;
+		cfg.dst_addr = res->start + (CTL_SD_DATA_PORT << host->bus_shift);
+		cfg.dst_addr_width = host->dma->dma_buswidth;
+		if (!cfg.dst_addr_width)
+			cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		cfg.src_addr = 0;
+		ret = dmaengine_slave_config(host->chan_tx, &cfg);
+		if (ret < 0)
+			goto ecfgtx;
+
+		host->chan_rx = dma_request_slave_channel_compat(mask,
+					host->dma->filter, pdata->chan_priv_rx,
+					&host->pdev->dev, "rx");
+		dev_dbg(&host->pdev->dev, "%s: RX: got channel %p\n", __func__,
+			host->chan_rx);
+
+		if (!host->chan_rx)
+			goto ereqrx;
+
+		cfg.direction = DMA_DEV_TO_MEM;
+		cfg.src_addr = cfg.dst_addr + host->pdata->dma_rx_offset;
+		cfg.src_addr_width = host->dma->dma_buswidth;
+		if (!cfg.src_addr_width)
+			cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		cfg.dst_addr = 0;
+		ret = dmaengine_slave_config(host->chan_rx, &cfg);
+		if (ret < 0)
+			goto ecfgrx;
+
+		host->bounce_buf = (u8 *)__get_free_page(GFP_KERNEL | GFP_DMA);
+		if (!host->bounce_buf)
+			goto ebouncebuf;
+
+		init_completion(&host->dma_dataend);
+		tasklet_init(&host->dma_issue,
+			     renesas_sdhi_sys_dmac_issue_tasklet_fn,
+			     (unsigned long)host);
+	}
+
+	renesas_sdhi_sys_dmac_enable_dma(host, true);
+
+	return;
+
+ebouncebuf:
+ecfgrx:
+	dma_release_channel(host->chan_rx);
+	host->chan_rx = NULL;
+ereqrx:
+ecfgtx:
+	dma_release_channel(host->chan_tx);
+	host->chan_tx = NULL;
+}
+
+static void renesas_sdhi_sys_dmac_release_dma(struct tmio_mmc_host *host)
+{
+	if (host->chan_tx) {
+		struct dma_chan *chan = host->chan_tx;
+		host->chan_tx = NULL;
+		dma_release_channel(chan);
+	}
+	if (host->chan_rx) {
+		struct dma_chan *chan = host->chan_rx;
+		host->chan_rx = NULL;
+		dma_release_channel(chan);
+	}
+	if (host->bounce_buf) {
+		free_pages((unsigned long)host->bounce_buf, 0);
+		host->bounce_buf = NULL;
+	}
+}
+
+static const struct tmio_mmc_dma_ops renesas_sdhi_sys_dmac_dma_ops = {
+	.start = renesas_sdhi_sys_dmac_start_dma,
+	.enable = renesas_sdhi_sys_dmac_enable_dma,
+	.request = renesas_sdhi_sys_dmac_request_dma,
+	.release = renesas_sdhi_sys_dmac_release_dma,
+	.abort = renesas_sdhi_sys_dmac_abort_dma,
+};
+
+const struct tmio_mmc_dma_ops *renesas_sdhi_get_dma_ops(void)
+{
+	return &renesas_sdhi_sys_dmac_dma_ops;
+}
diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 05edac3..8ca9860 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -35,6 +35,7 @@
 #include <linux/pinctrl/pinctrl-state.h>
 #include <linux/regulator/consumer.h>
 
+#include "renesas_sdhi.h"
 #include "tmio_mmc.h"
 
 #define EXT_ACC           0xe4
@@ -643,7 +644,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	/* All SDHI have SDIO status bits which must be 1 */
 	mmc_data->flags |= TMIO_MMC_SDIO_STATUS_SETBITS;
 
-	ret = tmio_mmc_host_probe(host, mmc_data, tmio_mmc_get_dma_ops());
+	ret = tmio_mmc_host_probe(host, mmc_data, renesas_sdhi_get_dma_ops());
 	if (ret < 0)
 		goto efree;
 
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 86aa49f3..cd5b4f3 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -212,15 +212,6 @@ void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 void tmio_mmc_disable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 irqreturn_t tmio_mmc_irq(int irq, void *devid);
 
-#if IS_ENABLED(CONFIG_MMC_SDHI)
-const struct tmio_mmc_dma_ops *tmio_mmc_get_dma_ops(void);
-#else
-static inline const struct tmio_mmc_dma_ops *tmio_mmc_get_dma_ops(void)
-{
-	return NULL;
-}
-#endif
-
 static inline char *tmio_mmc_kmap_atomic(struct scatterlist *sg,
 					 unsigned long *flags)
 {
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
deleted file mode 100644
index e743684..0000000
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ /dev/null
@@ -1,365 +0,0 @@
-/*
- * DMA function for TMIO MMC implementations
- *
- * Copyright (C) 2010-2011 Guennadi Liakhovetski
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/device.h>
-#include <linux/dma-mapping.h>
-#include <linux/dmaengine.h>
-#include <linux/mfd/tmio.h>
-#include <linux/mmc/host.h>
-#include <linux/pagemap.h>
-#include <linux/scatterlist.h>
-
-#include "tmio_mmc.h"
-
-#define TMIO_MMC_MIN_DMA_LEN 8
-
-static void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
-{
-	if (!host->chan_tx || !host->chan_rx)
-		return;
-
-	if (host->dma->enable)
-		host->dma->enable(host, enable);
-}
-
-static void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
-{
-	tmio_mmc_enable_dma(host, false);
-
-	if (host->chan_rx)
-		dmaengine_terminate_all(host->chan_rx);
-	if (host->chan_tx)
-		dmaengine_terminate_all(host->chan_tx);
-
-	tmio_mmc_enable_dma(host, true);
-}
-
-static void tmio_mmc_dma_callback(void *arg)
-{
-	struct tmio_mmc_host *host = arg;
-
-	wait_for_completion(&host->dma_dataend);
-
-	spin_lock_irq(&host->lock);
-
-	if (!host->data)
-		goto out;
-
-	if (host->data->flags & MMC_DATA_READ)
-		dma_unmap_sg(host->chan_rx->device->dev,
-			     host->sg_ptr, host->sg_len,
-			     DMA_FROM_DEVICE);
-	else
-		dma_unmap_sg(host->chan_tx->device->dev,
-			     host->sg_ptr, host->sg_len,
-			     DMA_TO_DEVICE);
-
-	tmio_mmc_do_data_irq(host);
-out:
-	spin_unlock_irq(&host->lock);
-}
-
-static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
-{
-	struct scatterlist *sg = host->sg_ptr, *sg_tmp;
-	struct dma_async_tx_descriptor *desc = NULL;
-	struct dma_chan *chan = host->chan_rx;
-	dma_cookie_t cookie;
-	int ret, i;
-	bool aligned = true, multiple = true;
-	unsigned int align = (1 << host->pdata->alignment_shift) - 1;
-
-	for_each_sg(sg, sg_tmp, host->sg_len, i) {
-		if (sg_tmp->offset & align)
-			aligned = false;
-		if (sg_tmp->length & align) {
-			multiple = false;
-			break;
-		}
-	}
-
-	if ((!aligned && (host->sg_len > 1 || sg->length > PAGE_CACHE_SIZE ||
-			  (align & PAGE_MASK))) || !multiple) {
-		ret = -EINVAL;
-		goto pio;
-	}
-
-	if (sg->length < TMIO_MMC_MIN_DMA_LEN) {
-		host->force_pio = true;
-		return;
-	}
-
-	tmio_mmc_disable_mmc_irqs(host, TMIO_STAT_RXRDY);
-
-	/* The only sg element can be unaligned, use our bounce buffer then */
-	if (!aligned) {
-		sg_init_one(&host->bounce_sg, host->bounce_buf, sg->length);
-		host->sg_ptr = &host->bounce_sg;
-		sg = host->sg_ptr;
-	}
-
-	ret = dma_map_sg(chan->device->dev, sg, host->sg_len, DMA_FROM_DEVICE);
-	if (ret > 0)
-		desc = dmaengine_prep_slave_sg(chan, sg, ret,
-			DMA_DEV_TO_MEM, DMA_CTRL_ACK);
-
-	if (desc) {
-		reinit_completion(&host->dma_dataend);
-		desc->callback = tmio_mmc_dma_callback;
-		desc->callback_param = host;
-
-		cookie = dmaengine_submit(desc);
-		if (cookie < 0) {
-			desc = NULL;
-			ret = cookie;
-		}
-	}
-pio:
-	if (!desc) {
-		/* DMA failed, fall back to PIO */
-		tmio_mmc_enable_dma(host, false);
-		if (ret >= 0)
-			ret = -EIO;
-		host->chan_rx = NULL;
-		dma_release_channel(chan);
-		/* Free the Tx channel too */
-		chan = host->chan_tx;
-		if (chan) {
-			host->chan_tx = NULL;
-			dma_release_channel(chan);
-		}
-		dev_warn(&host->pdev->dev,
-			 "DMA failed: %d, falling back to PIO\n", ret);
-	}
-}
-
-static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
-{
-	struct scatterlist *sg = host->sg_ptr, *sg_tmp;
-	struct dma_async_tx_descriptor *desc = NULL;
-	struct dma_chan *chan = host->chan_tx;
-	dma_cookie_t cookie;
-	int ret, i;
-	bool aligned = true, multiple = true;
-	unsigned int align = (1 << host->pdata->alignment_shift) - 1;
-
-	for_each_sg(sg, sg_tmp, host->sg_len, i) {
-		if (sg_tmp->offset & align)
-			aligned = false;
-		if (sg_tmp->length & align) {
-			multiple = false;
-			break;
-		}
-	}
-
-	if ((!aligned && (host->sg_len > 1 || sg->length > PAGE_CACHE_SIZE ||
-			  (align & PAGE_MASK))) || !multiple) {
-		ret = -EINVAL;
-		goto pio;
-	}
-
-	if (sg->length < TMIO_MMC_MIN_DMA_LEN) {
-		host->force_pio = true;
-		return;
-	}
-
-	tmio_mmc_disable_mmc_irqs(host, TMIO_STAT_TXRQ);
-
-	/* The only sg element can be unaligned, use our bounce buffer then */
-	if (!aligned) {
-		unsigned long flags;
-		void *sg_vaddr = tmio_mmc_kmap_atomic(sg, &flags);
-		sg_init_one(&host->bounce_sg, host->bounce_buf, sg->length);
-		memcpy(host->bounce_buf, sg_vaddr, host->bounce_sg.length);
-		tmio_mmc_kunmap_atomic(sg, &flags, sg_vaddr);
-		host->sg_ptr = &host->bounce_sg;
-		sg = host->sg_ptr;
-	}
-
-	ret = dma_map_sg(chan->device->dev, sg, host->sg_len, DMA_TO_DEVICE);
-	if (ret > 0)
-		desc = dmaengine_prep_slave_sg(chan, sg, ret,
-			DMA_MEM_TO_DEV, DMA_CTRL_ACK);
-
-	if (desc) {
-		reinit_completion(&host->dma_dataend);
-		desc->callback = tmio_mmc_dma_callback;
-		desc->callback_param = host;
-
-		cookie = dmaengine_submit(desc);
-		if (cookie < 0) {
-			desc = NULL;
-			ret = cookie;
-		}
-	}
-pio:
-	if (!desc) {
-		/* DMA failed, fall back to PIO */
-		tmio_mmc_enable_dma(host, false);
-		if (ret >= 0)
-			ret = -EIO;
-		host->chan_tx = NULL;
-		dma_release_channel(chan);
-		/* Free the Rx channel too */
-		chan = host->chan_rx;
-		if (chan) {
-			host->chan_rx = NULL;
-			dma_release_channel(chan);
-		}
-		dev_warn(&host->pdev->dev,
-			 "DMA failed: %d, falling back to PIO\n", ret);
-	}
-}
-
-static void tmio_mmc_start_dma(struct tmio_mmc_host *host,
-			       struct mmc_data *data)
-{
-	if (data->flags & MMC_DATA_READ) {
-		if (host->chan_rx)
-			tmio_mmc_start_dma_rx(host);
-	} else {
-		if (host->chan_tx)
-			tmio_mmc_start_dma_tx(host);
-	}
-}
-
-static void tmio_mmc_issue_tasklet_fn(unsigned long priv)
-{
-	struct tmio_mmc_host *host = (struct tmio_mmc_host *)priv;
-	struct dma_chan *chan = NULL;
-
-	spin_lock_irq(&host->lock);
-
-	if (host && host->data) {
-		if (host->data->flags & MMC_DATA_READ)
-			chan = host->chan_rx;
-		else
-			chan = host->chan_tx;
-	}
-
-	spin_unlock_irq(&host->lock);
-
-	tmio_mmc_enable_mmc_irqs(host, TMIO_STAT_DATAEND);
-
-	if (chan)
-		dma_async_issue_pending(chan);
-}
-
-static void tmio_mmc_request_dma(struct tmio_mmc_host *host,
-				 struct tmio_mmc_data *pdata)
-{
-	/* We can only either use DMA for both Tx and Rx or not use it at all */
-	if (!host->dma || (!host->pdev->dev.of_node &&
-		(!pdata->chan_priv_tx || !pdata->chan_priv_rx)))
-		return;
-
-	if (!host->chan_tx && !host->chan_rx) {
-		struct resource *res = platform_get_resource(host->pdev,
-							     IORESOURCE_MEM, 0);
-		struct dma_slave_config cfg = {};
-		dma_cap_mask_t mask;
-		int ret;
-
-		if (!res)
-			return;
-
-		dma_cap_zero(mask);
-		dma_cap_set(DMA_SLAVE, mask);
-
-		host->chan_tx = dma_request_slave_channel_compat(mask,
-					host->dma->filter, pdata->chan_priv_tx,
-					&host->pdev->dev, "tx");
-		dev_dbg(&host->pdev->dev, "%s: TX: got channel %p\n", __func__,
-			host->chan_tx);
-
-		if (!host->chan_tx)
-			return;
-
-		cfg.direction = DMA_MEM_TO_DEV;
-		cfg.dst_addr = res->start + (CTL_SD_DATA_PORT << host->bus_shift);
-		cfg.dst_addr_width = host->dma->dma_buswidth;
-		if (!cfg.dst_addr_width)
-			cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
-		cfg.src_addr = 0;
-		ret = dmaengine_slave_config(host->chan_tx, &cfg);
-		if (ret < 0)
-			goto ecfgtx;
-
-		host->chan_rx = dma_request_slave_channel_compat(mask,
-					host->dma->filter, pdata->chan_priv_rx,
-					&host->pdev->dev, "rx");
-		dev_dbg(&host->pdev->dev, "%s: RX: got channel %p\n", __func__,
-			host->chan_rx);
-
-		if (!host->chan_rx)
-			goto ereqrx;
-
-		cfg.direction = DMA_DEV_TO_MEM;
-		cfg.src_addr = cfg.dst_addr + host->pdata->dma_rx_offset;
-		cfg.src_addr_width = host->dma->dma_buswidth;
-		if (!cfg.src_addr_width)
-			cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
-		cfg.dst_addr = 0;
-		ret = dmaengine_slave_config(host->chan_rx, &cfg);
-		if (ret < 0)
-			goto ecfgrx;
-
-		host->bounce_buf = (u8 *)__get_free_page(GFP_KERNEL | GFP_DMA);
-		if (!host->bounce_buf)
-			goto ebouncebuf;
-
-		init_completion(&host->dma_dataend);
-		tasklet_init(&host->dma_issue, tmio_mmc_issue_tasklet_fn, (unsigned long)host);
-	}
-
-	tmio_mmc_enable_dma(host, true);
-
-	return;
-
-ebouncebuf:
-ecfgrx:
-	dma_release_channel(host->chan_rx);
-	host->chan_rx = NULL;
-ereqrx:
-ecfgtx:
-	dma_release_channel(host->chan_tx);
-	host->chan_tx = NULL;
-}
-
-static void tmio_mmc_release_dma(struct tmio_mmc_host *host)
-{
-	if (host->chan_tx) {
-		struct dma_chan *chan = host->chan_tx;
-		host->chan_tx = NULL;
-		dma_release_channel(chan);
-	}
-	if (host->chan_rx) {
-		struct dma_chan *chan = host->chan_rx;
-		host->chan_rx = NULL;
-		dma_release_channel(chan);
-	}
-	if (host->bounce_buf) {
-		free_pages((unsigned long)host->bounce_buf, 0);
-		host->bounce_buf = NULL;
-	}
-}
-
-static const struct tmio_mmc_dma_ops tmio_mmc_dma_ops = {
-	.start = tmio_mmc_start_dma,
-	.enable = tmio_mmc_enable_dma,
-	.request = tmio_mmc_request_dma,
-	.release = tmio_mmc_release_dma,
-	.abort = tmio_mmc_abort_dma,
-};
-
-const struct tmio_mmc_dma_ops *tmio_mmc_get_dma_ops(void)
-{
-	return &tmio_mmc_dma_ops;
-}
-- 
2.7.4
