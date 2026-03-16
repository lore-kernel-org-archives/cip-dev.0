Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4D4F506EA
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 14:59:34 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52440.1773673159009042004
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 07:59:32 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: jHj4tb4sSq+p7Qt7vAtvyg==
X-CSE-MsgGUID: o/KlhoWeQDO+3XPQi9ejqQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Mar 2026 23:59:31 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.53])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A1BA641B7814;
	Mon, 16 Mar 2026 23:59:30 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 08/35] phy: renesas: rcar-gen3-usb2: Allow SoC-specific OBINT bits via phy_data
Date: Mon, 16 Mar 2026 14:58:45 +0000
Message-ID: <20260316145915.8580-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 14:59:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22400

commit 4b7aa47e4c2c921b9511389bf42a4e30d64373e6 upstream.

Update the PHY driver to support SoC-specific OBINT enable bits by
introducing the `obint_enable_bits` field in the `rcar_gen3_phy_drv_data`
structure. This allows each SoC to specify bits required.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20250808215209.3692744-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 27 ++++++++++++------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 004b36bddad0..eca118e597e6 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -71,8 +71,7 @@
 /* OBINTSTA and OBINTEN */
 #define USB2_OBINT_SESSVLDCHG		BIT(12)
 #define USB2_OBINT_IDDIGCHG		BIT(11)
-#define USB2_OBINT_BITS			(USB2_OBINT_SESSVLDCHG | \
-					 USB2_OBINT_IDDIGCHG)
+#define USB2_OBINT_IDCHG_EN		BIT(0) /*  RZ/G2L specific */
 
 /* VBCTRL */
 #define USB2_VBCTRL_OCCLREN		BIT(16)
@@ -93,7 +92,6 @@
 #define USB2_ADPCTRL_DRVVBUS		BIT(4)
 
 /*  RZ/G2L specific */
-#define USB2_OBINT_IDCHG_EN		BIT(0)
 #define USB2_LINECTRL1_USB2_IDMON	BIT(0)
 
 #define NUM_OF_PHYS			4
@@ -129,7 +127,6 @@ struct rcar_gen3_chan {
 	struct work_struct work;
 	spinlock_t lock;	/* protects access to hardware and driver data structure. */
 	enum usb_dr_mode dr_mode;
-	u32 obint_enable_bits;
 	bool extcon_host;
 	bool is_otg_channel;
 	bool uses_otg_pins;
@@ -140,6 +137,7 @@ struct rcar_gen3_phy_drv_data {
 	bool no_adp_ctrl;
 	bool init_bus;
 	bool utmi_ctrl;
+	u32 obint_enable_bits;
 };
 
 /*
@@ -224,9 +222,9 @@ static void rcar_gen3_control_otg_irq(struct rcar_gen3_chan *ch, int enable)
 	u32 val = readl(usb2_base + USB2_OBINTEN);
 
 	if (ch->uses_otg_pins && enable)
-		val |= ch->obint_enable_bits;
+		val |= ch->phy_data->obint_enable_bits;
 	else
-		val &= ~ch->obint_enable_bits;
+		val &= ~ch->phy_data->obint_enable_bits;
 	writel(val, usb2_base + USB2_OBINTEN);
 }
 
@@ -429,7 +427,7 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
 	mdelay(20);
 
 	writel(0xffffffff, usb2_base + USB2_OBINTSTA);
-	writel(ch->obint_enable_bits, usb2_base + USB2_OBINTEN);
+	writel(ch->phy_data->obint_enable_bits, usb2_base + USB2_OBINTEN);
 
 	rcar_gen3_device_recognition(ch);
 }
@@ -449,9 +447,9 @@ static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, void *_ch)
 
 	scoped_guard(spinlock, &ch->lock) {
 		status = readl(usb2_base + USB2_OBINTSTA);
-		if (status & ch->obint_enable_bits) {
+		if (status & ch->phy_data->obint_enable_bits) {
 			dev_vdbg(dev, "%s: %08x\n", __func__, status);
-			writel(ch->obint_enable_bits, usb2_base + USB2_OBINTSTA);
+			writel(ch->phy_data->obint_enable_bits, usb2_base + USB2_OBINTSTA);
 			rcar_gen3_device_recognition(ch);
 			ret = IRQ_HANDLED;
 		}
@@ -590,28 +588,35 @@ static const struct phy_ops rz_g1c_phy_usb2_ops = {
 static const struct rcar_gen3_phy_drv_data rcar_gen3_phy_usb2_data = {
 	.phy_usb2_ops = &rcar_gen3_phy_usb2_ops,
 	.no_adp_ctrl = false,
+	.obint_enable_bits = USB2_OBINT_SESSVLDCHG |
+			     USB2_OBINT_IDDIGCHG,
 };
 
 static const struct rcar_gen3_phy_drv_data rz_g1c_phy_usb2_data = {
 	.phy_usb2_ops = &rz_g1c_phy_usb2_ops,
 	.no_adp_ctrl = false,
+	.obint_enable_bits = USB2_OBINT_SESSVLDCHG |
+			     USB2_OBINT_IDDIGCHG,
 };
 
 static const struct rcar_gen3_phy_drv_data rz_g2l_phy_usb2_data = {
 	.phy_usb2_ops = &rcar_gen3_phy_usb2_ops,
 	.no_adp_ctrl = true,
+	.obint_enable_bits = USB2_OBINT_IDCHG_EN,
 };
 
 static const struct rcar_gen3_phy_drv_data rz_g3s_phy_usb2_data = {
 	.phy_usb2_ops = &rcar_gen3_phy_usb2_ops,
 	.no_adp_ctrl = true,
 	.init_bus = true,
+	.obint_enable_bits = USB2_OBINT_IDCHG_EN,
 };
 
 static const struct rcar_gen3_phy_drv_data rz_v2h_phy_usb2_data = {
 	.phy_usb2_ops = &rcar_gen3_phy_usb2_ops,
 	.no_adp_ctrl = true,
 	.utmi_ctrl = true,
+	.obint_enable_bits = USB2_OBINT_IDCHG_EN,
 };
 
 static const struct of_device_id rcar_gen3_phy_usb2_match_table[] = {
@@ -756,7 +761,6 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 	if (IS_ERR(channel->base))
 		return PTR_ERR(channel->base);
 
-	channel->obint_enable_bits = USB2_OBINT_BITS;
 	channel->dr_mode = rcar_gen3_get_dr_mode(dev->of_node);
 	if (channel->dr_mode != USB_DR_MODE_UNKNOWN) {
 		channel->is_otg_channel = true;
@@ -795,9 +799,6 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 			goto error;
 	}
 
-	if (channel->phy_data->no_adp_ctrl)
-		channel->obint_enable_bits = USB2_OBINT_IDCHG_EN;
-
 	spin_lock_init(&channel->lock);
 	for (i = 0; i < NUM_OF_PHYS; i++) {
 		channel->rphys[i].phy = devm_phy_create(dev, NULL,
-- 
2.43.0


