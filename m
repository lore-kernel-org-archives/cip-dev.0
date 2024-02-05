Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44781C4829B
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 12:42:26 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.61925.1707136928406421430
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Feb 2024 04:42:18 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,245,1701097200"; 
   d="scan'208";a="192915844"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 05 Feb 2024 21:42:17 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 64DF040065B6;
	Mon,  5 Feb 2024 21:42:16 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 19/48] irqchip/sifive-plic: Improve naming scheme for per context offsets
Date: Mon,  5 Feb 2024 12:41:06 +0000
Message-Id: <20240205124135.14779-20-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 12:42:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14688

From: Niklas Cassel <niklas.cassel@wdc.com>

commit 0d3616bbd03cdfaa8a5fdf38e0fec2b1ef6ec0a0 upstream.

The PLIC supports a fixed number of contexts (15872).
Each context has fixed register offsets in PLIC.

The number of contexts that we need to initialize depends on the privilege
modes supported by each hart. Therefore, this mapping between PLIC context
registers to hart privilege modes is platform specific, and is currently
supplied via device tree.

For example, canaan,k210 has the following mapping:
Context0: hart0 M-mode
Context1: hart0 S-mode
Context2: hart1 M-mode
Context3: hart1 S-mode

While sifive,fu540 has the following mapping:
Context0: hart0 M-mode
Context1: hart1 M-mode
Context2: hart1 S-mode

Because the number of contexts per hart is not fixed, the names
ENABLE_PER_HART and CONTEXT_PER_HART for the register offsets are quite
confusing and might mislead the reader to think that these are fixed
register offsets per hart.

Rename the offsets to more clearly highlight that these are per PLIC
context and not per hart.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220302131544.3166154-2-Niklas.Cassel@wdc.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/irqchip/irq-sifive-plic.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index bd99ee0ae433..5b25e275fa6f 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -44,8 +44,8 @@
  * Each hart context has a vector of interrupt enable bits associated with it.
  * There's one bit for each interrupt source.
  */
-#define ENABLE_BASE			0x2000
-#define     ENABLE_PER_HART		0x80
+#define CONTEXT_ENABLE_BASE		0x2000
+#define     CONTEXT_ENABLE_SIZE		0x80
 
 /*
  * Each hart context has a set of control registers associated with it.  Right
@@ -53,7 +53,7 @@
  * take an interrupt, and a register to claim interrupts.
  */
 #define CONTEXT_BASE			0x200000
-#define     CONTEXT_PER_HART		0x1000
+#define     CONTEXT_SIZE		0x1000
 #define     CONTEXT_THRESHOLD		0x00
 #define     CONTEXT_CLAIM		0x04
 
@@ -363,11 +363,11 @@ static int __init plic_init(struct device_node *node,
 
 		cpumask_set_cpu(cpu, &priv->lmask);
 		handler->present = true;
-		handler->hart_base =
-			priv->regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
+		handler->hart_base = priv->regs + CONTEXT_BASE +
+			i * CONTEXT_SIZE;
 		raw_spin_lock_init(&handler->enable_lock);
-		handler->enable_base =
-			priv->regs + ENABLE_BASE + i * ENABLE_PER_HART;
+		handler->enable_base = priv->regs + CONTEXT_ENABLE_BASE +
+			i * CONTEXT_ENABLE_SIZE;
 		handler->priv = priv;
 done:
 		for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
-- 
2.34.1


