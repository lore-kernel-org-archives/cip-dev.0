Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016DCC4450A
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:18 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89142.1783073288744014724
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:08:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=nzj2bNzV;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493b7612475so3544975e9.3
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073287; x=1783678087; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LV0ZBakC0JP3nIeGblYk4ekY9ZFEoRUPFnAuhWbBJIY=;
        b=nzj2bNzVcEWcJFmd717LfQVE0ZMCAFWudwxPO5FM0cVG/QuKLofwAlthWihdd3Rcl7
         WEa00qjIuCq+z6nR2wBsbZqmLur8NYq+SUSeMnPik3oy9G6xDxtIyY06NzddHIUAoCWc
         wsFhM4HbBABGLHHwB9W7goazRzPA/mwurlVBCzFa/VQIs5n2bvxMWOFqoEb49xVDDSK9
         VP6nxURJnaEr5CXmZeInKRMTKuDNpCbXYnc9/v2y6hqdP9eUkOfSLegnQ7bNms3rmQxu
         zszHIfl881aHLCt5Qi8HEdaCUaJMZLj/ccHESZIvwgxgT6q9lFh/+UbuyZ1IXq1MO49M
         W+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073287; x=1783678087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LV0ZBakC0JP3nIeGblYk4ekY9ZFEoRUPFnAuhWbBJIY=;
        b=S7DaLtAyiJn0s5mYCT2hrftvOXgKs/cT7fidRiWowQUcp+FqL9ormAPf5BwnXdBxfm
         F4Uifm4WimZKCjK2OmpK7zA3KJJNlnDm2tu30s30Fp0+EpxgweHJQeGSNvCmaZFpkZh0
         JHJkfpp9aZn+voL/S99d2bGXv/IYFk5nfYBtjR5DyoBI6Wfs702wgdQ52WSXd4BcG9MW
         hp7tVPyOmEKos07vOiwhP0dCHYOVrk7ZJFQi3vxU5uZuu/yktphq45MzMQFbNYJasd/K
         1j5w/aroZyjiIJefXDTRs1wcoAztYk4k/QS9JqS0LCTW6qa3ATHQiqx2L6Ma9GAaMfNP
         rYng==
X-Gm-Message-State: AOJu0YwA/EPYa/sEQ88D18oYsOWE3Z/6WEvAd+XhjYtYmmPYUGF7+4FP
	UQoRBo8Svvdzy3eE/ZN5RSlIQ5g9W7FONcvcnqdgUHDugd8Qn+JxpXyDpYpweLBd
X-Gm-Gg: AfdE7cmaG7PJWDYyOSpuLIZQujoREJ5A1LDFJRj2uxhSSBUqhTs1GgwiR+AIHzmKxSJ
	CFCBDZRV1VbOEpSn9vNxMNyr4vGA6sD0qswrfjO334EpU6q09u4SMU9vEpERD4vaup3bYDESfmU
	btbo4lcZI2AoVeJgG0aHCF81U8xVGqLUlCSvkZ2NPQQl1JU5qU4Vg796895/YihAJvrtNXR8CnT
	0FVbeuWvpdNZoCiA99CR0a4wq0HANoxSUd3Z06AVpLp3rc3XaaRA2Qp+S5k2+xRDpcDMS6HB6zK
	jYoVfAmsJ5I7glfL3LkKBYo62bO+2zU8ca9q0Q3IyVUuXQQxn1+0pOEHF/WsMk7T0L7HD+N05r9
	TTllcigV24kmA9O0ie6RsJ/OC3m4MWV6XlqKpscxg4iWxm7NheYP6Cl6DFvhLtErdsdKkFUO0Hr
	xdGjoBrh2bXdFFUbftAHSz
X-Received: by 2002:a05:600d:c:b0:493:aa28:38ad with SMTP id 5b1f17b1804b1-493c2b4442emr102944735e9.10.1783073286763;
        Fri, 03 Jul 2026 03:08:06 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab3a8sm40993765e9.6.2026.07.03.03.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:08:06 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 18/26] irqchip/renesas-rzg2l: Drop IRQC_TINT_START macro
Date: Fri,  3 Jul 2026 11:07:37 +0100
Message-ID: <20260703100756.238233-19-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23410

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 87404cb8cae43b680caaaa621280e71969a09147 ]

The IRQC_TINT_START value is different for RZ/G3L and RZ/G2L SoC. Add
tint_start variable in struct rzg2l_hw_info to handle this difference and
drop the macro IRQC_TINT_START.

