Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D377AC4828D
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 12:28:15 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.20157.1707222466534019812
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 04:28:10 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,247,1701097200"; 
   d="scan'208";a="193048733"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Feb 2024 21:28:09 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.78])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 38FF84005E16;
	Tue,  6 Feb 2024 21:28:07 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 16/44] irqchip/sifive-plic: Disable S-mode IRQs if running in M-mode
Date: Tue,  6 Feb 2024 12:27:06 +0000
Message-Id: <20240206122734.13477-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 12:28:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14800

From: Niklas Cassel <niklas.cassel@wdc.com>

commit 098fdbc3531f06aae2426b3a6f9bd730e7691258 upstream.

When detecting a context for a privilege mode different from the current
running privilege mode, we simply skip to the next context register.

This means that we never clear the S-mode enable bits when running in
M-mode.

On canaan k210, a bunch of S-mode interrupts are enabled by the bootrom.
These S-mode specific interrupts should never trigger, since we never set
the mie.SEIE bit in the parent interrupt controller (riscv-intc).

However, we will be able to see the mip.SEIE bit set as pending.

This isn't a good default when CONFIG_RISCV_M_MODE is set, since in that
case we will never enter a lower privilege mode (e.g. S-mode).

Let's clear the S-mode enable bits when running the kernel in M-mode, such
that we won't have a interrupt pending bit set, which we will never clear.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220302131544.3166154-3-Niklas.Cassel@wdc.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 drivers/irqchip/irq-sifive-plic.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 5b25e275fa6fa..3a8a795000bf4 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -81,17 +81,21 @@ static int plic_parent_irq;
 static bool plic_cpuhp_setup_done;
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
-static inline void plic_toggle(struct plic_handler *handler,
-				int hwirq, int enable)
+static void __plic_toggle(void __iomem *enable_base, int hwirq, int enable)
 {
-	u32 __iomem *reg = handler->enable_base + (hwirq / 32) * sizeof(u32);
+	u32 __iomem *reg = enable_base + (hwirq / 32) * sizeof(u32);
 	u32 hwirq_mask = 1 << (hwirq % 32);
 
-	raw_spin_lock(&handler->enable_lock);
 	if (enable)
 		writel(readl(reg) | hwirq_mask, reg);
 	else
 		writel(readl(reg) & ~hwirq_mask, reg);
+}
+
+static void plic_toggle(struct plic_handler *handler, int hwirq, int enable)
+{
+	raw_spin_lock(&handler->enable_lock);
+	__plic_toggle(handler->enable_base, hwirq, enable);
 	raw_spin_unlock(&handler->enable_lock);
 }
 
@@ -326,8 +330,18 @@ static int __init plic_init(struct device_node *node,
 		 * Skip contexts other than external interrupts for our
 		 * privilege level.
 		 */
-		if (parent.args[0] != RV_IRQ_EXT)
+		if (parent.args[0] != RV_IRQ_EXT) {
+			/* Disable S-mode enable bits if running in M-mode. */
+			if (IS_ENABLED(CONFIG_RISCV_M_MODE)) {
+				void __iomem *enable_base = priv->regs +
+					CONTEXT_ENABLE_BASE +
+					i * CONTEXT_ENABLE_SIZE;
+
+				for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
+					__plic_toggle(enable_base, hwirq, 0);
+			}
 			continue;
+		}
 
 		hartid = riscv_of_parent_hartid(parent.np);
 		if (hartid < 0) {
-- 
2.34.1


