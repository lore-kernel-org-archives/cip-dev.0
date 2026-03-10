Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04552F41808
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 16:01:01 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43590.1773158454107655906
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Mar 2026 09:00:58 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: Wim4MTmKR9KD9g/3ynCHrg==
X-CSE-MsgGUID: DZiIB582TdGoAn7vJtt7NQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 11 Mar 2026 01:00:58 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.14])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 48A9D4019133;
	Wed, 11 Mar 2026 01:00:57 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 3/5] irqchip/renesas-rzv2h: Add support for RZ/V2N SoC
Date: Tue, 10 Mar 2026 16:00:48 +0000
Message-ID: <20260310160050.40977-4-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310160050.40977-1-ovidiu.panait.rb@renesas.com>
References: <20260310160050.40977-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Mar 2026 16:01:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22238

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 8d4c354bef3cc438db93f362e4657b317db03392 upstream.

Add support for the RZ/V2N Interrupt Control Unit (ICU) by introducing a
dedicated compatible string in the irqchip driver. While the RZ/V2N ICU
differs from the RZ/V2H(P) version in its register layout primarily due
to a reduced set of ECCRAM related registers the irqchip driver does not
currently access these registers.

As a result, the RZ/V2N ICU can be safely handled by rzv2h_icu_probe for
now, but it still requires a distinct compatible so that future changes
can differentiate the SoCs when needed.

[ tglx: Fixed up the made up subject prefix ]

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251127162447.320971-3-prabhakar.mahadev-lad.rj@bp.renesas.com
[OP: used rzv2h_icu_init instead of rzv2h_icu_probe in IRQCHIP_MATCH()]
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 766adccf11dc..b8dc29fc1198 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -632,6 +632,7 @@ static int rzv2h_icu_init(struct device_node *node, struct device_node *parent)
 
 IRQCHIP_PLATFORM_DRIVER_BEGIN(rzv2h_icu)
 IRQCHIP_MATCH("renesas,r9a09g047-icu", rzg3e_icu_init)
+IRQCHIP_MATCH("renesas,r9a09g056-icu", rzv2h_icu_init)
 IRQCHIP_MATCH("renesas,r9a09g057-icu", rzv2h_icu_init)
 IRQCHIP_PLATFORM_DRIVER_END(rzv2h_icu)
 MODULE_AUTHOR("Fabrizio Castro <fabrizio.castro.jz@renesas.com>");
-- 
2.51.0


