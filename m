Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94ECE92FEA
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 22:39:35 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.53287.1767047956505708700
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 14:39:35 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: e7JNYgF4SxqZ0lKYr+6nCg==
X-CSE-MsgGUID: 85qK+QQvTN2RLHHN9wTBQA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 30 Dec 2025 07:39:35 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BE8AF400A0FF;
	Tue, 30 Dec 2025 07:39:33 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 12/17] i2c: riic: Add support for RZ/T2H SoC
Date: Mon, 29 Dec 2025 22:39:06 +0000
Message-ID: <20251229223911.8663-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 22:39:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21270

commit 529a3ff283e7e788dd23d372aaf0820dac5822ae upstream.

Add support for the Renesas RZ/T2H (R9A09G077) SoC, which features a
different interrupt layout for the RIIC controller. Unlike other SoCs
with individual error interrupts, RZ/T2H uses a combined error interrupt
(EEI).

Introduce a new IRQ descriptor table for RZ/T2H, along with a custom
ISR (`riic_eei_isr`) to handle STOP and NACK detection from the shared
interrupt.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com> # on RZ/A1
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20250625104526.101004-6-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index b8745d1d28073..c22ccf17723ab 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -79,6 +79,7 @@
 #define ICIER_SPIE	BIT(3)
 
 #define ICSR2_NACKF	BIT(4)
+#define ICSR2_STOP	BIT(3)
 
 #define ICBR_RESERVED	GENMASK(7, 5) /* Should be 1 on writes */
 
@@ -326,6 +327,19 @@ static irqreturn_t riic_stop_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t riic_eei_isr(int irq, void *data)
+{
+	u8 icsr2 = riic_readb(data, RIIC_ICSR2);
+
+	if (icsr2 & ICSR2_NACKF)
+		return riic_tend_isr(irq, data);
+
+	if (icsr2 & ICSR2_STOP)
+		return riic_stop_isr(irq, data);
+
+	return IRQ_NONE;
+}
+
 static u32 riic_func(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
@@ -497,6 +511,13 @@ static const struct riic_irq_desc riic_irqs[] = {
 	{ .res_num = 5, .isr = riic_tend_isr, .name = "riic-nack" },
 };
 
+static const struct riic_irq_desc riic_rzt2h_irqs[] = {
+	{ .res_num = 0, .isr = riic_eei_isr,  .name = "riic-eei" },
+	{ .res_num = 1, .isr = riic_rdrf_isr, .name = "riic-rxi" },
+	{ .res_num = 2, .isr = riic_tdre_isr, .name = "riic-txi" },
+	{ .res_num = 3, .isr = riic_tend_isr, .name = "riic-tei" },
+};
+
 static int riic_i2c_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -643,6 +664,12 @@ static const struct riic_of_data riic_rz_v2h_info = {
 	.fast_mode_plus = true,
 };
 
+static const struct riic_of_data riic_rz_t2h_info = {
+	.regs = riic_rz_v2h_regs,
+	.irqs = riic_rzt2h_irqs,
+	.num_irqs = ARRAY_SIZE(riic_rzt2h_irqs),
+};
+
 static int riic_i2c_suspend(struct device *dev)
 {
 	struct riic_dev *riic = dev_get_drvdata(dev);
@@ -695,6 +722,7 @@ static const struct dev_pm_ops riic_i2c_pm_ops = {
 static const struct of_device_id riic_i2c_dt_ids[] = {
 	{ .compatible = "renesas,riic-r7s72100", .data =  &riic_rz_a1h_info, },
 	{ .compatible = "renesas,riic-r9a09g057", .data = &riic_rz_v2h_info },
+	{ .compatible = "renesas,riic-r9a09g077", .data = &riic_rz_t2h_info },
 	{ .compatible = "renesas,riic-rz", .data = &riic_rz_a_info },
 	{ /* Sentinel */ }
 };
-- 
2.43.0


