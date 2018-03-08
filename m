From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu,  8 Mar 2018 16:45:45 +0000
Subject: [cip-dev] [RFC/PATCH] dmaengine: ensure dmaengine helpers check
	valid callback
Message-ID: <1520527545-4515-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Vinod Koul <vinod.koul@intel.com>

dmaengine has various device callbacks and exposes helper
functions to invoke these. These helpers should check if channel,
device and callback is valid or not before invoking them.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
(cherry picked from commit 757d12e5849be549076901b0d33c60d5f360269c)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Jianming Qiao <jianming.qiao@bp.renesas.com>
---
Hello Ben,

we have stumbled upon a problem, and discovered there was this fix
upstream we would like to backport.

Do you think this should go through v4.4 LTS first or are you happy
to take it?

Thanks,
Fab

 include/linux/dmaengine.h | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index c47c68e..a16d185 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -767,6 +767,9 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
 	sg_dma_address(&sg) = buf;
 	sg_dma_len(&sg) = len;
 
+	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
+		return NULL;
+
 	return chan->device->device_prep_slave_sg(chan, &sg, 1,
 						  dir, flags, NULL);
 }
@@ -775,6 +778,9 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg(
 	struct dma_chan *chan, struct scatterlist *sgl,	unsigned int sg_len,
 	enum dma_transfer_direction dir, unsigned long flags)
 {
+	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
+		return NULL;
+
 	return chan->device->device_prep_slave_sg(chan, sgl, sg_len,
 						  dir, flags, NULL);
 }
@@ -786,6 +792,9 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_rio_sg(
 	enum dma_transfer_direction dir, unsigned long flags,
 	struct rio_dma_ext *rio_ext)
 {
+	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
+		return NULL;
+
 	return chan->device->device_prep_slave_sg(chan, sgl, sg_len,
 						  dir, flags, rio_ext);
 }
@@ -796,6 +805,9 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_cyclic(
 		size_t period_len, enum dma_transfer_direction dir,
 		unsigned long flags)
 {
+	if (!chan || !chan->device || !chan->device->device_prep_dma_cyclic)
+		return NULL;
+
 	return chan->device->device_prep_dma_cyclic(chan, buf_addr, buf_len,
 						period_len, dir, flags);
 }
@@ -804,6 +816,9 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_interleaved_dma(
 		struct dma_chan *chan, struct dma_interleaved_template *xt,
 		unsigned long flags)
 {
+	if (!chan || !chan->device || !chan->device->device_prep_interleaved_dma)
+		return NULL;
+
 	return chan->device->device_prep_interleaved_dma(chan, xt, flags);
 }
 
@@ -811,7 +826,7 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memset(
 		struct dma_chan *chan, dma_addr_t dest, int value, size_t len,
 		unsigned long flags)
 {
-	if (!chan || !chan->device)
+	if (!chan || !chan->device || !chan->device->device_prep_dma_memset)
 		return NULL;
 
 	return chan->device->device_prep_dma_memset(chan, dest, value,
@@ -824,6 +839,9 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_sg(
 		struct scatterlist *src_sg, unsigned int src_nents,
 		unsigned long flags)
 {
+	if (!chan || !chan->device || !chan->device->device_prep_dma_sg)
+		return NULL;
+
 	return chan->device->device_prep_dma_sg(chan, dst_sg, dst_nents,
 			src_sg, src_nents, flags);
 }
-- 
2.7.4
