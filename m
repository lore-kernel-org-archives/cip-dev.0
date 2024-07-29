Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D0FC49EA1
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 15:35:29 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.58893.1722267324064889186
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jul 2024 08:35:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,246,1716217200"; 
   d="scan'208";a="217878966"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 30 Jul 2024 00:35:25 +0900
Received: from localhost.localdomain (unknown [10.226.92.63])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 116E5401A444;
	Tue, 30 Jul 2024 00:35:23 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 08/13] phy: renesas: phy-rcar-gen3-usb2: Control VBUS for RZ/G2L SoCs
Date: Mon, 29 Jul 2024 16:34:53 +0100
Message-ID: <20240729153504.510443-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729153504.510443-1-biju.das.jz@bp.renesas.com>
References: <20240729153504.510443-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jul 2024 15:35:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16676

commit 24843404efe47eab1ee88d7475a0be0f2f6fd9db upstream.

Use regulator_hardware_enable() for controlling VBUS enable for
RZ/G2L alike SoCs in interrupt context.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Link: https://lore.kernel.org/r/20240702180032.207275-4-biju.das.jz@bp.renesas.com
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 7e61c6b278a7..90756f6befb0 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -190,6 +190,9 @@ static void rcar_gen3_enable_vbus_ctrl(struct rcar_gen3_chan *ch, int vbus)
 
 	dev_vdbg(ch->dev, "%s: %08x, %d\n", __func__, val, vbus);
 	if (ch->soc_no_adp_ctrl) {
+		if (ch->vbus)
+			regulator_hardware_enable(ch->vbus, vbus);
+
 		vbus_ctrl_reg = USB2_VBCTRL;
 		vbus_ctrl_val = USB2_VBCTRL_VBOUT;
 	}
@@ -720,7 +723,10 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 		phy_set_drvdata(channel->rphys[i].phy, &channel->rphys[i]);
 	}
 
-	channel->vbus = devm_regulator_get_optional(dev, "vbus");
+	if (channel->soc_no_adp_ctrl && channel->is_otg_channel)
+		channel->vbus = devm_regulator_get_exclusive(dev, "vbus");
+	else
+		channel->vbus = devm_regulator_get_optional(dev, "vbus");
 	if (IS_ERR(channel->vbus)) {
 		if (PTR_ERR(channel->vbus) == -EPROBE_DEFER) {
 			ret = PTR_ERR(channel->vbus);
-- 
2.43.0


