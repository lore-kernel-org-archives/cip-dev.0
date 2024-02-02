Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93959C47DB3
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 12:23:58 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.21395.1706876631566661535
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Feb 2024 04:23:56 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,238,1701097200"; 
   d="scan'208";a="196572322"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 02 Feb 2024 21:23:55 +0900
Received: from localhost.localdomain (unknown [10.226.93.210])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B695042182F1;
	Fri,  2 Feb 2024 21:23:53 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 6/6] clk: versaclock3: Drop ret variable
Date: Fri,  2 Feb 2024 12:23:38 +0000
Message-Id: <20240202122338.309435-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240202122338.309435-1-biju.das.jz@bp.renesas.com>
References: <20240202122338.309435-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 12:23:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14634

commit b08fa385937c1b6baae24683f6430230212b43e5 upstream.

Drop ret variable from vc3_clk_mux_determine_rate().

While at it, return the value returned by regmap_*
wherever possible instead of returning 0.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20231122142310.203169-6-biju.das.jz@bp.renesas.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/clk-versaclock3.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/clk-versaclock3.c b/drivers/clk/clk-versaclock3.c
index 0f281dd5ddad..89bd4c29346c 100644
--- a/drivers/clk/clk-versaclock3.c
+++ b/drivers/clk/clk-versaclock3.c
@@ -226,9 +226,8 @@ static int vc3_pfd_mux_set_parent(struct clk_hw *hw, u8 index)
 	struct vc3_hw_data *vc3 = container_of(hw, struct vc3_hw_data, hw);
 	const struct vc3_clk_data *pfd_mux = vc3->data;
 
-	regmap_update_bits(vc3->regmap, pfd_mux->offs, pfd_mux->bitmsk,
-			   index ? pfd_mux->bitmsk : 0);
-	return 0;
+	return regmap_update_bits(vc3->regmap, pfd_mux->offs, pfd_mux->bitmsk,
+				  index ? pfd_mux->bitmsk : 0);
 }
 
 static const struct clk_ops vc3_pfd_mux_ops = {
@@ -455,10 +454,8 @@ static int vc3_div_mux_set_parent(struct clk_hw *hw, u8 index)
 	struct vc3_hw_data *vc3 = container_of(hw, struct vc3_hw_data, hw);
 	const struct vc3_clk_data *div_mux = vc3->data;
 
-	regmap_update_bits(vc3->regmap, div_mux->offs, div_mux->bitmsk,
-			   index ? div_mux->bitmsk : 0);
-
-	return 0;
+	return regmap_update_bits(vc3->regmap, div_mux->offs, div_mux->bitmsk,
+				  index ? div_mux->bitmsk : 0);
 }
 
 static const struct clk_ops vc3_div_mux_ops = {
@@ -522,10 +519,9 @@ static int vc3_div_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	value = divider_get_val(rate, parent_rate, div_data->table,
 				div_data->width, div_data->flags);
-	regmap_update_bits(vc3->regmap, div_data->offs,
-			   VC3_DIV_MASK(div_data->width) << div_data->shift,
-			   value << div_data->shift);
-	return 0;
+	return regmap_update_bits(vc3->regmap, div_data->offs,
+				  VC3_DIV_MASK(div_data->width) << div_data->shift,
+				  value << div_data->shift);
 }
 
 static const struct clk_ops vc3_div_ops = {
@@ -537,11 +533,9 @@ static const struct clk_ops vc3_div_ops = {
 static int vc3_clk_mux_determine_rate(struct clk_hw *hw,
 				      struct clk_rate_request *req)
 {
-	int ret;
 	int frc;
 
-	ret = clk_mux_determine_rate_flags(hw, req, CLK_SET_RATE_PARENT);
-	if (ret) {
+	if (clk_mux_determine_rate_flags(hw, req, CLK_SET_RATE_PARENT)) {
 		/* The below check is equivalent to (best_parent_rate/rate) */
 		if (req->best_parent_rate >= req->rate) {
 			frc = DIV_ROUND_CLOSEST_ULL(req->best_parent_rate,
@@ -550,10 +544,9 @@ static int vc3_clk_mux_determine_rate(struct clk_hw *hw,
 			return clk_mux_determine_rate_flags(hw, req,
 							    CLK_SET_RATE_PARENT);
 		}
-		ret = 0;
 	}
 
-	return ret;
+	return 0;
 }
 
 static u8 vc3_clk_mux_get_parent(struct clk_hw *hw)
@@ -572,9 +565,8 @@ static int vc3_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	struct vc3_hw_data *vc3 = container_of(hw, struct vc3_hw_data, hw);
 	const struct vc3_clk_data *clk_mux = vc3->data;
 
-	regmap_update_bits(vc3->regmap, clk_mux->offs,
-			   clk_mux->bitmsk, index ? clk_mux->bitmsk : 0);
-	return 0;
+	return regmap_update_bits(vc3->regmap, clk_mux->offs, clk_mux->bitmsk,
+				  index ? clk_mux->bitmsk : 0);
 }
 
 static const struct clk_ops vc3_clk_mux_ops = {
-- 
2.25.1


