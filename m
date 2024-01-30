Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE869C46CD2
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 20:34:17 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.7251.1706646835418574585
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jan 2024 12:34:08 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,230,1701097200"; 
   d="scan'208";a="192272206"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 31 Jan 2024 05:34:07 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.7])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 234FC40A3D3B;
	Wed, 31 Jan 2024 05:34:05 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [RFC PATCH 5.10.y-cip 09/39] of/irq: Use interrupts-extended to find parent
Date: Tue, 30 Jan 2024 20:33:16 +0000
Message-Id: <20240130203346.94488-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130203346.94488-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240130203346.94488-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jan 2024 20:34:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14521

From: Samuel Holland <samuel@sholland.org>

commit e91033621d56e055803c4c4ba507fbbb2d145a7f upstream.

The RISC-V PLIC binding uses interrupts-extended to specify its parent
domain(s). That binding does not allow the interrupt-parent property to
appear in the irqchip node. This prevents of_irq_init from properly
detecting the irqchip hierarchy.

If no interrupt-parent property is present in the enclosing bus or root
node, then desc->interrupt_parent will be NULL for both the per-CPU
RISC-V INTC (the actual root domain) and the RISC-V PLIC. Similarly, if
the bus or root node specifies `interrupt-parent = <&plic>`, then
of_irq_init will hit the `desc->interrupt_parent == np` check, and again
all parents will be NULL. So things happen to work today for some boards
due to Makefile ordering.

However, things break when another irqchip ("foo") is stacked on top of
the PLIC. The bus or root node will have `interrupt-parent = <&foo>`,
since that is what all of the other peripherals need. When of_irq_init
runs, it will try to find the PLIC's parent domain. of_irq_find_parent
will fall back to using the interrupt-parent property of the PLIC's
parent node (i.e. the bus or root node), and of_irq_init will see "foo"
as the PLIC's parent domain. But this is wrong, because "foo" is
actually the PLIC's child domain!

So of_irq_init wrongly attempts to init the stacked irqchip before the
PLIC. This fails and breaks booting.

Fix this by using the first node referenced by interrupts-extended as
the parent when that property is present. This allows of_irq_init to see
the relationship between the PLIC and the per-CPU RISC-V INTC, and thus
only the RISC-V INTC is (correctly) considered a root domain.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220412051529.6293-1-samuel@sholland.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/of/irq.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 352e14b007e78..7f84e7649dc5b 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -507,9 +507,18 @@ void __init of_irq_init(const struct of_device_id *matches)
 
 		desc->irq_init_cb = match->data;
 		desc->dev = of_node_get(np);
-		desc->interrupt_parent = of_irq_find_parent(np);
-		if (desc->interrupt_parent == np)
+		/*
+		 * interrupts-extended can reference multiple parent domains.
+		 * Arbitrarily pick the first one; assume any other parents
+		 * are the same distance away from the root irq controller.
+		 */
+		desc->interrupt_parent = of_parse_phandle(np, "interrupts-extended", 0);
+		if (!desc->interrupt_parent)
+			desc->interrupt_parent = of_irq_find_parent(np);
+		if (desc->interrupt_parent == np) {
+			of_node_put(desc->interrupt_parent);
 			desc->interrupt_parent = NULL;
+		}
 		list_add_tail(&desc->list, &intc_desc_list);
 	}
 
-- 
2.34.1


