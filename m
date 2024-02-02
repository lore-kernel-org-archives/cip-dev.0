Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635DBC48296
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 11:38:08 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.20724.1706873888019641687
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Feb 2024 03:38:08 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,238,1701097200"; 
   d="scan'208";a="196569148"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Feb 2024 20:38:07 +0900
Received: from localhost.localdomain (unknown [10.226.93.210])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B95DB400A0E9;
	Fri,  2 Feb 2024 20:38:05 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 4/6] clk: versaclock3: Use u8 return type for get_parent() callback
Date: Fri,  2 Feb 2024 11:37:52 +0000
Message-Id: <20240202113754.202827-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240202113754.202827-1-biju.das.jz@bp.renesas.com>
References: <20240202113754.202827-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 11:38:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14619

commit a72956c82eebd138764fa214968571b0e455378e upstream.

The return type of get_parent() member in struct clk_ops is u8.
Use same return type for corresponding callback function as well.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20231122142310.203169-4-biju.das.jz@bp.renesas.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/clk-versaclock3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-versaclock3.c b/drivers/clk/clk-versaclock3.c
index ac5f2c43b595..9d7c3d1249b7 100644
--- a/drivers/clk/clk-versaclock3.c
+++ b/drivers/clk/clk-versaclock3.c
@@ -210,7 +210,7 @@ static const struct clk_div_table div3_divs[] = {
 
 static struct clk_hw *clk_out[6];
 
-static unsigned char vc3_pfd_mux_get_parent(struct clk_hw *hw)
+static u8 vc3_pfd_mux_get_parent(struct clk_hw *hw)
 {
 	struct vc3_hw_data *vc3 = container_of(hw, struct vc3_hw_data, hw);
 	const struct vc3_clk_data *pfd_mux = vc3->data;
@@ -440,7 +440,7 @@ static const struct clk_ops vc3_pll_ops = {
 	.set_rate = vc3_pll_set_rate,
 };
 
-static unsigned char vc3_div_mux_get_parent(struct clk_hw *hw)
+static u8 vc3_div_mux_get_parent(struct clk_hw *hw)
 {
 	struct vc3_hw_data *vc3 = container_of(hw, struct vc3_hw_data, hw);
 	const struct vc3_clk_data *div_mux = vc3->data;
@@ -558,7 +558,7 @@ static int vc3_clk_mux_determine_rate(struct clk_hw *hw,
 	return ret;
 }
 
-static unsigned char vc3_clk_mux_get_parent(struct clk_hw *hw)
+static u8 vc3_clk_mux_get_parent(struct clk_hw *hw)
 {
 	struct vc3_hw_data *vc3 = container_of(hw, struct vc3_hw_data, hw);
 	const struct vc3_clk_data *clk_mux = vc3->data;
-- 
2.25.1


