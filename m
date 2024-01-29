Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34579C47DB3
	for <webhook@archiver.kernel.org>; Mon, 29 Jan 2024 19:18:46 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.4194.1706555917034496852
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jan 2024 11:18:37 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,227,1701097200"; 
   d="scan'208";a="196034406"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 30 Jan 2024 04:18:36 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.7])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id AEF1A400C446;
	Tue, 30 Jan 2024 04:18:34 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 2/2] pinctrl: renesas: rzg2l: Enhance driver to support interrupt affinity setting
Date: Mon, 29 Jan 2024 19:18:29 +0000
Message-Id: <20240129191829.45687-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129191829.45687-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240129191829.45687-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jan 2024 19:18:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14486

commit e4c3a81ab88f3230713f4678deb9dd3cb8d0382c upstream.

Implement irq_set_affinity callback so that we can set affinity
for GPIO IRQs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231011195923.67404-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 044b6b261f988..22abac051ab6f 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1247,6 +1247,7 @@ static const struct irq_chip rzg2l_gpio_irqchip = {
 	.irq_set_type = rzg2l_gpio_irq_set_type,
 	.irq_eoi = rzg2l_gpio_irqc_eoi,
 	.irq_print_chip = rzg2l_gpio_irq_print_chip,
+	.irq_set_affinity = irq_chip_set_affinity_parent,
 	.flags = IRQCHIP_IMMUTABLE,
 	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
-- 
2.34.1


