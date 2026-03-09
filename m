Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2610EF36F8
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 07:51:20 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9081.1773042679038559139
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 00:51:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=O5yAycrK;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439aeed8a5bso8629018f8f.3
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 00:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773042677; x=1773647477; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GVkV79pzap/c2NM606S5rGzzKXJhaQWLJxw+MkVRUI=;
        b=O5yAycrK0pGT046qhrqbgtIlYm4lBdVTuLla/5I/ud/PAADubYzYbc3YlcrECn8HKH
         rRWs0Dd3k510h725SGBHxHQibFKPQg4Lhxw0vYzM8Rd7r4+mUJEpkvxKEXg74SYgaogw
         1g2CD8Q1/2j3J3RcpyKLU/grTWhQrTGp4aicZypNE8dA44lePicWpxcKrlJvQPn+lWDD
         Y6Ytmb1WSbeUErzaRtUXX5okxGNZv4RQr2f+R2Bf7rQ3R9ZLsOSMw/JfK5G3E9bde3Pf
         yA4XsjCrPJOKUvb1h++5wcThEaMCsTC0vm6B5PnIs30xyxNg7YpHFUuOhqGzdZk7kCQd
         jp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773042677; x=1773647477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5GVkV79pzap/c2NM606S5rGzzKXJhaQWLJxw+MkVRUI=;
        b=ONy5QwMFOG7SbMFnNShtBTYBsNG6XCcXUNNDI40FKPuFAuiFDlWkxcC9ryTvfw7+us
         otl3ASZRTBoZhDpoY1bRd+AYoTheYmbni5+p0gInb3ETTE//zZusKW3DKuCoRc4ay8Bf
         bk1RwdRdIQ9xLyMELN2d3KEnpY1tMqOF0/H5cLx0GJ0P3jBi2Y2+1usy5Mpj2maoA/PU
         n4c9XTL4klDck7sNxZtbeciakR2lsG4Z5KjtM4AL4XdgNnAWHDjO+jhQY5oyj9FY2++Q
         HTEE340huvfLEsTFM2pr7Acd2HaWJdhdHgfW8xW4V4KuwbMNx6dkugaI0ww0VF7CiJwd
         3ccg==
X-Gm-Message-State: AOJu0YwB+EaVKlSsFiU6h6VRR6wuamjogLWcXJUkXbmReRI2ivnyZDaD
	9qeEF9HSAzLv4pB8+PvJD61SXqosAxJlDSicjT20rO0wOfBTcM3ZogHsLLSGxA==
X-Gm-Gg: ATEYQzxnmgDE6cdnyR/RngqBEER8qn1IVtXNlq/04xw9jDu0mF0D3c1eEgd8u9uMez8
	psa8KR1uq1ATY/Y9ygyCI5yDbWTDLNUsPNOxVbChR8UJ9wGcwU+d3f6SriSoj5StrVjCGH1MOdm
	asyllEINVD8wmRdwEykHcOC1izqPb2QGUI05sdFBnAbSkMPb9Zx/EtCcPX90NrvIWCwKYEF4WRK
	CG46Fu64jIlzld12APYx8WjvbN10XkfWk0SqgOYwUgQMX1ctB8RSSg7omomYHueP7ALqGY1mta6
	kq6LoAgv6t58pcSSDLGR1eZIqnTHPMsXaSLvuNpkvG1j7W8Gk1thkemEsCr5JZoU3tcYtX3y+YX
	n4XvU8i6krhnN3uPmNZaE3Q9w6PB+fTbRvG3jCQ5jRMphnU04//Wi+YZdOx4D+RBblFu3veKm1y
	BZZz9o5lw3DsGvO/EsUKxIHWGq2lC28UsSHg6MgD0f72RfFHfk
X-Received: by 2002:a05:6000:144c:b0:439:c4ea:41a0 with SMTP id ffacd0b85a97d-439da8a0402mr15076265f8f.59.1773042676772;
        Mon, 09 Mar 2026 00:51:16 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2ba06sm25639376f8f.24.2026.03.09.00.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 00:51:16 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 3/6] irqchip/renesas-rzv2h: Add suspend/resume support
Date: Mon,  9 Mar 2026 07:51:05 +0000
Message-ID: <20260309075112.35445-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309075112.35445-1-biju.das.jz@bp.renesas.com>
References: <20260309075112.35445-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:51:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22151

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 3a74e73b863a2493c0502a08e20ab026a0134ca1 ]

