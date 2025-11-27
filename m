Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A87FD116F7
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 11:29:56 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16615.1764242986753558087
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Nov 2025 03:29:50 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: oC8exFhhQbSCXJnFt9y5XA==
X-CSE-MsgGUID: SJk7Ln39SmOX6zX5qLkdHQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 27 Nov 2025 20:29:49 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.131])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 68320401091A;
	Thu, 27 Nov 2025 20:29:48 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 3/6] irqchip/renesas-rzv2h: Add rzv2h_icu_register_dma_req()
Date: Thu, 27 Nov 2025 11:29:38 +0000
Message-ID: <20251127112941.55300-4-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127112941.55300-1-ovidiu.panait.rb@renesas.com>
References: <20251127112941.55300-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Nov 2025 11:29:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20745

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

commit 9002b75aa8e6f034ffbd1c1ccac46927a1cf0f12 upstream.

On the Renesas RZ/V2H(P) family of SoCs, DMAC IPs are connected
to the Interrupt Control Unit (ICU).
For DMA transfers, a request number must be registered with the
ICU, which means that the DMAC driver has to be able to instruct
the ICU driver with the registration of such id.

Export rzv2h_icu_register_dma_req() so that the DMAC driver can
register the DMAC request number.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20250423143422.3747702-4-fabrizio.castro.jz@renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c       | 35 +++++++++++++++++++++++
 include/linux/irqchip/irq-renesas-rzv2h.h | 23 +++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 include/linux/irqchip/irq-renesas-rzv2h.h

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 194c94dafff8..1d03ee911b2a 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/irqchip.h>
+#include <linux/irqchip/irq-renesas-rzv2h.h>
 #include <linux/irqdomain.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
@@ -41,6 +42,8 @@
 #define ICU_TSCLR				0x24
 #define ICU_TITSR(k)				(0x28 + (k) * 4)
 #define ICU_TSSR(k)				(0x30 + (k) * 4)
+#define ICU_DMkSELy(k, y)			(0x420 + (k) * 0x20 + (y) * 4)
+#define ICU_DMACKSELk(k)			(0x500 + (k) * 4)
 
 /* NMI */
 #define ICU_NMI_EDGE_FALLING			0
@@ -103,6 +106,15 @@ struct rzv2h_hw_info {
 	u8		field_width;
 };
 
+/* DMAC */
+#define ICU_DMAC_DkRQ_SEL_MASK			GENMASK(9, 0)
+
+#define ICU_DMAC_DMAREQ_SHIFT(up)		((up) * 16)
+#define ICU_DMAC_DMAREQ_MASK(up)		(ICU_DMAC_DkRQ_SEL_MASK \
+						 << ICU_DMAC_DMAREQ_SHIFT(up))
+#define ICU_DMAC_PREP_DMAREQ(sel, up)		(FIELD_PREP(ICU_DMAC_DkRQ_SEL_MASK, (sel)) \
+						 << ICU_DMAC_DMAREQ_SHIFT(up))
+
 /**
  * struct rzv2h_icu_priv - Interrupt Control Unit controller private data structure.
  * @base:	Controller's base address
@@ -117,6 +129,27 @@ struct rzv2h_icu_priv {
 	const struct rzv2h_hw_info	*info;
 };
 
+void rzv2h_icu_register_dma_req(struct platform_device *icu_dev, u8 dmac_index, u8 dmac_channel,
+				u16 req_no)
+{
+	struct rzv2h_icu_priv *priv = platform_get_drvdata(icu_dev);
+	u32 icu_dmksely, dmareq, dmareq_mask;
+	u8 y, upper;
+
+	y = dmac_channel / 2;
+	upper = dmac_channel % 2;
+
+	dmareq = ICU_DMAC_PREP_DMAREQ(req_no, upper);
+	dmareq_mask = ICU_DMAC_DMAREQ_MASK(upper);
+
+	guard(raw_spinlock_irqsave)(&priv->lock);
+
+	icu_dmksely = readl(priv->base + ICU_DMkSELy(dmac_index, y));
+	icu_dmksely = (icu_dmksely & ~dmareq_mask) | dmareq;
+	writel(icu_dmksely, priv->base + ICU_DMkSELy(dmac_index, y));
+}
+EXPORT_SYMBOL_GPL(rzv2h_icu_register_dma_req);
+
 static inline struct rzv2h_icu_priv *irq_data_to_priv(struct irq_data *data)
 {
 	return data->domain->host_data;
@@ -493,6 +526,8 @@ static int rzv2h_icu_init_common(struct device_node *node, struct device_node *p
 	if (!rzv2h_icu_data)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, rzv2h_icu_data);
+
 	rzv2h_icu_data->base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
 	if (IS_ERR(rzv2h_icu_data->base))
 		return PTR_ERR(rzv2h_icu_data->base);
diff --git a/include/linux/irqchip/irq-renesas-rzv2h.h b/include/linux/irqchip/irq-renesas-rzv2h.h
new file mode 100644
index 000000000000..618a60d2eac0
--- /dev/null
+++ b/include/linux/irqchip/irq-renesas-rzv2h.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Renesas RZ/V2H(P) Interrupt Control Unit (ICU)
+ *
+ * Copyright (C) 2025 Renesas Electronics Corporation.
+ */
+
+#ifndef __LINUX_IRQ_RENESAS_RZV2H
+#define __LINUX_IRQ_RENESAS_RZV2H
+
+#include <linux/platform_device.h>
+
+#define RZV2H_ICU_DMAC_REQ_NO_DEFAULT		0x3ff
+
+#ifdef CONFIG_RENESAS_RZV2H_ICU
+void rzv2h_icu_register_dma_req(struct platform_device *icu_dev, u8 dmac_index, u8 dmac_channel,
+				u16 req_no);
+#else
+static inline void rzv2h_icu_register_dma_req(struct platform_device *icu_dev, u8 dmac_index,
+					      u8 dmac_channel, u16 req_no) { }
+#endif
+
+#endif /* __LINUX_IRQ_RENESAS_RZV2H */
-- 
2.51.0


