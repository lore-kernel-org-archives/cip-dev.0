Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F2EE92FF5
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 22:39:35 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.53287.1767047956505708700
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 14:39:31 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: eBs3SeW+Rka7ZOuC22PQig==
X-CSE-MsgGUID: K5p3TZHERcWv8i/xkVZKxQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 30 Dec 2025 07:39:31 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 466154005037;
	Tue, 30 Dec 2025 07:39:30 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 10/17] i2c: riic: Pass IRQ desc array as part of OF data
Date: Mon, 29 Dec 2025 22:39:04 +0000
Message-ID: <20251229223911.8663-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 22:39:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21268

commit 11db6a53b2375b29fe742948d71b9b341f8944db upstream.

In preparation for adding support for Renesas RZ/T2H and RZ/N2H SoCs,
which feature a combined error interrupt instead of individual error
interrupts per condition, update the driver to support configurable IRQ
layouts via OF data.

Introduce a new `irqs` field and `num_irqs` count in `riic_of_data` to
allow future SoCs to provide a custom IRQ layout. This patch is a
non-functional change for existing SoCs and maintains compatibility with
the current `riic_irqs` array.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com> # on RZ/A1
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20250625104526.101004-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 20faf3d1581ba..0215e4a755a7a 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -102,6 +102,8 @@ enum riic_reg_list {
 
 struct riic_of_data {
 	const u8 *regs;
+	const struct riic_irq_desc *irqs;
+	u8 num_irqs;
 	bool fast_mode_plus;
 };
 
@@ -520,21 +522,23 @@ static int riic_i2c_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(riic->rstc),
 				     "failed to acquire deasserted reset\n");
 
-	for (i = 0; i < ARRAY_SIZE(riic_irqs); i++) {
+	riic->info = of_device_get_match_data(dev);
+
+	for (i = 0; i < riic->info->num_irqs; i++) {
+		const struct riic_irq_desc *irq_desc;
 		int irq;
 
-		irq = platform_get_irq(pdev, riic_irqs[i].res_num);
+		irq_desc = &riic->info->irqs[i];
+		irq = platform_get_irq(pdev, irq_desc->res_num);
 		if (irq < 0)
 			return irq;
 
-		ret = devm_request_irq(dev, irq, riic_irqs[i].isr,
-				       0, riic_irqs[i].name, riic);
+		ret = devm_request_irq(dev, irq, irq_desc->isr, 0, irq_desc->name, riic);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to request irq %s\n",
-					     riic_irqs[i].name);
+					     irq_desc->name);
 	}
 
-	riic->info = of_device_get_match_data(dev);
 
 	adap = &riic->adapter;
 	i2c_set_adapdata(adap, riic);
@@ -606,11 +610,15 @@ static const u8 riic_rz_a_regs[RIIC_REG_END] = {
 
 static const struct riic_of_data riic_rz_a_info = {
 	.regs = riic_rz_a_regs,
+	.irqs = riic_irqs,
+	.num_irqs = ARRAY_SIZE(riic_irqs),
 	.fast_mode_plus = true,
 };
 
 static const struct riic_of_data riic_rz_a1h_info = {
 	.regs = riic_rz_a_regs,
+	.irqs = riic_irqs,
+	.num_irqs = ARRAY_SIZE(riic_irqs),
 };
 
 static const u8 riic_rz_v2h_regs[RIIC_REG_END] = {
@@ -630,6 +638,8 @@ static const u8 riic_rz_v2h_regs[RIIC_REG_END] = {
 
 static const struct riic_of_data riic_rz_v2h_info = {
 	.regs = riic_rz_v2h_regs,
+	.irqs = riic_irqs,
+	.num_irqs = ARRAY_SIZE(riic_irqs),
 	.fast_mode_plus = true,
 };
 
-- 
2.43.0


