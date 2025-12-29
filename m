Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC223E92FF2
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 22:39:35 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.53287.1767047956505708700
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 14:39:30 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: HtVhyCyFRRSwviv4IDJqAQ==
X-CSE-MsgGUID: B7g1Ka7/SAK7d1Os9Ca7Ig==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 30 Dec 2025 07:39:29 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 831CF400A0FF;
	Tue, 30 Dec 2025 07:39:28 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 09/17] i2c: riic: Implement bus recovery
Date: Mon, 29 Dec 2025 22:39:03 +0000
Message-ID: <20251229223911.8663-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 22:39:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21267

commit ba9e1b5254783528e10b45b1f0fb40e21f4ff88a upstream.

Implement I2C bus recovery support for the RIIC controller by making use
of software-controlled SCL and SDA line manipulation. The controller allows
forcing SCL and SDA levels through control bits, which enables generation
of manual clock pulses and a stop condition to free a stuck bus.

This implementation wires up the bus recovery mechanism using
i2c_generic_scl_recovery and provides get/set operations for SCL and SDA.

This allows the RIIC driver to recover from bus hang scenarios where SDA
is held low by a slave.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Link: https://lore.kernel.org/r/20250501204003.141134-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 53 +++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 28ca8b9bfa2bb..20faf3d1581ba 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -52,6 +52,8 @@
 #define ICCR1_ICE	BIT(7)
 #define ICCR1_IICRST	BIT(6)
 #define ICCR1_SOWP	BIT(4)
+#define ICCR1_SCLO	BIT(3)
+#define ICCR1_SDAO	BIT(2)
 #define ICCR1_SCLI	BIT(1)
 #define ICCR1_SDAI	BIT(0)
 
@@ -151,11 +153,11 @@ static int riic_bus_barrier(struct riic_dev *riic)
 	ret = readb_poll_timeout(riic->base + riic->info->regs[RIIC_ICCR2], val,
 				 !(val & ICCR2_BBSY), 10, riic->adapter.timeout);
 	if (ret)
-		return ret;
+		return i2c_recover_bus(&riic->adapter);
 
 	if ((riic_readb(riic, RIIC_ICCR1) & (ICCR1_SDAI | ICCR1_SCLI)) !=
 	     (ICCR1_SDAI | ICCR1_SCLI))
-		return -EBUSY;
+		return i2c_recover_bus(&riic->adapter);
 
 	return 0;
 }
@@ -439,6 +441,52 @@ static int riic_init_hw(struct riic_dev *riic)
 	return 0;
 }
 
+static int riic_get_scl(struct i2c_adapter *adap)
+{
+	struct riic_dev *riic = i2c_get_adapdata(adap);
+
+	return !!(riic_readb(riic, RIIC_ICCR1) & ICCR1_SCLI);
+}
+
+static int riic_get_sda(struct i2c_adapter *adap)
+{
+	struct riic_dev *riic = i2c_get_adapdata(adap);
+
+	return !!(riic_readb(riic, RIIC_ICCR1) & ICCR1_SDAI);
+}
+
+static void riic_set_scl(struct i2c_adapter *adap, int val)
+{
+	struct riic_dev *riic = i2c_get_adapdata(adap);
+
+	if (val)
+		riic_clear_set_bit(riic, ICCR1_SOWP, ICCR1_SCLO, RIIC_ICCR1);
+	else
+		riic_clear_set_bit(riic, ICCR1_SOWP | ICCR1_SCLO, 0, RIIC_ICCR1);
+
+	riic_clear_set_bit(riic, 0, ICCR1_SOWP, RIIC_ICCR1);
+}
+
+static void riic_set_sda(struct i2c_adapter *adap, int val)
+{
+	struct riic_dev *riic = i2c_get_adapdata(adap);
+
+	if (val)
+		riic_clear_set_bit(riic, ICCR1_SOWP, ICCR1_SDAO, RIIC_ICCR1);
+	else
+		riic_clear_set_bit(riic, ICCR1_SOWP | ICCR1_SDAO, 0, RIIC_ICCR1);
+
+	riic_clear_set_bit(riic, 0, ICCR1_SOWP, RIIC_ICCR1);
+}
+
+static struct i2c_bus_recovery_info riic_bri = {
+	.recover_bus = i2c_generic_scl_recovery,
+	.get_scl = riic_get_scl,
+	.set_scl = riic_set_scl,
+	.get_sda = riic_get_sda,
+	.set_sda = riic_set_sda,
+};
+
 static const struct riic_irq_desc riic_irqs[] = {
 	{ .res_num = 0, .isr = riic_tend_isr, .name = "riic-tend" },
 	{ .res_num = 1, .isr = riic_rdrf_isr, .name = "riic-rdrf" },
@@ -495,6 +543,7 @@ static int riic_i2c_probe(struct platform_device *pdev)
 	adap->algo = &riic_algo;
 	adap->dev.parent = dev;
 	adap->dev.of_node = dev->of_node;
+	adap->bus_recovery_info = &riic_bri;
 
 	init_completion(&riic->msg_done);
 
-- 
2.43.0


