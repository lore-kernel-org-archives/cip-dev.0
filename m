Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5551DD116F6
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 11:29:56 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16616.1764242986845629606
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Nov 2025 03:29:47 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: zzqJt9j4QPuTPui73YA4ZQ==
X-CSE-MsgGUID: Zc7cBa0ET2StX5feNTmPxw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 27 Nov 2025 20:29:46 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.131])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id DFC1B401091A;
	Thu, 27 Nov 2025 20:29:44 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 1/6] dmaengine: dmatest: prevent using swiotlb buffer with nobounce parameter
Date: Thu, 27 Nov 2025 11:29:36 +0000
Message-ID: <20251127112941.55300-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127112941.55300-1-ovidiu.panait.rb@renesas.com>
References: <20251127112941.55300-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Nov 2025 11:29:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20743

From: Amelie Delaunay <amelie.delaunay@foss.st.com>

commit 70f008fb3ea9bd2e6727eebc858405acd49a212b upstream.

Source and destination data buffers are allocated with GPF_KERNEL flag.
It means that, if the DDR is more than 2GB, buffers can be allocated above
the 32-bit addressable space. In this case, and if the dma controller is
only 32-bit compatible, swiotlb bounce buffer, located in the 32-bit
addressable space, is used and introduces a memcpy.

To prevent this extra memcpy, due to swiotlb bounce buffer use because
source or destination data buffer is allocated above the 32-bit addressable
space, force source and destination data buffers allocation with GPF_DMA
instead, when nobounce parameter is true.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Link: https://lore.kernel.org/r/20231124160235.2459326-1-amelie.delaunay@foss.st.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/dma/dmatest.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index ffe621695e47..a4f608837849 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -21,6 +21,10 @@
 #include <linux/slab.h>
 #include <linux/wait.h>
 
+static bool nobounce;
+module_param(nobounce, bool, 0644);
+MODULE_PARM_DESC(nobounce, "Prevent using swiotlb buffer (default: use swiotlb buffer)");
+
 static unsigned int test_buf_size = 16384;
 module_param(test_buf_size, uint, 0644);
 MODULE_PARM_DESC(test_buf_size, "Size of the memcpy test buffer");
@@ -90,6 +94,7 @@ MODULE_PARM_DESC(polled, "Use polling for completion instead of interrupts");
 
 /**
  * struct dmatest_params - test parameters.
+ * @nobounce:		prevent using swiotlb buffer
  * @buf_size:		size of the memcpy test buffer
  * @channel:		bus ID of the channel to test
  * @device:		bus ID of the DMA Engine to test
@@ -106,6 +111,7 @@ MODULE_PARM_DESC(polled, "Use polling for completion instead of interrupts");
  * @polled:		use polling for completion instead of interrupts
  */
 struct dmatest_params {
+	bool		nobounce;
 	unsigned int	buf_size;
 	char		channel[20];
 	char		device[32];
@@ -215,6 +221,7 @@ struct dmatest_done {
 struct dmatest_data {
 	u8		**raw;
 	u8		**aligned;
+	gfp_t		gfp_flags;
 	unsigned int	cnt;
 	unsigned int	off;
 };
@@ -533,7 +540,7 @@ static int dmatest_alloc_test_data(struct dmatest_data *d,
 		goto err;
 
 	for (i = 0; i < d->cnt; i++) {
-		d->raw[i] = kmalloc(buf_size + align, GFP_KERNEL);
+		d->raw[i] = kmalloc(buf_size + align, d->gfp_flags);
 		if (!d->raw[i])
 			goto err;
 
@@ -655,6 +662,13 @@ static int dmatest_func(void *data)
 		goto err_free_coefs;
 	}
 
+	src->gfp_flags = GFP_KERNEL;
+	dst->gfp_flags = GFP_KERNEL;
+	if (params->nobounce) {
+		src->gfp_flags = GFP_DMA;
+		dst->gfp_flags = GFP_DMA;
+	}
+
 	if (dmatest_alloc_test_data(src, buf_size, align) < 0)
 		goto err_free_coefs;
 
@@ -1093,6 +1107,7 @@ static void add_threaded_test(struct dmatest_info *info)
 	struct dmatest_params *params = &info->params;
 
 	/* Copy test parameters */
+	params->nobounce = nobounce;
 	params->buf_size = test_buf_size;
 	strscpy(params->channel, strim(test_channel), sizeof(params->channel));
 	strscpy(params->device, strim(test_device), sizeof(params->device));
-- 
2.51.0


