Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3979ECCFA06
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 11:36:50 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18460.1762169800316022948
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Nov 2025 03:36:47 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: john.madieu.xa@bp.renesas.com)
X-CSE-ConnectionGUID: VuRiTJ16Szit5G7ijlq1fw==
X-CSE-MsgGUID: Go6Glq0CTq2+5zu1jlYlgw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 03 Nov 2025 20:36:46 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.166])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 76156400942A;
	Mon,  3 Nov 2025 20:36:45 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Subject: [PATCH 6.1.y-cip 21/25] net: stmmac: provide stmmac_pltfr_find_clk()
Date: Mon,  3 Nov 2025 12:35:54 +0100
Message-ID: <20251103113608.36240-22-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
References: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Nov 2025 11:36:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20313

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

[ Upstream commit de64872019492e4a84ee053e635cdf8f63f853d2 ]

Provide a generic way to find a clock in the bulk data.

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://patch.msgid.link/E1u2QO4-001Rp2-Dy@rmk-PC.armlinux.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[john.madieu:
 - Added clks and num_clks fields in plat_stmmacenet_data]
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 11 +++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h |  3 +++
 include/linux/stmmac.h                                |  2 ++
 3 files changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index be1f3142feb6..fd8fd9f894cd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -731,6 +731,17 @@ EXPORT_SYMBOL_GPL(stmmac_probe_config_dt);
 EXPORT_SYMBOL_GPL(devm_stmmac_probe_config_dt);
 EXPORT_SYMBOL_GPL(stmmac_remove_config_dt);
 
+struct clk *stmmac_pltfr_find_clk(struct plat_stmmacenet_data *plat_dat,
+				  const char *name)
+{
+	for (int i = 0; i < plat_dat->num_clks; i++)
+		if (strcmp(plat_dat->clks[i].id, name) == 0)
+			return plat_dat->clks[i].clk;
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(stmmac_pltfr_find_clk);
+
 int stmmac_get_platform_resources(struct platform_device *pdev,
 				  struct stmmac_resources *stmmac_res)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
index 2102c6d41464..09e7aebb3e32 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
@@ -18,6 +18,9 @@ devm_stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac);
 void stmmac_remove_config_dt(struct platform_device *pdev,
 			     struct plat_stmmacenet_data *plat);
 
+struct clk *stmmac_pltfr_find_clk(struct plat_stmmacenet_data *plat_dat,
+				  const char *name);
+
 int stmmac_get_platform_resources(struct platform_device *pdev,
 				  struct stmmac_resources *stmmac_res);
 
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index c9b0cd32fde3..3153c599b6c6 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -246,6 +246,8 @@ struct plat_stmmacenet_data {
 	struct clk *clk_tx_i;		/* clk_tx_i to MAC core */
 	unsigned int clk_ptp_rate;
 	unsigned int clk_ref_rate;
+	struct clk_bulk_data *clks;
+	int num_clks;
 	unsigned int mult_fact_100ns;
 	s32 ptp_max_adj;
 	u32 cdc_error_adj;
-- 
2.25.1


