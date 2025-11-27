Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DC0CFD2F6
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 11:30:26 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16539.1764243017745651992
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Nov 2025 03:30:22 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: bPYo4rJCRciEhI4gQLoGHg==
X-CSE-MsgGUID: w76l8rmGR4KZak9muWIj7w==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 27 Nov 2025 20:30:22 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.131])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 43F87401091A;
	Thu, 27 Nov 2025 20:30:20 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 4/5] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
Date: Thu, 27 Nov 2025 11:30:11 +0000
Message-ID: <20251127113012.55325-5-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127113012.55325-1-ovidiu.panait.rb@renesas.com>
References: <20251127113012.55325-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Nov 2025 11:30:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20753

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

commit 7de873201c44bff5b42f2e560098d463843b8a4c upstream.

The DMAC IP found on the Renesas RZ/V2H(P) family of SoCs is
similar to the version found on the Renesas RZ/G2L family of
SoCs, but there are some differences:
* It only uses one register area
* It only uses one clock
* It only uses one reset
* Instead of using MID/IRD it uses REQ No
* It is connected to the Interrupt Control Unit (ICU)
* On the RZ/G2L there is only 1 DMAC, on the RZ/V2H(P) there are 5

Add specific support for the Renesas RZ/V2H(P) family of SoC by
tackling the aforementioned differences.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20250423143422.3747702-6-fabrizio.castro.jz@renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 81 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index ea05703071cc..ab963f0fcc0f 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -14,6 +14,7 @@
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
+#include <linux/irqchip/irq-renesas-rzv2h.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -89,8 +90,14 @@ struct rz_dmac_chan {
 
 #define to_rz_dmac_chan(c)	container_of(c, struct rz_dmac_chan, vc.chan)
 
+struct rz_dmac_icu {
+	struct platform_device *pdev;
+	u8 dmac_index;
+};
+
 struct rz_dmac {
 	struct dma_device engine;
+	struct rz_dmac_icu icu;
 	struct device *dev;
 	struct reset_control *rstc;
 	void __iomem *base;
@@ -99,6 +106,8 @@ struct rz_dmac {
 	unsigned int n_channels;
 	struct rz_dmac_chan *channels;
 
+	bool has_icu;
+
 	DECLARE_BITMAP(modules, 1024);
 };
 
@@ -167,6 +176,9 @@ struct rz_dmac {
 #define RZ_DMAC_MAX_CHANNELS		16
 #define DMAC_NR_LMDESC			64
 
+/* RZ/V2H ICU related */
+#define RZV2H_MAX_DMAC_INDEX		4
+
 /*
  * -----------------------------------------------------------------------------
  * Device access
@@ -324,7 +336,13 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
 	lmdesc->chext = 0;
 	lmdesc->header = HEADER_LV;
 
-	rz_dmac_set_dmars_register(dmac, channel->index, 0);
+	if (dmac->has_icu) {
+		rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
+					   channel->index,
+					   RZV2H_ICU_DMAC_REQ_NO_DEFAULT);
+	} else {
+		rz_dmac_set_dmars_register(dmac, channel->index, 0);
+	}
 
 	channel->chcfg = chcfg;
 	channel->chctrl = CHCTRL_STG | CHCTRL_SETEN;
@@ -375,7 +393,13 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
 
 	channel->lmdesc.tail = lmdesc;
 
-	rz_dmac_set_dmars_register(dmac, channel->index, channel->mid_rid);
+	if (dmac->has_icu) {
+		rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
+					   channel->index, channel->mid_rid);
+	} else {
+		rz_dmac_set_dmars_register(dmac, channel->index, channel->mid_rid);
+	}
+
 	channel->chctrl = CHCTRL_SETEN;
 }
 
@@ -647,7 +671,13 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
 	if (ret < 0)
 		dev_warn(dmac->dev, "DMA Timeout");
 
-	rz_dmac_set_dmars_register(dmac, channel->index, 0);
+	if (dmac->has_icu) {
+		rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
+					   channel->index,
+					   RZV2H_ICU_DMAC_REQ_NO_DEFAULT);
+	} else {
+		rz_dmac_set_dmars_register(dmac, channel->index, 0);
+	}
 }
 
 /*
@@ -824,6 +854,38 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	return 0;
 }
 
+static int rz_dmac_parse_of_icu(struct device *dev, struct rz_dmac *dmac)
+{
+	struct device_node *np = dev->of_node;
+	struct of_phandle_args args;
+	uint32_t dmac_index;
+	int ret;
+
+	ret = of_parse_phandle_with_fixed_args(np, "renesas,icu", 1, 0, &args);
+	if (ret == -ENOENT)
+		return 0;
+	if (ret)
+		return ret;
+
+	dmac->has_icu = true;
+
+	dmac->icu.pdev = of_find_device_by_node(args.np);
+	of_node_put(args.np);
+	if (!dmac->icu.pdev) {
+		dev_err(dev, "ICU device not found.\n");
+		return -ENODEV;
+	}
+
+	dmac_index = args.args[0];
+	if (dmac_index > RZV2H_MAX_DMAC_INDEX) {
+		dev_err(dev, "DMAC index %u invalid.\n", dmac_index);
+		return -EINVAL;
+	}
+	dmac->icu.dmac_index = dmac_index;
+
+	return 0;
+}
+
 static int rz_dmac_parse_of(struct device *dev, struct rz_dmac *dmac)
 {
 	struct device_node *np = dev->of_node;
@@ -840,7 +902,7 @@ static int rz_dmac_parse_of(struct device *dev, struct rz_dmac *dmac)
 		return -EINVAL;
 	}
 
-	return 0;
+	return rz_dmac_parse_of_icu(dev, dmac);
 }
 
 static int rz_dmac_probe(struct platform_device *pdev)
@@ -874,9 +936,11 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	if (IS_ERR(dmac->base))
 		return PTR_ERR(dmac->base);
 
-	dmac->ext_base = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(dmac->ext_base))
-		return PTR_ERR(dmac->ext_base);
+	if (!dmac->has_icu) {
+		dmac->ext_base = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(dmac->ext_base))
+			return PTR_ERR(dmac->ext_base);
+	}
 
 	/* Register interrupt handler for error */
 	irq = platform_get_irq_byname(pdev, irqname);
@@ -991,9 +1055,12 @@ static void rz_dmac_remove(struct platform_device *pdev)
 	reset_control_assert(dmac->rstc);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+
+	platform_device_put(dmac->icu.pdev);
 }
 
 static const struct of_device_id of_rz_dmac_match[] = {
+	{ .compatible = "renesas,r9a09g057-dmac", },
 	{ .compatible = "renesas,rz-dmac", },
 	{ /* Sentinel */ }
 };
-- 
2.51.0