On RZ/G3E using PSCI, s2ram powers down the SoC. Add suspend/resume
callbacks to restore IRQ type for NMI, TINT and external IRQ interrupts.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260113125315.359967-3-biju.das.jz@bp.renesas.com
[ Biju:
  Dropped function parameter from rzv2h_irqc_irq_{suspend,resume}()
  Dropped rzv2h_irqc_syscore
  Dropped const qualifier from rzv2h_irqc_syscore_ops
  Replaced register_syscore->register_syscore_ops
]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 56 +++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 6096199cce52..ff3f84cfa8a1 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -20,6 +20,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/spinlock.h>
+#include <linux/syscore_ops.h>
 
 /* DT "interrupts" indexes */
 #define ICU_IRQ_START				1
@@ -91,6 +92,18 @@
 
 #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
 
+/**
+ * struct rzv2h_irqc_reg_cache - registers cache (necessary for suspend/resume)
+ * @nitsr: ICU_NITSR register
+ * @iitsr: ICU_IITSR register
+ * @titsr: ICU_TITSR registers
+ */
+struct rzv2h_irqc_reg_cache {
+	u32	nitsr;
+	u32	iitsr;
+	u32	titsr[2];
+};
+
 /**
  * struct rzv2h_hw_info - Interrupt Control Unit controller hardware info structure.
  * @tssel_lut:		TINT lookup table
@@ -120,13 +133,15 @@ struct rzv2h_hw_info {
  * @fwspec:	IRQ firmware specific data
  * @lock:	Lock to serialize access to hardware registers
  * @info:	Pointer to struct rzv2h_hw_info
+ * @cache:	Registers cache for suspend/resume
  */
-struct rzv2h_icu_priv {
+static struct rzv2h_icu_priv {
 	void __iomem			*base;
 	struct irq_fwspec		fwspec[ICU_NUM_IRQ];
 	raw_spinlock_t			lock;
 	const struct rzv2h_hw_info	*info;
-};
+	struct rzv2h_irqc_reg_cache	cache;
+} *rzv2h_icu_data;
 
 void rzv2h_icu_register_dma_req(struct platform_device *icu_dev, u8 dmac_index, u8 dmac_channel,
 				u16 req_no)
@@ -421,6 +436,40 @@ static int rzv2h_icu_set_type(struct irq_data *d, unsigned int type)
 	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
 }
 
+static int rzv2h_irqc_irq_suspend(void)
+{
+	struct rzv2h_irqc_reg_cache *cache = &rzv2h_icu_data->cache;
+	void __iomem *base = rzv2h_icu_data->base;
+
+	cache->nitsr = readl_relaxed(base + ICU_NITSR);
+	cache->iitsr = readl_relaxed(base + ICU_IITSR);
+	for (unsigned int i = 0; i < 2; i++)
+		cache->titsr[i] = readl_relaxed(base + rzv2h_icu_data->info->t_offs + ICU_TITSR(i));
+
+	return 0;
+}
+
+static void rzv2h_irqc_irq_resume(void)
+{
+	struct rzv2h_irqc_reg_cache *cache = &rzv2h_icu_data->cache;
+	void __iomem *base = rzv2h_icu_data->base;
+
+	/*
+	 * Restore only interrupt type. TSSRx will be restored at the
+	 * request of pin controller to avoid spurious interrupts due
+	 * to invalid PIN states.
+	 */
+	for (unsigned int i = 0; i < 2; i++)
+		writel_relaxed(cache->titsr[i], base + rzv2h_icu_data->info->t_offs + ICU_TITSR(i));
+	writel_relaxed(cache->iitsr, base + ICU_IITSR);
+	writel_relaxed(cache->nitsr, base + ICU_NITSR);
+}
+
+static struct syscore_ops rzv2h_irqc_syscore_ops = {
+	.suspend	= rzv2h_irqc_irq_suspend,
+	.resume		= rzv2h_irqc_irq_resume,
+};
+
 static const struct irq_chip rzv2h_icu_chip = {
 	.name			= "rzv2h-icu",
 	.irq_eoi		= rzv2h_icu_eoi,
@@ -508,7 +557,6 @@ static int rzv2h_icu_init_common(struct device_node *node, struct device_node *p
 				 const struct rzv2h_hw_info *hw_info)
 {
 	struct irq_domain *irq_domain, *parent_domain;
-	struct rzv2h_icu_priv *rzv2h_icu_data;
 	struct platform_device *pdev;
 	struct reset_control *resetn;
 	int ret;
@@ -575,6 +623,8 @@ static int rzv2h_icu_init_common(struct device_node *node, struct device_node *p
 
 	rzv2h_icu_data->info = hw_info;
 
+	register_syscore_ops(&rzv2h_irqc_syscore_ops);
+
 	/*
 	 * coccicheck complains about a missing put_device call before returning, but it's a false
 	 * positive. We still need &pdev->dev after successfully returning from this function.
-- 
2.43.0


