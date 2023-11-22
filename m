Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E27C61D9C
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 14:28:49 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.20658.1700663304421656546
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Nov 2023 06:28:43 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,219,1695654000"; 
   d="scan'208";a="187743106"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 22 Nov 2023 23:28:43 +0900
Received: from localhost.localdomain (unknown [10.226.92.150])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A24264010DEB;
	Wed, 22 Nov 2023 23:28:41 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 09/11] clk: vc3: Fix output clock mapping
Date: Wed, 22 Nov 2023 14:28:17 +0000
Message-Id: <20231122142819.203737-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122142819.203737-1-biju.das.jz@bp.renesas.com>
References: <20231122142819.203737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 14:28:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13621

commit 6dcf03bcac31dec528867180f96580652fc3ac5b upstream.

According to Table 3. ("Output Source") in the 5P35023 datasheet,
the output clock mapping should be 0=REF, 1=SE1, 2=SE2, 3=SE3,
4=DIFF1, 5=DIFF2. But the code uses inverse. Fix this mapping issue.

Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Closes: https://lore.kernel.org/all/CAMuHMdUHD+bEco=WYTYWsTAyRt3dTQQt4Xpaejss0Y2ZpLCMNg@mail.gmail.com/
Fixes: 6e9aff555db7 ("clk: Add support for versa3 clock driver")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230824104812.147775-4-biju.das.jz@bp.renesas.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/clk-versaclock3.c | 68 +++++++++++++++++------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/clk/clk-versaclock3.c b/drivers/clk/clk-versaclock3.c
index 4013b114bfdf..dd4c1f3b5863 100644
--- a/drivers/clk/clk-versaclock3.c
+++ b/drivers/clk/clk-versaclock3.c
@@ -119,20 +119,20 @@ enum vc3_div {
 };
 
 enum vc3_clk_mux {
-	VC3_DIFF2_MUX,
-	VC3_DIFF1_MUX,
-	VC3_SE3_MUX,
-	VC3_SE2_MUX,
 	VC3_SE1_MUX,
+	VC3_SE2_MUX,
+	VC3_SE3_MUX,
+	VC3_DIFF1_MUX,
+	VC3_DIFF2_MUX,
 };
 
 enum vc3_clk {
-	VC3_DIFF2,
-	VC3_DIFF1,
-	VC3_SE3,
-	VC3_SE2,
-	VC3_SE1,
 	VC3_REF,
+	VC3_SE1,
+	VC3_SE2,
+	VC3_SE3,
+	VC3_DIFF1,
+	VC3_DIFF2,
 };
 
 struct vc3_clk_data {
@@ -894,33 +894,33 @@ static struct vc3_hw_data clk_div[] = {
 };
 
 static struct vc3_hw_data clk_mux[] = {
-	[VC3_DIFF2_MUX] = {
+	[VC3_SE1_MUX] = {
 		.data = &(struct vc3_clk_data) {
-			.offs = VC3_DIFF2_CTRL_REG,
-			.bitmsk = VC3_DIFF2_CTRL_REG_DIFF2_CLK_SEL
+			.offs = VC3_SE1_DIV4_CTRL,
+			.bitmsk = VC3_SE1_DIV4_CTRL_SE1_CLK_SEL
 		},
 		.hw.init = &(struct clk_init_data){
-			.name = "diff2_mux",
+			.name = "se1_mux",
 			.ops = &vc3_clk_mux_ops,
 			.parent_hws = (const struct clk_hw *[]) {
-				&clk_div[VC3_DIV1].hw,
-				&clk_div[VC3_DIV3].hw
+				&clk_div[VC3_DIV5].hw,
+				&clk_div[VC3_DIV4].hw
 			},
 			.num_parents = 2,
 			.flags = CLK_SET_RATE_PARENT
 		}
 	},
-	[VC3_DIFF1_MUX] = {
+	[VC3_SE2_MUX] = {
 		.data = &(struct vc3_clk_data) {
-			.offs = VC3_DIFF1_CTRL_REG,
-			.bitmsk = VC3_DIFF1_CTRL_REG_DIFF1_CLK_SEL
+			.offs = VC3_SE2_CTRL_REG0,
+			.bitmsk = VC3_SE2_CTRL_REG0_SE2_CLK_SEL
 		},
 		.hw.init = &(struct clk_init_data){
-			.name = "diff1_mux",
+			.name = "se2_mux",
 			.ops = &vc3_clk_mux_ops,
 			.parent_hws = (const struct clk_hw *[]) {
-				&clk_div[VC3_DIV1].hw,
-				&clk_div[VC3_DIV3].hw
+				&clk_div[VC3_DIV5].hw,
+				&clk_div[VC3_DIV4].hw
 			},
 			.num_parents = 2,
 			.flags = CLK_SET_RATE_PARENT
@@ -942,33 +942,33 @@ static struct vc3_hw_data clk_mux[] = {
 			.flags = CLK_SET_RATE_PARENT
 		}
 	},
-	[VC3_SE2_MUX] = {
+	[VC3_DIFF1_MUX] = {
 		.data = &(struct vc3_clk_data) {
-			.offs = VC3_SE2_CTRL_REG0,
-			.bitmsk = VC3_SE2_CTRL_REG0_SE2_CLK_SEL
+			.offs = VC3_DIFF1_CTRL_REG,
+			.bitmsk = VC3_DIFF1_CTRL_REG_DIFF1_CLK_SEL
 		},
 		.hw.init = &(struct clk_init_data){
-			.name = "se2_mux",
+			.name = "diff1_mux",
 			.ops = &vc3_clk_mux_ops,
 			.parent_hws = (const struct clk_hw *[]) {
-				&clk_div[VC3_DIV5].hw,
-				&clk_div[VC3_DIV4].hw
+				&clk_div[VC3_DIV1].hw,
+				&clk_div[VC3_DIV3].hw
 			},
 			.num_parents = 2,
 			.flags = CLK_SET_RATE_PARENT
 		}
 	},
-	[VC3_SE1_MUX] = {
+	[VC3_DIFF2_MUX] = {
 		.data = &(struct vc3_clk_data) {
-			.offs = VC3_SE1_DIV4_CTRL,
-			.bitmsk = VC3_SE1_DIV4_CTRL_SE1_CLK_SEL
+			.offs = VC3_DIFF2_CTRL_REG,
+			.bitmsk = VC3_DIFF2_CTRL_REG_DIFF2_CLK_SEL
 		},
 		.hw.init = &(struct clk_init_data){
-			.name = "se1_mux",
+			.name = "diff2_mux",
 			.ops = &vc3_clk_mux_ops,
 			.parent_hws = (const struct clk_hw *[]) {
-				&clk_div[VC3_DIV5].hw,
-				&clk_div[VC3_DIV4].hw
+				&clk_div[VC3_DIV1].hw,
+				&clk_div[VC3_DIV3].hw
 			},
 			.num_parents = 2,
 			.flags = CLK_SET_RATE_PARENT
@@ -1107,7 +1107,7 @@ static int vc3_probe(struct i2c_client *client)
 				name, 0, CLK_SET_RATE_PARENT, 1, 1);
 		else
 			clk_out[i] = devm_clk_hw_register_fixed_factor_parent_hw(dev,
-				name, &clk_mux[i].hw, CLK_SET_RATE_PARENT, 1, 1);
+				name, &clk_mux[i - 1].hw, CLK_SET_RATE_PARENT, 1, 1);
 
 		if (IS_ERR(clk_out[i]))
 			return PTR_ERR(clk_out[i]);
-- 
2.25.1


