Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F364CC3271E
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 13:04:27 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.16669.1720184666832067661
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 06:04:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,184,1716217200"; 
   d="scan'208";a="214374044"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Jul 2024 22:04:26 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.112])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DBA25453293E;
	Fri,  5 Jul 2024 22:04:24 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 3/9] irqchip/renesas-rzg2l: Simplify rzg2l_irqc_irq_{en,dis}able()
Date: Fri,  5 Jul 2024 14:04:11 +0100
Message-Id: <20240705130417.125593-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240705130417.125593-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240705130417.125593-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 13:04:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16409

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 46efb3053f4f23357e9e29f8abaa6f801d956a0c upstream.

Simplify rzg2l_irqc_irq_{en,dis}able() by moving common code to
rzg2l_tint_irq_endisable().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index ae67fec2ab468..f6484bf15e0b8 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -138,7 +138,7 @@ static void rzg2l_irqc_eoi(struct irq_data *d)
 	irq_chip_eoi_parent(d);
 }
 
-static void rzg2l_irqc_irq_disable(struct irq_data *d)
+static void rzg2l_tint_irq_endisable(struct irq_data *d, bool enable)
 {
 	unsigned int hw_irq = irqd_to_hwirq(d);
 
@@ -151,30 +151,24 @@ static void rzg2l_irqc_irq_disable(struct irq_data *d)
 
 		raw_spin_lock(&priv->lock);
 		reg = readl_relaxed(priv->base + TSSR(tssr_index));
-		reg &= ~(TIEN << TSSEL_SHIFT(tssr_offset));
+		if (enable)
+			reg |= TIEN << TSSEL_SHIFT(tssr_offset);
+		else
+			reg &= ~(TIEN << TSSEL_SHIFT(tssr_offset));
 		writel_relaxed(reg, priv->base + TSSR(tssr_index));
 		raw_spin_unlock(&priv->lock);
 	}
+}
+
+static void rzg2l_irqc_irq_disable(struct irq_data *d)
+{
+	rzg2l_tint_irq_endisable(d, false);
 	irq_chip_disable_parent(d);
 }
 
 static void rzg2l_irqc_irq_enable(struct irq_data *d)
 {
-	unsigned int hw_irq = irqd_to_hwirq(d);
-
-	if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
-		struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
-		u32 offset = hw_irq - IRQC_TINT_START;
-		u32 tssr_offset = TSSR_OFFSET(offset);
-		u8 tssr_index = TSSR_INDEX(offset);
-		u32 reg;
-
-		raw_spin_lock(&priv->lock);
-		reg = readl_relaxed(priv->base + TSSR(tssr_index));
-		reg |= TIEN << TSSEL_SHIFT(tssr_offset);
-		writel_relaxed(reg, priv->base + TSSR(tssr_index));
-		raw_spin_unlock(&priv->lock);
-	}
+	rzg2l_tint_irq_endisable(d, true);
 	irq_chip_enable_parent(d);
 }
 
-- 
2.34.1


