Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBCAEF3711
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 08:11:42 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9255.1773043895463909205
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 01:11:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=a0MvcuHZ;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852f73d0a3so12406205e9.3
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 01:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773043894; x=1773648694; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsG4o7EzrFJzgvWOjQM9gCn6BXEzLaT35BtwCw/87Qk=;
        b=a0MvcuHZhYYOCDs1BoMPcVIDNwQp9YKJH0VeDHNF3RuEVv/v7avGmfMTDZOX6kQ2y7
         mqNNnOvz8Stz4/75n0NeIjUvJp8tAEg9geSdGDIuHp9QMj16M1LPUUTOt42r7ekXVQBG
         uc5ZS3CIau6jMlVLCYJ5lVvafOJQb55kkoYhvEtTzJaoLMxsZ9hkl1hDiqy6E0dgmFEC
         7HHTGltRcH8RuJRmMSyu6U5aH1zfsqzw3Q90/l3OnHYPJ0nfdZSY42PQa3gW/h0zgX3x
         ILjpnfoEWgMkvtPXWlVN/QIOk4vShgd7vf0momXzhO1WkFisnqbzwHOyTyf52uAFpidB
         232Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773043894; x=1773648694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CsG4o7EzrFJzgvWOjQM9gCn6BXEzLaT35BtwCw/87Qk=;
        b=GvL9QGiuA+gpfDgX8MbMtSENTJBOsNhF0PTtnrRYf/gT0y6N+Wl/VWhlvePgZxW9ao
         +VV5uouoQWy7J4KbGfTlszBlRdciAksfuaeal4/C0vi672WSXAtMSa1zOZn3/vWnix7Y
         PrCo+QjQ9QxgfCF9lp+sr0z7O4rrgZXw3rjvBoQnLqfKVHwvObBosDikINZZEMJoNVwt
         rB0huBUHpTpldCsAjfougQXSx53sEAJWR6omShpK9rXSha79Jhc67zgNXwyo+Zp4zo4M
         4j7V1aUB2tEPTFR/gvNR62joSM/exiRWncGeHpwWZyJcNgZx27e1rZlC94aF5GGzaQ3f
         BY5g==
X-Gm-Message-State: AOJu0YyfLdjn3SSQ6DJA39V2vAhft4LxylnkChfKdL3soAAxD2tifzIZ
	df8VulwQHQotoCik/JK+8ann9Kigj2A9j589XtuazWnbJFD9Bq75y2iYyg6c5w==
X-Gm-Gg: ATEYQzzgQACHf2pZQ50P101cpJTBIJfkLgvqJv3ekDaeauspKxI+cTKzTGXXtncpIfe
	v/KUeN+XDlMlLqPTn1eHb5e4zk8INR5qJV2SO4ZJ0l3aC1qvfx5h7xIP5RW1j9wYVHJ/W5UbNtr
	NCe7PuO6vD/aIlEUGSO09MPuJH2WwgdvA1A60m9jMWjovfs+KGiuEYEvWejiQyHYR1+zOV7l4Ha
	a2WnFXKMpWcjqe1RLyacxx6P64IODXUYZwHdcx9qzOA6O5IU8rvxWFPIN8/OgOA3ft17J8+gNAo
	DppNvMKwbynzq5gZA/3uBh8HnFRsk/xSo+2mIa6/3fp8mtDUwBC37MqlKKhnwSy1DcHO259r6dQ
	kUcAa3luf8baIEuOHG99gsRAOsz87YJKusvZ/5r35s0cTvkgPyFcwxP3gHNk478IKlJ7AIujllX
	QVc1CRNjZQM/Fc5SSkWai96umWf9BevxYw+eNQKENdObbXsbFm
X-Received: by 2002:a05:600c:474f:b0:485:35d3:ce73 with SMTP id 5b1f17b1804b1-48535d3cf36mr75931795e9.32.1773043893368;
        Mon, 09 Mar 2026 01:11:33 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853f8f9938sm4252135e9.23.2026.03.09.01.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 01:11:32 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 3/6] irqchip/renesas-rzv2h: Add suspend/resume support
Date: Mon,  9 Mar 2026 08:11:23 +0000
Message-ID: <20260309081129.154109-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309081129.154109-1-biju.das.jz@bp.renesas.com>
References: <20260309081129.154109-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 08:11:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22158

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
index 118c1fc177f6..7a3e9d6248dc 100644
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
@@ -573,6 +621,8 @@ static int rzv2h_icu_init_common(struct device_node *node, struct device_node *p
 
 	rzv2h_icu_data->info = hw_info;
 
+	register_syscore_ops(&rzv2h_irqc_syscore_ops);
+
 	/*
 	 * coccicheck complains about a missing put_device call before returning, but it's a false
 	 * positive. We still need &pdev->dev after successfully returning from this function.
-- 
2.43.0


