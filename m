Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFFBCF9C6B
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 17:04:17 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1523.1763658240642756193
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Nov 2025 09:04:12 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: KIG3RLUXQ7qsRACYpy1Fhw==
X-CSE-MsgGUID: DDlKvLsTSrmCP1gejpMxBA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Nov 2025 02:04:12 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.111])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 08EEA40614F0;
	Fri, 21 Nov 2025 02:04:10 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [PATCH 6.12.y-cip 07/10] phy: renesas: phy-rcar-gen3-usb2: Add USB2.0 PHY support for RZ/V2H(P)
Date: Thu, 20 Nov 2025 17:03:54 +0000
Message-ID: <20251120170357.18342-8-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120170357.18342-1-ovidiu.panait.rb@renesas.com>
References: <20251120170357.18342-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Nov 2025 17:04:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20654

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 3767474d7497a4d03f58118d02b742b903626d03 upstream.

Add USB2.0 PHY support for RZ/V2H(P) SoC.

On the RZ/V2H(P) SoC we need to configure the UTMI to a specific value
as compared to other SoCs (which doesn't need configuring it).

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20250414145729.343133-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 30 ++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index bfc49236a28e..a65e39d106a9 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -29,8 +29,10 @@
 #define USB2_INT_ENABLE		0x000
 #define USB2_AHB_BUS_CTR	0x008
 #define USB2_USBCTR		0x00c
+#define USB2_REGEN_CG_CTRL	0x104	/* RZ/V2H(P) only */
 #define USB2_SPD_RSM_TIMSET	0x10c
 #define USB2_OC_TIMSET		0x110
+#define USB2_UTMI_CTRL		0x118	/* RZ/V2H(P) only */
 #define USB2_COMMCTRL		0x600
 #define USB2_OBINTSTA		0x604
 #define USB2_OBINTEN		0x608
@@ -51,12 +53,18 @@
 #define USB2_USBCTR_DIRPD	BIT(2)
 #define USB2_USBCTR_PLL_RST	BIT(1)
 
+/* REGEN_CG_CTRL*/
+#define USB2_REGEN_CG_CTRL_UPHY_WEN	BIT(0)
+
 /* SPD_RSM_TIMSET */
 #define USB2_SPD_RSM_TIMSET_INIT	0x014e029b
 
 /* OC_TIMSET */
 #define USB2_OC_TIMSET_INIT		0x000209ab
 
+/* UTMI_CTRL */
+#define USB2_UTMI_CTRL_INIT		0x8000018f
+
 /* COMMCTRL */
 #define USB2_COMMCTRL_OTG_PERI		BIT(31)	/* 1 = Peripheral mode */
 
@@ -126,12 +134,14 @@ struct rcar_gen3_chan {
 	bool is_otg_channel;
 	bool uses_otg_pins;
 	bool soc_no_adp_ctrl;
+	bool utmi_ctrl;
 };
 
 struct rcar_gen3_phy_drv_data {
 	const struct phy_ops *phy_usb2_ops;
 	bool no_adp_ctrl;
 	bool init_bus;
+	bool utmi_ctrl;
 };
 
 /*
@@ -477,6 +487,14 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
 	if (rphy->int_enable_bits)
 		rcar_gen3_init_otg(channel);
 
+	if (channel->utmi_ctrl) {
+		val = readl(usb2_base + USB2_REGEN_CG_CTRL) | USB2_REGEN_CG_CTRL_UPHY_WEN;
+		writel(val, usb2_base + USB2_REGEN_CG_CTRL);
+
+		writel(USB2_UTMI_CTRL_INIT, usb2_base + USB2_UTMI_CTRL);
+		writel(val & ~USB2_REGEN_CG_CTRL_UPHY_WEN, usb2_base + USB2_REGEN_CG_CTRL);
+	}
+
 	rphy->initialized = true;
 
 	return 0;
@@ -592,6 +610,12 @@ static const struct rcar_gen3_phy_drv_data rz_g3s_phy_usb2_data = {
 	.init_bus = true,
 };
 
+static const struct rcar_gen3_phy_drv_data rz_v2h_phy_usb2_data = {
+	.phy_usb2_ops = &rcar_gen3_phy_usb2_ops,
+	.no_adp_ctrl = true,
+	.utmi_ctrl = true,
+};
+
 static const struct of_device_id rcar_gen3_phy_usb2_match_table[] = {
 	{
 		.compatible = "renesas,usb2-phy-r8a77470",
@@ -613,6 +637,10 @@ static const struct of_device_id rcar_gen3_phy_usb2_match_table[] = {
 		.compatible = "renesas,usb2-phy-r9a08g045",
 		.data = &rz_g3s_phy_usb2_data,
 	},
+	{
+		.compatible = "renesas,usb2-phy-r9a09g057",
+		.data = &rz_v2h_phy_usb2_data,
+	},
 	{
 		.compatible = "renesas,rzg2l-usb2-phy",
 		.data = &rz_g2l_phy_usb2_data,
@@ -764,6 +792,8 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 	if (phy_data->no_adp_ctrl)
 		channel->obint_enable_bits = USB2_OBINT_IDCHG_EN;
 
+	channel->utmi_ctrl = phy_data->utmi_ctrl;
+
 	spin_lock_init(&channel->lock);
 	for (i = 0; i < NUM_OF_PHYS; i++) {
 		channel->rphys[i].phy = devm_phy_create(dev, NULL,
-- 
2.51.0


