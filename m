Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65249C47DB3
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 11:38:18 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.20724.1706873888019641687
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Feb 2024 03:38:10 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,238,1701097200"; 
   d="scan'208";a="196569152"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Feb 2024 20:38:09 +0900
Received: from localhost.localdomain (unknown [10.226.93.210])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0BA324000F90;
	Fri,  2 Feb 2024 20:38:07 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 5/6] clk: versaclock3: Add missing space between ')' and '{'
Date: Fri,  2 Feb 2024 11:37:53 +0000
Message-Id: <20240202113754.202827-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240202113754.202827-1-biju.das.jz@bp.renesas.com>
References: <20240202113754.202827-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 11:38:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14620

commit 123511056263bf1dce005f56bf76ba610d83e157 upstream.

Add missing space between ')' and '{' for hw.init initialization.

While at it, update the macro VC3_PLL1_LOOP_FILTER_N_DIV_MSB
0x0a->0xa.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20231122142310.203169-5-biju.das.jz@bp.renesas.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/clk-versaclock3.c | 44 +++++++++++++++++------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/clk-versaclock3.c b/drivers/clk/clk-versaclock3.c
index 9d7c3d1249b7..a718c23d96b4 100644
--- a/drivers/clk/clk-versaclock3.c
+++ b/drivers/clk/clk-versaclock3.c
@@ -37,7 +37,7 @@
 #define VC3_PLL1_M_DIV(n)		((n) & GENMASK(5, 0))
 
 #define VC3_PLL1_VCO_N_DIVIDER		0x9
-#define VC3_PLL1_LOOP_FILTER_N_DIV_MSB	0x0a
+#define VC3_PLL1_LOOP_FILTER_N_DIV_MSB	0xa
 
 #define VC3_OUT_DIV1_DIV2_CTRL		0xf
 