While at it, update the variable type of titseln, tssr_offset, tssr_index,
index, and sense to unsigned int, in rzg2l_tint_set_edge() as these
variables are used only for calculation.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260325192451.172562-14-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 87ee70235b69..73f6e86b57d6 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -23,7 +23,6 @@
 
 #define IRQC_IRQ_START			1
 #define IRQC_IRQ_COUNT			8
-#define IRQC_TINT_START			(IRQC_IRQ_START + IRQC_IRQ_COUNT)
 #define IRQC_TINT_COUNT			32
 
 #define ISCR				0x10
@@ -70,9 +69,11 @@ struct rzg2l_irqc_reg_cache {
 
 /**
  * struct rzg2l_hw_info - Interrupt Control Unit controller hardware info structure.
+ * @tint_start:		Start of TINT interrupts
  * @num_irq:		Total Number of interrupts
  */
 struct rzg2l_hw_info {
+	unsigned int	tint_start;
 	unsigned int	num_irq;
 };
 
@@ -126,7 +127,7 @@ static void rzg2l_clear_irq_int(struct rzg2l_irqc_priv *priv, unsigned int hwirq
 
 static void rzg2l_clear_tint_int(struct rzg2l_irqc_priv *priv, unsigned int hwirq)
 {
-	u32 bit = BIT(hwirq - IRQC_TINT_START);
+	u32 bit = BIT(hwirq - priv->info.tint_start);
 	u32 reg;
 
 	reg = readl_relaxed(priv->base + TSCR);
@@ -181,7 +182,7 @@ static void rzfive_irqc_unmask_irq_interrupt(struct rzg2l_irqc_priv *priv,
 static void rzfive_irqc_mask_tint_interrupt(struct rzg2l_irqc_priv *priv,
 					    unsigned int hwirq)
 {
-	u32 bit = BIT(hwirq - IRQC_TINT_START);
+	u32 bit = BIT(hwirq - priv->info.tint_start);
 
 	writel_relaxed(readl_relaxed(priv->base + TMSK) | bit, priv->base + TMSK);
 }
@@ -189,7 +190,7 @@ static void rzfive_irqc_mask_tint_interrupt(struct rzg2l_irqc_priv *priv,
 static void rzfive_irqc_unmask_tint_interrupt(struct rzg2l_irqc_priv *priv,
 					      unsigned int hwirq)
 {
-	u32 bit = BIT(hwirq - IRQC_TINT_START);
+	u32 bit = BIT(hwirq - priv->info.tint_start);
 
 	writel_relaxed(readl_relaxed(priv->base + TMSK) & ~bit, priv->base + TMSK);
 }
@@ -254,7 +255,7 @@ static void rzfive_tint_endisable(struct irq_data *d, bool enable)
 {
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 	unsigned int hwirq = irqd_to_hwirq(d);
-	unsigned int offset = hwirq - IRQC_TINT_START;
+	unsigned int offset = hwirq - priv->info.tint_start;
 	unsigned int tssr_offset = TSSR_OFFSET(offset);
 	unsigned int tssr_index = TSSR_INDEX(offset);
 	u32 reg;
@@ -300,7 +301,7 @@ static void rzg2l_tint_irq_endisable(struct irq_data *d, bool enable)
 {
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 	unsigned int hw_irq = irqd_to_hwirq(d);
-	unsigned int offset = hw_irq - IRQC_TINT_START;
+	unsigned int offset = hw_irq - priv->info.tint_start;
 	unsigned int tssr_offset = TSSR_OFFSET(offset);
 	unsigned int tssr_index = TSSR_INDEX(offset);
 	u32 reg;
@@ -389,10 +390,10 @@ static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
 {
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 	unsigned int hwirq = irqd_to_hwirq(d);
-	u32 titseln = hwirq - IRQC_TINT_START;
-	u32 tssr_offset = TSSR_OFFSET(titseln);
-	u8 tssr_index = TSSR_INDEX(titseln);
-	u8 index, sense;
+	unsigned int titseln = hwirq - priv->info.tint_start;
+	unsigned int tssr_offset = TSSR_OFFSET(titseln);
+	unsigned int tssr_index = TSSR_INDEX(titseln);
+	unsigned int index, sense;
 	u32 reg, tssr;
 
 	switch (type & IRQ_TYPE_SENSE_MASK) {
@@ -692,6 +693,7 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 }
 
 static const struct rzg2l_hw_info rzg2l_hw_params = {
+	.tint_start	= IRQC_IRQ_START + IRQC_IRQ_COUNT,
 	.num_irq	= IRQC_IRQ_START + IRQC_IRQ_COUNT + IRQC_TINT_COUNT,
 };
 
-- 
2.43.0


