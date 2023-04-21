Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597DDC77B78
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 07:18:20 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.6173.1682061490711437733
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 00:18:15 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.99,214,1677510000"; 
   d="scan'208";a="160252431"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Apr 2023 16:18:15 +0900
Received: from localhost.localdomain (unknown [10.226.93.14])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3B6F641AA8A6;
	Fri, 21 Apr 2023 16:18:12 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 17/33] clk: renesas: rzg2l: Add support for RZ/V2M reset monitor reg
Date: Fri, 21 Apr 2023 08:17:13 +0100
Message-Id: <20230421071729.130347-18-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
References: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 07:18:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11290

From: Phil Edworthy <phil.edworthy@renesas.com>

commit 8090bea32484d45b19b57577dee4519cbc28571c upstream.

The RZ/V2M doesn't have a matching set of reset monitor regs for each reset
reg like the RZ/G2L. Instead, it has a single CPG_RST_MON reg which has a
single bit per module.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220503115557.53370-10-phil.edworthy@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 10 +++++++++-
 drivers/clk/renesas/rzg2l-cpg.h | 10 ++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index c34577c44519..7b8a373f6ebc 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -747,8 +747,16 @@ static int rzg2l_cpg_status(struct reset_controller_dev *rcdev,
 	const struct rzg2l_cpg_info *info = priv->info;
 	unsigned int reg = info->resets[id].off;
 	u32 bitmask = BIT(info->resets[id].bit);
+	s8 monbit = info->resets[id].monbit;
 
-	return !!(readl(priv->base + CLK_MRST_R(reg)) & bitmask);
+	if (info->has_clk_mon_regs) {
+		return !!(readl(priv->base + CLK_MRST_R(reg)) & bitmask);
+	} else if (monbit >= 0) {
+		u32 monbitmask = BIT(monbit);
+
+		return !!(readl(priv->base + CPG_RST_MON) & monbitmask);
+	}
+	return -ENOTSUPP;
 }
 
 static const struct reset_control_ops rzg2l_cpg_reset_ops = {
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 80fc07404246..f05b2b775cd5 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -18,6 +18,7 @@
 #define CPG_PL3_SSEL		(0x408)
 #define CPG_PL6_SSEL		(0x414)
 #define CPG_PL6_ETH_SSEL	(0x418)
+#define CPG_RST_MON		(0x680)
 
 #define CPG_CLKSTATUS_SELSDHI0_STS	BIT(28)
 #define CPG_CLKSTATUS_SELSDHI1_STS	BIT(29)
@@ -161,17 +162,22 @@ struct rzg2l_mod_clk {
  *
  * @off: register offset
  * @bit: reset bit
+ * @monbit: monitor bit in CPG_RST_MON register, -1 if none
  */
 struct rzg2l_reset {
 	u16 off;
 	u8 bit;
+	s8 monbit;
 };
 
-#define DEF_RST(_id, _off, _bit)	\
+#define DEF_RST_MON(_id, _off, _bit, _monbit)	\
 	[_id] = { \
 		.off = (_off), \
-		.bit = (_bit) \
+		.bit = (_bit), \
+		.monbit = (_monbit) \
 	}
+#define DEF_RST(_id, _off, _bit)	\
+	DEF_RST_MON(_id, _off, _bit, -1)
 
 /**
  * struct rzg2l_cpg_info - SoC-specific CPG Description
-- 
2.25.1