@@ -611,7 +611,7 @@ static struct vc3_hw_data clk_pfd_mux[] = {
 			.offs = VC3_PLL_OP_CTRL,
 			.bitmsk = BIT(VC3_PLL_OP_CTRL_PLL2_REFIN_SEL)
 		},
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(struct clk_init_data) {
 			.name = "pfd2_mux",
 			.ops = &vc3_pfd_mux_ops,
 			.parent_data = pfd_mux_parent_data,
@@ -624,7 +624,7 @@ static struct vc3_hw_data clk_pfd_mux[] = {
 			.offs = VC3_GENERAL_CTR,
 			.bitmsk = BIT(VC3_GENERAL_CTR_PLL3_REFIN_SEL)
 		},
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(struct clk_init_data) {
 			.name = "pfd3_mux",
 			.ops = &vc3_pfd_mux_ops,
 			.parent_data = pfd_mux_parent_data,
@@ -642,7 +642,7 @@ static struct vc3_hw_data clk_pfd[] = {
 			.mdiv1_bitmsk = VC3_PLL1_M_DIV1,
 			.mdiv2_bitmsk = VC3_PLL1_M_DIV2
 		},
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(struct clk_init_data) {
 			.name = "pfd1",
 			.ops = &vc3_pfd_ops,
 			.parent_data = &(const struct clk_parent_data) {
@@ -659,7 +659,7 @@ static struct vc3_hw_data clk_pfd[] = {
 			.mdiv1_bitmsk = VC3_PLL2_M_DIV1,
 			.mdiv2_bitmsk = VC3_PLL2_M_DIV2
 		},
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(struct clk_init_data) {
 			.name = "pfd2",
 			.ops = &vc3_pfd_ops,
 			.parent_hws = (const struct clk_hw *[]) {
@@ -676,7 +676,7 @@ static struct vc3_hw_data clk_pfd[] = {
 			.mdiv1_bitmsk = VC3_PLL3_M_DIV1,
 			.mdiv2_bitmsk = VC3_PLL3_M_DIV2
 		},
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(struct clk_init_data) {
 			.name = "pfd3",
 			.ops = &vc3_pfd_ops,
 			.parent_hws = (const struct clk_hw *[]) {
@@ -697,7 +697,7 @@ static struct vc3_hw_data clk_pll[] = {
 			.vco_min = VC3_PLL1_VCO_MIN,
 			.vco_max = VC3_PLL1_VCO_MAX
 		},
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(struct clk_init_data) {
 			.name = "pll1",
 			.ops = &vc3_pll_ops,
 			.parent_hws = (const struct clk_hw *[]) {
@@ -715,7 +715,7 @@ static struct vc3_hw_data clk_pll[] = {
 			.vco_min = VC3_PLL2_VCO_MIN,
 			.vco_max = VC3_PLL2_VCO_MAX
 		},
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(struct clk_init_data) {
 			.name = "pll2",
 			.ops = &vc3_pll_ops,
 			.parent_hws = (const struct clk_hw *[]) {
@@ -733,7 +733,7 @@ static struct vc3_hw_data clk_pll[] = {
 			.vco_min = VC3_PLL3_VCO_MIN,
 			.vco_max = VC3_PLL3_VCO_MAX
 		},
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(struct clk_init_data) {
 			.name = "pll3",
 			.ops = &vc3_pll_ops,
 			.parent_hws = (const struct clk_hw *[]) {
@@ -766,7 +766,7 @@ static struct vc3_hw_data clk_div_mux[] = {
 			.offs = VC3_GENERAL_CTR,
 			.bitmsk = VC3_GENERAL_CTR_DIV1_SRC_SEL
 		},
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(struct clk_init_data) {
 			.name = "div1_mux",
 			.ops = &vc3_div_mux_ops,
 			.parent_data = div_mux_parent_data[VC3_DIV1_MUX],
@@ -779,7 +779,7 @@ static struct vc3_hw_data clk_div_mux[] = {
 			.offs = VC3_PLL3_CHARGE_PUMP_CTRL,
 			.bitmsk = VC3_PLL3_CHARGE_PUMP_CTRL_OUTDIV3_SRC_SEL
 		},
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(struct clk_init_data) {
 			.name = "div3_mux",
 			.ops = &vc3_div_mux_ops,
 			.parent_data = div_mux_parent_data[VC3_DIV3_MUX],
@@ -792,7 +792,7 @@ static struct vc3_hw_data clk_div_mux[] = {
 			.offs = VC3_OUTPUT_CTR,
 			.bitmsk = VC3_OUTPUT_CTR_DIV4_SRC_SEL
 		},
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(struct clk_init_data) {
 			.name = "div4_mux",
 			.ops = &vc3_div_mux_ops,
 			.parent_data = div_mux_parent_data[VC3_DIV4_MUX],
@@ -811,7 +811,7 @@ static struct vc3_hw_data clk_div[] = {
 			.width = 4,
 			.flags = CLK_DIVIDER_READ_ONLY
 		},
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(struct clk_init_data) {
 			.name = "div1",
 			.ops = &vc3_div_ops,
 			.parent_hws = (const struct clk_hw *[]) {
@@ -829,7 +829,7 @@ static struct vc3_hw_data clk_div[] = {
 			.width = 4,
 			.flags = CLK_DIVIDER_READ_ONLY
 		},
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(struct clk_init_data) {
 			.name = "div2",
 			.ops = &vc3_div_ops,
 			.parent_hws = (const struct clk_hw *[]) {
@@ -847,7 +847,7 @@ static struct vc3_hw_data clk_div[] = {
 			.width = 4,
 			.flags = CLK_DIVIDER_READ_ONLY
 		},
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(struct clk_init_data) {
 			.name = "div3",
 			.ops = &vc3_div_ops,
 			.parent_hws = (const struct clk_hw *[]) {
@@ -865,7 +865,7 @@ static struct vc3_hw_data clk_div[] = {
 			.width = 4,
 			.flags = CLK_DIVIDER_READ_ONLY
 		},
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(struct clk_init_data) {
 			.name = "div4",
 			.ops = &vc3_div_ops,
 			.parent_hws = (const struct clk_hw *[]) {
@@ -883,7 +883,7 @@ static struct vc3_hw_data clk_div[] = {
 			.width = 4,
 			.flags = CLK_DIVIDER_READ_ONLY
 		},
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(struct clk_init_data) {
 			.name = "div5",
 			.ops = &vc3_div_ops,
 			.parent_hws = (const struct clk_hw *[]) {
@@ -901,7 +901,7 @@ static struct vc3_hw_data clk_mux[] = {
 			.offs = VC3_SE1_DIV4_CTRL,
 			.bitmsk = VC3_SE1_DIV4_CTRL_SE1_CLK_SEL
 		},
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(struct clk_init_data) {
 			.name = "se1_mux",
 			.ops = &vc3_clk_mux_ops,
 			.parent_hws = (const struct clk_hw *[]) {
@@ -917,7 +917,7 @@ static struct vc3_hw_data clk_mux[] = {
 			.offs = VC3_SE2_CTRL_REG0,
 			.bitmsk = VC3_SE2_CTRL_REG0_SE2_CLK_SEL
 		},
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(struct clk_init_data) {
 			.name = "se2_mux",
 			.ops = &vc3_clk_mux_ops,
 			.parent_hws = (const struct clk_hw *[]) {
@@ -933,7 +933,7 @@ static struct vc3_hw_data clk_mux[] = {
 			.offs = VC3_SE3_DIFF1_CTRL_REG,
 			.bitmsk = VC3_SE3_DIFF1_CTRL_REG_SE3_CLK_SEL
 		},
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(struct clk_init_data) {
 			.name = "se3_mux",
 			.ops = &vc3_clk_mux_ops,
 			.parent_hws = (const struct clk_hw *[]) {
@@ -949,7 +949,7 @@ static struct vc3_hw_data clk_mux[] = {
 			.offs = VC3_DIFF1_CTRL_REG,
 			.bitmsk = VC3_DIFF1_CTRL_REG_DIFF1_CLK_SEL
 		},
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(struct clk_init_data) {
 			.name = "diff1_mux",
 			.ops = &vc3_clk_mux_ops,
 			.parent_hws = (const struct clk_hw *[]) {
@@ -965,7 +965,7 @@ static struct vc3_hw_data clk_mux[] = {
 			.offs = VC3_DIFF2_CTRL_REG,
 			.bitmsk = VC3_DIFF2_CTRL_REG_DIFF2_CLK_SEL
 		},
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(struct clk_init_data) {
 			.name = "diff2_mux",
 			.ops = &vc3_clk_mux_ops,
 			.parent_hws = (const struct clk_hw *[]) {
-- 
2.25.1


